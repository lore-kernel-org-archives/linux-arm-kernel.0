From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 15 Apr 2014 20:16:01 +0200
Subject: [PATCH 3/5] ARM: pj4: properly detect existence of iWMMXt coprocessor
In-Reply-To: <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20140414151236.75f8816d@skate>
 <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1397585763-23482-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit fdb487f5c961b94486a78fa61fa28b8eff1954ab
  ("ARM: 8015/1: Add cpu_is_pj4 to distinguish PJ4 because it
    has some differences with V7")
introduced a fix for checking PJ4 cpuid to not use PJ4 specific
coprocessor access on non-PJ4 platforms.

Unfortunately, this in turn broke Marvell Armada 370/XP, both
comprising Marvell PJ4B CPUs without iWMMXt extension. Instead
of only checking for cpuid, which may not be sufficient to
determine iWMMXt support, the presence of iWMMXt coprocessors
can be checked by enabling and reading the Coprocessor ID
register (wCID, register 0 of CP1).

Therefore this adds an explicit check for the presence and correct
wCID value, before enabling iWMMXt capabilities. As a bonus, also
print the iWMMXt version of a detected coprocessor.

This has been tested to properly detect iWMMXt presence/absence on:
- PJ4,  CPUID 0x560f5815, wCID 0x56052001: Marvell Dove, iWMMXt v2
- PJ4B, CPUID 0x561f5811: Marvell Armada 370, no iWMMXt
- PJ4B, CPUID 0x562f5841, wCID 0x56052001: Marvell Armada 1500, iWMMXt v2
- PJ4B, CPUID 0x562f5842: Marvell Armada XP, no iWMMXt

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
 arch/arm/kernel/pj4-cp0.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
index 12352cd30ab2..8153e36b2491 100644
--- a/arch/arm/kernel/pj4-cp0.c
+++ b/arch/arm/kernel/pj4-cp0.c
@@ -72,6 +72,33 @@ static void __init pj4_cp_access_write(u32 value)
 		: "=r" (temp) : "r" (value));
 }
 
+static int __init pj4_get_iwmmxt_version(void)
+{
+	u32 cp_access, wcid;
+
+	cp_access = pj4_cp_access_read();
+	pj4_cp_access_write(cp_access | 0xf);
+
+	/* check if coprocessor 0 and 1 are available */
+	if ((pj4_cp_access_read() & 0xf) != 0xf) {
+		pj4_cp_access_write(cp_access);
+		return -ENODEV;
+	}
+
+	/* read iWMMXt coprocessor id register p1, c0 */
+	__asm__ __volatile__ ("mrc    p1, 0, %0, c0, c0, 0\n" : "=r" (wcid));
+
+	pj4_cp_access_write(cp_access);
+
+	/* iWMMXt v1 */
+	if ((wcid & 0xffffff00) == 0x56051000)
+		return 1;
+	/* iWMMXt v2 */
+	if ((wcid & 0xffffff00) == 0x56052000)
+		return 2;
+
+	return -EINVAL;
+}
 
 /*
  * Disable CP0/CP1 on boot, and let call_fpe() and the iWMMXt lazy
@@ -80,17 +107,22 @@ static void __init pj4_cp_access_write(u32 value)
 static int __init pj4_cp0_init(void)
 {
 	u32 __maybe_unused cp_access;
+	int vers;
 
 	if (!cpu_is_pj4())
 		return 0;
 
+	vers = pj4_get_iwmmxt_version();
+	if (vers < 0)
+		return 0;
+
 #ifndef CONFIG_IWMMXT
 	pr_info("PJ4 iWMMXt coprocessor detected, but kernel support is missing.\n");
 #else
 	cp_access = pj4_cp_access_read() & ~0xf;
 	pj4_cp_access_write(cp_access);
 
-	printk(KERN_INFO "PJ4 iWMMXt coprocessor enabled.\n");
+	pr_info("PJ4 iWMMXt v%d coprocessor enabled.\n", vers);
 	elf_hwcap |= HWCAP_IWMMXT;
 	thread_register_notifier(&iwmmxt_notifier_block);
 #endif
-- 
1.9.1
