From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Jan 2013 16:40:34 +0000
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <20130106162200.GC11025@mudshark.cambridge.arm.com>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
 <50E5E967.3020805@wwwdotorg.org>
 <20130106162200.GC11025@mudshark.cambridge.arm.com>
Message-ID: <20130106164033.GA3222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 06, 2013 at 04:22:00PM +0000, Will Deacon wrote:
> On Thu, Jan 03, 2013 at 08:26:15PM +0000, Stephen Warren wrote:
> > On 01/03/2013 05:21 AM, Russell King - ARM Linux wrote:
> > > On Thu, Jan 03, 2013 at 12:02:59PM +0000, Will Deacon wrote:
> > >> You need the smp_send_stop call in order to send the cpu_kill (looks like
> > >> tegra needs die and then kill). So you really need hotplug support as well
> > >> as suspend for this to do much (if not, the secondaries end up spinning
> > >> with interrupts disabled which is probably the best we can do anyway).
> > >>
> > >> We could add SUSPEND as a KEXEC dependency if SMP (we already have HOTPLUG
> > >> there) if you like?
> > > 
> > > Or we could look into bringing in the code to do this when KEXEC is
> > > enabled - which would mean an amount of restructuring of the Kconfig
> > > files.
> > 
> > I'm not sure if any of this thread means we should hold off on this
> > patch, or just that the Kconfig could/should be enhanced later?
> 
> Well, Russell's suggestion looked easy enough to have a crack out so you
> could always post a series implementing it along with this patch.
> 
> > One thing I did just notice with my patch: disable_nonboot_cpus() ends
> > up being called twice for the poweroff path:
> > 
> > [   30.461847] Disabling non-boot CPUs ...
> > [   30.478797] CPU1: shutdown
> > [   30.492104] Power down.
> > [   30.494578] Disabling non-boot CPUs ...
> > 
> > Is this worth worrying about?
> 
> It's harmless but it's also pretty horrible. Unfortunately, I don't see
> what we can do about it: it's a direct side-effect of generic code calling
> disable_nonboot_cpus for poweroff and not for kexec.

I think we're starting to hit the age old problem with software: over
time it becomes more difficult to change established software as it
becomes more risky to make changes, and no one wants to make those
changes through fear of breakign something else.

Eventually, this results in someone declaring that the current project
is beyond hope, and the next Linus Torvalds comes along and the next
Linux kernel project will be born.  That probably isn't want people want,
but it's what will eventually happen when things just get too painful.

Unless, of course, we start pushing back now and don't leave issues to
fester.

However, that said, I can see why kexec does this.  I've not looked too
deeply into kexec, but I'd image that the path where the secondary CPUs
are not taken offline prior to kexec happening is to allow kexec to
be used for crash recovery, where you don't want to do too much in case
you re-tickle the bug that caused the original crash.

I suspect what platforms like x86 do in this scenario (via
machine_shutdown) is to forcefully put the secondary CPUs into reset
and hold them there until the new kexec'd kernel gets going.

The problem is... on ARM we're yet again shot in the foot through the
unwillingness to architect certain aspects of the system: there is no
architecturally known way to place CPUs into a reset state once they've
been started up.  In other words, once a CPU starts executing kernel
code, it needs to always execute kernel code or there must be some kind
of platform specific hook to disable it.

Maybe that's the answer here: have machine_shutdown() call out to some
platform specific function to do the forced-takedown of secondary CPUs,
and if there's no such specific function, then we use our present CPU
stopping method of making them spin in a WFI loop with IRQs disabled.
