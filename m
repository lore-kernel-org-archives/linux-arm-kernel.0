From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 28 Mar 2011 01:28:20 +0200
Subject: [PATCH 4/7] ARM / SA1100: Use struct syscore_ops for "core" power
	management
In-Reply-To: <201103280125.11750.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl>
Message-ID: <201103280128.21107.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Replace the sysdev class and struct sys_device used for power
management by the SA1100 interrupt-handling code with a
struct syscore_ops object which is simpler.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-sa1100/irq.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

Index: linux-2.6/arch/arm/mach-sa1100/irq.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-sa1100/irq.c
+++ linux-2.6/arch/arm/mach-sa1100/irq.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/ioport.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 
 #include <mach/hardware.h>
 #include <asm/mach/irq.h>
@@ -234,7 +234,7 @@ static struct sa1100irq_state {
 	unsigned int	iccr;
 } sa1100irq_state;
 
-static int sa1100irq_suspend(struct sys_device *dev, pm_message_t state)
+static int sa1100irq_suspend(void)
 {
 	struct sa1100irq_state *st = &sa1100irq_state;
 
@@ -264,7 +264,7 @@ static int sa1100irq_suspend(struct sys_
 	return 0;
 }
 
-static int sa1100irq_resume(struct sys_device *dev)
+static void sa1100irq_resume(void)
 {
 	struct sa1100irq_state *st = &sa1100irq_state;
 
@@ -277,24 +277,17 @@ static int sa1100irq_resume(struct sys_d
 
 		ICMR = st->icmr;
 	}
-	return 0;
 }
 
-static struct sysdev_class sa1100irq_sysclass = {
-	.name		= "sa11x0-irq",
+static struct syscore_ops sa1100irq_syscore_ops = {
 	.suspend	= sa1100irq_suspend,
 	.resume		= sa1100irq_resume,
 };
 
-static struct sys_device sa1100irq_device = {
-	.id		= 0,
-	.cls		= &sa1100irq_sysclass,
-};
-
 static int __init sa1100irq_init_devicefs(void)
 {
-	sysdev_class_register(&sa1100irq_sysclass);
-	return sysdev_register(&sa1100irq_device);
+	register_syscore_ops(&sa1100irq_syscore_ops);
+	return 0;
 }
 
 device_initcall(sa1100irq_init_devicefs);
