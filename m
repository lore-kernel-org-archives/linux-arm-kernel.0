From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Nov 2011 19:23:43 +0000
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
Message-ID: <20111101192343.GA32003@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Nov 01, 2011 at 04:07:31PM +0000, Russell King - ARM Linux wrote:
> This series cleans up some of the restart code for ARM.  It doesn't go
> as far as Will's patch set (or even anywhere close to it) mainly because
> of the poor state of the various implementations in various platforms.

Thanks for helping out with this!

> Effectively, the various platforms themselves stand in the way of optimal
> cleanup of this code.

Agreed. I'm hoping that people will complain if we break them by accident.

> Other platforms use arm_pm_restart() to intercept the restart, and
> force the mode to 'g', 'h' or 's'.  As the mode already defaults to
> 'h' I don't understand why people felt forcing it in that case was
> necessary.  As for the 's' case, this can be done by merely specifying
> ".soft_reboot = 1" in the machine record.  We can solve the 'g' case
> by changing .soft_reboot to be a char "restart_mode" argument which
> sets the default restart mode.

Actually, I think we can go as far as deleteing the 'g' mode and using the
GPIO reset as a fallback if we fail in the usual 'h' case. This mode is only
used by mach-pxa, so it would be good to get rid of it.

We can always do this in a later patch series if it gets in the way (I have
a series to clean up the reboot modes already).

> So, this patch set takes us a little way there by cleaning up some of
> the restart code:
> 
> 1. remove the useless argument to setup_mm_for_reboot()

I'm definitely in favour of this change, but be aware that I plan to modify
setup_mm_for_reboot in the future to:

  (a) Use a static identity mapping so we don't have to pgd_alloc explicitly
      [I can't see this affecting anything]

  (b) Extend the identity mapping into kernel space, leaving some room for
      the kernel image. If this is all called from soft_reboot, which just
      does the cpu_reset(addr) afterwards, then we're fine. I have code to
      take care of changing stack and switching to the new mapping.

> 5. provide (and use) a function for soft rebooting which includes the
>    setup of the MMU tables and call cpu_reset() - and remove the MMU
>    setup from the code paths before arch_reset() is called.

This function will probably grow to contain the arm_machine_reset function
body that I have for kexec.

If you're happy with the direction I'd like to take this in, then you can
have my Acked-by tags for patches 1 and 5.

Cheers,

Will
