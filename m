From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 13 May 2010 18:09:27 +0800
Subject: [PATCH 1/3] pxa: append tavorevb3 support
Message-ID: <mailman.211.1282733027.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bringup tavorevb3 development platform. UART and PMIC are enabled.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/Kconfig                   |    4 +
 arch/arm/mach-pxa/Makefile                  |    1 +
 arch/arm/mach-pxa/include/mach/mfp-pxa930.h |    7 ++
 arch/arm/mach-pxa/pxa930.c                  |    2 +-
 arch/arm/mach-pxa/tavorevb3.c               |  136 +++++++++++++++++++++++++++
 5 files changed, 149 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-pxa/tavorevb3.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 2bfcd10..4b83b9b 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -41,6 +41,10 @@ config MACH_TAVOREVB
 	select PXA3xx
 	select CPU_PXA930

+config MACH_TAVOREVB3
+	bool "PXA95x Development Platform (aka TavorEVB III)"
+	select CPU_PXA950
+
 config MACH_SAAR
 	bool "PXA930 Handheld Platform (aka SAAR)"
 	select PXA3xx
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 85c7fb3..28eef69 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_MACH_ZYLONITE300)	+= zylonite.o zylonite_pxa300.o
 obj-$(CONFIG_MACH_ZYLONITE320)	+= zylonite.o zylonite_pxa320.o
 obj-$(CONFIG_MACH_LITTLETON)	+= littleton.o
 obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
+obj-$(CONFIG_MACH_TAVOREVB3)	+= tavorevb3.o
 obj-$(CONFIG_MACH_SAAR)		+= saar.o

 # 3rd Party Dev Platforms
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
b/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
index 0d119d3..04f7c97 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
@@ -69,6 +69,7 @@
 #define nBE0_GPIO_60		MFP_CFG(nBE0, AF0)
 #define nBE1_GPIO_61		MFP_CFG(nBE1, AF0)
 #define RDY_GPIO_62		MFP_CFG(RDY, AF0)
+#define PMIC_INT_GPIO83		MFP_CFG_LPM(PMIC_INT, AF0, PULL_HIGH)

 /* Chip Select */
 #define DF_nCS0_nCS2		MFP_CFG_LPM(DF_nCS0, AF3, PULL_HIGH)
@@ -92,6 +93,9 @@
 #define GPIO63_CI2C_SCL		MFP_CFG_LPM(GPIO63, AF4, PULL_HIGH)
 #define GPIO64_CI2C_SDA		MFP_CFG_LPM(GPIO64, AF4, PULL_HIGH)

+#define GPIO73_CI2C_SCL		MFP_CFG_LPM(GPIO73, AF1, PULL_HIGH)
+#define GPIO74_CI2C_SDA		MFP_CFG_LPM(GPIO74, AF1, PULL_HIGH)
+
 #define GPIO77_CI2C_SCL		MFP_CFG_LPM(GPIO77, AF2, PULL_HIGH)
 #define GPIO78_CI2C_SDA		MFP_CFG_LPM(GPIO78, AF2, PULL_HIGH)

@@ -345,6 +349,9 @@
 #define GPIO69_UART1_CTS	MFP_CFG(GPIO69, AF2)
 #define GPIO70_UART1_RTS	MFP_CFG(GPIO70, AF2)

+#define GPIO53_UART1_TXD	MFP_CFG(GPIO53, AF2)
+#define GPIO54_UART1_RXD	MFP_CFG(GPIO54, AF2)
+
 /* UART2 - BTUART */
 #define GPIO91_UART2_RXD	MFP_CFG(GPIO91, AF1)
 #define GPIO92_UART2_TXD	MFP_CFG(GPIO92, AF1)
diff --git a/arch/arm/mach-pxa/pxa930.c b/arch/arm/mach-pxa/pxa930.c
index 0642920..7d29dd3 100644
--- a/arch/arm/mach-pxa/pxa930.c
+++ b/arch/arm/mach-pxa/pxa930.c
@@ -192,7 +192,7 @@ static struct mfp_addr_map pxa935_mfp_addr_map[]
__initdata = {

 static int __init pxa930_init(void)
 {
-	if (cpu_is_pxa930() || cpu_is_pxa935()) {
+	if (cpu_is_pxa930() || cpu_is_pxa935() || cpu_is_pxa950()) {
 		mfp_init_base(io_p2v(MFPR_BASE));
 		mfp_init_addr(pxa930_mfp_addr_map);
 	}
diff --git a/arch/arm/mach-pxa/tavorevb3.c b/arch/arm/mach-pxa/tavorevb3.c
new file mode 100644
index 0000000..5eeba64
--- /dev/null
+++ b/arch/arm/mach-pxa/tavorevb3.c
@@ -0,0 +1,136 @@
+/*
+ *  linux/arch/arm/mach-pxa/tavorevb3.c
+ *
+ *  Support for the Marvell EVB3 Development Platform.
+ *
+ *  Copyright:  (C) Copyright 2008-2010 Marvell International Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/mfd/88pm860x.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/pxa930.h>
+
+#include <plat/i2c.h>
+
+#include "devices.h"
+#include "generic.h"
+
+#define TAVOREVB3_NR_IRQS	(IRQ_BOARD_START + 24)
+
+static mfp_cfg_t evb3_mfp_cfg[] __initdata = {
+	/* UART */
+	GPIO53_UART1_TXD,
+	GPIO54_UART1_RXD,
+
+	/* PMIC */
+	PMIC_INT_GPIO83,
+};
+
+#if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
+static struct pm860x_touch_pdata evb3_touch = {
+	.gpadc_prebias	= 1,
+	.slot_cycle	= 1,
+	.tsi_prebias	= 6,
+	.pen_prebias	= 16,
+	.pen_prechg	= 2,
+	.res_x		= 300,
+};
+
+static struct pm860x_backlight_pdata evb3_backlight[] = {
+	{
+		.id	= PM8606_ID_BACKLIGHT,
+		.iset	= PM8606_WLED_CURRENT(24),
+		.flags	= PM8606_BACKLIGHT1,
+	},
+	{},
+};
+
+static struct pm860x_led_pdata evb3_led[] = {
+	{
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED1_RED,
+	}, {
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED1_GREEN,
+	}, {
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED1_BLUE,
+	}, {
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED2_RED,
+	}, {
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED2_GREEN,
+	}, {
+		.id	= PM8606_ID_LED,
+		.iset	= PM8606_LED_CURRENT(12),
+		.flags	= PM8606_LED2_BLUE,
+	},
+};
+
+static struct pm860x_platform_data evb3_pm8607_info = {
+	.touch				= &evb3_touch,
+	.backlight			= &evb3_backlight[0],
+	.led				= &evb3_led[0],
+	.companion_addr			= 0x10,
+	.irq_mode			= 0,
+	.irq_base			= IRQ_BOARD_START,
+
+	.i2c_port			= GI2C_PORT,
+};
+
+static struct i2c_board_info evb3_i2c_info[] = {
+	{
+		.type		= "88PM860x",
+		.addr		= 0x34,
+		.platform_data	= &evb3_pm8607_info,
+		.irq		= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO83)),
+	},
+};
+
+static void __init evb3_init_i2c(void)
+{
+	pxa_set_i2c_info(NULL);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(evb3_i2c_info));
+}
+#else
+static inline void evb3_init_i2c(void) {}
+#endif
+
+static void __init evb3_init(void)
+{
+	/* initialize MFP configurations */
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(evb3_mfp_cfg));
+
+	pxa_set_ffuart_info(NULL);
+
+	evb3_init_i2c();
+}
+
+MACHINE_START(TAVOREVB3, "PXA950 Evaluation Board (aka TavorEVB3)")
+	.phys_io	= 0x40000000,
+	.boot_params	= 0xa0000100,
+	.map_io         = pxa_map_io,
+	.nr_irqs	= TAVOREVB3_NR_IRQS,
+	.init_irq       = pxa3xx_init_irq,
+	.timer          = &pxa_timer,
+	.init_machine   = evb3_init,
+MACHINE_END
-- 
1.5.6.5

--001485f5ce5cfac746048ea38df3
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-pxa-append-tavorevb3-support.patch"
Content-Disposition: attachment; 
	filename="0001-pxa-append-tavorevb3-support.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gda1uqvj0

RnJvbSBiYjZkYjQ3YWRhZThkMGNlMWExMmMzNTNjN2Q4OThiZDNjMTk3ZDg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFRodSwgMTMgTWF5IDIwMTAgMTg6MDk6MjcgKzA4MDAKU3ViamVjdDogW1BB
VENIIDEvM10gcHhhOiBhcHBlbmQgdGF2b3JldmIzIHN1cHBvcnQKCkJyaW5ndXAgdGF2b3JldmIz
IGRldmVsb3BtZW50IHBsYXRmb3JtLiBVQVJUIGFuZCBQTUlDIGFyZSBlbmFibGVkLgoKU2lnbmVk
LW9mZi1ieTogSGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgotLS0K
IGFyY2gvYXJtL21hY2gtcHhhL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgICA0ICsKIGFy
Y2gvYXJtL21hY2gtcHhhL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgICAxICsKIGFyY2gv
YXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9tZnAtcHhhOTMwLmggfCAgICA3ICsrCiBhcmNoL2Fy
bS9tYWNoLXB4YS9weGE5MzAuYyAgICAgICAgICAgICAgICAgIHwgICAgMiArLQogYXJjaC9hcm0v
bWFjaC1weGEvdGF2b3JldmIzLmMgICAgICAgICAgICAgICB8ICAxMzYgKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDE0OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtcHhhL3Rhdm9yZXZiMy5j
CgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1weGEvS2NvbmZpZyBiL2FyY2gvYXJtL21hY2gt
cHhhL0tjb25maWcKaW5kZXggMmJmY2QxMC4uNGI4M2I5YiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0v
bWFjaC1weGEvS2NvbmZpZworKysgYi9hcmNoL2FybS9tYWNoLXB4YS9LY29uZmlnCkBAIC00MSw2
ICs0MSwxMCBAQCBjb25maWcgTUFDSF9UQVZPUkVWQgogCXNlbGVjdCBQWEEzeHgKIAlzZWxlY3Qg
Q1BVX1BYQTkzMAogCitjb25maWcgTUFDSF9UQVZPUkVWQjMKKwlib29sICJQWEE5NXggRGV2ZWxv
cG1lbnQgUGxhdGZvcm0gKGFrYSBUYXZvckVWQiBJSUkpIgorCXNlbGVjdCBDUFVfUFhBOTUwCisK
IGNvbmZpZyBNQUNIX1NBQVIKIAlib29sICJQWEE5MzAgSGFuZGhlbGQgUGxhdGZvcm0gKGFrYSBT
QUFSKSIKIAlzZWxlY3QgUFhBM3h4CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXB4YS9NYWtl
ZmlsZSBiL2FyY2gvYXJtL21hY2gtcHhhL01ha2VmaWxlCmluZGV4IDg1YzdmYjMuLjI4ZWVmNjkg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtcHhhL01ha2VmaWxlCisrKyBiL2FyY2gvYXJtL21h
Y2gtcHhhL01ha2VmaWxlCkBAIC0zMiw2ICszMiw3IEBAIG9iai0kKENPTkZJR19NQUNIX1pZTE9O
SVRFMzAwKQkrPSB6eWxvbml0ZS5vIHp5bG9uaXRlX3B4YTMwMC5vCiBvYmotJChDT05GSUdfTUFD
SF9aWUxPTklURTMyMCkJKz0genlsb25pdGUubyB6eWxvbml0ZV9weGEzMjAubwogb2JqLSQoQ09O
RklHX01BQ0hfTElUVExFVE9OKQkrPSBsaXR0bGV0b24ubwogb2JqLSQoQ09ORklHX01BQ0hfVEFW
T1JFVkIpCSs9IHRhdm9yZXZiLm8KK29iai0kKENPTkZJR19NQUNIX1RBVk9SRVZCMykJKz0gdGF2
b3JldmIzLm8KIG9iai0kKENPTkZJR19NQUNIX1NBQVIpCQkrPSBzYWFyLm8KIAogIyAzcmQgUGFy
dHkgRGV2IFBsYXRmb3JtcwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9t
YWNoL21mcC1weGE5MzAuaCBiL2FyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9tZnAtcHhh
OTMwLmgKaW5kZXggMGQxMTlkMy4uMDRmN2M5NyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1w
eGEvaW5jbHVkZS9tYWNoL21mcC1weGE5MzAuaAorKysgYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNs
dWRlL21hY2gvbWZwLXB4YTkzMC5oCkBAIC02OSw2ICs2OSw3IEBACiAjZGVmaW5lIG5CRTBfR1BJ
T182MAkJTUZQX0NGRyhuQkUwLCBBRjApCiAjZGVmaW5lIG5CRTFfR1BJT182MQkJTUZQX0NGRyhu
QkUxLCBBRjApCiAjZGVmaW5lIFJEWV9HUElPXzYyCQlNRlBfQ0ZHKFJEWSwgQUYwKQorI2RlZmlu
ZSBQTUlDX0lOVF9HUElPODMJCU1GUF9DRkdfTFBNKFBNSUNfSU5ULCBBRjAsIFBVTExfSElHSCkK
IAogLyogQ2hpcCBTZWxlY3QgKi8KICNkZWZpbmUgREZfbkNTMF9uQ1MyCQlNRlBfQ0ZHX0xQTShE
Rl9uQ1MwLCBBRjMsIFBVTExfSElHSCkKQEAgLTkyLDYgKzkzLDkgQEAKICNkZWZpbmUgR1BJTzYz
X0NJMkNfU0NMCQlNRlBfQ0ZHX0xQTShHUElPNjMsIEFGNCwgUFVMTF9ISUdIKQogI2RlZmluZSBH
UElPNjRfQ0kyQ19TREEJCU1GUF9DRkdfTFBNKEdQSU82NCwgQUY0LCBQVUxMX0hJR0gpCiAKKyNk
ZWZpbmUgR1BJTzczX0NJMkNfU0NMCQlNRlBfQ0ZHX0xQTShHUElPNzMsIEFGMSwgUFVMTF9ISUdI
KQorI2RlZmluZSBHUElPNzRfQ0kyQ19TREEJCU1GUF9DRkdfTFBNKEdQSU83NCwgQUYxLCBQVUxM
X0hJR0gpCisKICNkZWZpbmUgR1BJTzc3X0NJMkNfU0NMCQlNRlBfQ0ZHX0xQTShHUElPNzcsIEFG
MiwgUFVMTF9ISUdIKQogI2RlZmluZSBHUElPNzhfQ0kyQ19TREEJCU1GUF9DRkdfTFBNKEdQSU83
OCwgQUYyLCBQVUxMX0hJR0gpCiAKQEAgLTM0NSw2ICszNDksOSBAQAogI2RlZmluZSBHUElPNjlf
VUFSVDFfQ1RTCU1GUF9DRkcoR1BJTzY5LCBBRjIpCiAjZGVmaW5lIEdQSU83MF9VQVJUMV9SVFMJ
TUZQX0NGRyhHUElPNzAsIEFGMikKIAorI2RlZmluZSBHUElPNTNfVUFSVDFfVFhECU1GUF9DRkco
R1BJTzUzLCBBRjIpCisjZGVmaW5lIEdQSU81NF9VQVJUMV9SWEQJTUZQX0NGRyhHUElPNTQsIEFG
MikKKwogLyogVUFSVDIgLSBCVFVBUlQgKi8KICNkZWZpbmUgR1BJTzkxX1VBUlQyX1JYRAlNRlBf
Q0ZHKEdQSU85MSwgQUYxKQogI2RlZmluZSBHUElPOTJfVUFSVDJfVFhECU1GUF9DRkcoR1BJTzky
LCBBRjEpCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXB4YS9weGE5MzAuYyBiL2FyY2gvYXJt
L21hY2gtcHhhL3B4YTkzMC5jCmluZGV4IDA2NDI5MjAuLjdkMjlkZDMgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL21hY2gtcHhhL3B4YTkzMC5jCisrKyBiL2FyY2gvYXJtL21hY2gtcHhhL3B4YTkzMC5j
CkBAIC0xOTIsNyArMTkyLDcgQEAgc3RhdGljIHN0cnVjdCBtZnBfYWRkcl9tYXAgcHhhOTM1X21m
cF9hZGRyX21hcFtdIF9faW5pdGRhdGEgPSB7CiAKIHN0YXRpYyBpbnQgX19pbml0IHB4YTkzMF9p
bml0KHZvaWQpCiB7Ci0JaWYgKGNwdV9pc19weGE5MzAoKSB8fCBjcHVfaXNfcHhhOTM1KCkpIHsK
KwlpZiAoY3B1X2lzX3B4YTkzMCgpIHx8IGNwdV9pc19weGE5MzUoKSB8fCBjcHVfaXNfcHhhOTUw
KCkpIHsKIAkJbWZwX2luaXRfYmFzZShpb19wMnYoTUZQUl9CQVNFKSk7CiAJCW1mcF9pbml0X2Fk
ZHIocHhhOTMwX21mcF9hZGRyX21hcCk7CiAJfQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1w
eGEvdGF2b3JldmIzLmMgYi9hcmNoL2FybS9tYWNoLXB4YS90YXZvcmV2YjMuYwpuZXcgZmlsZSBt
b2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi41ZWViYTY0Ci0tLSAvZGV2L251bGwKKysrIGIvYXJj
aC9hcm0vbWFjaC1weGEvdGF2b3JldmIzLmMKQEAgLTAsMCArMSwxMzYgQEAKKy8qCisgKiAgbGlu
dXgvYXJjaC9hcm0vbWFjaC1weGEvdGF2b3JldmIzLmMKKyAqCisgKiAgU3VwcG9ydCBmb3IgdGhl
IE1hcnZlbGwgRVZCMyBEZXZlbG9wbWVudCBQbGF0Zm9ybS4KKyAqCisgKiAgQ29weXJpZ2h0OiAg
KEMpIENvcHlyaWdodCAyMDA4LTIwMTAgTWFydmVsbCBJbnRlcm5hdGlvbmFsIEx0ZC4KKyAqCisg
KiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0
IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcworICogIHB1Ymxpc2hoZWQgYnkgdGhlIEZyZWUg
U29mdHdhcmUgRm91bmRhdGlvbi4KKyAqLworCisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5o
PgorI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgorI2luY2x1ZGUgPGxpbnV4L2kyYy5oPgor
I2luY2x1ZGUgPGxpbnV4L2dwaW8uaD4KKyNpbmNsdWRlIDxsaW51eC9tZmQvODhwbTg2MHguaD4K
KworI2luY2x1ZGUgPGFzbS9tYWNoLXR5cGVzLmg+CisjaW5jbHVkZSA8YXNtL21hY2gvYXJjaC5o
PgorCisjaW5jbHVkZSA8bWFjaC9weGE5MzAuaD4KKworI2luY2x1ZGUgPHBsYXQvaTJjLmg+CisK
KyNpbmNsdWRlICJkZXZpY2VzLmgiCisjaW5jbHVkZSAiZ2VuZXJpYy5oIgorCisjZGVmaW5lIFRB
Vk9SRVZCM19OUl9JUlFTCShJUlFfQk9BUkRfU1RBUlQgKyAyNCkKKworc3RhdGljIG1mcF9jZmdf
dCBldmIzX21mcF9jZmdbXSBfX2luaXRkYXRhID0geworCS8qIFVBUlQgKi8KKwlHUElPNTNfVUFS
VDFfVFhELAorCUdQSU81NF9VQVJUMV9SWEQsCisKKwkvKiBQTUlDICovCisJUE1JQ19JTlRfR1BJ
TzgzLAorfTsKKworI2lmIGRlZmluZWQoQ09ORklHX0kyQ19QWEEpIHx8IGRlZmluZWQoQ09ORklH
X0kyQ19QWEFfTU9EVUxFKQorc3RhdGljIHN0cnVjdCBwbTg2MHhfdG91Y2hfcGRhdGEgZXZiM190
b3VjaCA9IHsKKwkuZ3BhZGNfcHJlYmlhcwk9IDEsCisJLnNsb3RfY3ljbGUJPSAxLAorCS50c2lf
cHJlYmlhcwk9IDYsCisJLnBlbl9wcmViaWFzCT0gMTYsCisJLnBlbl9wcmVjaGcJPSAyLAorCS5y
ZXNfeAkJPSAzMDAsCit9OworCitzdGF0aWMgc3RydWN0IHBtODYweF9iYWNrbGlnaHRfcGRhdGEg
ZXZiM19iYWNrbGlnaHRbXSA9IHsKKwl7CisJCS5pZAk9IFBNODYwNl9JRF9CQUNLTElHSFQsCisJ
CS5pc2V0CT0gUE04NjA2X1dMRURfQ1VSUkVOVCgyNCksCisJCS5mbGFncwk9IFBNODYwNl9CQUNL
TElHSFQxLAorCX0sCisJe30sCit9OworCitzdGF0aWMgc3RydWN0IHBtODYweF9sZWRfcGRhdGEg
ZXZiM19sZWRbXSA9IHsKKwl7CisJCS5pZAk9IFBNODYwNl9JRF9MRUQsCisJCS5pc2V0CT0gUE04
NjA2X0xFRF9DVVJSRU5UKDEyKSwKKwkJLmZsYWdzCT0gUE04NjA2X0xFRDFfUkVELAorCX0sIHsK
KwkJLmlkCT0gUE04NjA2X0lEX0xFRCwKKwkJLmlzZXQJPSBQTTg2MDZfTEVEX0NVUlJFTlQoMTIp
LAorCQkuZmxhZ3MJPSBQTTg2MDZfTEVEMV9HUkVFTiwKKwl9LCB7CisJCS5pZAk9IFBNODYwNl9J
RF9MRUQsCisJCS5pc2V0CT0gUE04NjA2X0xFRF9DVVJSRU5UKDEyKSwKKwkJLmZsYWdzCT0gUE04
NjA2X0xFRDFfQkxVRSwKKwl9LCB7CisJCS5pZAk9IFBNODYwNl9JRF9MRUQsCisJCS5pc2V0CT0g
UE04NjA2X0xFRF9DVVJSRU5UKDEyKSwKKwkJLmZsYWdzCT0gUE04NjA2X0xFRDJfUkVELAorCX0s
IHsKKwkJLmlkCT0gUE04NjA2X0lEX0xFRCwKKwkJLmlzZXQJPSBQTTg2MDZfTEVEX0NVUlJFTlQo
MTIpLAorCQkuZmxhZ3MJPSBQTTg2MDZfTEVEMl9HUkVFTiwKKwl9LCB7CisJCS5pZAk9IFBNODYw
Nl9JRF9MRUQsCisJCS5pc2V0CT0gUE04NjA2X0xFRF9DVVJSRU5UKDEyKSwKKwkJLmZsYWdzCT0g
UE04NjA2X0xFRDJfQkxVRSwKKwl9LAorfTsKKworc3RhdGljIHN0cnVjdCBwbTg2MHhfcGxhdGZv
cm1fZGF0YSBldmIzX3BtODYwN19pbmZvID0geworCS50b3VjaAkJCQk9ICZldmIzX3RvdWNoLAor
CS5iYWNrbGlnaHQJCQk9ICZldmIzX2JhY2tsaWdodFswXSwKKwkubGVkCQkJCT0gJmV2YjNfbGVk
WzBdLAorCS5jb21wYW5pb25fYWRkcgkJCT0gMHgxMCwKKwkuaXJxX21vZGUJCQk9IDAsCisJLmly
cV9iYXNlCQkJPSBJUlFfQk9BUkRfU1RBUlQsCisKKwkuaTJjX3BvcnQJCQk9IEdJMkNfUE9SVCwK
K307CisKK3N0YXRpYyBzdHJ1Y3QgaTJjX2JvYXJkX2luZm8gZXZiM19pMmNfaW5mb1tdID0gewor
CXsKKwkJLnR5cGUJCT0gIjg4UE04NjB4IiwKKwkJLmFkZHIJCT0gMHgzNCwKKwkJLnBsYXRmb3Jt
X2RhdGEJPSAmZXZiM19wbTg2MDdfaW5mbywKKwkJLmlycQkJPSBncGlvX3RvX2lycShtZnBfdG9f
Z3BpbyhNRlBfUElOX0dQSU84MykpLAorCX0sCit9OworCitzdGF0aWMgdm9pZCBfX2luaXQgZXZi
M19pbml0X2kyYyh2b2lkKQoreworCXB4YV9zZXRfaTJjX2luZm8oTlVMTCk7CisJaTJjX3JlZ2lz
dGVyX2JvYXJkX2luZm8oMCwgQVJSQVlfQU5EX1NJWkUoZXZiM19pMmNfaW5mbykpOworfQorI2Vs
c2UKK3N0YXRpYyBpbmxpbmUgdm9pZCBldmIzX2luaXRfaTJjKHZvaWQpIHt9CisjZW5kaWYKKwor
c3RhdGljIHZvaWQgX19pbml0IGV2YjNfaW5pdCh2b2lkKQoreworCS8qIGluaXRpYWxpemUgTUZQ
IGNvbmZpZ3VyYXRpb25zICovCisJcHhhM3h4X21mcF9jb25maWcoQVJSQVlfQU5EX1NJWkUoZXZi
M19tZnBfY2ZnKSk7CisKKwlweGFfc2V0X2ZmdWFydF9pbmZvKE5VTEwpOworCisJZXZiM19pbml0
X2kyYygpOworfQorCitNQUNISU5FX1NUQVJUKFRBVk9SRVZCMywgIlBYQTk1MCBFdmFsdWF0aW9u
IEJvYXJkIChha2EgVGF2b3JFVkIzKSIpCisJLnBoeXNfaW8JPSAweDQwMDAwMDAwLAorCS5ib290
X3BhcmFtcwk9IDB4YTAwMDAxMDAsCisJLm1hcF9pbyAgICAgICAgID0gcHhhX21hcF9pbywKKwku
bnJfaXJxcwk9IFRBVk9SRVZCM19OUl9JUlFTLAorCS5pbml0X2lycSAgICAgICA9IHB4YTN4eF9p
bml0X2lycSwKKwkudGltZXIgICAgICAgICAgPSAmcHhhX3RpbWVyLAorCS5pbml0X21hY2hpbmUg
ICA9IGV2YjNfaW5pdCwKK01BQ0hJTkVfRU5ECi0tIAoxLjUuNi41Cgo=
--001485f5ce5cfac746048ea38df3--
