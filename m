From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 14 Feb 2017 10:19:41 +0530
Subject: [RESEND PATCH v4 2/2] dt-bindings: Add DT bindings info for FlexRM
 ring manager
In-Reply-To: <1487047781-25513-1-git-send-email-anup.patel@broadcom.com>
References: <1487047781-25513-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1487047781-25513-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree bindings document for the FlexRM
ring manager found on Broadcom iProc SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 .../bindings/mailbox/brcm,iproc-flexrm-mbox.txt    | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
new file mode 100644
index 0000000..752ae6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
@@ -0,0 +1,59 @@
+Broadcom FlexRM Ring Manager
+============================
+The Broadcom FlexRM ring manager provides a set of rings which can be
+used to submit work to offload engines. An SoC may have multiple FlexRM
+hardware blocks. There is one device tree entry per FlexRM block. The
+FlexRM driver will create a mailbox-controller instance for given FlexRM
+hardware block where each mailbox channel is a separate FlexRM ring.
+
+Required properties:
+--------------------
+- compatible:	Should be "brcm,iproc-flexrm-mbox"
+- reg:		Specifies base physical address and size of the FlexRM
+		ring registers
+- msi-parent:	Phandles (and potential Device IDs) to MSI controllers
+		The FlexRM engine will send MSIs (instead of wired
+		interrupts) to CPU. There is one MSI for each FlexRM ring.
+		Refer devicetree/bindings/interrupt-controller/msi.txt
+- #mbox-cells:	Specifies the number of cells needed to encode a mailbox
+		channel. This should be 3.
+
+		The 1st cell is the mailbox channel number.
+
+		The 2nd cell contains MSI completion threshold. This is the
+		number of completion messages for which FlexRM will inject
+		one MSI interrupt to CPU.
+
+		The 3nd cell contains MSI timer value representing time for
+		which FlexRM will wait to accumulate N completion messages
+		where N is the value specified by 2nd cell above. If FlexRM
+		does not get required number of completion messages in time
+		specified by this cell then it will inject one MSI interrupt
+		to CPU provided atleast one completion message is available.
+
+Optional properties:
+--------------------
+- dma-coherent:	Present if DMA operations made by the FlexRM engine (such
+		as DMA descriptor access, access to buffers pointed by DMA
+		descriptors and read/write pointer updates to DDR) are
+		cache coherent with the CPU.
+
+Example:
+--------
+crypto_mbox: mbox at 67000000 {
+	compatible = "brcm,iproc-flexrm-mbox";
+	reg = <0x67000000 0x200000>;
+	msi-parent = <&gic_its 0x7f00>;
+	#mbox-cells = <3>;
+};
+
+crypto at 672c0000 {
+	compatible = "brcm,spu2-v2-crypto";
+	reg = <0x672c0000 0x1000>;
+	mboxes = <&crypto_mbox 0 0x1 0xffff>,
+		 <&crypto_mbox 1 0x1 0xffff>,
+		 <&crypto_mbox 16 0x1 0xffff>,
+		 <&crypto_mbox 17 0x1 0xffff>,
+		 <&crypto_mbox 30 0x1 0xffff>,
+		 <&crypto_mbox 31 0x1 0xffff>;
+};
-- 
2.7.4
