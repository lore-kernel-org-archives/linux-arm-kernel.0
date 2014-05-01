From: s-anna@ti.com (Suman Anna)
Date: Wed, 30 Apr 2014 19:34:29 -0500
Subject: [PATCHv5 RFC 08/15] hwspinlock/core: add support for base id in DT
In-Reply-To: <1398904476-26200-1-git-send-email-s-anna@ti.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
Message-ID: <1398904476-26200-9-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HwSpinlock core requires a base id for registering a bank
of hwspinlocks. This base id needs to be unique across multiple
IP instances of a hwspinlock device, so that each hwlock can be
represented uniquely in a system.

Support has been added to represent this in DT through a common
property 'hwlock-base-id', and retrieve the value through a core
OF helper function, of_hwspin_lock_get_base_id(). The representation
in DT provides a uniform way of assigning a fixed base value for a
hwspinlock device across different SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 Documentation/devicetree/bindings/hwlock/hwlock.txt |  6 ++++++
 drivers/hwspinlock/hwspinlock_core.c                | 21 +++++++++++++++++++++
 include/linux/hwspinlock.h                          |  1 +
 3 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwlock/hwlock.txt b/Documentation/devicetree/bindings/hwlock/hwlock.txt
index 32381cc..d538a9b 100644
--- a/Documentation/devicetree/bindings/hwlock/hwlock.txt
+++ b/Documentation/devicetree/bindings/hwlock/hwlock.txt
@@ -18,6 +18,12 @@ Common properties:
 			property is needed on hwlock devices, where the number
 			of supported locks within a hwlock device cannot be
 			read from a register.
+- hwlock-base-id:	An unique base Id for the locks for a particular hwlock
+			device. This property is mandatory ONLY if a SoC has
+			several hwlock devices.
+
+			See documentation on struct hwspinlock_pdata in
+			include/linux/hwspinlock.h for more details.
 
 Hwlock Users:
 =============
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 3966c0c..4be1664 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -264,6 +264,27 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 EXPORT_SYMBOL_GPL(__hwspin_unlock);
 
 /**
+ * of_hwspin_lock_get_base_id() - OF helper to retrieve base id
+ * @dn: device node pointer
+ *
+ * This is an OF helper function that can be called by the underlying
+ * platform-specific implementations, to retrieve the base id for the
+ * set of locks present within a hwspinlock device instance.
+ *
+ * Returns the base id value on success, or an appropriate error code
+ * as returned by the OF layer
+ */
+int of_hwspin_lock_get_base_id(struct device_node *dn)
+{
+	unsigned int val;
+	int ret;
+
+	ret = of_property_read_u32(dn, "hwlock-base-id", &val);
+	return ret ? ret : val;
+}
+EXPORT_SYMBOL_GPL(of_hwspin_lock_get_base_id);
+
+/**
  * of_hwspin_lock_get_num_locks() - OF helper to retrieve number of locks
  * @dn: device node pointer
  *
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index 068e628..4857728 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -64,6 +64,7 @@ struct hwspinlock_pdata {
 
 int of_hwspin_lock_simple_xlate(struct hwspinlock_device *bank,
 				const struct of_phandle_args *hwlock_spec);
+int of_hwspin_lock_get_base_id(struct device_node *dn);
 int of_hwspin_lock_get_num_locks(struct device_node *dn);
 int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 		const struct hwspinlock_ops *ops, int base_id, int num_locks);
-- 
1.9.2
