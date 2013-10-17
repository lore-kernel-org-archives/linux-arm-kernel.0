From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 18 Oct 2013 08:38:22 +0900
Subject: [PATCH] ARM: s3c64xx: mini6410: Correct card detect type for
 HSMMC1
In-Reply-To: <1527511.ScaEHrLnaz@flatron>
References: <1380471121-9478-1-git-send-email-tomasz.figa@gmail.com>
 <1527511.ScaEHrLnaz@flatron>
Message-ID: <1e2a01cecb91$f790c700$e6b25500$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Kukjin,
> 
Hi,

> On Sunday 29 of September 2013 18:12:01 Tomasz Figa wrote:
> > According to board schematics, for HSMMC1 a GPIO line is used to detect
> > card presence, while currently it is being configured for internal card
> > detect line, which is multiplexed with card detect line of HSMMC0 and
> > thus breaking it.
> >
> > This patch adds proper sdhci platform data setting card detect type to
> > external GPIO and fixing operation of HSMMC0.
> >
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > ---
> >  arch/arm/mach-s3c64xx/mach-mini6410.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> Would you mind taking this patch to your tree?
> 
Applied, thanks.
Kukjin

> Best regards,
> Tomasz
> 
> > diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c
> > b/arch/arm/mach-s3c64xx/mach-mini6410.c index 58d46a3..97ae470 100644
> > --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> > @@ -36,7 +36,9 @@
> >  #include <plat/devs.h>
> >  #include <plat/fb.h>
> >  #include <linux/platform_data/mtd-nand-s3c2410.h>
> > +#include <linux/platform_data/mmc-sdhci-s3c.h>
> >  #include <plat/regs-serial.h>
> > +#include <plat/sdhci.h>
> >  #include <linux/platform_data/touchscreen-s3c2410.h>
> >
> >  #include <video/platform_lcd.h>
> > @@ -214,6 +216,13 @@ static struct platform_device mini6410_lcd_powerdev
> > = { .dev.platform_data	= &mini6410_lcd_power_data,
> >  };
> >
> > +static struct s3c_sdhci_platdata mini6410_hsmmc1_pdata = {
> > +	.max_width		= 4,
> > +	.cd_type		= S3C_SDHCI_CD_GPIO,
> > +	.ext_cd_gpio		= S3C64XX_GPN(10),
> > +	.ext_cd_gpio_invert	= true,
> > +};
> > +
> >  static struct platform_device *mini6410_devices[] __initdata = {
> >  	&mini6410_device_eth,
> >  	&s3c_device_hsmmc0,
> > @@ -321,6 +330,7 @@ static void __init mini6410_machine_init(void)
> >
> >  	s3c_nand_set_platdata(&mini6410_nand_info);
> >  	s3c_fb_set_platdata(&mini6410_lcd_pdata[features.lcd_index]);
> > +	s3c_sdhci1_set_platdata(&mini6410_hsmmc1_pdata);
> >  	s3c24xx_ts_set_platdata(NULL);
> >
> >  	/* configure nCS1 width to 16 bits */
