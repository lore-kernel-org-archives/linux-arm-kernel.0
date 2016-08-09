From: andre.przywara@arm.com (Andre Przywara)
Date: Tue,  9 Aug 2016 12:53:00 +0100
Subject: [RFC PATCH 2/5] DT: mailbox: add binding doc for the ARM SMC mailbox
In-Reply-To: <20160809115303.17032-1-andre.przywara@arm.com>
References: <20160809115303.17032-1-andre.przywara@arm.com>
Message-ID: <20160809115303.17032-3-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/mailbox/arm-smc.txt        | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt

diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
new file mode 100644
index 0000000..9919a12
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
@@ -0,0 +1,53 @@
+ARM SMC Mailbox Driver
+======================
+
+This mailbox driver uses the ARM smc (secure monitor call) instruction to
+trigger a mailbox-connected activity in firmware running on the very same
+core as the caller. By nature this operation is synchronous and this
+driver provides no way for asynchronous messages to be delivered the other
+way round, from firmware to the OS. However the value of r0/w0 the firmware
+returns after the smc call is delivered as a received message to the
+mailbox framework, so a synchronous communication can be established.
+
+One usecase of this mailbox is the SCP interface, which uses shared memory
+to transfer commands and parameters and mailboxes to trigger a function
+call. This driver allows SoC without a separate management processor (or
+when such a processor is not available or used) to use this standardized
+interface anyway.
+
+The driver requires no special hardware, any core which supports the SMC
+instruction can be used. This requires firmware in monitor mode/EL3 to
+handle the mailbox message.
+
+Mailbox Device Node:
+====================
+
+Required properties:
+--------------------
+- compatible:		Shall be "arm,smc-mbox"
+- #mbox-cells		Shall be 1 - the index of the channel needed.
+- identifiers		An array of 32-bit values specifying the function
+			IDs used by each mailbox channel. Those function IDs
+			follow the ARM SMC calling convention standard [1].
+			There is one identifier per channel and the number
+			of supported channels is determined by the length
+			of this array.
+
+Example:
+--------
+
+	mailbox: smc_mbox {
+		#mbox-cells = <1>;
+		compatible = "arm,smc-mbox";
+		identifiers = <0x82000001 0x82000002>;
+	};
+
+	scpi {
+		compatible = "arm,scpi";
+		mboxes = <&mailbox 0>;
+		shmem = <&cpu_scp_shmem>;
+	};
+
+
+[1]
+http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0028a/index.html
-- 
2.9.0
