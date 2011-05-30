From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 May 2011 09:45:43 +0200
Subject: [PATCH 0/3] SPEAr320: Add pwm support
In-Reply-To: <cover.1306739836.git.viresh.kumar@st.com>
References: <cover.1306739836.git.viresh.kumar@st.com>
Message-ID: <201105300945.43816.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 May 2011 09:21:02 Viresh Kumar wrote:
>  MAINTAINERS                                   |    5 +
>  arch/arm/configs/spear3xx_defconfig           |    2 +
>  arch/arm/mach-spear3xx/include/mach/generic.h |    1 +
>  arch/arm/mach-spear3xx/spear320.c             |   16 +
>  arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
>  drivers/misc/Kconfig                          |    7 +
>  drivers/misc/Makefile                         |    1 +
>  drivers/misc/st_pwm.c                         |  486 +++++++++++++++++++++++++
>  8 files changed, 519 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/misc/st_pwm.c

No objection to your patch, but I think we need to have
a long-term plan for pwm:

arnd at wuerfel:~/linux-2.6$ git ls-files | grep pwm.c
arch/arm/mach-exynos4/include/mach/pwm-clock.h
arch/arm/mach-mxs/devices/platform-mxs-pwm.c
arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
arch/arm/mach-s5pc100/include/mach/pwm-clock.h
arch/arm/mach-s5pv210/include/mach/pwm-clock.h
arch/arm/mach-vt8500/pwm.c
arch/arm/plat-mxc/devices/platform-mxc_pwm.c
arch/arm/plat-mxc/pwm.c
arch/arm/plat-pxa/pwm.c
arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
arch/arm/plat-samsung/dev-pwm.c
arch/arm/plat-samsung/pwm-clock.c
arch/arm/plat-samsung/pwm.c
arch/mips/jz4740/pwm.c
arch/unicore32/kernel/pwm.c
drivers/leds/leds-atmel-pwm.c
drivers/leds/leds-pwm.c
drivers/mfd/twl6030-pwm.c
drivers/misc/ab8500-pwm.c
drivers/misc/atmel_pwm.c
drivers/misc/ep93xx_pwm.c

My rough feeling is that what this should look like is a new
subsystem that exports a set of operations and has specific
drivers, like:

drivers/pwm/Kconfig
drivers/pwm/pwm_core.c
drivers/pwm/pwm_pxa.c
drivers/pwm/pwm_unicore.c
drivers/pwm/pwm_st.c
drivers/pwm/pwm_...

This is in the spirit of turning code that is organized by platform
into code that is organized by subsystem, and factoring out the
common bits.

A real problem we are going to hit without this is the fact that each
of these drivers exports the same symbols, which prevents you from
building a multi-platform kernel. It will need to export the common
set of symbols and pass through operations to the individual drivers
then:

arnd at wuerfel:~/linux-2.6$ git ls-files |  grep pwm.c | xargs grep EXPORT_SYMBOL -h | sort | uniq -c
      1 EXPORT_SYMBOL(pwm_channel_alloc);
      1 EXPORT_SYMBOL(pwm_channel_free);
      1 EXPORT_SYMBOL(pwm_channel_handler);
      1 EXPORT_SYMBOL(__pwm_channel_onoff);
      1 EXPORT_SYMBOL(pwm_clk_alloc);
      1 EXPORT_SYMBOL(pwm_clk_free);
      7 EXPORT_SYMBOL(pwm_config);
      7 EXPORT_SYMBOL(pwm_disable);
      7 EXPORT_SYMBOL(pwm_enable);
      7 EXPORT_SYMBOL(pwm_free);
      7 EXPORT_SYMBOL(pwm_request);

As you can see here, the one driver is the odd one out, it provides a completely
different API. This is drivers/misc/atmel_pwm.c, and it should eventually get
converted over.

	Arnd
