From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 13 Feb 2017 05:04:56 -0800
Subject: [PATCH 4.4 11/20] ARM: 8642/1: LPAE: catch pending imprecise abort on
 unmask
In-Reply-To: <20170213130403.531813333@linuxfoundation.org>
References: <20170213130403.531813333@linuxfoundation.org>
Message-ID: <20170213130404.030256529@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

commit 97a98ae5b8acf08d07d972c087b2def060bc9b73 upstream.

Asynchronous external abort is coded differently in DFSR with LPAE enabled.

Fixes: 9254970c "ARM: 8447/1: catch pending imprecise abort on unmask".
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mm/fault.c |    4 ++--
 arch/arm/mm/fault.h |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -610,9 +610,9 @@ static int __init early_abort_handler(un
 
 void __init early_abt_enable(void)
 {
-	fsr_info[22].fn = early_abort_handler;
+	fsr_info[FSR_FS_AEA].fn = early_abort_handler;
 	local_abt_enable();
-	fsr_info[22].fn = do_bad;
+	fsr_info[FSR_FS_AEA].fn = do_bad;
 }
 
 #ifndef CONFIG_ARM_LPAE
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
