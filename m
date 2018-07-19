From: jacopo@jmondi.org (Jacopo Mondi)
Date: Thu, 19 Jul 2018 21:48:13 +0200
Subject: [RFC] ARM: imx6q: add ENET_CLK_SEL mux option
Message-ID: <1532029693-22764-1-git-send-email-jacopo@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just an attempt to set IOMUX_GPR1[21] bit...

Not-Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>

---
Hello imx people (recipients list comes from get_maintainer script)

   I'm very new to this platform, so pardon me if I'm asking a question here,
more than sending an actual patch.

Context: I have a board that needs bit 21 of register IOMUX_GPR1 set.
This basically tells the SoC to use an internally generated clock as clock
reference for the external PHY chip.

I dug a bit in the imx pincontroller driver and in the imx6q/dl device trees,
and I've found out that mmio-mux is used to control the IOMUX_GPR* registers.

So I've copied what has been done here by Philipp in commit bc97e88ecd and
added a new entry to the "mux-reg-masks" property and then referenced it with
a new sub-node of the mmio-mux node.

So far, I think I got it properly.

Question is, how do I trigger the actual writing of that bit? Do I need to
reference the newly introduced "enet_clk_mux" sub-node from the fec device
node? Does the fec driver support muxes as the video-mux.c driver does? It
doesn't seems to me :(

Thanks for your time in replying to this
    j

also: I know it's wrong adding this to imx6q.dtsi, please bear with it for now.
---

 arch/arm/boot/dts/imx6q.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 70483ce..4dd4d42 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -317,6 +317,11 @@
 			};
 		};
 	};
+
+	enet_clk_mux {
+		compatible = "enet-mux";
+		mux-controls = <&mux 7>;
+	};
 };

 &hdmi {
@@ -452,7 +457,8 @@
 			<0x0c 0x000000c0>, /* LVDS0_MUX_CTL */
 			<0x0c 0x00000300>, /* LVDS1_MUX_CTL */
 			<0x28 0x00000003>, /* DCIC1_MUX_CTL */
-			<0x28 0x0000000c>; /* DCIC2_MUX_CTL */
+			<0x28 0x0000000c>, /* DCIC2_MUX_CTL */
+			<0x04 0x00200000>; /* ENET_CLK_SEL */
 };

 &vpu {
--
2.7.4
