From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Mar 2018 12:05:57 +0000
Subject: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
In-Reply-To: <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
 <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
Message-ID: <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 12:56:24PM +0100, Grzegorz Jaszczyk wrote:
> Thank you for your feedback. I probably over-interpreted some of the
> documentation paragraph to justify (probably) buggy behavior that I am
> seeing. Regardless of correctness of this patch I will appreciate if
> you could help understanding this issue.
> 
> First the whole story: I was debugging why the crashdump kernel hangs
> in v. early stage, when the kdump was triggered from the
> ARM_SBSA_WATCHDOG interrupt handler, while everything worked fine when
> it was triggered from the process context. Finally It occurred that it
> is because the crashdump kernel doesn't get any timer interrupt. I
> also notice that this problem doesn't occur when the gic is configured
> to work in EOImode == 1. In such circumstances, the write to
> GIC_CPU_EOI in gic_handle_irq is causing priority drop to idle, and
> therefore when the crashdump kernel starts, the timer interrupt is
> able to preempt still active watchdog interrupt (I know that this
> interrupt shouldn't be active after irq_set_irqchip_state but for some
> reason it seems to not do the job correctly).

Do you have a way to reproduce the problem?

Is there an easy way to cause the watchdog to trigger a kdump as above,
e.g. via LKDTM?

> In my commit log I wrongly describe the bahaviour of
> irq_set_irqchip_state and irq_get_irqchip_state. In
> machine_kexec_mask_interrupts (when watchdog interrupt is active)
> after adding some debugs I see that (focusing only on watchdog
> interrupt):
> 1) before calling irq_set_irqchip_state when I check the status with
> irq_get_irqchip_state I see that watchdog interrupt is active
> 2) decative interrupt via irq_set_irqchip_state
> 3) check the status via irq_get_irqchip_state which indicates that the
> status has changed to inactive, so everything seems to be fine, but
> still in crashdump kernel I don't get any interrupts (when the EOImode
> == 0).
> 
> When I modify the machine_kexec_mask_interrupts, to call the eoi for
> watchdog (only temporary to observe the effect):
> if (i == watchdog_irq)
>      chip->irq_eoi(&desc->irq_data);
> 
> everything is working. So it seems that deactivating the interrupt via
> write to GIC_CPU_EOI (EOImode == 0) or GIC_CPU_EOI +
> GIC_CPU_DEACTIVATE (EOImode == 1) does the job, while deactivating it
> with use of GIC_DIST_ACTIVE_CLEAR doesn't.
> 
> I am using the unmodified GICv2m ("arm,gic-400") and the watchdog
> interrupt is connected as one of the SPI. 

I think you just mean GICv2 here. GICv2m is an MSI controller, and
shouldn't interact with the SBSA watchdog's SPI.

Can you tell us which platform you are seeing this on?

Thanks,
Mark.
