From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 17 Jul 2015 13:04:02 +0100
Subject: [PATCH 1/6] mailbox: dt: Supply bindings for ST's Mailbox IP
In-Reply-To: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1437134647-28298-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/mailbox/sti-mailbox.txt    | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
new file mode 100644
index 0000000..3390e3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
@@ -0,0 +1,53 @@
+ST Microelectronics Mailbox Driver
+
+Each ST Mailbox IP currently consists of 4 instances of 32 channels.  Messages
+are passed between Application and Remote processors using shared memory.
+
+Controller
+----------
+
+Required properties:
+- compatible		: Should be "st,stih407-mailbox"
+- reg			: Offset and length of the device's register set
+- mbox-name		: Name of the mailbox
+- #mbox-cells:		: Must be 3
+			  <&phandle instance channel direction>
+			    phandle   : Label name of controller
+			    instance  : Instance number
+			    channel   : Channel number
+			    direction : Data flow direction; MBOX_TX or MBOX_RX
+
+Optional properties
+- interrupts		: Contains the IRQ line for a Rx mailbox
+			    [NB: The absence of this property denotes Tx only]
+
+Example:
+
+mailbox0: mailbox at 0  {
+	compatible	= "st,stih407-mailbox";
+	reg		= <0x8f00000 0x1000>;
+	interrupts	= <GIC_SPI 1 IRQ_TYPE_NONE>;
+	#mbox-cells	= <3>;
+	mbox-name	= "a9";
+};
+
+Client
+------
+
+Required properties:
+- compatible		: Many (See the client docs)
+- reg			: Shared (between Application and Remote) memory address
+- mboxes		: Standard property to specify a Mailbox (See ./mailbox.txt)
+			  Cells must match 'mbox-cells' (See Controller docs above)
+
+Optional properties
+- mbox-names		: Name given to channels seen in the 'mboxes' property.
+
+Example:
+
+mailbox_test {
+	compatible	= "mailbox_test";
+	reg		= <0x[shared_memory_address], [shared_memory_size]>;
+	mboxes		= <&mailbox2 0 1 MBOX_TX>, <&mailbox0 2 1 MBOX_RX>;
+	mbox-names	= "tx",	"rx";
+};
-- 
1.9.1
