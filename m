From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 14:49:01 +0900
Subject: [PATCH 0/2] ARM: shmobile: sh73a0 Suspend-to-RAM
In-Reply-To: <1363872697-11267-1-git-send-email-hechtb+renesas@gmail.com>
References: <1363872697-11267-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130327054901.GQ25431@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 02:31:35PM +0100, Bastian Hecht wrote:
> Here is a patch for shutting down the CPU0 to Power Off mode during
> SUSPEND-to-RAM (in which case CPU1 is already shut down to Power Off mode
> due to CPU hotplug).
> 
> While patch 2/2 implements this, we face some unresolved problems with the
> interrupt controller code. See: "[PATCH] input: st1232: Add IRQF_NO_SUSPEND flag"
> posted on 14th of February. This problem makes us unable to use the touchscreen
> as a wakeup source. I consider patch 2/2 sane in itself though, and we
> should consider merging it.
> 
> To test Suspend-to-RAM, patch 1/2 is supplied that is a workaround to the problem.
> 
> When I use the gpio keys in general (and as wakeup source), I get
> ------------[ cut here ]------------
> WARNING: at drivers/tty/tty_buffer.c:428 flush_to_ldisc+0x44/0x1a0()
> tty is NULL
> I suppose this is another independent problem to this code.
> 
> Side note for future work: On the way to CPUIdle we might want to use
> CPUIDLE_FLAG_COUPLED that enables us to coordinate the shutdown of both CPUs.
> 
> The patches are based on Simon's renesas/next branch.

I'm a little reticent to accept this change with two known problems
unless we are absolutely sure the problems are orthogonal.

> Bastian Hecht (2):
>   input: st1232: Add IRQF_NO_SUSPEND flag
>   ARM: shmobile: sh73a0: Suspend-to-RAM Power Off mode
> 
>  arch/arm/mach-shmobile/Makefile              |    2 +-
>  arch/arm/mach-shmobile/headsmp-sh73a0.S      |   72 ++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>  arch/arm/mach-shmobile/pm-sh73a0.c           |   32 ++++++++++--
>  arch/arm/mach-shmobile/smp-sh73a0.c          |    2 +-
>  drivers/input/touchscreen/st1232.c           |    2 +-
>  6 files changed, 104 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/mach-shmobile/headsmp-sh73a0.S
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
