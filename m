From: schen@mvista.com (Steve Chen)
Date: Thu, 17 Sep 2009 16:29:38 -0500
Subject: [PATCH v2] arm: remove unused code in delay.S
In-Reply-To: <20090917194119.GA12510@n2100.arm.linux.org.uk>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<20090915103739.GA19519@elf.ucw.cz>
	<1253017761.3273.117.camel@linux-1lbu>
	<200909151541.08852.marek.vasut@gmail.com>
	<1253032210.3273.128.camel@linux-1lbu>
	<94a0d4530909151158y489a96e3x63ff932c713822b0@mail.gmail.com>
	<1253043875.3273.131.camel@linux-1lbu>
	<m3k4zzdimy.fsf@intrepid.localdomain>
	<20090916134721.GA11218@n2100.arm.linux.org.uk>
	<20090917193257.GA10599@shareable.org>
	<20090917194119.GA12510@n2100.arm.linux.org.uk>
Message-ID: <1253222978.3273.236.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document #if 0 code block in delay.S and make it selectable for compile.

Signed-off-by: Steve Chen <schen@mvista.com>

---

 arch/arm/Kconfig     |   14 ++++++++++++++
 arch/arm/lib/delay.S |    2 +-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aef63c8..ed8bf14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -813,6 +813,20 @@ config ARM_ERRATA_460075
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
