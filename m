From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 13 Sep 2013 19:17:10 +0300
Subject: [PATCH 0/8] IOP GPIO refactoring
In-Reply-To: <CACRpkdYbHTF0XGu-wLAeaw-nnSTEPh-ej9iizMbojmB8gzvb=Q@mail.gmail.com>
References: <1378741198-12847-1-git-send-email-linus.walleij@linaro.org>
 <20130910141434.GD3379@blackmetal.musicnaut.iki.fi>
 <CACRpkdYbHTF0XGu-wLAeaw-nnSTEPh-ej9iizMbojmB8gzvb=Q@mail.gmail.com>
Message-ID: <20130913161710.GA22033@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 13, 2013 at 10:15:58AM +0200, Linus Walleij wrote:
> On Tue, Sep 10, 2013 at 4:14 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > With patch 6 it starts to crash on first gpio_get_value(), I guess
> > because gpio-iop platform device is not registered on N2100...?
> 
> I think I've fixed this with the v2 versions of patches 1-3, you can
> pull in and test the entire stack on Torvalds HEAD from here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git iop-cleanup

It's still crashing. This should be done somewhere in the series:

diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index bc40a97..6266f0e 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -343,8 +343,14 @@ static int __init n2100_request_gpios(void)
 }
 device_initcall(n2100_request_gpios);
 
+static struct resource n2100_gpio_res[] = {
+	DEFINE_RES_MEM((IOP3XX_PERIPHERAL_PHYS_BASE + 0x07c4), 0x10),
+};
+
 static void __init n2100_init_machine(void)
 {
+	platform_device_register_simple("gpio-iop", 0, n2100_gpio_res,
+					ARRAY_SIZE(n2100_gpio_res));
 	platform_device_register(&iop3xx_i2c0_device);
 	platform_device_register(&n2100_flash_device);
 	platform_device_register(&n2100_serial_device);

A.
