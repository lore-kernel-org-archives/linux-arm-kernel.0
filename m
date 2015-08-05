From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  5 Aug 2015 10:58:07 +0200
Subject: [PATCH v4 3/6] ARM: shmobile: sh73a0 dtsi: Add L2 cache-controller
 node
In-Reply-To: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1438765090-823-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing L2 cache-controller node. This will allow migration to
the generic l2c OF initialization.

The L2 cache is an ARM L2C-310 (r3p1), of size 512 KiB (64 KiB x 8
ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New,
  - Commit eeedcea69e927857 ("ARM: 8395/1: l2c: Add support for the
    "arm,shared-override" property") is queued for 4.3 in arm/for-next.
---
 arch/arm/boot/dts/sh73a0.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 11e17c5f26e2cae2..e84fce5e4090f4ab 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -53,6 +53,22 @@
 		      <0xf0000100 0x100>;
 	};
 
+	L2: cache-controller {
+		compatible = "arm,pl310-cache";
+		reg = <0xf0100000 0x1000>;
+		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd_a3sm>;
+		arm,data-latency = <3 3 3>;
+		arm,tag-latency = <2 2 2>;
+		arm,shared-override;
+		cache-unified;
+		cache-level = <2>;
+		cache-size = <0x80000>;
+		cache-sets = <2048>;
+		cache-block-size = <32>;
+		cache-line-size = <32>;
+	};
+
 	sbsc2: memory-controller at fb400000 {
 		compatible = "renesas,sbsc-sh73a0";
 		reg = <0xfb400000 0x400>;
-- 
1.9.1
