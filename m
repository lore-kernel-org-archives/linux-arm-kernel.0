From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Aug 2013 10:46:13 +0200
Subject: [RFC v1 4/5] ARM: mvebu: add Armada 1500 and Sony NSZ-GS7 device
 tree files
In-Reply-To: <521154A9.3000505@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308172128.35245.arnd@arndb.de> <521154A9.3000505@gmail.com>
Message-ID: <201308191046.13504.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 August 2013, Sebastian Hesselbarth wrote:
> On 08/17/2013 09:28 PM, Arnd Bergmann wrote:
> > On Friday 16 August 2013, Sebastian Hesselbarth wrote:

> > This seems like a strange combination. I would have expected either PJ4+Aurora+apbtimer
> > or A9+pl310+localtimer, based on what I found in the chromecast kernel source.
> > Do you have more information here about what is used on the two variants?
> 
> I have no clue, what combination it really is. Unfortunately,
> Marvell didn't release any open datasheets, of course.
> 
> I can only look at GPL'd Asus Cube kernel, I used for getting an idea
> of what was required for initial support and reg offsets, irqs and
> friends. They bring up twd as localtimer. Also, grep'ing the Cube
> kernel sources in mach-mv88de3100 gives hits for CONFIG_PJ4 (note the
> missing B), l2x0, smp_twd, apb_timer.
> 
> No hits for pl310, A9.

I found this snippet in Kconfig for the Chromecast:

config ARCH_MV88DE3100_BG2
        bool "BG2 family"
        help
          Support for Marvell BG2 processors, based on the Marvell
          PJ4B CPU and the Marvell TAUROS3 L2 cache controller, or
          the ARM CortexA9 CPU and the ARM PL310 L2 cache controller

config ARCH_MV88DE3100_BG3
        bool "BG3 family"
        help
          Support for Marvell BG3 processors, based on the ARM
          CortexA9MP CPU and the ARM PL310 L2 cache controller


A9 will always work when CPU_V7 is set, it doesn't have a Kconfig option.
When CPU_PJ4 is set, it will work on both. Regarding the other options,
this is what I found from the defconfigs in chromecast:

$ git grep LOCAL_TIMER arch/arm/configs/*mv88*
arch/arm/configs/mv88de3100_ax_android_defconfig:CONFIG_LOCAL_TIMERS=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2:CONFIG_LOCAL_TIMERS=y
arch/arm/configs/mv88de3100_ax_emmc_android_defconfig:CONFIG_LOCAL_TIMERS=y
arch/arm/configs/mv88de3100_ax_linux_defconfig:CONFIG_LOCAL_TIMERS=y

$ git grep CONFIG_SMP= arch/arm/configs/*mv88*
arch/arm/configs/mv88de3100_ax_android_defconfig:CONFIG_SMP=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2:CONFIG_SMP=y
arch/arm/configs/mv88de3100_ax_emmc_android_defconfig:CONFIG_SMP=y
arch/arm/configs/mv88de3100_ax_linux_defconfig:CONFIG_SMP=y

$ git grep CPU_PJ4 arch/arm/configs/*mv88*
arch/arm/configs/eureka_mv88de31xx_defconfig:CONFIG_CPU_PJ4=y
arch/arm/configs/mv88de3100_ax_android_defconfig:CONFIG_CPU_PJ4=y
arch/arm/configs/mv88de3100_ax_bg2a0_rdkdmp_dongle_defconfig:CONFIG_CPU_PJ4=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2:CONFIG_CPU_PJ4=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2cd_dmp:CONFIG_CPU_PJ4=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2cd_dmp_nol2:CONFIG_CPU_PJ4=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2cd_dngle_256:CONFIG_CPU_PJ4=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2cd_dngle_nol2:CONFIG_CPU_PJ4=y
arch/arm/configs/mv88de3100_ax_emmc_android_defconfig:CONFIG_CPU_PJ4=y
arch/arm/configs/mv88de3100_ax_linux_defconfig:CONFIG_CPU_PJ4=y

$ git grep CACHE_TAUROS3= arch/arm/configs/*mv88*
arch/arm/configs/eureka_mv88de31xx_defconfig:CONFIG_CACHE_TAUROS3=y
arch/arm/configs/mv88de3100_ax_android_defconfig:CONFIG_CACHE_TAUROS3=y
arch/arm/configs/mv88de3100_ax_bg2a0_rdkdmp_dongle_defconfig:CONFIG_CACHE_TAUROS3=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2:CONFIG_CACHE_TAUROS3=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2cd_dmp:CONFIG_CACHE_TAUROS3=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2cd_dngle_256:CONFIG_CACHE_TAUROS3=y
arch/arm/configs/mv88de3100_ax_emmc_android_defconfig:CONFIG_CACHE_TAUROS3=y
arch/arm/configs/mv88de3100_ax_linux_defconfig:CONFIG_CACHE_TAUROS3=y

$ git grep CACHE_PL310 arch/arm/configs/*mv88*
arch/arm/configs/eureka_mv88de30xx_defconfig:CONFIG_CACHE_PL310=y

$ git grep L2X arch/arm/configs/*mv88*
arch/arm/configs/eureka_mv88de30xx_defconfig:CONFIG_CACHE_L2X0=y

$ git grep MV88DE3100_BG....= arch/arm/configs/*mv88*
arch/arm/configs/eureka_mv88de30xx_defconfig:CONFIG_MV88DE3100_BG2_CD=y
arch/arm/configs/eureka_mv88de31xx_defconfig:CONFIG_MV88DE3100_BG2_A0=y
arch/arm/configs/mv88de3100_ax_android_defconfig:CONFIG_MV88DE3100_BG2_A0=y
arch/arm/configs/mv88de3100_ax_bg2a0_rdkdmp_dongle_defconfig:CONFIG_MV88DE3100_BG2_A0=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2:CONFIG_MV88DE3100_BG2_A0=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2cd_dmp:CONFIG_MV88DE3100_BG2_A0=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2cd_dmp_nol2:CONFIG_MV88DE3100_BG2_A0=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2cd_dngle_256:CONFIG_MV88DE3100_BG2_A0=y
arch/arm/configs/mv88de3100_ax_defconfig.bg2cd_dngle_nol2:CONFIG_MV88DE3100_BG2_A0=y
arch/arm/configs/mv88de3100_ax_emmc_android_defconfig:CONFIG_MV88DE3100_BG2_A0=y
arch/arm/configs/mv88de3100_ax_linux_defconfig:CONFIG_MV88DE3100_BG2_A0=y

Evidently, the only defconfig that is for Cortex-A9 is eureka_mv88de30xx_defconfig,
which is used on the Chromecast and has version MV88DE3100_BG2_CD (presumably
renamed to product number de3005). LOCAL_TIMER is used exactly on those that have
SMP support here, which makes sense.

	Arnd
