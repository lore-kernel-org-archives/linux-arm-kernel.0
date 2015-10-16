From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 16 Oct 2015 08:21:27 +0100
Subject: [PATCH v4 1/5] mailbox: dt: Supply bindings for ST's Mailbox IP
In-Reply-To: <1444980091-16728-1-git-send-email-lee.jones@linaro.org>
References: <1444980091-16728-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1444980091-16728-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/mailbox/sti-mailbox.txt    | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
new file mode 100644
index 0000000..b61eec9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
@@ -0,0 +1,51 @@
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
+- #mbox-cells:		: Must be 2
+			  <&phandle instance channel direction>
+			    phandle   : Label name of controller
+			    instance  : Instance number
+			    channel   : Channel number
+
+Optional properties
+- interrupts		: Contains the IRQ line for a Rx mailbox
+
+Example:
+
+mailbox0: mailbox at 0  {
+	compatible	= "st,stih407-mailbox";
+	reg		= <0x08f00000 0x1000>;
+	interrupts	= <GIC_SPI 1 IRQ_TYPE_NONE>;
+	#mbox-cells	= <2>;
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
+	mboxes		= <&mailbox2 0 1>, <&mailbox0 2 1>;
+	mbox-names	= "tx",	"rx";
+};
-- 
1.9.1
