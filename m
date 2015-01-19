From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 19 Jan 2015 14:01:17 +0100
Subject: [PATCH] ARM: dts: sun4i: Add simplefb node with
 de_fe0-de_be0-lcd0-hdmi pipeline
In-Reply-To: <1421672477-12978-1-git-send-email-hdegoede@redhat.com>
References: <1421672477-12978-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1421672477-12978-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Testing has shown that on sun4i the display backend engine does not have
deep enough fifo-s causing flickering / tearing in full-hd mode due to
fifo underruns. This can be avoided by letting the display frontend engine
do the dma from memory, and then letting it feed the data directly into
the backend unmodified, as the frontend does have deep enough fifo-s.

Note since u-boot-v2015.01 has been released using the de_be0-lcd0-hdmi
pipeline on sun4i, we need to keep that one around too (unfortunately).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index f5e35b5..ccd60e3 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -44,6 +44,14 @@
 				 <&ahb_gates 44>;
 			status = "disabled";
 		};
+
+		framebuffer at 1 {
+			compatible = "allwinner,simple-framebuffer", "simple-framebuffer";
+			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
+			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
+				 <&ahb_gates 44>, <&ahb_gates 46>;
+			status = "disabled";
+		};
 	};
 
 	cpus {
-- 
2.1.0
