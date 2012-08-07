From: p.paneri@samsung.com (Praveen Paneri)
Date: Tue, 7 Aug 2012 16:19:21 +0530
Subject: [PATCH v2 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
In-Reply-To: <098c01cd7483$6a93eeb0$3fbbcc10$%kim@samsung.com>
References: <1344324524-2286-1-git-send-email-p.paneri@samsung.com>
 <098c01cd7483$6a93eeb0$3fbbcc10$%kim@samsung.com>
Message-ID: <CAD6zSYNq+7daWqER1PNaDCiTVrn72B1vGW0e3etZJJUxSnkdOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2012 at 3:30 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Praveen Paneri wrote:
>>
>> Changes from v1:
>> Rebased patches to latest usb-next branch
>> Changed the name 'sec_usbphy' to 'samsung_usbphy'
>>
> Yes, looks better. But I'm not sure Felipe or Greg would prefer to use '_'
> not '-'...you used samsung-usbphy as a name in your patch.
Are you suggesting to change the name to 'samsung-usbphy' instead?
>
>> This patch set introduces a phy driver for samsung SoCs. It uses the
>> existing
>> transceiver infrastructure to provide phy control functions. Use of this
>> driver
>> can be extended for usb host phy as well. Over the period of time all the
>> phy
>> related code for most of the samsung SoCs can be integrated here.
>> Removing the existing phy code from mach-s3c64xx but not from other
>> machine
>
> Why? Is there any reason? After quick looking at your patches, seems this
> can remove all of setup-usb-phy in arch/arm/ for Samsung stuff. In addition,
> the isolation hook function also can be put in this by using platform_data
> or dt parsing.
No particular reason for it. Yes it can remove all of the setup-usbphy
code. I will send separate patches adding the support for other SoCs
and removing the phy related code from arch/arm.
>
>> code.This driver is tested with smdk6410 and Exynos4210(with DT).
>>
> I and my colleague, Yulgon will comment on this series soon.
That would be great. Will wait for that. You may use below patch to
add dt support for s3c-hsotg to test it on V310 board.

diff --git a/arch/arm/boot/dts/exynos4210.dtsi
b/arch/arm/boot/dts/exynos4210.dtsi
index e28cf10..de3cc78 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -67,6 +67,12 @@
 		reg = <0x125B0000 0x100>;
 	};

+	usbotg at 12480000 {
+		compatible = "samsung,exynos4210-hsotg";
+		reg = <0x12480000 0x20000>;
+		interrupts = <0 71 0>;
+	};
+
 	keypad at 100A0000 {
 		compatible = "samsung,s5pv210-keypad";
 		reg = <0x100A0000 0x100>;
diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index f4ba9a3..79b77ff 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -26,6 +26,7 @@
 #include <linux/seq_file.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
@@ -3719,10 +3720,23 @@ static int __devexit s3c_hsotg_remove(struct
platform_device *pdev)
 #define s3c_hsotg_resume NULL
 #endif

+#ifdef CONFIG_OF
+static const struct of_device_id s3c_hsotg_dt_match[] = {
+	{
+		.compatible = "samsung,exynos4210-hsotg",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, s3c_usbphy_dt_match);
+#else
+#define s3c_hsotg_dt_match NULL
+#endif
+
 static struct platform_driver s3c_hsotg_driver = {
 	.driver		= {
 		.name	= "s3c-hsotg",
 		.owner	= THIS_MODULE,
+		.of_match_table = s3c_hsotg_dt_match,
 	},
 	.probe		= s3c_hsotg_probe,
 	.remove		= __devexit_p(s3c_hsotg_remove),

Thanks
Praveen
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
>> Praveen Paneri (5):
>>   usb: phy: samsung: Introducing usb phy driver for hsotg
>>   usb: s3c-hsotg: Adding phy driver support
>>   ARM: S3C64XX: Removing old phy setup code
>>   ARM: S3C64XX: Enabling samsung_usbphy driver
>>   ARM: Exynos4210: Enabling samsung_usbphy driver
>>
>>  .../devicetree/bindings/usb/samsung-usbphy.txt     |    9 +
>>  arch/arm/boot/dts/exynos4210.dtsi                  |    5 +
>>  arch/arm/mach-exynos/include/mach/map.h            |    1 +
>>  arch/arm/mach-exynos/mach-exynos4-dt.c             |    8 +
>>  arch/arm/mach-exynos/setup-usb-phy.c               |   13 +
>>  arch/arm/mach-s3c64xx/include/mach/map.h           |    2 +
>>  arch/arm/mach-s3c64xx/mach-crag6410.c              |    5 +-
>>  arch/arm/mach-s3c64xx/mach-smartq.c                |    6 +-
>>  arch/arm/mach-s3c64xx/mach-smdk6410.c              |    5 +-
>>  arch/arm/mach-s3c64xx/setup-usb-phy.c              |   79 +----
>>  arch/arm/plat-samsung/devs.c                       |   32 ++
>>  arch/arm/plat-samsung/include/plat/devs.h          |    1 +
>>  arch/arm/plat-samsung/include/plat/usb-phy.h       |    1 +
>>  drivers/usb/gadget/s3c-hsotg.c                     |   38 ++-
>>  drivers/usb/phy/Kconfig                            |    8 +
>>  drivers/usb/phy/Makefile                           |    1 +
>>  drivers/usb/phy/samsung_usbphy.c                   |  355
> ++++++++++++++++++++
>>  drivers/usb/phy/samsung_usbphy.h                   |   48 +++
>>  include/linux/platform_data/s3c-hsotg.h            |    5 +
>>  19 files changed, 534 insertions(+), 88 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/usb/samsung-
>> usbphy.txt
>>  create mode 100644 drivers/usb/phy/samsung_usbphy.c
>>  create mode 100644 drivers/usb/phy/samsung_usbphy.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
