From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 11 Jun 2016 10:41:00 +0100
Subject: [PATCH v3 1/2] clocksource/arm_arch_timer: Force per-CPU
 interrupt to be level-triggered
In-Reply-To: <575AFB4A.3030508@gmail.com>
References: <1465235791-7064-1-git-send-email-marc.zyngier@arm.com>
 <1465235791-7064-2-git-send-email-marc.zyngier@arm.com>
 <5759DB58.5070906@gmail.com> <20160610082952.4f20d732@arm.com>
 <575AFB4A.3030508@gmail.com>
Message-ID: <20160611104100.7475689e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jun 2016 10:39:22 -0700
David Daney <ddaney.cavm@gmail.com> wrote:

> On 06/10/2016 12:29 AM, Marc Zyngier wrote:
> > On Thu, 09 Jun 2016 14:10:48 -0700
> > David Daney <ddaney.cavm@gmail.com> wrote:
> >
> >> On 06/06/2016 10:56 AM, Marc Zyngier wrote:
> >>> The ARM architected timer produces level-triggered interrupts (this
> >>> is mandated by the architecture). Unfortunately, most device-trees
> >>> get this wrong, and expose an edge-triggered interrupt.
> >>>
> >>> Until now, this wasn't too much an issue, as the programming of the
> >>> trigger would fail (the corresponding PPI cannot be reconfigured),
> >>> and the kernel would be happy with this. But we're about to change
> >>> this, and trust DT a lot if the driver doesn't provide its own
> >>> trigger information. In that context, the timer breaks badly.
> >>>
> >>> While we do need to fix the DTs, there is also some userspace out
> >>> there (kvmtool) that generates the same kind of broken DT on the
> >>> fly, and that will completely break with newer kernels.
> >>>
> >>> As a safety measure, and to keep buggy software alive as well as
> >>> buying us some time to fix DTs all over the place, let's check
> >>> what trigger configuration has been given us by the firmware.
> >>> If this is not a level configuration, then we know that the
> >>> DT/ACPI configuration is bust, and we pick some defaults which
> >>> won't be worse than the existing setup.
> >>>
> >>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >>
> >>
> >> I tried to test this patch, but there is a problem somewhere that I have
> >> not yet tracked down.  On Cavium Thunder (gic-v3 based) I have tested
> >> with the device tree interrupt type of both 4 and 8 and get the same result:
> >>
> >>
> >> [    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ2,
> >> assuming level low
> >> [    0.000000] arm_arch_timer: WARNING: Please fix your firmware
> >> [    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ3,
> >> assuming level low
> >> [    0.000000] arm_arch_timer: WARNING: Please fix your firmware
> >> [    0.000000] arm_arch_timer: Architected cp15 timer(s) running at
> >> 100.00MHz (phys).
> >> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> >> max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
> >> [    0.000002] sched_clock: 56 bits at 100MHz, resolution 10ns, wraps
> >> every 4398046511100ns
> >>
> >> It could be that the gic-v3 irq mapping code is broken.  I will try to
> >> look into it, but there may be other fixes needed before we would
> >> consider this patch to be an improvement.
> >
> > That's because the core kernel has other bugs which are going to be
> > addressed in 4.8. So far, we cannot set the trigger of a per-cpu
> > interrupt from the device tree, and we end-up with whatever is the
> > default (edge). You can put whatever you want in the DT, it will be
> > ignored.
> 
> Yes, after looking into it, I see what you mean.
> 
> >
> > This series in preparation of these fixes landing in 4.8, where we'll
> > be able to do the right thing, and will start noticing stupid things
> > coming from the DT.
> >
> 
> I don't object to the patch, but would suggest a couple of things:
> 
> o We need to test it *after* the irq configuration issues are corrected.
> 
> o The merging order be such that we never get the WARNING messages.

What do you prefer? A benign warning message? or a broken system? You
sound more afraid of the former than the later (and yes, things *are*
broken at the moment).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
