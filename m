From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Jan 2011 19:22:41 +0000
Subject: [PATCH V3] ARM: S5PV310: Implement kernel timers using MCT
In-Reply-To: <1296205364-30175-1-git-send-email-kgene.kim@samsung.com>
References: <1296205364-30175-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110131192241.GD32737@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 28, 2011 at 06:02:44PM +0900, Kukjin Kim wrote:
> +irqreturn_t s5pv310_mct_comp_isr(int irq, void *dev_id)

static?

> +{
> +	struct clock_event_device *evt;

	struct clock_event_device *evt = dev_id;

> +
> +	s5pv310_mct_write(0x1, S5PV310_MCT_G_INT_CSTAT);
> +
> +	evt = &mct_comp_device;
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction mct_comp_event_irq = {
> +	.name		= "mct_comp_irq",
> +	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
> +	.handler	= s5pv310_mct_comp_isr,

	.dev_id		= &mct_comp_device,


> +static void s5pv310_mct_tick_init(struct clock_event_device *evt)
> +{
> +	unsigned int cpu = smp_processor_id();
> +
> +	evt = &mct_tick[cpu].evt;

Why do you want to overwrite the already provided event device?
