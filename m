From: s-anna@ti.com (Suman Anna)
Date: Wed, 4 Mar 2015 20:01:13 -0600
Subject: [PATCH v8 1/4] Documentation: dt: add common bindings for hwspinlock
In-Reply-To: <1425520876-37826-1-git-send-email-s-anna@ti.com>
References: <1425520876-37826-1-git-send-email-s-anna@ti.com>
Message-ID: <1425520876-37826-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the generic common bindings used to represent
a hwlock device and use/request locks in a device-tree build.

Each hwspinlock provider should have the '#hwlock-cells' property,
which represents the number of cells to be used for representing
a specific hwspinlock. Client users shall use the property
'hwlocks' for requesting specific lock(s).

Note that the document is named hwlock.txt deliberately to keep
it a bit more generic.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
v8: Revised the binding completely, removed hwlock-num-locks and
    hwlock-base-id properties. Added hwlock-names as optional
    property. Revised patch description as well. 

 .../devicetree/bindings/hwlock/hwlock.txt          | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt

diff --git a/Documentation/devicetree/bindings/hwlock/hwlock.txt b/Documentation/devicetree/bindings/hwlock/hwlock.txt
new file mode 100644
index 000000000000..085d1f5c916a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/hwlock.txt
@@ -0,0 +1,59 @@
+Generic hwlock bindings
+=======================
+
+Generic bindings that are common to all the hwlock platform specific driver
+implementations.
+
+Please also look through the individual platform specific hwlock binding
+documentations for identifying any additional properties specific to that
+platform.
+
+hwlock providers:
+=================
+
+Required properties:
+- #hwlock-cells:        Specifies the number of cells needed to represent a
+                        specific lock.
+
+hwlock users:
+=============
+
+Consumers that require specific hwlock(s) should specify them using the
+property "hwlocks", and an optional "hwlock-names" property.
+
+Required properties:
+- hwlocks:              List of phandle to a hwlock provider node and an
+                        associated hwlock args specifier as indicated by
+                        #hwlock-cells. The list can have just a single hwlock
+                        or multiple hwlocks, with each hwlock represented by
+                        a phandle and a corresponding args specifier.
+
+Optional properties:
+- hwlock-names:         List of hwlock name strings defined in the same order
+                        as the hwlocks, with one name per hwlock. Consumers can
+                        use the hwlock-names to match and get a specific hwlock.
+
+
+1. Example of a node using a single specific hwlock:
+
+The following example has a node requesting a hwlock in the bank defined by
+the node hwlock1. hwlock1 is a hwlock provider with an argument specifier
+of length 1.
+
+	node {
+		...
+		hwlocks = <&hwlock1 2>;
+		...
+	};
+
+2. Example of a node using multiple specific hwlocks:
+
+The following example has a node requesting two hwlocks, a hwlock within
+the hwlock device node 'hwlock1' with #hwlock-cells value of 1, and another
+hwlock within the hwlock device node 'hwlock2' with #hwlock-cells value of 2.
+
+	node {
+		...
+		hwlocks = <&hwlock1 2>, <&hwlock2 0 3>;
+		...
+	};
-- 
2.3.0
