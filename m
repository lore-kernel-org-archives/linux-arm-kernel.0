From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 12 Jan 2012 11:17:12 +1100
Subject: [PATCH 00/11] ep93xx: Move SoC private bits to core
In-Reply-To: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
Message-ID: <4F0E2688.3020802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/12 14:14, Ryan Mallon wrote:

> This patch series is an effort to move the ep93xx SoC specific code out
> of drivers and include/mach into arch/arm/mach-ep93xx. This work
> involves the following changes:


So, I stupidly managed to make this patch series against some old,
irrelevant kernel version. I have rebased the patches on top of -next
(avaiable on the ep93xx-private-soc branch
git at github.com:RyanMallon/linux-2.6.git, hopefully I got that right,
it's my first attempt at doing a public git tree).

The rebase went cleanly, except for patch 5 being dropped since the ARM
reset rework already made that change. Since the patches should be
largely unchanged, I'll wait for an initial round of comments before
posting the new versions.

Apologies for the mistake,
~Ryan

> 
>  - Create a new private header called soc.h to replace most of 
>    mach/include/ep93xx-regs.h
>  - Move the Maverick crunch code from arch/arm/kernel to mach-ep93xx
>  - Move all system controller access to the ep93xx core code
> 
> There are a small handful of defines left in ep93xx-regs.h which are
> used by both the ep93xx core and include/mach files (uncompress.h,
> debug-macro.S, etc).
> 
> Ryan Mallon (11):
>   ep93xx: Move PHYS_BASE defines to local SoC header file
>   ep93xx: Move GPIO defines to gpio-ep93xx.h
>   ep93xx: Move peripheral defines to local SoC header
>   ep93xx: Configure GPIO ports in core code
>   ep93xx: Move arch_reset to core.c
>   ep93xx: Don't use system controller defines in audio drivers
>   ep93xx: Make syscon access functions private to SoC
>   ep93xx: Move EP93XX_WATCHDOG_BASE define to driver
>   ep93xx: Move crunch code to mach-ep93xx directory
>   ep93xx: Move EP93XX_SYSCON defines to SoC private header
>   ep93xx: Remove unnecessary includes of ep93xx-regs.h
> 
>  arch/arm/kernel/Makefile                        |    3 -
>  arch/arm/mach-ep93xx/Makefile                   |    3 +
>  arch/arm/mach-ep93xx/adssphere.c                |    1 +
>  arch/arm/mach-ep93xx/clock.c                    |    1 +
>  arch/arm/mach-ep93xx/core.c                     |   47 ++++--
>  arch/arm/{kernel => mach-ep93xx}/crunch-bits.S  |    0
>  arch/arm/{kernel => mach-ep93xx}/crunch.c       |    4 +-
>  arch/arm/mach-ep93xx/dma.c                      |    2 +
>  arch/arm/mach-ep93xx/edb93xx.c                  |    2 +
>  arch/arm/mach-ep93xx/gesbc9312.c                |    1 +
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |  191 +--------------------
>  arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h |   10 +
>  arch/arm/mach-ep93xx/include/mach/hardware.h    |    1 -
>  arch/arm/mach-ep93xx/include/mach/platform.h    |   16 +--
>  arch/arm/mach-ep93xx/include/mach/system.h      |   14 +--
>  arch/arm/mach-ep93xx/micro9.c                   |    1 +
>  arch/arm/mach-ep93xx/simone.c                   |    2 +
>  arch/arm/mach-ep93xx/snappercl15.c              |    2 +
>  arch/arm/mach-ep93xx/soc.h                      |  210 +++++++++++++++++++++++
>  arch/arm/mach-ep93xx/ts72xx.c                   |    2 +
>  arch/arm/mach-ep93xx/vision_ep9307.c            |    2 +
>  drivers/gpio/gpio-ep93xx.c                      |    7 -
>  drivers/watchdog/ep93xx_wdt.c                   |    2 +
>  sound/soc/ep93xx/edb93xx.c                      |    4 +-
>  sound/soc/ep93xx/snappercl15.c                  |    4 +-
>  25 files changed, 279 insertions(+), 253 deletions(-)
>  rename arch/arm/{kernel => mach-ep93xx}/crunch-bits.S (100%)
>  rename arch/arm/{kernel => mach-ep93xx}/crunch.c (98%)
>  create mode 100644 arch/arm/mach-ep93xx/soc.h
> 
