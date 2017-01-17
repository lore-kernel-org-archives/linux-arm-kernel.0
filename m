From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Tue, 17 Jan 2017 18:42:10 +0100
Subject: [PATCH] ARM: LPAE: catch pending imprecise abort on unmask
Message-ID: <20170117174210.28122-1-alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Asynchronous external abort is coded differently in DFSR with LPAE enabled.

Fixes: 9254970c "ARM: 8447/1: catch pending imprecise abort on unmask".

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mm/fault.c | 4 ++--
 arch/arm/mm/fault.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 3a2e678b8d30..0122ad1a6027 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -610,9 +610,9 @@ static int __init early_abort_handler(unsigned long addr, unsigned int fsr,
 
 void __init early_abt_enable(void)
 {
-	fsr_info[22].fn = early_abort_handler;
+	fsr_info[FSR_FS_AEA].fn = early_abort_handler;
 	local_abt_enable();
-	fsr_info[22].fn = do_bad;
+	fsr_info[FSR_FS_AEA].fn = do_bad;
 }
 
 #ifndef CONFIG_ARM_LPAE
diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index 67532f242271..afc1f84e763b 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -11,11 +11,15 @@
 #define FSR_FS5_0		(0x3f)
 
 #ifdef CONFIG_ARM_LPAE
+#define FSR_FS_AEA		17
+
 static inline int fsr_fs(unsigned int fsr)
 {
 	return fsr & FSR_FS5_0;
 }
 #else
+#define FSR_FS_AEA		22
+
 static inline int fsr_fs(unsigned int fsr)
 {
 	return (fsr & FSR_FS3_0) | (fsr & FSR_FS4) >> 6;
-- 
2.11.0
