From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 15 Apr 2014 20:16:00 +0200
Subject: [PATCH 2/5] ARM: pj4: enable iWMMXt only if CONFIG_IWMMXT is set
In-Reply-To: <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20140414151236.75f8816d@skate>
 <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1397585763-23482-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes PJ4 coprocessor init to only expose iWMMXt capabilities,
if the corresponding kernel support for iWMMXt is enabled.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Chao Xie <xiechao.mail@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/kernel/pj4-cp0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
index fc7208636284..12352cd30ab2 100644
--- a/arch/arm/kernel/pj4-cp0.c
+++ b/arch/arm/kernel/pj4-cp0.c
@@ -45,7 +45,7 @@ static int iwmmxt_do(struct notifier_block *self, unsigned long cmd, void *t)
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block iwmmxt_notifier_block = {
+static struct notifier_block __maybe_unused iwmmxt_notifier_block = {
 	.notifier_call	= iwmmxt_do,
 };
 
@@ -79,17 +79,21 @@ static void __init pj4_cp_access_write(u32 value)
  */
 static int __init pj4_cp0_init(void)
 {
-	u32 cp_access;
+	u32 __maybe_unused cp_access;
 
 	if (!cpu_is_pj4())
 		return 0;
 
+#ifndef CONFIG_IWMMXT
+	pr_info("PJ4 iWMMXt coprocessor detected, but kernel support is missing.\n");
+#else
 	cp_access = pj4_cp_access_read() & ~0xf;
 	pj4_cp_access_write(cp_access);
 
 	printk(KERN_INFO "PJ4 iWMMXt coprocessor enabled.\n");
 	elf_hwcap |= HWCAP_IWMMXT;
 	thread_register_notifier(&iwmmxt_notifier_block);
+#endif
 
 	return 0;
 }
-- 
1.9.1
