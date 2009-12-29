From: andy@warmcat.com (Andy Green)
Date: Tue, 29 Dec 2009 14:40:36 +0000
Subject: [PATCH 3/4] smdk6410-add-chipselect-setup.patch
In-Reply-To: <20091229143756.15524.25160.stgit@hit-nxdomain.opendns.com>
References: <20091229143756.15524.25160.stgit@hit-nxdomain.opendns.com>
Message-ID: <20091229144036.15524.88967.stgit@hit-nxdomain.opendns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the mach-smdk6410.c file claims it can start up the
smsc9115 ethernet device on the board, it should take care
about configuring the necessary chip select nCS1 so it can
see the chip.  The select defaults to 8-bit mode so without
config the Ethernet doesn't work.

This patch uses the new SROM definitions to set nCS1 to the
state found in the Samsung U-Boot port for 6410.  It may be
more conservative that it needs to be since those settings
were marked as for CS8900A also using this chip select.

But this change is enough to get the ethernet working when
booted with Qi.

Signed-off-by: Andy Green <andy@warmcat.com>
---

 arch/arm/mach-s3c6410/mach-smdk6410.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index 480d297..d613932 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -49,6 +49,7 @@
 #include <plat/regs-modem.h>
 #include <plat/regs-gpio.h>
 #include <plat/regs-sys.h>
+#include <plat/regs-srom.h>
 #include <plat/iic.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
@@ -156,8 +157,8 @@ static struct s3c_fb_platdata smdk6410_lcd_pdata __initdata = {
 
 static struct resource smdk6410_smsc911x_resources[] = {
 	[0] = {
-		.start = 0x18000000,
-		.end   = 0x18000000 + SZ_64K - 1,
+		.start = S3C64XX_PA_XM0CSN1,
+		.end   = S3C64XX_PA_XM0CSN1 + SZ_64K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
@@ -429,10 +430,32 @@ static void __init smdk6410_map_io(void)
 
 static void __init smdk6410_machine_init(void)
 {
+	u32 cs1;
+
 	s3c_i2c0_set_platdata(NULL);
 	s3c_i2c1_set_platdata(NULL);
 	s3c_fb_set_platdata(&smdk6410_lcd_pdata);
 
+	/* configure nCS1 width to 16 bits */
+
+	cs1 = __raw_readl(S3C64XX_SROM_BW) &
+		    ~(S3C64XX_SROM_BW__CS_MASK << S3C64XX_SROM_BW__NCS1__SHIFT);
+	cs1 |= ((1 << S3C64XX_SROM_BW__DATAWIDTH__SHIFT) |
+		(1 << S3C64XX_SROM_BW__WAITENABLE__SHIFT) |
+		(1 << S3C64XX_SROM_BW__BYTEENABLE__SHIFT)) <<
+						   S3C64XX_SROM_BW__NCS1__SHIFT;
+	__raw_writel(cs1, S3C64XX_SROM_BW);
+
+	/* set timing for nCS1 suitable for ethernet chip */
+
+	__raw_writel((0 << S3C64XX_SROM_BCX__PMC__SHIFT) |
+		     (6 << S3C64XX_SROM_BCX__TACP__SHIFT) |
+		     (4 << S3C64XX_SROM_BCX__TCAH__SHIFT) |
+		     (1 << S3C64XX_SROM_BCX__TCOH__SHIFT) |
+		     (0xe << S3C64XX_SROM_BCX__TACC__SHIFT) |
+		     (4 << S3C64XX_SROM_BCX__TCOS__SHIFT) |
+		     (0 << S3C64XX_SROM_BCX__TACS__SHIFT), S3C64XX_SROM_BC1);
+
 	gpio_request(S3C64XX_GPN(5), "LCD power");
 	gpio_request(S3C64XX_GPF(13), "LCD power");
 	gpio_request(S3C64XX_GPF(15), "LCD power");
