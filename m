From: schen@mvista.com (Steve Chen)
Date: Fri, 18 Sep 2009 11:46:58 -0500
Subject: [PATCH v3] arm: remove unused code in delay.S
Message-ID: <1253292418.3273.257.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document #if 0 code block in delay.S and make it selectable for compile.

Signed-off-by: Steve Chen <schen@mvista.com>

---
 arch/arm/Kconfig     |   31 +++++++++++++++++++++++++++++++
 arch/arm/lib/delay.S |    2 +-
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aef63c8..f44cb70 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -813,6 +813,37 @@ config ARM_ERRATA_460075
 	  ACTLR register. Note that setting specific bits in the ACTLR
register
 	  may not be available in non-secure mode.
 
+config OLD_CPU_DELAY
+	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
+	bool "Different delay() code for some older CPUs"
+	def_bool n
+	help
+	  Enable this if observing longer than expected delays.  This code
+	  improves delay accuracy for some CPUs.  However, it can also cause
+	  delay duration to be too short for others which leads to stability
+	  issues.
+
+	  In other words, do not enable unless you can guarantee that the
+	  processor (or ALL of the processors if building a generic kernel)
+	  delays for at least the time requested after enabling.
+
+	  ARM610 and ARM710 are known to benefit from enabling this option.
+	  It should not be enabled for StrongARMs, because it is known
+	  to produce too short delays on those.
+
+	  Lastly, below are 2 lists.  The first list contains the processors
+	  that would benefit from enabling this flag, and the second list
+	  contains processor that are known to have issues.  Please note that
+	  both lists are by no means complete.  Entries are expected to be
+	  added and refined.  If you like to update the list, please send a
+	  patch to Linux ARM mailing list.
+
+	  CPUs should enable this flag
+		ARM610
+		ARM710
+
+	  CPUs should disable this flag
+		StrongARM
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/lib/delay.S b/arch/arm/lib/delay.S
index 8d6a876..67e679b 100644
--- a/arch/arm/lib/delay.S
+++ b/arch/arm/lib/delay.S
@@ -42,7 +42,7 @@ ENTRY(__const_udelay)				@ 0 <= r0 <= 0x7fffff06
 @ Delay routine
 ENTRY(__delay)
 		subs	r0, r0, #1
-#if 0
+#ifdef CONFIG_OLD_CPU_DELAY
 		movls	pc, lr
 		subs	r0, r0, #1
 		movls	pc, lr
