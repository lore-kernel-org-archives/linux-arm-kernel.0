From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 30 Sep 2014 14:26:27 +0200
Subject: [PATCH/RFC v2 4/4] ARM: shmobile: r8a7740 dtsi: Add minimal device
 node for Coresight-ETM
In-Reply-To: <1412079987-1827-1-git-send-email-geert+renesas@glider.be>
References: <1412079987-1827-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1412079987-1827-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If power area D4, which contains the Coresight-ETM hardware block, is
powered down on R-Mobile A1 (r8a7740), the kernel crashes when
suspending from s2ram with:

    Internal error: Oops - undefined instruction: 0 [#1] ARM

This happens because dbg_cpu_pm_notify() calls reset_ctrl_regs(), which
can't access the debug registers as the debug module is powered down.

Add a minimal device node for the Coresight-ETM hardware block, and hook
it up to the D4 PM domain, so the R-Mobile System Controller driver can
keep the arm_dbg_regs_available flag in sync with the state of the D4 PM
domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree at vger.kernel.org
---
This is a fix on top of series "[PATCH 00/13] ARM: shmobile: R-Mobile:
DT PM domain support" (https://lkml.org/lkml/2014/9/25/452), to be
folded into "[PATCH v3 10/13] ARM: shmobile: r8a7740 dtsi: Add PM domain
support" (https://lkml.org/lkml/2014/9/25/450).

v2:
  - New

---
 arch/arm/boot/dts/r8a7740.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 0fb93df46af4ce08..2ae08fc99be678c3 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -44,6 +44,11 @@
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	ptm {
+		compatible = "arm,coresight-etm3x";
+		power-domains = <&pd_d4>;
+	};
+
 	cmt1: timer at e6138000 {
 		compatible = "renesas,cmt-48-r8a7740", "renesas,cmt-48";
 		reg = <0xe6138000 0x170>;
-- 
1.9.1
