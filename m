From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 26 Jun 2017 16:55:05 +0100
Subject: [PATCH 1/9] Documentation: dt-bindings: add support for mailbox
 client shared memory
In-Reply-To: <1498492513-29771-1-git-send-email-sudeep.holla@arm.com>
References: <1498492513-29771-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1498492513-29771-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many users of the mailbox controllers depend on the shared memory between the
two end points to exchange the main data while using simple doorbell mechanism
to alert the end points of the presence of a message.

This patch defines device tree bindings to represent such shared memory in a
generic way.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../devicetree/bindings/mailbox/mailbox.txt        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/mailbox.txt b/Documentation/devicetree/bindings/mailbox/mailbox.txt
index be05b9746c69..af8ecee2ac68 100644
--- a/Documentation/devicetree/bindings/mailbox/mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/mailbox.txt
@@ -23,6 +23,11 @@ assign appropriate mailbox channel to client drivers.
 
 Optional property:
 - mbox-names: List of identifier strings for each mailbox channel.
+- shmem : List of phandle pointing to the shared memory(SHM) area between the
+	  users of these mailboxes for IPC, one for each mailbox. This shared
+	  memory can be part of any memory reserved for the purpose of this
+	  communication between the mailbox client and the remote.
+
 
 Example:
 	pwr_cntrl: power {
@@ -30,3 +35,26 @@ assign appropriate mailbox channel to client drivers.
 		mbox-names = "pwr-ctrl", "rpc";
 		mboxes = <&mailbox 0 &mailbox 1>;
 	};
+
+Example with shared memory(shmem):
+
+	sram: sram at 50000000 {
+		compatible = "mmio-sram";
+		reg = <0x50000000 0x10000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x50000000 0x10000>;
+
+		cl_shmem: shmem at 0 {
+			compatible = "client-shmem";
+			reg = <0x0 0x200>;
+		};
+	};
+
+	client at 2e000000 {
+		...
+		mboxes = <&mailbox 0>;
+		shmem = <&cl_shmem>;
+		..
+	};
-- 
2.7.4
