From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon, 16 Dec 2013 21:24:18 +0100
Subject: [RFC PATCH 07/10] irqchip: atmel-aic: document new dt properties and
 children nodes
In-Reply-To: <1387225461-6201-1-git-send-email-b.brezillon@overkiz.com>
References: <1387225461-6201-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1387225461-6201-8-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irq muxing and irq-mapping dt binding documentation.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../bindings/interrupt-controller/atmel,aic.txt    |   45 ++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
index ad03121..63258c6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
@@ -17,8 +17,36 @@ Required properties:
   The third cell is used to specify the irq priority from 0 (lowest) to 7
   (highest).
 - reg: Should contain AIC registers location and length
+- #address-cells: Shall be 1 (used to represent the irq line id when defining
+  irq-mux nodes).
+- #size-cells: Shall be 0.
 - atmel,external-irqs: u32 array of external irqs.
 
+Optional properties:
+- atmel,irq-mapping: u32 mask array representing the available irqs:
+    e.i. : atmel,irq-mapping = <0xffff1fff> => irqs 13 to 15 are unavailables
+
+Optional children nodes:
+- irq-mux nodes:
+  Required properties:
+  * compatible: Should be "atmel,aic-mux"
+
+  Optional children nodes:
+  * muxed irq entries:
+      Required properties:
+      + compatible: Shall be
+        "atmel,aic-mux-1reg-irq": irq enable/disable/retrieve-status is done by
+        setting/clearing/reading flags in a specific register
+        or
+        "atmel,aic-mux-3reg-irq": irq enable/disable/retrieve-status is done
+        by writing/reading flags in specific enable/disable/mask registers
+      + atmel,aic-mux-irq-reg: represent the disable or mode register used to
+        disable the given muxed irq.
+        The first cell is a phandle to the device node owning the muxed irq.
+	The second cell is the iomem range index.
+        The third cell is the disable or mode register offset.
+	The fourth cell is the mask used to disable the irq.
+
 Examples:
 	/*
 	 * AIC
@@ -29,6 +57,23 @@ Examples:
 		interrupt-parent;
 		#interrupt-cells = <3>;
 		reg = <0xfffff000 0x200>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sysc_irq_mux: irq-mux at 1 {
+			compatible = "atmel,aic-mux";
+			reg = <1>;
+
+			dbgu_irq {
+				compatible = "atmel,aic-mux-3reg-irq";
+				atmel,aic-mux-irq-reg = <&dbgu 0 0xc 0xc0001afb>;
+			};
+
+			pmc_irq {
+				compatible = "atmel,aic-mux-3reg-irq";
+				atmel,aic-mux-irq-reg = <&pmc 0 0x64 0xf0f>;
+			};
+		};
 	};
 
 	/*
-- 
1.7.9.5
