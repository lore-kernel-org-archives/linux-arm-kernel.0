From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 21 Nov 2014 00:30:31 +0100 (CET)
Subject: [RFC PATCH] arm: imx: Workaround i.MX6 PMU interrupts muxed to
 one SPI
In-Reply-To: <1416483757-24165-1-git-send-email-daniel.thompson@linaro.org>
References: <1416483757-24165-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <alpine.DEB.2.11.1411210016360.6439@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Nov 2014, Daniel Thompson wrote:
> +/*
> + * The PMU IRQ lines of all cores are muxed onto a single interrupt.
> + * Rotate the interrupt around the cores if the current CPU cannot
> + * figure out why the interrupt has been triggered.
> + */
> +static irqreturn_t imx6q_pmu_handler(int irq, void *dev, irq_handler_t handler)
> +{
> +	irqreturn_t ret = handler(irq, dev);
> +	int next;
> +
> +	if (ret == IRQ_NONE && num_online_cpus() > 1) {

What guarantees that ret == IRQ_HANDLED is a sign for 'this is only
for this particular core' interrupt ?

> +		next = cpumask_next(smp_processor_id(), cpu_online_mask);
> +		if (next > nr_cpu_ids)
> +			next = cpumask_next(-1, cpu_online_mask);
> +		irq_set_affinity(irq, cpumask_of(next));
> +	}

Aside of the fact, that the hardware designers who came up with such a
brainfart should be put on sane drugs, this is just silly.

Rotating that thing around will introduce arbitrary latencies and
dependencies on other interrupts to be handled.

So if there is really no way to figure out which of the cores is the
actual target of the PMU interrupt then you should simply broadcast
that interrupt to a designated per cpu vector async from the one which
handles it in the first place and be done with it. That's the only
sane option you have.

Until now I assumed that on the core components side only timers and
interrupt controllers are supposed to be designed by janitors, but
there seems to be some more evil efforts underway.

Thanks,

	tglx
