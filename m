From: zhongkaihua@huawei.com (Kaihua Zhong)
Date: Tue, 19 Dec 2017 19:15:43 +0800
Subject: [PATCH v4 1/3] dt-bindings: mailbox: Introduce Hi3660 controller
 binding
In-Reply-To: <1513682145-19892-1-git-send-email-zhongkaihua@huawei.com>
References: <1513682145-19892-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <1513682145-19892-2-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Introduce a binding for the Hi3660 mailbox controller, the mailbox is
used within application processor (AP), communication processor (CP),
HIFI and MCU, etc.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../bindings/mailbox/hisilicon,hi3660-mailbox.txt  | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt b/Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
new file mode 100644
index 0000000..3e5b453
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
@@ -0,0 +1,51 @@
+Hisilicon Hi3660 Mailbox Controller
+
+Hisilicon Hi3660 mailbox controller supports up to 32 channels.  Messages
+are passed between processors, including application & communication
+processors, MCU, HIFI, etc.  Each channel is unidirectional and accessed
+by using MMIO registers; it supports maximum to 8 words message.
+
+Controller
+----------
+
+Required properties:
+- compatible:		: Shall be "hisilicon,hi3660-mbox"
+- reg:			: Offset and length of the device's register set
+- #mbox-cells:		: Must be 3
+			  <&phandle channel dst_irq ack_irq>
+			    phandle	: Label name of controller
+			    channel	: Channel number
+			    dst_irq	: Remote interrupt vector
+			    ack_irq	: Local interrupt vector
+
+- interrupts:		: Contains the two IRQ lines for mailbox.
+
+Example:
+
+mailbox: mailbox at e896b000 {
+	compatible = "hisilicon,hi3660-mbox";
+	reg = <0x0 0xe896b000 0x0 0x1000>;
+	interrupts = <0x0 0xc0 0x4>,
+		     <0x0 0xc1 0x4>;
+	#mbox-cells = <3>;
+};
+
+Client
+------
+
+Required properties:
+- compatible		: See the client docs
+- mboxes		: Standard property to specify a Mailbox (See ./mailbox.txt)
+			  Cells must match 'mbox-cells' (See Controller docs above)
+
+Optional properties
+- mbox-names		: Name given to channels seen in the 'mboxes' property.
+
+Example:
+
+stub_clock: stub_clock at e896b500 {
+	compatible = "hisilicon,hi3660-stub-clk";
+	reg = <0x0 0xe896b500 0x0 0x0100>;
+	#clock-cells = <1>;
+	mboxes = <&mailbox 13 3 0>;
+};
-- 
1.9.1
