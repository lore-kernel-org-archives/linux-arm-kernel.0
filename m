From: mgreer@animalcreek.com (Mark A. Greer)
Date: Tue, 2 Oct 2012 17:52:18 -0700
Subject: [PATCH] ARM: arch timer: Export 'read_current_timer' symbol
Message-ID: <20121003005218.GA23874@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Commit 923df96b9f31b7d08d8438ff9677326d9537accf
(ARM: 7451/1: arch timer: implement read_current_timer and get_cycles)
modifies get_cycles() such that it calls read_current_timer().
Unfortunately, the 'read_current_timer' symbol is not exported so when
a driver that calls get_cycles() is built as a module, an undefined
reference error occurs.

A good example is the crypto/tcrypt.c (CONFIG_CRYPTO_TEST) driver
because it calls get_cycles() and can only be built as a module.

Fix this error by exporting the 'read_current_timer' symbol.

CC: Will Deacon <will.deacon@arm.com>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---

This patch applies against current arm-soc/for-next branch.

 arch/arm/kernel/armksyms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 60d3b73..e7a29fe 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -156,3 +156,7 @@ EXPORT_SYMBOL(__gnu_mcount_nc);
 #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
 EXPORT_SYMBOL(__pv_phys_offset);
 #endif
+
+#ifdef CONFIG_ARM_ARCH_TIMER
+EXPORT_SYMBOL(read_current_timer);
+#endif
-- 
1.7.12
