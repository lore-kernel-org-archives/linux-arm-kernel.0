From: eric@anholt.net (Eric Anholt)
Date: Tue,  5 May 2015 13:27:44 -0700
Subject: [PATCH 1/3 v6] dt/bindings: Add binding for the BCM2835 mailbox driver
Message-ID: <1430857666-18877-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lubomir Rintel <lkundrak@v3.sk>

This patch was split out of Lubomir's original mailbox patch by Eric
Anholt, and the required properties documentation and examples have
been filled out more completely and updated for the driver being
changed to expose a single channel.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---

v2: Split into a separate patch for submitting to the devicetree list.
    Consistently start node docs with a capital letter. device's
    address in the example shouldn't have "0x". Drop machine-specific
    interrupt numbers from the docs.  (changes by anholt).

v3: Move the file to just bcm2835-mbox.txt, clean up formatting
    (changes by anholt, from review by Lee Jones).

v4: Move file back by consensus from various Broadcom platform
    maintainers (changes by anholt, acked by Lee Jones).

v5: Document that the mailbox cell should be 0 in clients, and add an
    example of a client.

v6: Add change description to commit message separate from this
    version section.  Update for #mbox-cells 0 change.

 .../bindings/mailbox/brcm,bcm2835-mbox.txt         | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
new file mode 100644
index 0000000..e893615
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
@@ -0,0 +1,26 @@
+Broadcom BCM2835 VideoCore mailbox IPC
+
+Required properties:
+
+- compatible:	Should be "brcm,bcm2835-mbox"
+- reg:		Specifies base physical address and size of the registers
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+- #mbox-cells:	Specifies the number of cells needed to encode a mailbox
+		  channel. The value shall be 0, since there is only one
+		  mailbox channel implemented by the device.
+
+Example:
+
+mailbox: mailbox at 7e00b800 {
+	compatible = "brcm,bcm2835-mbox";
+	reg = <0x7e00b880 0x40>;
+	interrupts = <0 1>;
+	#mbox-cells = <0>;
+};
+
+firmware: firmware {
+	compatible = "raspberrypi,firmware";
+	mboxes = <&mailbox>;
+	#power-domain-cells = <1>;
+};
-- 
2.1.4
