From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 22 Jul 2011 22:38:27 +0200
Subject: [PATCH 2/3] ARM: tegra: paz00: export the WIFI rfkill gpio
In-Reply-To: <201107151517.03176.anarsoul@gmail.com>
References: <1310725464-2524-1-git-send-email-marvin24@gmx.de>
	<1310725464-2524-3-git-send-email-marvin24@gmx.de>
	<201107151517.03176.anarsoul@gmail.com>
Message-ID: <201107222238.28131.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vasily,

On Friday 15 July 2011 14:17:02 Vasily Khoruzhick wrote:
> On Friday 15 July 2011 13:24:22 Marc Dietrich wrote:
> > This makes the WIFI rfkill gpio available to userspace. On boot,
> > WIFI will be unblocked by default.
> 
> Take a look on rfkill-gpio driver.

mmh, seems I don't understand that driver. I made a simple patch which roughly 
goes like this: 

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-
paz00.c
index e85711f..06b3089 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-tegra.h>
+#include <linux/rfkill-gpio.h>
 #include <linux/platform_data/tegra_usb.h>
 
 #include <asm/mach-types.h>

...

+static struct rfkill_gpio_platform_data rfkill_gpio_data = {
+       .name           = "rfkill-gpio",
+       .reset_gpio     = TEGRA_WIFI_RST,
+       .shutdown_gpio  = TEGRA_WIFI_PWRN,
+       .type           = RFKILL_TYPE_WLAN,
+};
+
+static struct platform_device rfkill_gpio = {
+       .name   = "rfkill_gpio",
+       .id     = -1,
+       .dev    = {
+               .platform_data  = &rfkill_gpio_data,
+       },
+};
+

@@ -327,6 +343,7 @@ static struct platform_device *paz00_devices[] __initdata = 
{
        &tegra_spi_device3,
        &tegra_spi_device4,
        &leds_gpio,
+       &rfkill_gpio,
        &tegra_gart_device,
        &tegra_i2s_device1,
        &tegra_das_device,

now I get two rfkill devices:

root at ac100:/sys/devices/platform/rfkill_gpio/rfkill/rfkill0# rfkill list; echo 0 
> state; sleep 5; rfkill list; echo 1 > state; sleep 5; rfkill list
0: rfkill-gpio: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
0: rfkill-gpio: Wireless LAN
        Soft blocked: yes
        Hard blocked: no
1: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: yes
0: rfkill-gpio: Wireless LAN
        Soft blocked: no
        Hard blocked: no
1: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no

writing echo 1 > state is equal to rfkill block 0, while rfkill block 1 seems to 
be the softblock of phy0.

Is it possible that the gpios (rst and pwrn) are exchanged?
Why do I get two devices: rfkill-gpio from rfkill-gpio driver and phy0 from the 
wifi driver? I guess the latter shows the current state of the chip and the 
first? The state of the "switch"?

Thanks 

Marc


> Regards
> Vasily
> 
> > Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> > ---
> > 
> >  arch/arm/mach-tegra/board-paz00-pinmux.c |    1 +
> >  arch/arm/mach-tegra/board-paz00.c        |   16 ++++++++++++++++
> >  arch/arm/mach-tegra/board-paz00.h        |    6 ++++++
> >  3 files changed, 23 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c
> > b/arch/arm/mach-tegra/board-paz00-pinmux.c index bdd2627..c02a48f 100644
> > --- a/arch/arm/mach-tegra/board-paz00-pinmux.c
> > +++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
> > @@ -145,6 +145,7 @@ static struct tegra_gpio_table gpio_table[] = {
> > 
> >  	{ .gpio = TEGRA_GPIO_SD1_WP,	.enable = true },
> >  	{ .gpio = TEGRA_GPIO_SD1_POWER,	.enable = true },
> >  	{ .gpio = TEGRA_ULPI_RST,	.enable = true },
> > 
> > +	{ .gpio = TEGRA_WIFI_PWRN,	.enable = true },
> > 
> >  };
> >  
> >  void paz00_pinmux_init(void)
> > 
> > diff --git a/arch/arm/mach-tegra/board-paz00.c
> > b/arch/arm/mach-tegra/board-paz00.c index 931b06e..0bc652b 100644
> > --- a/arch/arm/mach-tegra/board-paz00.c
> > +++ b/arch/arm/mach-tegra/board-paz00.c
> > @@ -25,6 +25,7 @@
> > 
> >  #include <linux/dma-mapping.h>
> >  #include <linux/pda_power.h>
> >  #include <linux/io.h>
> > 
> > +#include <linux/gpio.h>
> > 
> >  #include <linux/i2c.h>
> >  #include <linux/i2c-tegra.h>
> >  #include <linux/platform_data/tegra_usb.h>
> > 
> > @@ -165,6 +166,20 @@ static struct tegra_sdhci_platform_data sdhci_pdata4
> > = { .is_8bit	= 1,
> > 
> >  };
> > 
> > +static void __init paz00_wifi_init(void)
> > +{
> > +	int ret;
> > +
> > +	/* unlock hw rfkill */
> > +	ret = gpio_request_one(TEGRA_WIFI_PWRN, GPIOF_OUT_INIT_HIGH,
> > +		"wifi pwrn");
> > +	if (ret) {
> > +		pr_warning("WIFI: could not requestrfkill gpio\n");
> > +		return;
> > +	}
> > +	gpio_export(TEGRA_WIFI_PWRN, 0);
> > +};
> > +
> > 
> >  static void __init tegra_paz00_init(void)
> >  {
> >  
> >  	tegra_clk_init_from_table(paz00_clk_init_table);
> > 
> > @@ -178,6 +193,7 @@ static void __init tegra_paz00_init(void)
> > 
> >  	paz00_i2c_init();
> >  	paz00_usb_init();
> > 
> > +	paz00_wifi_init();
> > 
> >  }
> >  
> >  MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
> > 
> > diff --git a/arch/arm/mach-tegra/board-paz00.h
> > b/arch/arm/mach-tegra/board-paz00.h index d4ff39d..5d2849e 100644
> > --- a/arch/arm/mach-tegra/board-paz00.h
> > +++ b/arch/arm/mach-tegra/board-paz00.h
> > @@ -17,11 +17,17 @@
> > 
> >  #ifndef _MACH_TEGRA_BOARD_PAZ00_H
> >  #define _MACH_TEGRA_BOARD_PAZ00_H
> > 
> > +/* SDCARD */
> > 
> >  #define TEGRA_GPIO_SD1_CD		TEGRA_GPIO_PV5
> >  #define TEGRA_GPIO_SD1_WP		TEGRA_GPIO_PH1
> >  #define TEGRA_GPIO_SD1_POWER		TEGRA_GPIO_PT3
> > 
> > +
> > +/* ULPI */
> > 
> >  #define TEGRA_ULPI_RST			TEGRA_GPIO_PV0
> > 
> > +/* WIFI */
> > +#define TEGRA_WIFI_PWRN			TEGRA_GPIO_PK5
> > +
> > 
> >  void paz00_pinmux_init(void);
> >  
> >  #endif
