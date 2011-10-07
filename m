From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri,  7 Oct 2011 17:25:13 +0530
Subject: [PATCH V2 2/2] ARM: S3C2410: irq: Remove __init attributes to fix
	compilation warning
In-Reply-To: <1317988513-20800-1-git-send-email-tushar.behera@linaro.org>
References: <1317988513-20800-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1317988513-20800-3-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The structure *_irq_driver is passed as a parameter in
sysdev_driver_register(). This in turn would add this structure to a
list which may be traversed later.

Hence, even though the functions referenced through this structure have
__init attribute, we cannot possibly add __initdata attribute to it.

To remove compilation warnings, the functions referenced thorugh this
structure are also defined without __init attribute.

It removes following two warnings.

WARNING: vmlinux.o(.data+0x4f58): Section mismatch in reference from the
variable s3c2416_irq_driver to the function .init.text:s3c2416_irq_add()
The variable s3c2416_irq_driver references the function __init s3c2416_irq_add()

WARNING: vmlinux.o(.data+0x7c50): Section mismatch in reference from the
variable s3c2443_irq_driver to the function .init.text:s3c2443_irq_add()
The variable s3c2443_irq_driver references the function __init s3c2443_irq_add()

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c2416/irq.c |    4 ++--
 arch/arm/mach-s3c2443/irq.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2416/irq.c b/arch/arm/mach-s3c2416/irq.c
index 28ad20d..53e8e57 100644
--- a/arch/arm/mach-s3c2416/irq.c
+++ b/arch/arm/mach-s3c2416/irq.c
@@ -194,7 +194,7 @@ static struct irq_chip s3c2416_irq_uart3 = {
 
 /* IRQ initialisation code */
 
-static int __init s3c2416_add_sub(unsigned int base,
+static int s3c2416_add_sub(unsigned int base,
 				   void (*demux)(unsigned int,
 						 struct irq_desc *),
 				   struct irq_chip *chip,
@@ -213,7 +213,7 @@ static int __init s3c2416_add_sub(unsigned int base,
 	return 0;
 }
 
-static int __init s3c2416_irq_add(struct sys_device *sysdev)
+static int s3c2416_irq_add(struct sys_device *sysdev)
 {
 	printk(KERN_INFO "S3C2416: IRQ Support\n");
 
diff --git a/arch/arm/mach-s3c2443/irq.c b/arch/arm/mach-s3c2443/irq.c
index 83ecb11..18585dd 100644
--- a/arch/arm/mach-s3c2443/irq.c
+++ b/arch/arm/mach-s3c2443/irq.c
@@ -222,7 +222,7 @@ static struct irq_chip s3c2443_irq_cam = {
 
 /* IRQ initialisation code */
 
-static int __init s3c2443_add_sub(unsigned int base,
+static int s3c2443_add_sub(unsigned int base,
 				   void (*demux)(unsigned int,
 						 struct irq_desc *),
 				   struct irq_chip *chip,
@@ -241,7 +241,7 @@ static int __init s3c2443_add_sub(unsigned int base,
 	return 0;
 }
 
-static int __init s3c2443_irq_add(struct sys_device *sysdev)
+static int s3c2443_irq_add(struct sys_device *sysdev)
 {
 	printk("S3C2443: IRQ Support\n");
 
-- 
1.7.4.1
