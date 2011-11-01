From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Nov 2011 23:09:05 +0000
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <20111101211933.GA32442@mudshark.cambridge.arm.com>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<20111101192343.GA32003@mudshark.cambridge.arm.com>
	<20111101194154.GU19187@n2100.arm.linux.org.uk>
	<20111101211933.GA32442@mudshark.cambridge.arm.com>
Message-ID: <20111101230905.GV19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2011 at 09:19:33PM +0000, Will Deacon wrote:
> Ah yes, you're right. I think it might be worth defining 'h' as
> REBOOT_MODE_HARD and 's' as REBOOT_MODE_SOFT, but there's no reason to
> disallow other combinations giving that the core code no longer has to
> do anything with these.

I don't see any need to define these to anything, especially as we just
take the first character of the reboot= argument.  If we did change it,
it would imply that we'd need to change how we parsed that argument as
well.

> > The nice thing about that is we no longer have to worry about calling
> > arm_pm_restart() with 'h' and a platform doing a soft-reboot instead.
> 
> Yes, that's truly horrific. It's a miracle soft reboot worked at all from v6
> onwards.

The short answer is it doesn't - and it's something that with this new
structure we can fix - we're no longer concerned by whatever the platform
code is doing between the soft restart setup code and actually executing
the soft restart itself.

Thankfully, at the point where we have v6 support, most platforms have
advanced to the point where there's (mostly) always a hardware method
to do a restart, which is much more preferable than trying to do a
soft-reboot (it ensures that all peripheral devices are placed into a
known state, whereas a soft restart doesn't have that guarantee.)

> > arm_machine_restart() has become almost empty - I want to move the
> > IRQ disables out into machine_restart() and kill off arm_machine_restart()
> > entirely (at the moment its the 'default' action, which is to call the
> > old arch_reset() thing.)
> > 
> > Eventually, when we have everyone hooking into arm_pm_restart() instead,
> > arm_machine_restart() will be unused and meaningless to keep around.
> 
> That's where our friend Coccinelle comes in at the end of my patch series.

We do have this problem - mioa701 - which insists on doing things like
kfree, free_irq, gpio_free in this path, which is a bad idea as it can
be called from many different contexts including IRQ context.  That
will appear to work for '/sbin/reboot' but not for things like softdog
or a sysrq-b.  Arguably, mioa701 is broken in this regard.

However, we don't know whether removing the code will then prevent it
rebooting even for a userspace-invoked reboot.  We need feedback from
the platform maintainer for that (added Philipp and Robert in the
hope one of them can answer this - and maybe send a patch to fix it.)
