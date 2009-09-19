From: schen@mvista.com (Steve Chen)
Date: Sat, 19 Sep 2009 07:55:29 -0500
Subject: [PATCH v4] arm: remove unused code in delay.S
In-Reply-To: <20090918205349.GM29905@game.jcrosoft.org>
References: <1253292418.3273.257.camel@linux-1lbu>
	<20090918190920.GB11461@pengutronix.de>
	<1253305534.3273.283.camel@linux-1lbu>
	<20090918205349.GM29905@game.jcrosoft.org>
Message-ID: <1253364929.3273.298.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document #if 0 code block in delay.S and make it selectable for compile.

Signed-off-by: Steve Chen <schen@mvista.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
Reviewed-by: Jamie Lokier <jamie@shareable.org>
Reviewed-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Reviewed-by: Krzysztof Halasa <khc@pm.waw.pl>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Reviewed-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

---

 arch/arm/Kconfig     |   23 +++++++++++++++++++++++
 arch/arm/lib/delay.S |    2 +-
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aef63c8..9a5a49a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -813,6 +813,29 @@ config ARM_ERRATA_460075
 	  ACTLR register. Note that setting specific bits in the ACTLR
register
 	  may not be available in non-secure mode.
 
+config OLD_CPU_DELAY
+	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
+	bool "Different delay() code for some older CPUs"
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
+	  CPUs should enable this flag
+		ARM610 (rmk)
+		ARM710 (rmk)
+
+	  CPUs should disable this flag
+		StrongARM (rmk)
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
