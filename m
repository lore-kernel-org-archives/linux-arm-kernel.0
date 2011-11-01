From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Nov 2011 19:41:54 +0000
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <20111101192343.GA32003@mudshark.cambridge.arm.com>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<20111101192343.GA32003@mudshark.cambridge.arm.com>
Message-ID: <20111101194154.GU19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2011 at 07:23:43PM +0000, Will Deacon wrote:
> Hi Russell,
> 
> On Tue, Nov 01, 2011 at 04:07:31PM +0000, Russell King - ARM Linux wrote:
> > Other platforms use arm_pm_restart() to intercept the restart, and
> > force the mode to 'g', 'h' or 's'.  As the mode already defaults to
> > 'h' I don't understand why people felt forcing it in that case was
> > necessary.  As for the 's' case, this can be done by merely specifying
> > ".soft_reboot = 1" in the machine record.  We can solve the 'g' case
> > by changing .soft_reboot to be a char "restart_mode" argument which
> > sets the default restart mode.
> 
> Actually, I think we can go as far as deleteing the 'g' mode and using the
> GPIO reset as a fallback if we fail in the usual 'h' case. This mode is only
> used by mach-pxa, so it would be good to get rid of it.
> 
> We can always do this in a later patch series if it gets in the way (I have
> a series to clean up the reboot modes already).

I think it's useful to distinguish between them especially as there's
platforms in PXA land doing weirdo things with this.  Some platforms
use the GPIO reset thing as a way to shut the system down as well as
reboot it, so it's not purely just about reboot (which is in itself
annoying).

The other thing is that the generic code shouldn't care what value 'mode'
actually is - we just pass it through to the platform handler (via
arm_pm_restart()) and if the platform handler wants to ignore it and
just do the software reboot thing, it uses soft_restart(addr) which
does all the necessary setup for that.

The nice thing about that is we no longer have to worry about calling
arm_pm_restart() with 'h' and a platform doing a soft-reboot instead.

> > So, this patch set takes us a little way there by cleaning up some of
> > the restart code:
> > 
> > 1. remove the useless argument to setup_mm_for_reboot()
> 
> I'm definitely in favour of this change, but be aware that I plan to modify
> setup_mm_for_reboot in the future to:
> 
>   (a) Use a static identity mapping so we don't have to pgd_alloc explicitly
>       [I can't see this affecting anything]
> 
>   (b) Extend the identity mapping into kernel space, leaving some room for
>       the kernel image. If this is all called from soft_reboot, which just
>       does the cpu_reset(addr) afterwards, then we're fine. I have code to
>       take care of changing stack and switching to the new mapping.

Well, bear in mind that (1) + (5) produce something really self-contained.
We no longer fiddle with MMU tables for anything but the 'soft reboot'
path.  That means things like hardware based reset (eg, using watchdogs,
asserting GPIOs, etc) are all dealt with without fiddling with the MMU
and caches.

The side effect of this is that the whole soft-reboot thing is now a
self-contained chunk of code which can deal with setting things up in
order to do what it needs to do without fear of trampling over hardware
mappings.

> > 5. provide (and use) a function for soft rebooting which includes the
> >    setup of the MMU tables and call cpu_reset() - and remove the MMU
> >    setup from the code paths before arch_reset() is called.
> 
> This function will probably grow to contain the arm_machine_reset function
> body that I have for kexec.

arm_machine_restart() has become almost empty - I want to move the
IRQ disables out into machine_restart() and kill off arm_machine_restart()
entirely (at the moment its the 'default' action, which is to call the
old arch_reset() thing.)

Eventually, when we have everyone hooking into arm_pm_restart() instead,
arm_machine_restart() will be unused and meaningless to keep around.
