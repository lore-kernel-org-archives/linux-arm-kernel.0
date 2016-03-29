From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 29 Mar 2016 11:15:49 -0700
Subject: [PATCH] ARM: sa1100: Initialize gpio after gpio subsystem has been
 initialized
Message-ID: <1459275349-11356-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sa1100 gpio driver was initialized from interrupt initialization code,
which is earlier than the gpio subsystem is initialized. Since commit
ff2b13592299 ("gpio: make the gpiochip a real device"), this is fatal
and causes the system to crash.

The sa1100 gpio driver must be initialized prior to arch_initcall, since
its gpio pins are used in arch_initcall code, but after the gpio subsystem
is initialized (core_initcall). Initialize it with postcore_initcall.

Fixes: ff2b13592299 ("gpio: make the gpiochip a real device")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---

Tested by building collie_defconfig and:

qemu-system-arm -M collie -kernel arch/arm/boot/zImage \
	-no-reboot -initrd busybox-armv4.cpio \
	--append "rdinit=/sbin/init console=ttySA1" -monitor null -nographic

 arch/arm/mach-sa1100/generic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 345e63f4eb71..850aa7f8f649 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -321,6 +321,15 @@ static int __init sa1100_init(void)
 
 arch_initcall(sa1100_init);
 
+static int __init sa1100_gpio_init(void)
+{
+	sa1100_init_gpio();
+
+	return 0;
+}
+
+postcore_initcall(sa1100_gpio_init);
+
 void __init sa11x0_init_late(void)
 {
 	sa11x0_pm_init();
@@ -386,8 +395,6 @@ void __init sa1100_init_irq(void)
 	request_resource(&iomem_resource, &irq_resource);
 
 	sa11x0_init_irq_nodt(IRQ_GPIO0_SC, irq_resource.start);
-
-	sa1100_init_gpio();
 }
 
 /*
-- 
2.5.0
