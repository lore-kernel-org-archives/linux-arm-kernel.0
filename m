From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 May 2018 11:21:14 +0100
Subject: [PATCH] armpmu: broadcast overflow irq on multi-core system
 having one muxed SPI for PMU.
In-Reply-To: <1525941385-12766-1-git-send-email-hoeun.ryu@lge.com.com>
References: <1525941385-12766-1-git-send-email-hoeun.ryu@lge.com.com>
Message-ID: <20180510102114.obmctt3nn7xakggi@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Thu, May 10, 2018 at 05:36:17PM +0900, Hoeun Ryu wrote:
> From: Hoeun Ryu <hoeun.ryu@lge.com>
> 
>  On some SoCs like i.MX6DL/QL have only one muxed SPI for multi-core system.
> On the systems, a CPU can be interrupted by overflow irq but it is possible that
> the overflow actually occurs on another CPU.

Muxing the PMU IRQs is a really broken system design, and there's no
good way of supporting it.

What we should do for such systems is:

* Add a flag to the DT to describe that the IRQs are muxed, as this
  cannot be probed.

* Add hrtimer code to periodically update the counters, to avoid
  overflow (e.g. as we do in the l2x0 PMU).

* Reject sampling for such systems, as this cannot be done reliably or
  efficiently.

NAK to broadcasting the IRQ -- there are a number of issues with the
general approach.

We should update the PMU probing code to warn when we have fewer IRQs
than CPUs, and fail gracefully to the above.

[...]

>  static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
>  {

> +			/* smp_call_function cannot be called with irq disabled */
> +			local_irq_enable();
> +			preempt_disable();
> +			smp_call_function_many(&mask, __armpmu_handle_irq, dev, 0);
> +			preempt_enable();
> +			local_irq_disable();

For many reasons, this sequence is not safe.

It is not safe to enable IRQs in irq handlers. Please never do this.

Thus it's also never safe to call smp_call_function*() in IRQ handlers.

Futher, If you ever encounter a case where you need to avoid preemption
across enabling IRQs, preemption must be disabled *before* enabling
IRQs.

Thanks,
Mark.
