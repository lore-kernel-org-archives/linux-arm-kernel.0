From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Nov 2011 21:19:33 +0000
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <20111101194154.GU19187@n2100.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<20111101192343.GA32003@mudshark.cambridge.arm.com>
	<20111101194154.GU19187@n2100.arm.linux.org.uk>
Message-ID: <20111101211933.GA32442@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2011 at 07:41:54PM +0000, Russell King - ARM Linux wrote:
> The other thing is that the generic code shouldn't care what value 'mode'
> actually is - we just pass it through to the platform handler (via
> arm_pm_restart()) and if the platform handler wants to ignore it and
> just do the software reboot thing, it uses soft_restart(addr) which
> does all the necessary setup for that.

Ah yes, you're right. I think it might be worth defining 'h' as REBOOT_MODE_HARD
and 's' as REBOOT_MODE_SOFT, but there's no reason to disallow other
combinations giving that the core code no longer has to do anything with
these.

> The nice thing about that is we no longer have to worry about calling
> arm_pm_restart() with 'h' and a platform doing a soft-reboot instead.

Yes, that's truly horrific. It's a miracle soft reboot worked at all from v6
onwards.

> > I'm definitely in favour of this change, but be aware that I plan to modify
> > setup_mm_for_reboot in the future to:
> > 
> >   (a) Use a static identity mapping so we don't have to pgd_alloc explicitly
> >       [I can't see this affecting anything]
> > 
> >   (b) Extend the identity mapping into kernel space, leaving some room for
> >       the kernel image. If this is all called from soft_reboot, which just
> >       does the cpu_reset(addr) afterwards, then we're fine. I have code to
> >       take care of changing stack and switching to the new mapping.
> 
> Well, bear in mind that (1) + (5) produce something really self-contained.
> We no longer fiddle with MMU tables for anything but the 'soft reboot'
> path.  That means things like hardware based reset (eg, using watchdogs,
> asserting GPIOs, etc) are all dealt with without fiddling with the MMU
> and caches.

Yup, so we should be able to add the scary MMU and cache stuff into
soft_reboot. We can even call this function from the kexec code.

> arm_machine_restart() has become almost empty - I want to move the
> IRQ disables out into machine_restart() and kill off arm_machine_restart()
> entirely (at the moment its the 'default' action, which is to call the
> old arch_reset() thing.)
> 
> Eventually, when we have everyone hooking into arm_pm_restart() instead,
> arm_machine_restart() will be unused and meaningless to keep around.

That's where our friend Coccinelle comes in at the end of my patch series.

Will
