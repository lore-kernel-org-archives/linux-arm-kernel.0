From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  7 Mar 2012 02:36:52 -0800
Subject: [PATCH] ARM: S3C24XX: Fix Section mismatch
Message-ID: <1331116612-14491-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes following:

WARNING: arch/arm/mach-s3c24xx/built-in.o(.text+0x4464): Section mismatch in reference
from the function usb_simtec_init() to the (unknown reference) .init.data:(unknown)
The function usb_simtec_init() references
the (unknown reference) __initdata (unknown).
This is often because usb_simtec_init lacks a __initdata
annotation or the annotation of (unknown) is wrong.

WARNING: arch/arm/mach-s3c24xx/built-in.o(.data+0xf44): Section mismatch in reference
from the variable s3c2416_irq_interface to the function .init.text:s3c2416_irq_add()
The variable s3c2416_irq_interface references
the function __init s3c2416_irq_add()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: arch/arm/mach-s3c24xx/built-in.o(.data+0x1b80): Section mismatch in reference
from the variable s3c2443_irq_interface to the function .init.text:s3c2443_irq_add()
The variable s3c2443_irq_interface references
the function __init s3c2443_irq_add()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/irq-s3c2416.c |    2 +-
 arch/arm/mach-s3c24xx/irq-s3c2443.c |    2 +-
 arch/arm/mach-s3c24xx/simtec-usb.c  |    2 +-
 arch/arm/mach-s3c24xx/simtec.h      |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq-s3c2416.c b/arch/arm/mach-s3c24xx/irq-s3c2416.c
index b8a5836..59b7632 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c2416.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c2416.c
@@ -310,7 +310,7 @@ static int __init s3c2416_irq_add(struct device *dev)
 	return 0;
 }
 
-static struct subsys_interface s3c2416_irq_interface = {
+static struct subsys_interface s3c2416_irq_interface __initdata = {
 	.name		= "s3c2416_irq",
 	.subsys		= &s3c2416_subsys,
 	.add_dev	= s3c2416_irq_add,
diff --git a/arch/arm/mach-s3c24xx/irq-s3c2443.c b/arch/arm/mach-s3c24xx/irq-s3c2443.c
index 35e4ff2..439f186 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c2443.c
@@ -265,7 +265,7 @@ static int __init s3c2443_irq_add(struct device *dev)
 	return 0;
 }
 
-static struct subsys_interface s3c2443_irq_interface = {
+static struct subsys_interface s3c2443_irq_interface __initdata = {
 	.name		= "s3c2443_irq",
 	.subsys		= &s3c2443_subsys,
 	.add_dev	= s3c2443_irq_add,
diff --git a/arch/arm/mach-s3c24xx/simtec-usb.c b/arch/arm/mach-s3c24xx/simtec-usb.c
index d91c1a7..c303d1b 100644
--- a/arch/arm/mach-s3c24xx/simtec-usb.c
+++ b/arch/arm/mach-s3c24xx/simtec-usb.c
@@ -104,7 +104,7 @@ static struct s3c2410_hcd_info usb_simtec_info __initdata = {
 };
 
 
-int usb_simtec_init(void)
+int __init usb_simtec_init(void)
 {
 	int ret;
 
diff --git a/arch/arm/mach-s3c24xx/simtec.h b/arch/arm/mach-s3c24xx/simtec.h
index ae8f4f9..f514cd5 100644
--- a/arch/arm/mach-s3c24xx/simtec.h
+++ b/arch/arm/mach-s3c24xx/simtec.h
@@ -15,7 +15,7 @@ struct s3c24xx_audio_simtec_pdata;
 
 extern void nor_simtec_init(void);
 
-extern int usb_simtec_init(void);
+extern int __init usb_simtec_init(void);
 
 extern int simtec_audio_add(const char *codec_name, bool has_lr_routing,
 			    struct s3c24xx_audio_simtec_pdata *pdata);
-- 
1.7.4.4
