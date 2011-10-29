From: will.deacon@arm.com (Will Deacon)
Date: Sat, 29 Oct 2011 14:56:53 +0100
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111029102108.GY19187@n2100.arm.linux.org.uk>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
Message-ID: <20111029135653.GA25057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Oct 29, 2011 at 11:21:08AM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 28, 2011 at 03:43:29PM +0100, Will Deacon wrote:
> > arch_reset is a static inline function defined in mach/system.h and, as
> > such, is a blocker for the single zImage work.
> > 
> > This patch introduces an arm_arch_reset function pointer to which
> > platforms can assign their reset function rather than define it in the
> > header file.
> 
> I think this is slightly the wrong approach.  We already have:
> 
> void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
> EXPORT_SYMBOL_GPL(arm_pm_restart);
> 
> so why do we need a new function pointer?  We could convert the bulk of
> arm_machine_restart() to a library function (setup_restart()), moving
> the failure to reboot into machine_restart().

Funny you should mention this approach. I've been toying with something
similar for the kexec reset path but I hadn't managed to join the dots
between that and the arch_reset code.

I initially observed this in the idle code, where it looks to me like all
the pm_idle overrides could actually be done in the arch_idle hook (the only
slightly fiddly one is OMAP). Maybe Nicolas could use the same sort of
approach for that?

> This would then allow everyone to hook into the restart via the same
> method irrespective of what they want, and if they want the old
> 'arch_reset' way, call setup_restart() themselves.

Yup, it's a fantastic idea because it allows us to put all of the identity
mapping bits into setup_restart as well. So then platforms make the choice
about the mapping they want, rather than being told via the reboot mode.

The only downside is that I have to go over all of the platforms again
unless I can polish up my Coccinelle-fu. Ho-hum.

> IOW, something like this:
> 
>  arch/arm/include/asm/system.h |    2 +-
>  arch/arm/kernel/process.c     |   30 +++++++++++++++++-------------
>  2 files changed, 18 insertions(+), 14 deletions(-)

[...]

I'll give this a go for v2, thanks. Once this is sorted out I'll do a second
pass to clean up the reboot modes since I've already got some patches for
that.

Cheers,

Will
