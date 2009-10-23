From: francesco.virlinzi@st.com (Francesco Virlinzi)
Date: Fri, 23 Oct 2009 15:26:42 +0200
Subject: [PATCH] generic clock framework
Message-ID: <mailman.13.1257861683.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

version: 0.6.2

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 drivers/base/Makefile           |    4 +
 drivers/base/base.h             |    5 +
 drivers/base/clk.c              | 1606 +++++++++++++++++++++++++++++++++++++++
 drivers/base/clk.h              |  319 ++++++++
 drivers/base/clk_pm.c           |  197 +++++
 drivers/base/clk_utils.c        |  456 +++++++++++
 drivers/base/init.c             |    1 +
 drivers/base/platform.c         |   27 +
 include/linux/clk.h             |  251 ++++++
 include/linux/platform_device.h |    9 +
 init/Kconfig                    |   23 +
 11 files changed, 2898 insertions(+), 0 deletions(-)
 create mode 100644 drivers/base/clk.c
 create mode 100644 drivers/base/clk.h
 create mode 100644 drivers/base/clk_pm.c
 create mode 100644 drivers/base/clk_utils.c

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index b5b8ba5..b78a2bf 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -16,6 +16,10 @@ ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_MODULES)	+= module.o
 endif
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
+ifdef CONFIG_GENERIC_CLK_FM
+obj-y			+= clk.o clk_utils.o
+obj-$(CONFIG_PM)	+= clk_pm.o
+endif
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/base/base.h b/drivers/base/base.h
index b528145..bc5b9e8 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -94,6 +94,11 @@ extern int devices_init(void);
 extern int buses_init(void);
 extern int classes_init(void);
 extern int firmware_init(void);
+#ifdef CONFIG_GENERIC_CLK_FM
+extern int clock_init(void);
+#else
+static inline int clock_init(void){ return 0; }
+#endif
 #ifdef CONFIG_SYS_HYPERVISOR
 extern int hypervisor_init(void);
 #else
diff --git a/drivers/base/clk.c b/drivers/base/clk.c
new file mode 100644
index 0000000..7feae61
--- /dev/null
+++ b/drivers/base/clk.c
@@ -0,0 +1,1606 @@
+/*
+ * -------------------------------------------------------------------------
+ * clk.c
+ * -------------------------------------------------------------------------
+ * (C) STMicroelectronics 2008
+ * (C) STMicroelectronics 2009
+ * Author: Francesco M. Virlinzi <francesco.virlinzi@st.com>
+ * -------------------------------------------------------------------------
+ * May be copied or modified under the terms of the GNU General Public
+ * License v.2 ONLY.  See linux/COPYING for more information.
+ *
+ * -------------------------------------------------------------------------
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/klist.h>
+#include <linux/sysdev.h>
+#include <linux/kref.h>
+#include <linux/kobject.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+#include "clk.h"
+#include "base.h"
+
+#define CLK_NAME		"Generic Clk Framework"
+#define CLK_VERSION		"0.6.2"
+
+/* #define CLK_SAFE_CODE */
+
+klist_entry_support(clock, clk, node)
+klist_entry_support(child_clock, clk, child_node)
+klist_entry_support(dev_info, pdev_clk_info, node)
+
+#define to_clk(ptr)	container_of(ptr, struct clk, kobj)
+#define to_tnode(ptr)	container_of(ptr, struct clk_tnode, pnode)
+
+static int sysfs_clk_attr_show(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	ssize_t ret = -EIO;
+	struct kobj_attribute *kattr
+	    = container_of(attr, struct kobj_attribute, attr);
+	if (kattr->show)
+		ret = kattr->show(kobj, kattr, buf);
+	return ret;
+}
+
+static ssize_t
+sysfs_clk_attr_store(struct kobject *kobj, struct attribute *attr,
+			const char *buf, size_t count)
+{
+	ssize_t ret = -EIO;
+	struct kobj_attribute *kattr
+	    = container_of(attr, struct kobj_attribute, attr);
+	if (kattr->store)
+		ret = kattr->store(kobj, kattr, buf, count);
+	return ret;
+}
+
+static struct sysfs_ops clk_sysfs_ops = {
+	.show = sysfs_clk_attr_show,
+	.store = sysfs_clk_attr_store,
+};
+
+static struct kobj_type ktype_clk = {
+	.sysfs_ops = &clk_sysfs_ops,
+};
+
+static struct clk *check_clk(struct clk *);
+
+static struct kobject *clk_kobj;
+static DEFINE_MUTEX(clk_list_sem);
+static atomic_t transaction_counter = ATOMIC_INIT(0);
+struct klist clk_list = KLIST_INIT(clk_list, NULL, NULL);
+
+klist_function_support(child, clk, child_node, kobj)
+klist_function_support(device, pdev_clk_info, node, pdev->dev.kobj)
+
+/*
+ * The ___clk_xxx operations doesn't raise propagation
+ * they are used to operate on the real clock
+ */
+static int
+__clk_operations(struct clk *clk, unsigned long rate,
+	enum clk_ops_id const id_ops)
+{
+	int ret = 0;
+	unsigned long *ops_fns = (unsigned long *)clk->ops;
+	if (likely(ops_fns && ops_fns[id_ops])) {
+		int (*fns)(struct clk *clk, unsigned long rate)
+			= (void *)ops_fns[id_ops];
+		unsigned long flags;
+		spin_lock_irqsave(&clk->lock, flags);
+		ret = fns(clk, rate);
+		spin_unlock_irqrestore(&clk->lock, flags);
+	}
+	return ret;
+}
+
+static inline int __clk_init(struct clk *clk)
+{
+	pr_debug(": %s\n", clk->name);
+	return __clk_operations(clk, 0, __CLK_INIT);
+}
+static inline int __clk_enable(struct clk *clk)
+{
+	pr_debug(": %s\n", clk->name);
+	return __clk_operations(clk, 0, __CLK_ENABLE);
+}
+static inline int __clk_disable(struct clk *clk)
+{
+	pr_debug(": %s\n", clk->name);
+	return __clk_operations(clk, 0, __CLK_DISABLE);
+}
+static inline int __clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	pr_debug(": %s\n", clk->name);
+	return __clk_operations(clk, rate, __CLK_SET_RATE);
+}
+static inline int __clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	pr_debug(": %s\n", clk->name);
+	return __clk_operations(clk, (unsigned long)parent, __CLK_SET_PARENT);
+}
+static inline int __clk_recalc_rate(struct clk *clk)
+{
+	pr_debug(": %s\n", clk->name);
+	return __clk_operations(clk, 0, __CLK_RECALC);
+}
+static inline int __clk_round(struct clk *clk, unsigned long value)
+{
+	pr_debug(": %s\n", clk->name);
+	return __clk_operations(clk, value, __CLK_ROUND);
+}
+
+static inline int __clk_eval(struct clk *clk, unsigned long prate)
+{
+#ifndef CONFIG_CLK_FORCE_GENERIC_EVALUATE
+	pr_debug(": %s\n", clk->name);
+	return	__clk_operations(clk, prate, __CLK_EVAL);
+#else
+	unsigned long rate, flags;
+	pr_debug(": %s\n", clk->name);
+	if (likely(clk->ops && clk->ops->eval)) {
+		spin_lock_irqsave(&clk->lock, flags);
+		rate = clk->ops->eval(clk, prate);
+		spin_unlock_irqrestore(&clk->lock, flags);
+	} else
+		rate = clk_generic_evaluate_rate(clk, prate);
+	return rate;
+#endif
+}
+
+#ifdef CONFIG_PM_RUNTIME
+static int
+clk_pm_runtime_devinfo(enum rpm_status code, struct pdev_clk_info *info)
+{
+	struct platform_device *pdev = info->pdev;
+
+	pr_debug("\n");
+
+	switch (code) {
+	case RPM_ACTIVE:
+		return clk_notify_child_event(CHILD_DEVICE_ENABLED, info->clk);
+	case RPM_SUSPENDED:
+		return clk_notify_child_event(CHILD_DEVICE_DISABLED, info->clk);
+	}
+	return -EINVAL;
+}
+
+int clk_pm_runtime_device(enum rpm_status code, struct platform_device *dev)
+{
+	int idx;
+	int ret = 0;
+	struct pdev_clk_info *info;
+
+	if (!dev)
+		return -EFAULT;
+
+	if (!dev->clks || !pdevice_num_clocks(dev))
+		return 0;
+
+	pr_debug("\n");
+/*
+ *	Check if the device is under a transaction.
+ * 	If so the GCFdoesn't raise a 'clk_pm_runtime_devinfo'
+ *	all the device change will be notified on 'tnode_transaction_complete'
+ *	if required....
+ */
+	if (atomic_read((atomic_t *)&dev->clk_flags)) {
+		pr_debug("%s.%d under transaction\n", dev->name, dev->id);
+		return ret;
+	}
+	for (idx = 0, info = dev->clks; idx < pdevice_num_clocks(dev); ++idx)
+		ret |= clk_pm_runtime_devinfo(&info[idx], state, 0);
+
+	return ret;
+}
+#else
+#define clk_pm_runtime_devinfo(x, y)
+#define clk_pm_runtime_device(x, y)
+#endif
+
+/**
+ * tnode_malloc
+ *
+ * Allocs the memory for both the transaction and the
+ * clk_event objects
+ */
+static struct clk_tnode *tnode_malloc(struct clk_tnode *parent,
+	unsigned long nevent)
+{
+	struct clk_event *evt;
+	struct clk_tnode *node;
+
+	if (nevent > 32)
+		return NULL;
+
+	node = kmalloc(sizeof(*node) + nevent *	sizeof(*evt), GFP_KERNEL);
+
+	if (!node)
+		return NULL;
+
+	evt = (struct clk_event *)(sizeof(struct clk_tnode) + (long)node);
+
+	node->tid    = atomic_inc_return(&transaction_counter);
+	node->parent = parent;
+	node->size   = nevent;
+	node->events = evt;
+	node->events_map = 0;
+	INIT_LIST_HEAD(&node->childs);
+
+	return node;
+}
+
+/**
+ * tnode_free
+ *
+ * Free the tnode memory
+ */
+static void tnode_free(struct clk_tnode *node)
+{
+	if (tnode_get_parent(node)) {
+		list_del(&node->pnode);
+		kfree(node);
+	}
+}
+
+/**
+ *  tnode_check_clock -
+ *
+ *  @node: the tnode object
+ *  @clk:  the clock object
+ *
+ *  returns a boolean value
+ *  it checks if the clock (clk) is managed by the
+ *  tnode (node) or any parent node
+ */
+static int __must_check
+tnode_check_clock(struct clk_tnode *node, struct clk *clk)
+{
+	int j;
+	for (; node; node = tnode_get_parent(node))
+		/* scans all the event */
+		tnode_for_each_valid_events(node, j)
+			if (tnode_get_clock(node, j) == clk)
+					return 1; /* FOUND!!! */
+	return 0;
+}
+
+/**
+  * tnode_lock_clocks -
+  *
+  * @node: the tnode object
+  *
+  * marks all the clocks under transaction to be sure there is no more
+  * than one transaction for each clock
+  */
+static int __must_check
+tnode_lock_clocks(struct clk_tnode *node)
+{
+	int i;
+	pr_debug("\n");
+
+	/* 1. try to mark all the clocks in transaction */
+	for (i = 0; i < tnode_get_size(node); ++i)
+		if (clk_set_towner(tnode_get_clock(node, i), node)) {
+			struct clk *clkp = tnode_get_clock(node, i);
+			/* this clock is already locked */
+			/* we accept that __only__ if it is locked by a
+			 * parent tnode!!!
+			 */
+			if (!tnode_get_parent(node)) {
+				pr_debug("Error clk %s locked but "
+					  "there is no parent!\n", clkp->name);
+				goto err_0;
+			}
+			pr_debug("clk %s already locked\n", clkp->name);
+			if (tnode_check_clock(tnode_get_parent(node), clkp)) {
+				pr_debug("ok clk %s locked "
+					  "by a parent\n", clkp->name);
+				continue;
+			} else
+				goto err_0;
+		} else
+			/* set the event as valid in the bitmap*/
+			tnode_set_map_id(node, i);
+
+/*
+ * all the clocks are marked succesfully or all the clock on
+ * this tnode are already managed by parent
+ */
+	if (!tnode_get_map(node)) { /* check if the bitamp is not zero */
+		if (tnode_get_parent(node))
+			kfree(node);
+		return 1;
+	}
+
+ /*
+ * all the clocks are marked succesfully _and_ there is at least
+ * one clock marked.
+ * Add the tnode to its parent! and return
+ */
+	if (tnode_get_parent(node))
+		list_add_tail(&node->pnode, &tnode_get_parent(node)->childs);
+
+	return 0;
+
+err_0:
+	pr_debug("Error on clock locking...\n");
+	for (--i; i >= 0; --i)
+		if (tnode_check_map_id(node, i))
+			clk_clean_towner(tnode_get_clock(node, i));
+
+	if (tnode_get_parent(node))
+		kfree(node);
+
+	return -EINVAL;
+}
+
+/**
+ * tnode_transaction_complete -
+ *
+ * checks the devices status when the transaction is complete.
+ */
+static void tnode_transaction_complete(struct clk_tnode *node)
+{
+	struct klist_iter i;
+	struct pdev_clk_info *dev_info;
+	int j;
+
+	pr_debug("tid: %d\n", (int)tnode_get_id(node));
+	tnode_for_each_valid_events(node, j) {
+	klist_iter_init(&tnode_get_clock(node, j)->devices, &i);
+	while ((dev_info = next_dev_info(&i))) {
+		/* update the device state */
+		struct platform_device *dev = dev_info->pdev;
+		switch (dev->clk_state & (DEV_SUSPENDED_ON_TRANSACTION |
+					  DEV_RESUMED_ON_TRANSACTION)) {
+		case 0: /* this device doesn't care on the clock transaction */
+			atomic_clear_mask(DEV_ON_TRANSACTION,
+				(atomic_t *)&dev->clk_state);
+			break;
+
+		case (DEV_SUSPENDED_ON_TRANSACTION |
+			DEV_RESUMED_ON_TRANSACTION):
+			/* this device was suspended and
+			 * resumed therefore no real change
+			 */
+			pr_debug("dev: %s.%d "
+				"Suspended&Resumed (no child event)\n",
+				dev->name, dev->id);
+			atomic_clear_mask(DEV_ON_TRANSACTION |
+					  DEV_SUSPENDED_ON_TRANSACTION |
+					  DEV_RESUMED_ON_TRANSACTION,
+					  (atomic_t *)&dev->clk_state);
+			break;
+		case DEV_SUSPENDED_ON_TRANSACTION:
+			atomic_clear_mask(DEV_ON_TRANSACTION |
+				DEV_SUSPENDED_ON_TRANSACTION,
+				(atomic_t *)&dev->clk_state);
+			pr_debug("dev: %s.%d Suspended\n",
+				dev->name, dev->id);
+			clk_pm_runtime_device(RPM_SUSPENDED, dev);
+			break;
+		case DEV_RESUMED_ON_TRANSACTION:
+			atomic_clear_mask(DEV_ON_TRANSACTION |
+				DEV_RESUMED_ON_TRANSACTION,
+				(atomic_t *)&dev->clk_state);
+			pr_debug("dev: %s.%d Resumed\n",
+				dev->name, dev->id);
+			clk_pm_runtime_device(RPM_ACTIVE, dev);
+			break;
+
+		default:
+			printk(KERN_ERR "%s: device %s,%d clk_flags _not_ valid %u\n",
+				__func__, dev->name, dev->id,
+				(unsigned int)dev->clk_state);
+		}
+	}
+	klist_iter_exit(&i);
+	clk_clean_towner(tnode_get_clock(node, j));
+	}
+	pr_debug("tid: %d exit\n", (int)tnode_get_id(node));
+	return;
+}
+
+/*
+ * Check if the clk is registered
+ */
+#ifdef CLK_SAFE_CODE
+static struct clk *check_clk(struct clk *clk)
+{
+	struct clk *clkp;
+	struct clk *result = NULL;
+	struct klist_iter i;
+
+	pr_debug("\n");
+
+	klist_iter_init(&clk_list, &i);
+	while ((clkp = next_clock(&i)))
+		if (clk == clkp) {
+			result = clk;
+			break;
+		}
+	klist_iter_exit(&i);
+	return result;
+}
+#else
+static inline struct clk *check_clk(struct clk *clk)
+{
+	return clk;
+}
+#endif
+
+enum child_event_e {
+	CHILD_CLOCK_ENABLED = 1,
+	CHILD_CLOCK_DISABLED,
+	CHILD_DEVICE_ENABLED,
+	CHILD_DEVICE_DISABLED,
+};
+
+static int
+clk_notify_child_event(enum child_event_e const code, struct clk *clk)
+{
+	if (!clk)
+		return 0;
+
+	switch (code) {
+	case CHILD_CLOCK_ENABLED:
+		++clk->nr_active_clocks;
+		break;
+	case CHILD_CLOCK_DISABLED:
+		--clk->nr_active_clocks;
+		break;
+	case CHILD_DEVICE_ENABLED:
+		++clk->nr_active_devices;
+		break;
+	case CHILD_DEVICE_DISABLED:
+		--clk->nr_active_devices;
+		break;
+	}
+
+	if (clk_is_auto_switching(clk)) {
+		/*
+		 * Check if there are still users
+		 */
+		if (!clk->nr_active_devices && !clk->nr_active_clocks)
+			clk_disable(clk);
+		else if (!clk_get_rate(clk)) /* if off.. turn-on */
+			clk_enable(clk);
+	}
+
+	return 0;
+}
+
+/**
+ * clk_dev_events_malloc -
+ *
+ * builds a struct clk_event array (dev_event).
+ * the array size (how many elements) is based on device_num_clocks(dev)
+ * the contenets of each element is equal to:
+ * - the events array (if the idx-clock is under transaction)
+ * - the current clock setting if the idx-clock isn't under transaction
+ */
+static struct clk_event * __must_check
+clk_dev_events_malloc(struct platform_device const *dev)
+{
+	struct clk_event *dev_events;
+	struct clk_tnode *node;
+	int i, j;
+	pr_debug("\n");
+/*
+ * 1.  simple case:
+ *	- device_num_clocks(dev) = 1
+ */
+	if (pdevice_num_clocks(dev) == 1) {
+		node = (struct clk_tnode *)pdevice_clock(dev, 0)->towner;
+		for (i = 0; i < tnode_get_size(node); ++i)
+			if (tnode_get_clock(node, i) == pdevice_clock(dev, 0))
+				return tnode_get_event(node, i);
+	}
+/*
+ * 2. - device_num_clocks(dev) > 1
+ *	GCF has to build a dedicated device events (devents) array
+ *	for this device! sorted as the device registered it-self!
+ */
+	dev_events = kmalloc(sizeof(*dev_events) * pdevice_num_clocks(dev),
+			GFP_KERNEL);
+	if (!dev_events)
+		return NULL;
+
+	for (i = 0; i < pdevice_num_clocks(dev); ++i) {
+		node = (struct clk_tnode *)pdevice_clock(dev, i)->towner;
+		dev_events[i].clk = pdevice_clock(dev, i);
+		if (!node) {/* this means this clocs isn't under transaction */
+		     dev_events[i].old_rate =
+				clk_get_rate(pdevice_clock(dev, i));
+		     dev_events[i].new_rate =
+				clk_get_rate(pdevice_clock(dev, i));
+		     continue;
+		}
+		/* search the right clk_event */
+		for (j = 0; tnode_get_clock(node, j) != pdevice_clock(dev, i);
+		     ++j);
+
+		dev_events[i].old_rate = tnode_get_event(node, j)->old_rate;
+		dev_events[i].new_rate = tnode_get_event(node, j)->new_rate;
+	}
+	return dev_events;
+}
+
+/**
+ * clk_devents_free -
+ * free the devent allocated on the device dev.
+ */
+static inline void
+clk_dev_events_free(struct clk_event *dev_events, struct platform_device *dev)
+{
+	if (pdevice_num_clocks(dev) == 1)
+		return ;
+	kfree(dev_events);
+}
+
+/**
+ * clk_trnsc_fsm -
+ *
+ * propagate the transaction to all the childs
+ * each transaction has the following life-time:
+ *
+ *	+---------------+
+ *	|    ENTER_CLK	|   The ENTER state only for clocks
+ *	+---------------+     - acquires all the clock of the transaction
+ *		|	       - builds the transaction graph
+ *		|	      - for each clock generates a child transaction
+ *		|
+ *   +---------------------+
+ *   |	+---------------+  |
+ *   |	|    ENTER_DEV 	|  |  The ENTER state only for devices
+ *   |  +---------------+  |  - >> NOTIFY_CLK_ENTERCHANGE << notified
+ *   |		|	   |  - - the device could refuse the operation
+ *   |		|	   |
+ *   |	+---------------+  |
+ *   |	|    PRE_DEV	|  |  The PRE state only devices
+ *   |	+---------------+  |  - >> NOTIFY_CLK_PRECHANGE << notified
+ *   |		|	   |  - - the device could be suspended
+ *   +---------------------+
+ *		|
+ *	+---------------+
+ * 	|   CHANGE_CLK	|    The CHANGE state only for clocks
+ *	+---------------+     - updates all the physical clocks
+ *		|	        and relative clk_event_s according to
+ *		|	        the hw value.
+ *   +---------------------+
+ *   |		|	   |
+ *   |	+---------------+  |
+ *   |	|   POST_DEV	|  |  The POST state only for devices
+ *   |  +---------------+  |  - >> NOTIFY_CLK_POSTCHANGE << notified
+ *   |		|	   |  - - the devices could be resumed
+ *   |		|	   |
+ *   |	+---------------+  |
+ *   |	|  EXIT_DEV	|  |   The EXIT state only for devices
+ *   |  +---------------+  |   - >> NOTIFY_CLK_EXITCHANGE << notified
+ *   |		|	   |   - - the devices is aware all the other
+ *   +---------------------+	   devices are resumed.
+ *		|
+ *	+---------------+
+ *	|  EXIT_CLK	|      The EXIT state only for clocks
+ *	+---------------+      (to free all the memory)
+ *				- Free all the allocated memory
+ *
+ */
+
+static enum notify_ret_e
+clk_trnsc_fsm(enum clk_fsm_e const code, struct clk_tnode *node)
+{
+	struct pdev_clk_info *dev_info;
+	struct clk_tnode *tchild;
+	struct klist_iter i;
+	int j;
+	enum notify_ret_e tmp, ret_notifier = NOTIFY_EVENT_HANDLED;
+
+#ifdef CONFIG_CLK_DEBUG
+	switch (code) {
+	case TRNSC_ENTER_CLOCK:
+	case TRNSC_ENTER_DEVICE:
+		printk(KERN_INFO "ENTER_%s ",
+			(code == TRNSC_ENTER_CLOCK ? "CLK" : "DEV"));
+		break;
+	case TRNSC_PRE_DEVICE:
+		printk(KERN_INFO "PRE_DEV ");
+		break;
+	case TRNSC_CHANGE_CLOCK:
+		printk(KERN_INFO "CHANGE_CLK ");
+		break;
+	case TRNSC_POST_DEVICE:
+		printk(KERN_INFO "POST_DEV ");
+		break;
+	case TRNSC_EXIT_DEVICE:
+	case TRNSC_EXIT_CLOCK:
+		printk(KERN_INFO "EXIT_%s ",
+			(code == TRNSC_EXIT_DEVICE ? "DEV" : "CLK"));
+			break;
+	}
+	printk(KERN_INFO"tid:%u ", (unsigned int)tnode_get_id(node));
+	if (tnode_get_parent(node))
+		printk(KERN_INFO " (tpid: %d)",
+			(int)tnode_get_id(tnode_get_parent(node)));
+	printk(KERN_INFO " (0x%x/0x%x) ", (unsigned int)tnode_get_size(node),
+			(unsigned int)tnode_get_map(node));
+	for (j = 0; j < tnode_get_size(node); ++j) {
+		if (tnode_check_map_id(node, j))
+			/* print only the valid event... */
+			printk(KERN_INFO"- %s ",
+				tnode_get_clock(node, j)->name);
+		else if (code == TRNSC_ENTER_CLOCK)
+			printk(KERN_INFO"- %s ",
+				tnode_get_clock(node, j)->name);
+	}
+	printk(KERN_INFO"\n");
+#endif
+
+	/* 
+	 * Clk ENTER state
+	 */
+	if (code == TRNSC_ENTER_CLOCK) {
+		unsigned long idx;
+		enum clk_event_e sub_code;
+		struct clk *clkp;
+		struct clk_event *sub_event = NULL;
+
+		/* first of all the GCF tries to lock the clock of this tnode
+		 * and links the tnode to its parent (if any)
+		 */
+		switch (tnode_lock_clocks(node)) {
+		case 0:
+			break;
+		case -EINVAL:
+			return NOTIFY_EVENT_NOTHANDLED;
+		case 1:
+			return NOTIFY_EVENT_HANDLED;
+		}
+
+		pr_debug("clocks acquired\n");
+		/* Propagates the events to the sub clks */
+		tnode_for_each_valid_events(node, j) {
+
+		if (!clk_allow_propagation(tnode_get_clock(node, j))) {
+			pr_debug("clk: %s doesn't want propagation\n",
+				tnode_get_clock(node, j)->name);
+			continue;
+		}
+		if (!(tnode_get_clock(node, j)->nr_clocks))
+			continue;
+
+		tchild = tnode_malloc(node,
+			tnode_get_clock(node, j)->nr_clocks);
+		if (!tchild) {
+			printk(KERN_ERR "No enough memory during a clk "
+					"transaction\n");
+			ret_notifier |= NOTIFY_EVENT_NOTHANDLED;;
+			return ret_notifier;
+		}
+
+		pr_debug("memory for child transaction acquired\n");
+		idx = 0;
+		sub_code = clk_event_decode(tnode_get_event(node, j));
+		klist_iter_init(&tnode_get_clock(node, j)->childs, &i);
+		while ((clkp = next_child_clock(&i))) {
+			sub_event = tnode_get_event(tchild, idx);
+			clk_event_init(sub_event, clkp, clk_get_rate(clkp),
+				clk_get_rate(clkp));
+			switch (sub_code) {/* prepare the sub event fields */
+			case _CLK_CHANGE:
+			case _CLK_ENABLE:
+				sub_event->new_rate = clk_evaluate_rate(clkp,
+					tnode_get_event(node, j)->new_rate);
+				break;
+			case _CLK_DISABLE:
+				sub_event->new_rate = 0;
+				break;
+			case _CLK_NOCHANGE:
+				break;
+			}
+			++idx;
+			}
+		klist_iter_exit(&i);
+		/* now GCF can araiese the sub transaction */
+		ret_notifier |=
+			clk_trnsc_fsm(code, tchild);
+		}
+		return ret_notifier;
+	}
+
+	/*
+	 * Clk CHANGE state
+	 */
+	if (code == TRNSC_CHANGE_CLOCK) {
+		/* the clocks on the root node are managed directly in the
+		 * clk_set_rate/clk_enable/... functions ...
+		 * while all the other clocks have to managed here!
+		 */
+		if (node->parent)
+			tnode_for_each_valid_events(node, j) {
+				struct clk_event *event;
+				long code;
+				event = tnode_get_event(node, j);
+				code = clk_event_decode(event);
+				switch (code) {
+				case _CLK_CHANGE:
+					__clk_recalc_rate(event->clk);
+					event->new_rate =
+						clk_get_rate(event->clk);
+					break;
+				case _CLK_ENABLE:
+					if (clk_follow_parent(event->clk)) {
+						__clk_enable(event->clk);
+						event->new_rate =
+						clk_get_rate(event->clk);
+					}
+					break;
+				case _CLK_DISABLE:
+					if (clk_is_enabled(event->clk))
+						__clk_disable(event->clk);
+					break;
+				}
+			}
+
+		list_for_each_entry(tchild, &node->childs, pnode)
+			ret_notifier |= clk_trnsc_fsm(code, tchild);
+
+		return ret_notifier;
+	}
+
+	/*
+	 * Clk EXIT state
+	 */
+	if (code == TRNSC_EXIT_CLOCK) {
+		struct list_head *ptr, *next;
+		/* scans all the transaction childs */
+		list_for_each_safe(ptr, next, &node->childs)
+			clk_trnsc_fsm(code, to_tnode(ptr));
+
+		/* update the devices/clocks state */
+		tnode_transaction_complete(node);
+
+		tnode_free(node);
+		pr_debug("EXIT_CLK complete\n");
+
+		return ret_notifier;
+	}
+
+	/*
+	 * Here the devices management
+	 */
+	tnode_for_each_valid_events(node, j) {
+		if (!clk_allow_propagation(tnode_get_clock(node, j)))
+			continue;
+	klist_iter_init(&tnode_get_clock(node, j)->devices, &i);
+	while ((dev_info = next_dev_info(&i))) {
+		struct platform_device *pdev = dev_info->pdev;
+		struct platform_driver *pdrv = 	container_of(
+			pdev->dev.driver, struct platform_driver, driver);
+
+		struct clk_event *dev_events;
+
+		if (!pdrv || !pdrv->notify) {
+			pr_debug(
+			"device %s.%d registered with no notify function\n",
+				pdev->name, pdev->id);
+			continue;
+		}
+		/* check if it already had a 'code' event */
+		if (pdev_transaction_move_on(pdev, code))
+			continue;
+
+		dev_events = clk_dev_events_malloc(pdev);
+		if (!dev_events) {
+			printk(KERN_ERR"%s: No Memory during a clk "
+				"transaction\n", __func__);
+			continue;
+		}
+
+		/* GCF can use 'code' directly in the .notify function
+		 * just because external 'NOTIFY_CLK_xxxCHANGE' code
+		 * matchs with the internal 'device' code
+		 */
+		tmp = pdrv->notify(code, pdev, dev_events);
+		clk_dev_events_free(dev_events, pdev);
+		ret_notifier |= tmp;
+#ifdef CONFIG_PM_RUNTIME
+		if (code == TRNSC_PRE_DEVICE && tmp == NOTIFY_EVENT_HANDLED) {
+			printk(KERN_INFO "clk %s on code %u suspends "
+				"device %s.%d\n",
+				transaction_get_clock(node, j)->name,
+				(unsigned int)code, pdev->name, pdev->id);
+			pm_runtime_suspend(&pdev->dev);
+		} else
+		if (code == TRNSC_POST_DEVICE && tmp == NOTIFY_EVENT_HANDLED) {
+			printk(KERN_INFO "clk %s on code %u resumes "
+				"device %s.%d\n",
+				transaction_get_clock(node, j)->name,
+				(unsigned int)code, pdev->name, pdev->id);
+			pm_runtime_resume(&pdev->dev);
+		};
+#endif
+	} /* while closed */
+	klist_iter_exit(&i);
+	} /* for closed */
+
+	/*
+	 *and propagate down...
+	 */
+	list_for_each_entry(tchild, &node->childs, pnode)
+			ret_notifier |= clk_trnsc_fsm(code, tchild);
+
+	return ret_notifier;
+}
+
+static void clk_initialize(struct clk *clk)
+{
+	kobject_init(&clk->kobj, &ktype_clk);
+	kobject_set_name(&clk->kobj, "%s", clk->name);
+	kobject_get(&clk->kobj);
+
+	clk->nr_clocks = 0;
+	clk->nr_active_clocks = 0;
+	clk->nr_active_devices = 0;
+	clk->towner = NULL;
+
+	klist_init(&clk->childs, klist_get_child, klist_put_child);
+	klist_init(&clk->devices, klist_get_device, klist_put_device);
+
+}
+
+/**
+  * clk_register -
+  *
+  * registers a new clk in the system.
+  * returns zero if success
+  */
+int clk_register(struct clk *clk)
+{
+	int ret = 0;
+	if (!clk)
+		return -EFAULT;
+	pr_debug("%s\n", clk->name);
+
+	clk_initialize(clk);
+
+	/* Initialize ... */
+	__clk_init(clk);
+
+	if (clk->parent) {
+#ifdef CLK_SAFE_CODE
+		/* 1. the parent has to be registered */
+		if (!check_clk(clk->parent))
+			return -ENODEV;
+		/* 2. an always enabled child has to sit on a always
+		 *    enabled parent!
+		 */
+		if (clk->flags & CLK_ALWAYS_ENABLED &&
+			!(clk->parent->flags & CLK_ALWAYS_ENABLED))
+			return -EFAULT;
+		/* 3. a fixed child has to sit on a fixed parent */
+		if (clk_is_readonly(clk) && !clk_is_readonly(clk->parent))
+			return -EFAULT;
+#endif
+		klist_add_tail(&clk->child_node, &clk->parent->childs);
+		clk->parent->nr_clocks++;
+	}
+
+	ret = kobject_add(&clk->kobj,
+		(clk->parent ? &clk->parent->kobj : clk_kobj), clk->name);
+	if (ret)
+		goto err_0;
+
+	clk->kdevices =	kobject_create_and_add("devices", &clk->kobj);
+	if (!clk->kdevices)
+		goto err_1;
+
+	klist_add_tail(&clk->node, &clk_list);
+	if (clk->flags & CLK_ALWAYS_ENABLED) {
+		__clk_enable(clk);
+		clk_notify_child_event(CHILD_CLOCK_ENABLED, clk->parent);
+	}
+	return ret;
+
+err_1:
+	/* subsystem_remove_file... removed in the common code... ??? */
+	kobject_del(&clk->kobj);
+err_0:
+	return ret;
+}
+EXPORT_SYMBOL(clk_register);
+
+/**
+  * clk_unregister -
+  * unregisters the clock from system
+  */
+int clk_unregister(struct clk *clk)
+{
+	pr_debug("\n");
+
+	if (!clk)
+		return -EFAULT;
+
+	if (!list_empty(&clk->devices.k_list))
+		return -EFAULT; /* somebody is still using this clock */
+
+	kobject_del(clk->kdevices);
+	kfree(clk->kdevices);
+	/* subsystem_remove_file... removed in the common code... ??? */
+	kobject_del(&clk->kobj);
+	klist_del(&clk->node);
+	if (clk->parent) {
+		klist_del(&clk->child_node);
+		clk->parent->nr_clocks--;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_unregister);
+
+static int clk_add_devinfo(struct pdev_clk_info *info)
+{
+	int ret = 0;
+	pr_debug("\n");
+
+#ifdef CLK_SAFE_CODE
+	if (!info || !info->clk || !check_clk(info->clk))
+		return -EFAULT;
+#endif
+	ret = sysfs_create_link(info->clk->kdevices, &info->pdev->dev.kobj,
+		dev_name(&info->pdev->dev));
+	if (ret) {
+		pr_debug(" Error %d\n", ret);
+		return ret;
+	}
+	klist_add_tail(&info->node, &info->clk->devices);
+
+	return 0;
+}
+
+static int clk_del_devinfo(struct pdev_clk_info *info)
+{
+	pr_debug("\n");
+
+#ifdef CLK_SAFE_CODE
+	if (!info || !info->clk || !check_clk(info->clk))
+		return -EFAULT;
+#endif
+	sysfs_remove_link(info->clk->kdevices, dev_name(&info->pdev->dev));
+	klist_del(&info->node);
+
+#ifndef CONFIG_PM_RUNTIME
+	/*
+	 * Without PM_RUNTIME the GCF assumes the device is
+	 * 'not active' when it's removed
+	 */
+	clk_notify_child_event(CHILD_DEVICE_DISABLED, info->clk);
+#endif
+	return 0;
+}
+
+int clk_probe_device(struct platform_device *dev, enum pdev_probe_state state)
+{
+	int idx;
+	switch (state) {
+	case PDEV_PROBEING:
+		/* before the .probe function is called the GCF
+		 * has to turn-on _all_ the clocks the device uses
+		 * to garantee a safe .probe
+		 */
+		for (idx = 0; idx < pdevice_num_clocks(dev); ++idx)
+			if (pdevice_clock(dev, idx))
+				clk_enable(pdevice_clock(dev, idx));
+		return 0;
+	case PDEV_PROBED:
+#ifdef CONFIG_PM_RUNTIME
+	/*
+	 * Here the GCF should check the device's pm_runtime state
+	 * And if the device is suspended the clk_frmwk can turn-off the clocks
+	 */
+#else
+	/*
+	 * Without PM_RUNTIME the GCF assumes the device is active
+	 */
+	for (idx = 0; idx < pdevice_num_clocks(dev); ++idx)
+		clk_notify_child_event(CHILD_DEVICE_ENABLED,
+			pdevice_clock(dev, idx));
+#endif
+	break;
+	case PDEV_PROBE_FAILED:
+	/*
+	 * TO DO something...
+	 */
+		break;
+	}
+	return 0;
+}
+
+int clk_add_device(struct platform_device *dev, enum pdev_add_state state)
+{
+	int idx;
+	int ret;
+
+	if (!dev)
+		return -EFAULT;
+
+	switch (state) {
+	case PDEV_ADDING:
+	case PDEV_ADD_FAILED:
+		/*
+		 * TO DO something
+		 */
+		return 0;
+	case PDEV_ADDED:
+		break;
+	}
+	/* case PDEV_ADDED ... */
+	if (!dev->clks || !pdevice_num_clocks(dev))
+		return 0;	/* this device will not use
+				   the clk framework */
+
+	pr_debug("%s.%d with %u clocks\n", dev->name, dev->id,
+		(unsigned int)pdevice_num_clocks(dev));
+
+	dev->clk_state = 0;
+	for (idx = 0; idx < pdevice_num_clocks(dev); ++idx) {
+		if (!pdevice_clock(dev, idx)) {	/* clk can not be NULL... */
+			pr_debug("Error clock NULL\n");
+			continue;
+		}
+		pr_debug("->under %s\n", dev->clks[idx].clk->name);
+		dev->clks[idx].pdev = dev;
+		ret = clk_add_devinfo(&dev->clks[idx]);
+		if (ret)
+			goto err_0;
+	}
+
+	return 0;
+err_0:
+	for (--idx; idx >= 0; --idx)
+		clk_del_devinfo(&dev->clks[idx]);
+
+	return -EINVAL;
+}
+
+int clk_del_device(struct platform_device *dev)
+{
+	int idx;
+	if (!dev)
+		return -EFAULT;
+
+	for (idx = 0; idx < pdevice_num_clocks(dev); ++idx)
+		clk_del_devinfo(&dev->clks[idx]);
+
+	return 0;
+}
+
+void clk_put(struct clk *clk)
+{
+	if (clk && !IS_ERR(clk))
+		kobject_put(&clk->kobj);
+}
+
+static int clk_is_parent(struct clk const *child, struct clk const *parent)
+{
+	if (!child || !parent)
+		return 0;
+	if (!child->parent)
+		return 0;
+	if (child->parent == parent)
+		return 1;
+	else
+		return clk_is_parent(child->parent, parent);
+}
+
+int clk_enable(struct clk *clk)
+{
+	int ret;
+	struct clk_tnode transaction;
+	struct clk_event event;
+
+	event = EVENT(clk, 0, CLK_UNDEFINED_RATE);
+	transaction = TRANSACTION_ROOT(1, &event);
+
+	pr_debug("%s\n", clk->name);
+
+
+	if (clk->flags & CLK_ALWAYS_ENABLED || clk_is_enabled(clk))
+		return 0;
+
+	if (clk->parent) {
+		/* turn-on the parent if the parent is 'auto_switch' */
+		clk_notify_child_event(CHILD_CLOCK_ENABLED, clk->parent);
+
+		if (!clk_is_enabled(clk->parent)) {
+			/* the parent is still disabled... */
+			clk_notify_child_event(CHILD_CLOCK_DISABLED,
+				clk->parent);
+			return -EINVAL;
+		}
+	}
+
+	ret = clk_trnsc_fsm(TRNSC_ENTER_CLOCK, &transaction);
+	if (ret) {
+		ret = -EPERM;
+		goto err_0;
+	}
+
+	/* if not zero somebody doens't agree the clock update */
+	ret = clk_trnsc_fsm(TRNSC_ENTER_DEVICE, &transaction);
+	if (ret) {
+		ret = -EPERM;
+		goto err_1;
+		}
+
+	clk_trnsc_fsm(TRNSC_PRE_DEVICE, &transaction);
+
+	ret = __clk_enable(clk);
+
+	event.new_rate = clk_get_rate(clk);
+
+	clk_trnsc_fsm(TRNSC_CHANGE_CLOCK, &transaction);
+
+	clk_trnsc_fsm(TRNSC_POST_DEVICE, &transaction);
+
+err_1:
+	clk_trnsc_fsm(TRNSC_EXIT_DEVICE, &transaction);
+
+err_0:
+	clk_trnsc_fsm(TRNSC_EXIT_CLOCK, &transaction);
+
+	if (ret)
+		clk_notify_child_event(CHILD_CLOCK_DISABLED, clk->parent);
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_enable);
+
+/**
+ * clk_disable -
+ * disables the clock
+ * Is isn't really good that it's a 'void' function...
+ * but this is common interface
+ */
+void clk_disable(struct clk *clk)
+{
+	struct clk_tnode transaction;
+	struct clk_event event;
+	int ret;
+
+	event = EVENT(clk, clk_get_rate(clk), 0);
+	transaction = TRANSACTION_ROOT(1, &event);
+
+	pr_debug("\n");
+
+	if (clk->flags & CLK_ALWAYS_ENABLED || !clk_is_enabled(clk))
+		return;
+
+	ret = clk_trnsc_fsm(TRNSC_ENTER_CLOCK, &transaction);
+	if (ret)
+		goto err_0;
+
+	/* if not zero somebody doens't agree the clock update */
+	ret = clk_trnsc_fsm(TRNSC_ENTER_DEVICE, &transaction);
+	if (ret)
+		goto err_1;
+
+	clk_trnsc_fsm(TRNSC_PRE_DEVICE, &transaction);
+
+	__clk_disable(clk);
+
+	clk_trnsc_fsm(TRNSC_CHANGE_CLOCK, &transaction);
+
+	clk_trnsc_fsm(TRNSC_POST_DEVICE, &transaction);
+
+err_0:
+	clk_trnsc_fsm(TRNSC_EXIT_DEVICE, &transaction);
+err_1:
+	clk_trnsc_fsm(TRNSC_EXIT_CLOCK, &transaction);
+
+	clk_notify_child_event(CHILD_CLOCK_DISABLED, clk->parent);
+
+	return ;
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return clk->parent;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	int ret = -EOPNOTSUPP;
+	struct clk *old_parent = clk->parent;
+	struct clk_event event;
+	struct clk_tnode transaction;
+	int clk_was_enabled = clk_is_enabled(clk);
+
+	event = EVENT(clk, clk_get_rate(clk), CLK_UNDEFINED_RATE);
+	transaction = TRANSACTION_ROOT(1, &event);
+
+	if (!clk || !parent)
+		return -EINVAL;
+
+	if (clk->parent == parent)
+		return 0;
+
+	pr_debug("\n");
+
+	if (clk_was_enabled && !clk_is_enabled(parent))
+		/* turn-on parent if possible */
+		clk_notify_child_event(CHILD_CLOCK_ENABLED, parent);
+
+	ret = clk_trnsc_fsm(TRNSC_ENTER_CLOCK, &transaction);
+	if (ret) {
+		ret = -EPERM;
+		goto err_0;
+	}
+
+	/* if not zero somebody doens't agree the clock updated */
+	ret = clk_trnsc_fsm(TRNSC_ENTER_DEVICE, &transaction);
+	if (ret) {
+		ret = -EPERM;
+		goto err_1;
+	}
+
+	clk_trnsc_fsm(TRNSC_PRE_DEVICE, &transaction);
+
+	/* Now we updated the hw */
+	ret = __clk_set_parent(clk, parent);
+	if (ret) {
+		/* there was a problem...
+		 * therefore clk is still on the old parent
+		 */
+		clk->parent = old_parent; /* to be safe ! */
+		goto err_2;
+	}
+
+	klist_del(&clk->child_node);
+
+	clk->parent = parent;
+
+	ret = kobject_move(&clk->kobj, &clk->parent->kobj);
+	if (ret)
+		;
+
+	klist_add_tail(&clk->child_node, &clk->parent->childs);
+
+	clk->parent->nr_clocks++;
+	old_parent->nr_clocks--;
+
+err_2:
+	event.new_rate = clk_get_rate(clk);
+
+	clk_trnsc_fsm(TRNSC_CHANGE_CLOCK, &transaction);
+
+	clk_trnsc_fsm(TRNSC_POST_DEVICE, &transaction);
+
+err_1:
+	clk_trnsc_fsm(TRNSC_EXIT_DEVICE, &transaction);
+err_0:
+	clk_trnsc_fsm(TRNSC_EXIT_CLOCK, &transaction);
+
+	if (clk_was_enabled && !ret) {
+		/* 5. to decrease the old_parent nchild counter */
+		clk_notify_child_event(CHILD_CLOCK_DISABLED, old_parent);
+		/* 5. increase the new_parent nchild counter */
+		clk_notify_child_event(CHILD_CLOCK_ENABLED, clk->parent);
+		/* 6. to decrease the old_parent nchild counter */
+		clk_notify_child_event(CHILD_CLOCK_DISABLED, old_parent);
+		}
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	int ret = -EOPNOTSUPP;
+	struct clk_event event;
+	struct clk_tnode transaction;
+
+	event = EVENT(clk, clk_get_rate(clk), clk_round_rate(clk, rate));
+	transaction = TRANSACTION_ROOT(1, &event);
+
+	pr_debug("\n");
+
+	if (clk_is_readonly(clk))
+		/* read only clock doesn't have to be "touched" !!!! */
+		return -EPERM;
+
+	if (event.new_rate == clk_get_rate(clk))
+		return 0;
+
+	ret = clk_trnsc_fsm(TRNSC_ENTER_CLOCK, &transaction);
+	if (ret) {
+		ret = -EPERM;
+		goto err_0;
+	}
+
+	/* if not zero somebody doens't agree the clock updated */
+	ret = clk_trnsc_fsm(TRNSC_ENTER_DEVICE, &transaction);
+	if (ret) {
+		ret = -EPERM;
+		goto err_1;
+	}
+
+	clk_trnsc_fsm(TRNSC_PRE_DEVICE, &transaction);
+
+	__clk_set_rate(clk, event.new_rate);
+	/* reload new_rate to avoid hw rounding... */
+	event.new_rate = clk_get_rate(clk);
+
+	clk_trnsc_fsm(TRNSC_CHANGE_CLOCK, &transaction);
+	clk_trnsc_fsm(TRNSC_POST_DEVICE, &transaction);
+
+err_1:
+	clk_trnsc_fsm(TRNSC_EXIT_DEVICE, &transaction);
+err_0:
+	clk_trnsc_fsm(TRNSC_EXIT_CLOCK, &transaction);
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	pr_debug("\n");
+
+	if (likely(clk->ops && clk->ops->round))
+		return clk->ops->round(clk, rate);
+	return rate;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+unsigned long clk_evaluate_rate(struct clk *clk, unsigned long prate)
+{
+	pr_debug("\n");
+	if (!clk->parent)/* without parent this function has no meaning */
+		return CLK_UNDEFINED_RATE;
+
+	if (!prate)/* on parent disabled than disable the child */
+		return 0;
+
+	if (likely(clk->ops && clk->ops->eval))
+		return clk->ops->eval(clk, prate);
+
+	return CLK_UNDEFINED_RATE;
+}
+EXPORT_SYMBOL(clk_evaluate_rate);
+
+int clk_set_rates(struct clk **clks, unsigned long *rates, unsigned long nclks)
+{
+	int i, ret = 0;
+	struct clk_event *evt;
+	struct clk_tnode transaction = TRANSACTION_ROOT(nclks, NULL)
+
+	pr_debug("\n");
+
+	if (!clks || !rates || !nclks)
+		return -EINVAL;
+	evt = kmalloc(sizeof(*evt) *
+		tnode_get_size(&transaction), GFP_KERNEL);
+
+	if (!evt)
+		return -ENOMEM;
+
+	tnode_set_events(&transaction, evt);
+
+	for (i = 0; i < tnode_get_size(&transaction); ++i) {
+		tnode_set_clock(&transaction, i, clks[i]);
+		tnode_get_event(&transaction, i)->old_rate =
+			clk_get_rate(clks[i]);
+		tnode_get_event(&transaction, i)->new_rate =
+			clk_round_rate(clks[i], rates[i]);
+	}
+
+	ret = clk_trnsc_fsm(TRNSC_ENTER_CLOCK, &transaction);
+	if (ret) {
+		ret = -EPERM;
+		goto err_0;
+	}
+
+	/* if not zero somebody doens't agree the clock updated */
+	ret = clk_trnsc_fsm(TRNSC_ENTER_DEVICE, &transaction);
+	if (ret) {
+		ret = -EPERM;
+		goto err_1;
+	}
+
+	clk_trnsc_fsm(TRNSC_PRE_DEVICE, &transaction);
+
+	for (i = 0; i < tnode_get_size(&transaction); ++i) {
+		if (!clk_is_enabled(clks[i]) && rates[i])
+			ret |= __clk_enable(clks[i]);
+		else if (clk_is_enabled(clks[i]) && !rates[i])
+			ret |= __clk_disable(clks[i]);
+		else
+			ret |= __clk_set_rate(clks[i], rates[i]);
+
+		/* reload new_rate to avoid hw rounding... */
+		tnode_get_event(&transaction, i)->new_rate =
+			clk_get_rate(clks[i]);
+	}
+
+	clk_trnsc_fsm(TRNSC_CHANGE_CLOCK, &transaction);
+
+	clk_trnsc_fsm(TRNSC_POST_DEVICE, &transaction);
+
+err_1:
+	clk_trnsc_fsm(TRNSC_EXIT_DEVICE, &transaction);
+
+err_0:
+	clk_trnsc_fsm(TRNSC_EXIT_CLOCK, &transaction);
+
+	kfree(evt);
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_rates);
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	struct clk *clk = NULL;
+	struct clk *clkp;
+	struct klist_iter i;
+	int found = 0, idno;
+
+	mutex_lock(&clk_list_sem);
+#if 0
+	if (dev == NULL || dev->bus != &platform_bus_type)
+		idno = -1;
+	else
+		idno = to_platform_device(dev)->id;
+
+	klist_iter_init(&clk_list, &i);
+	while ((clkp = next_clock(&i)) && !found)
+		if (clk->id == idno && strcmp(id, clk->name) == 0 &&
+			try_module_get(clk->owner)) {
+				clk = clkp;
+				found = 1;
+		}
+	klist_iter_exit(&i);
+
+	if (found)
+		goto _found;
+#endif
+	klist_iter_init(&clk_list, &i);
+	while ((clkp = next_clock(&i)))
+		if (strcmp(id, clkp->name) == 0
+		    && try_module_get(clkp->owner)) {
+			clk = clkp;
+			break;
+		}
+	klist_iter_exit(&i);
+_found:
+	mutex_unlock(&clk_list_sem);
+	return clk;
+}
+EXPORT_SYMBOL(clk_get);
+
+int clk_for_each(int (*fn) (struct clk *clk, void *data), void *data)
+{
+	struct clk *clkp;
+	struct klist_iter i;
+	int result = 0;
+
+	if (!fn)
+		return -EFAULT;
+
+	pr_debug("\n");
+	mutex_lock(&clk_list_sem);
+	klist_iter_init(&clk_list, &i);
+
+	while ((clkp = next_clock(&i)))
+		result |= fn(clkp, data);
+
+	klist_iter_exit(&i);
+	mutex_unlock(&clk_list_sem);
+	return result;
+}
+EXPORT_SYMBOL(clk_for_each);
+
+int clk_for_each_child(struct clk *clk,
+	int (*fn) (struct clk *clk, void *data), void *data)
+{
+	struct clk *clkp;
+	struct klist_iter i;
+	int result = 0;
+
+	if (!clk || !fn)
+		return -EFAULT;
+
+	klist_iter_init(&clk->childs, &i);
+
+	while ((clkp = next_child_clock(&i)))
+		result |= fn(clkp, data);
+
+	klist_iter_exit(&i);
+
+	return result;
+}
+EXPORT_SYMBOL(clk_for_each_child);
+
+static int __init early_clk_complete(struct clk *clk, void *data)
+{
+	int ret;
+
+	ret = kobject_add(&clk->kobj,
+		(clk->parent ? &clk->parent->kobj : clk_kobj),
+		clk->name);
+	if (ret)
+		return ret;
+
+	clk->kdevices = kobject_create_and_add("devices", &clk->kobj);
+	if (!clk->kdevices)
+		return -EINVAL;
+
+	return 0;
+}
+
+int __init early_clk_register(struct clk *clk)
+{
+	int retval = 0;
+	if (!clk)
+		return -EFAULT;
+	pr_debug("%s\n", clk->name);
+
+	clk_initialize(clk);
+
+	/* Initialize ... */
+	__clk_init(clk);
+
+	if (clk->parent) {
+#ifdef CLK_SAFE_CODE
+		/* 1. the parent has to be registered */
+		if (!check_clk(clk->parent))
+			return -ENODEV;
+		/* 2. an always enabled child has to sit on a always
+		 *    enabled parent!
+		 */
+		if (clk->flags & CLK_ALWAYS_ENABLED &&
+			!(clk->parent->flags & CLK_ALWAYS_ENABLED))
+			return -EFAULT;
+		/* 3. a fixed child has to sit on a fixed parent */
+		if (clk_is_readonly(clk) && !clk_is_readonly(clk->parent))
+			return -EFAULT;
+#endif
+		klist_add_tail(&clk->child_node, &clk->parent->childs);
+		clk->parent->nr_clocks++;
+	}
+
+	klist_add_tail(&clk->node, &clk_list);
+	if (clk->flags & CLK_ALWAYS_ENABLED) {
+		__clk_enable(clk);
+		clk_notify_child_event(CHILD_CLOCK_ENABLED, clk->parent);
+	}
+	return retval;
+}
+
+int __init clock_init(void)
+{
+	clk_kobj = kobject_create_and_add("clocks", NULL);
+	if (!clk_kobj)
+		return -EINVAL ;
+
+	clk_for_each(early_clk_complete, NULL);
+
+	printk(KERN_INFO CLK_NAME " " CLK_VERSION "\n");
+
+	return 0;
+}
+
diff --git a/drivers/base/clk.h b/drivers/base/clk.h
new file mode 100644
index 0000000..61672ef
--- /dev/null
+++ b/drivers/base/clk.h
@@ -0,0 +1,319 @@
+/*
+   -------------------------------------------------------------------------
+   clk.h
+   -------------------------------------------------------------------------
+   (C) STMicroelectronics 2008
+   (C) STMicroelectronics 2009
+   Author: Francesco M. Virlinzi <francesco.virlinzi@st.com>
+   ----------------------------------------------------------------------------
+   May be copied or modified under the terms of the GNU General Public
+   License v.2 ONLY.  See linux/COPYING for more information.
+
+   ------------------------------------------------------------------------- */
+
+#ifdef CONFIG_GENERIC_CLK_FM
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/kobject.h>
+#include <linux/klist.h>
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <asm/atomic.h>
+
+enum clk_ops_id {
+	__CLK_INIT = 0,
+	__CLK_ENABLE,
+	__CLK_DISABLE,
+	__CLK_SET_RATE,
+	__CLK_SET_PARENT,
+	__CLK_RECALC,
+	__CLK_ROUND,
+	__CLK_EVAL,
+};
+
+extern struct klist clk_list;
+/**
+  * clk_tnode
+  *      it's the internal strucure used to track each node
+  *      in the transaction graph.
+  *      _NO_ api is showed to the other modules
+  */
+struct clk_tnode {
+	/** @tid: the tnode id */
+	unsigned long tid;
+	/** @size: how may clock are involved in this tnode */
+	unsigned long size;
+	/** @parent: the parent tnode */
+	struct clk_tnode *parent;
+	/* @events_map: a bitmap to declare the
+	 * valid events in this tnode
+	 */
+	unsigned long events_map;
+	/** @events: the event array of this tnode */
+	struct clk_event *events;
+	/** @child: links the childres tnode */
+	struct list_head childs;
+	/** @pnode: links the tnode to the parent */
+	struct list_head pnode;
+};
+
+/*
+ *  tnode_get_size -
+ *  returns the number of events in the transaction
+ */
+static inline unsigned long
+tnode_get_size(struct clk_tnode *tnode)
+{
+	return tnode->size;
+}
+
+static inline unsigned long
+tnode_get_map(struct clk_tnode *tnode)
+{
+	return tnode->events_map;
+}
+
+static inline unsigned long
+tnode_check_map_id(struct clk_tnode *node, int id)
+{
+	return node->events_map & (1 << id);
+}
+
+static inline void
+tnode_set_map_id(struct clk_tnode *node, int id)
+{
+	node->events_map |= (1 << id);
+}
+
+static inline unsigned long
+tnode_get_id(struct clk_tnode *node)
+{
+	return node->tid;
+}
+
+static inline struct clk_event*
+tnode_get_event(struct clk_tnode *node, int id)
+{
+	return &(node->events[id]);
+}
+
+static inline struct clk_event *tnode_get_events(struct clk_tnode *node)
+{
+	return tnode_get_event(node, 0);
+}
+
+static inline void
+tnode_set_events(struct clk_tnode *node, struct clk_event *events)
+{
+	node->events = events;
+}
+
+static inline struct clk*
+tnode_get_clock(struct clk_tnode *node, int id)
+{
+	return tnode_get_event(node, id)->clk;
+}
+
+static inline void
+tnode_set_clock(struct clk_tnode *node, int id, struct clk *clk)
+{
+	node->events[id].clk = clk;
+}
+
+static inline struct clk_tnode *tnode_get_parent(struct clk_tnode *node)
+{
+	return node->parent;
+}
+
+#define tnode_for_each_valid_events(node, _j)			\
+	for ((_j) = (ffs(tnode_get_map(node)) - 1);		\
+	     (_j) < tnode_get_size((node)); ++(_j))		\
+			if (tnode_check_map_id((node), (_j)))
+
+#define EVENT(_clk,  _oldrate, _newrate)		\
+	(struct clk_event)				\
+	{						\
+		.clk = (struct clk *)(_clk),		\
+		.old_rate = (unsigned long)(_oldrate),	\
+		.new_rate = (unsigned long)(_newrate),	\
+	};
+
+#define TRANSACTION_ROOT(_num, _event)					\
+	(struct clk_tnode) {						\
+		.tid    = atomic_inc_return(&transaction_counter),	\
+		.size   = (_num),					\
+		.events = (struct clk_event *)(_event),			\
+		.parent = NULL,						\
+		.childs = LIST_HEAD_INIT(transaction.childs),		\
+		.events_map = 0,					\
+		};
+
+#define klist_function_support(_name, _type, _field, _kobj)		\
+static void klist_get_##_name(struct klist_node *n)			\
+{									\
+	struct _type *entry = container_of(n, struct _type, _field);	\
+	kobject_get(&entry->_kobj);					\
+}									\
+static void klist_put_##_name(struct klist_node *n)			\
+{									\
+	struct _type *entry = container_of(n, struct _type, _field);	\
+	kobject_put(&entry->_kobj);					\
+}
+
+#define klist_entry_support(name, type, field)				\
+static struct type *next_##name(struct klist_iter *i)			\
+{	struct klist_node *n = klist_next(i);				\
+	return n ? container_of(n, struct type, field) : NULL;		\
+}
+
+static inline void
+clk_event_init(struct clk_event *evt, struct clk *clk,
+		unsigned long oldrate, unsigned long newrate)
+{
+	evt->clk      = clk;
+	evt->old_rate = oldrate;
+	evt->new_rate = newrate;
+}
+
+enum clk_fsm_e {
+	TRNSC_ENTER_CLOCK	= 0x10,
+	TRNSC_ENTER_DEVICE	= NOTIFY_CLK_ENTERCHANGE,	/* 0x1 */
+	TRNSC_PRE_DEVICE	= NOTIFY_CLK_PRECHANGE,		/* 0x2 */
+	TRNSC_CHANGE_CLOCK	= 0x20,
+	TRNSC_POST_DEVICE	= NOTIFY_CLK_POSTCHANGE,	/* 0x4 */
+	TRNSC_EXIT_DEVICE	= NOTIFY_CLK_EXITCHANGE,	/* 0x8 */
+	TRNSC_EXIT_CLOCK	= 0x40
+};
+
+#define DEV_SUSPENDED_ON_TRANSACTION	(0x10)
+#define DEV_RESUMED_ON_TRANSACTION	(0x20)
+#define DEV_ON_TRANSACTION	(TRNSC_ENTER_DEVICE	|	\
+				TRNSC_PRE_DEVICE	|	\
+				TRNSC_POST_DEVICE	|	\
+				TRNSC_EXIT_DEVICE)
+
+static inline int
+pdev_transaction_move_on(struct platform_device *dev, unsigned int value)
+{
+	int ret = -EINVAL;
+	unsigned long flag;
+#ifdef CONFIG_CLK_DEBUG
+	static const char *dev_state[] = {
+		"dev_enter",
+		"dev_pre",
+		"dev_post",
+		"dev_exit"
+	};
+
+	unsigned long old = dev->clk_state & DEV_ON_TRANSACTION;
+	int was = 0, is = 0;
+	if (
+	   (old == 0 && value == TRNSC_ENTER_DEVICE) ||
+	   (old == TRNSC_ENTER_DEVICE && value == TRNSC_EXIT_DEVICE) ||
+	   (old == TRNSC_ENTER_DEVICE && value == TRNSC_PRE_DEVICE) ||
+	   (old == TRNSC_PRE_DEVICE && value == TRNSC_POST_DEVICE) ||
+	   (old == TRNSC_POST_DEVICE && value == TRNSC_EXIT_DEVICE))
+		goto ok;
+	switch (old) {
+	case TRNSC_ENTER_DEVICE:
+		was = 0;
+		break;
+	case TRNSC_PRE_DEVICE:
+		was = 1;
+		break;
+	case TRNSC_POST_DEVICE:
+		was = 2;
+		break;
+	case TRNSC_EXIT_DEVICE:
+		was = 3;
+		break;
+	}
+	switch (value) {
+	case TRNSC_ENTER_DEVICE:
+		is = 0;
+		break;
+	case TRNSC_PRE_DEVICE:
+		is = 1;
+		break;
+	case TRNSC_POST_DEVICE:
+		is = 2;
+		break;
+	case TRNSC_EXIT_DEVICE:
+		is = 3;
+		break;
+	}
+	printk(KERN_ERR "The device %s.%d shows a wrong evolution during "
+		"a clock transaction\nDev state was %s and moved on %s\n",
+		dev->name, dev->id, dev_state[was], dev_state[is]);
+ok:
+#endif
+	local_irq_save(flag);
+	if ((dev->clk_state & DEV_ON_TRANSACTION) != value) {
+		dev->clk_state &= ~DEV_ON_TRANSACTION;
+		dev->clk_state |= value;
+		ret = 0;
+	}
+	local_irq_restore(flag);
+	return ret;
+}
+
+static inline int
+clk_set_towner(struct clk *clk, struct clk_tnode *node)
+{
+	return atomic_cmpxchg((atomic_t *)&clk->towner, 0, (int)node);
+}
+
+static inline void
+clk_clean_towner(struct clk *clk)
+{
+	atomic_set((atomic_t *)(&clk->towner), 0);
+}
+
+static inline int
+clk_is_enabled(struct clk *clk)
+{
+	return clk->rate != 0;
+}
+
+static inline int
+clk_is_readonly(struct clk *clk)
+{
+	return !clk->ops || !clk->ops->set_rate;
+}
+
+static inline int
+clk_allow_propagation(struct clk *clk)
+{
+	return !!(clk->flags & CLK_EVENT_PROPAGATES);
+}
+
+static inline int
+clk_is_auto_switching(struct clk *clk)
+{
+	return !!(clk->flags & CLK_AUTO_SWITCHING);
+}
+
+static inline int
+clk_follow_parent(struct clk *clk)
+{
+	return !!(clk->flags & CLK_FOLLOW_PARENT);
+}
+
+enum pdev_add_state {
+	PDEV_ADDING,
+	PDEV_ADDED,
+	PDEV_ADD_FAILED,
+};
+
+enum pdev_probe_state {
+	PDEV_PROBEING,
+	PDEV_PROBED,
+	PDEV_PROBE_FAILED,
+};
+
+int clk_add_device(struct platform_device *dev, enum pdev_add_state state);
+int clk_probe_device(struct platform_device *dev, enum pdev_probe_state state);
+int clk_del_device(struct platform_device *dev);
+
+#endif
diff --git a/drivers/base/clk_pm.c b/drivers/base/clk_pm.c
new file mode 100644
index 0000000..56c1760
--- /dev/null
+++ b/drivers/base/clk_pm.c
@@ -0,0 +1,197 @@
+/*
+ * -------------------------------------------------------------------------
+ * clk_pm.c
+ * -------------------------------------------------------------------------
+ * (C) STMicroelectronics 2008
+ * (C) STMicroelectronics 2009
+ * Author: Francesco M. Virlinzi <francesco.virlinzi@st.com>
+ * -------------------------------------------------------------------------
+ * May be copied or modified under the terms of the GNU General Public
+ * License v.2 ONLY.  See linux/COPYING for more information.
+ *
+ * -------------------------------------------------------------------------
+ */
+
+#include <linux/clk.h>
+#include <linux/klist.h>
+#include <linux/list.h>
+#include <linux/sysdev.h>
+#include <linux/device.h>
+#include <linux/kref.h>
+#include <linux/kobject.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <linux/proc_fs.h>
+#include "power/power.h"
+#include "clk.h"
+#include "base.h"
+
+static int
+__clk_operations(struct clk *clk, unsigned long rate, enum clk_ops_id id_ops)
+{
+	int ret = -EINVAL;
+	unsigned long *ops_fns = (unsigned long *)clk->ops;
+	if (likely(ops_fns && ops_fns[id_ops])) {
+		int (*fns)(struct clk *clk, unsigned long rate)
+			= (void *)ops_fns[id_ops];
+		unsigned long flags;
+		spin_lock_irqsave(&clk->lock, flags);
+		ret = fns(clk, rate);
+		spin_unlock_irqrestore(&clk->lock, flags);
+	}
+	return ret;
+}
+
+static inline int __clk_init(struct clk *clk)
+{
+	return __clk_operations(clk, 0, __CLK_INIT);
+}
+
+static inline int __clk_enable(struct clk *clk)
+{
+	return __clk_operations(clk, 0, __CLK_ENABLE);
+}
+
+static inline int __clk_disable(struct clk *clk)
+{
+	return __clk_operations(clk, 0, __CLK_DISABLE);
+}
+
+static inline int __clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return __clk_operations(clk, rate, __CLK_SET_RATE);
+}
+
+static inline int __clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	return __clk_operations(clk, (unsigned long)parent, __CLK_SET_PARENT);
+}
+
+static inline int __clk_recalc_rate(struct clk *clk)
+{
+	return __clk_operations(clk, 0, __CLK_RECALC);
+}
+
+static inline int pm_clk_ratio(struct clk *clk)
+{
+	register unsigned int val, exp;
+
+	val = ((clk->flags >> CLK_PM_RATIO_SHIFT) &
+		((1 << CLK_PM_RATIO_NRBITS) - 1)) + 1;
+	exp = ((clk->flags >> CLK_PM_EXP_SHIFT) &
+		((1 << CLK_PM_EXP_NRBITS) - 1));
+
+	return val << exp;
+}
+
+static inline int pm_clk_is_off(struct clk *clk)
+{
+	return ((clk->flags & CLK_PM_TURNOFF) == CLK_PM_TURNOFF);
+}
+
+static inline void pm_clk_set(struct clk *clk, int edited)
+{
+#define CLK_PM_EDITED (1 << CLK_PM_EDIT_SHIFT)
+	clk->flags &= ~CLK_PM_EDITED;
+	clk->flags |= (edited ? CLK_PM_EDITED : 0);
+}
+
+static inline int pm_clk_is_modified(struct clk *clk)
+{
+	return ((clk->flags & CLK_PM_EDITED) != 0);
+}
+
+static int clk_resume_from_standby(struct clk *clk, void *data)
+{
+	pr_debug("\n");
+	if (!likely(clk->ops))
+		return 0;
+	/* check if the pm modified the clock */
+	if (!pm_clk_is_modified(clk))
+		return 0;;
+	pm_clk_set(clk, 0);
+	if (pm_clk_is_off(clk))
+		__clk_enable(clk);
+	else
+		__clk_set_rate(clk, clk->rate * pm_clk_ratio(clk));
+	return 0;
+}
+
+static int clk_on_standby(struct clk *clk, void *data)
+{
+	pr_debug("\n");
+
+	if (!clk->ops)
+		return 0;
+	if (!clk->rate) /* already disabled */
+		return 0;
+
+	pm_clk_set(clk, 1);	/* set as modified */
+	if (pm_clk_is_off(clk))		/* turn-off */
+		__clk_disable(clk);
+	else    /* reduce */
+		__clk_set_rate(clk, clk->rate / pm_clk_ratio(clk));
+	return 0;
+}
+
+static int clk_resume_from_hibernation(struct clk *clk, void *data)
+{
+	unsigned long rate = clk->rate;
+	pr_debug("\n");
+	__clk_set_parent(clk, clk->parent);
+	__clk_set_rate(clk, rate);
+	__clk_recalc_rate(clk);
+	return 0;
+}
+
+static int clks_sysdev_suspend(struct sys_device *dev, pm_message_t state)
+{
+	static pm_message_t prev_state;
+
+	switch (state.event) {
+	case PM_EVENT_ON:
+		switch (prev_state.event) {
+		case PM_EVENT_FREEZE: /* Resumeing from hibernation */
+			clk_for_each(clk_resume_from_hibernation, NULL);
+			break;
+		case PM_EVENT_SUSPEND:
+			clk_for_each(clk_resume_from_standby, NULL);
+			break;
+		}
+	case PM_EVENT_SUSPEND:
+		clk_for_each(clk_on_standby, NULL);
+		break;
+	case PM_EVENT_FREEZE:
+		break;
+	}
+	prev_state = state;
+	return 0;
+}
+
+static int clks_sysdev_resume(struct sys_device *dev)
+{
+	return clks_sysdev_suspend(dev, PMSG_ON);
+}
+
+static struct sysdev_class clk_sysdev_class = {
+	.name = "clks",
+};
+
+static struct sysdev_driver clks_sysdev_driver = {
+	.suspend = clks_sysdev_suspend,
+	.resume = clks_sysdev_resume,
+};
+
+static struct sys_device clks_sysdev_dev = {
+	.cls = &clk_sysdev_class,
+};
+
+static int __init clk_sysdev_init(void)
+{
+	sysdev_class_register(&clk_sysdev_class);
+	sysdev_driver_register(&clk_sysdev_class, &clks_sysdev_driver);
+	sysdev_register(&clks_sysdev_dev);
+	return 0;
+}
+
+subsys_initcall(clk_sysdev_init);
diff --git a/drivers/base/clk_utils.c b/drivers/base/clk_utils.c
new file mode 100644
index 0000000..a222aa7
--- /dev/null
+++ b/drivers/base/clk_utils.c
@@ -0,0 +1,456 @@
+/*
+ * -------------------------------------------------------------------------
+ * clk_utils.c
+ * -------------------------------------------------------------------------
+ * (C) STMicroelectronics 2008
+ * (C) STMicroelectronics 2009
+ * Author: Francesco M. Virlinzi <francesco.virlinzi@st.com>
+ * -------------------------------------------------------------------------
+ * May be copied or modified under the terms of the GNU General Public
+ * License v.2 ONLY.  See linux/COPYING for more information.
+ *
+ * -------------------------------------------------------------------------
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/klist.h>
+#include <linux/list.h>
+#include <linux/delay.h>
+#include <linux/sysdev.h>
+#include <linux/kref.h>
+#include <linux/kobject.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+#include "power/power.h"
+#include "clk.h"
+#include "base.h"
+
+int clk_generic_notify(unsigned long code,
+	struct platform_device *pdev, void *data)
+{
+	struct clk_event *event = (struct clk_event *)data;
+	unsigned long event_decode = clk_event_decode(event);
+
+	switch (code) {
+	case NOTIFY_CLK_ENTERCHANGE:
+		return NOTIFY_EVENT_HANDLED;	/* to accept */
+
+	case NOTIFY_CLK_PRECHANGE:
+		/* without clock (not still enabled) the device can not work */
+		if (event_decode == _CLK_ENABLE)
+			return NOTIFY_EVENT_NOTHANDLED;
+		return NOTIFY_EVENT_HANDLED;	/* to suspend */
+
+	case NOTIFY_CLK_POSTCHANGE:
+		/* without clock (just disabled) the device can not work */
+		if (event_decode == _CLK_DISABLE)
+			return NOTIFY_EVENT_NOTHANDLED;
+		return NOTIFY_EVENT_HANDLED;	/* to resume */
+
+	case NOTIFY_CLK_EXITCHANGE:
+		return NOTIFY_EVENT_HANDLED;
+	}
+
+	return NOTIFY_EVENT_HANDLED;
+}
+EXPORT_SYMBOL(clk_generic_notify);
+
+unsigned long clk_generic_evaluate_rate(struct clk *clk, unsigned long prate)
+{
+	unsigned long current_prate;
+
+	if (!clk->parent)
+		return -EINVAL;
+
+	if (!prate)	/* if zero return zero (on disable: disable!) */
+		return 0;
+
+	if (prate == CLK_UNDEFINED_RATE) /* on undefined: undefined */
+		return CLK_UNDEFINED_RATE;
+
+	current_prate = clk_get_rate(clk->parent);
+	if (current_prate == prate)
+		return clk_get_rate(clk);
+
+	if (current_prate > prate) /* down scale */
+		return (clk_get_rate(clk) * prate) / current_prate;
+	else
+		return (clk_get_rate(clk) / current_prate) * prate;
+}
+EXPORT_SYMBOL(clk_generic_evaluate_rate);
+
+#ifdef CONFIG_PROC_FS
+/*
+ * The "clocks" file is created under /proc
+ * to list all the clocks registered in the system
+ */
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+static void *clk_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct list_head *tmp;
+	union {
+		loff_t value;
+		long parts[2];
+	} ltmp;
+
+	ltmp.value = *pos;
+	tmp = (struct list_head *)ltmp.parts[0];
+	tmp = tmp->next;
+	ltmp.parts[0] = (long)tmp;
+
+	*pos = ltmp.value;
+
+	if (tmp == &clk_list.k_list)
+		return NULL; /* No more to read */
+
+	return pos;
+}
+
+static void *clk_seq_start(struct seq_file *s, loff_t *pos)
+{
+	if (!*pos) { /* first call! */
+		union {
+			loff_t value;
+			long parts[2];
+		} ltmp;
+		ltmp.parts[0] = (long) clk_list.k_list.next;
+		*pos = ltmp. value;
+		return pos;
+	}
+	--(*pos); /* to realign *pos value! */
+
+	return clk_seq_next(s, NULL, pos);
+}
+
+static int clk_seq_show(struct seq_file *s, void *v)
+{
+	unsigned long *l = (unsigned long *)v;
+	struct list_head *node = (struct list_head *)(*l);
+	struct clk *clk = container_of(node, struct clk, node.n_node);
+	unsigned long rate = clk_get_rate(clk);
+
+	if (unlikely(!rate && !clk->parent))
+		return 0;
+
+	seq_printf(s, "%-12s\t: %ld.%02ldMHz - ", clk->name,
+	       rate / 1000000, (rate % 1000000) / 10000);
+	seq_printf(s, "[0x%p]", clk);
+	if (clk_is_enabled(clk))
+		seq_printf(s, " - enabled");
+
+	if (clk->parent)
+		seq_printf(s, " - [%s]", clk->parent->name);
+	seq_printf(s, "\n");
+
+	return 0;
+}
+
+static void clk_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static const struct seq_operations clk_seq_ops = {
+	.start = clk_seq_start,
+	.next = clk_seq_next,
+	.stop = clk_seq_stop,
+	.show = clk_seq_show,
+};
+
+static int clk_proc_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &clk_seq_ops);
+}
+
+static const struct file_operations clk_proc_ops = {
+	.owner = THIS_MODULE,
+	.open = clk_proc_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int __init clk_proc_init(void)
+{
+	struct proc_dir_entry *p;
+
+	p = create_proc_entry("clocks", S_IRUGO, NULL);
+
+	if (unlikely(!p))
+		return -EINVAL;
+
+	p->proc_fops = &clk_proc_ops;
+
+	return 0;
+}
+
+subsys_initcall(clk_proc_init);
+#endif
+
+#ifdef CONFIG_SYSFS
+static ssize_t clk_rate_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct clk *clk = container_of(kobj, struct clk, kobj);
+
+	return sprintf(buf, "%u\n", (unsigned int)clk_get_rate(clk));
+}
+
+static ssize_t clk_rate_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	unsigned long rate = simple_strtoul(buf, NULL, 10);
+	struct clk *clk = container_of(kobj, struct clk, kobj);
+
+	if (rate) {
+		if (!clk_is_enabled(clk))
+			clk_enable(clk);
+		if (clk_set_rate(clk, rate) < 0)
+			return -EINVAL;
+	} else
+		clk_disable(clk);
+	return count;
+}
+
+static const char *clk_ctrl_token[] = {
+	"auto_switching",
+	"no_auto_switching",
+	"allow_propagation",
+	"no_allow_propagation",
+	"follow_parent",
+	"no_follow_parent",
+};
+static ssize_t clk_state_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct clk *clk = container_of(kobj, struct clk, kobj);
+	ssize_t ret;
+
+
+	ret = sprintf(buf, "clock name: %s\n", clk->name);
+	if (clk_is_enabled(clk))
+		ret += sprintf(buf + ret, " + enabled\n");
+	else
+		ret += sprintf(buf + ret, " + disabled\n");
+	if (clk_is_readonly(clk))
+		ret += sprintf(buf + ret, " + rate read only\n");
+	else
+		ret += sprintf(buf + ret, " + rate writable\n");
+	ret +=
+	    sprintf(buf + ret, " + %s\n",
+		    clk_ctrl_token[(clk_allow_propagation(clk) ? 2 : 3)]);
+	ret +=
+	    sprintf(buf + ret, " + %s\n",
+		    clk_ctrl_token[(clk_is_auto_switching(clk) ? 0 : 1)]);
+	ret +=
+	    sprintf(buf + ret, " + %s\n",
+		    clk_ctrl_token[(clk_follow_parent(clk) ? 4 : 5)]);
+	ret +=
+	    sprintf(buf + ret, " + nr_clocks:  %u\n", clk->nr_clocks);
+	ret +=
+	    sprintf(buf + ret, " + nr_active_clocks:  %u\n",
+		clk->nr_active_clocks);
+	ret +=
+	    sprintf(buf + ret, " + nr_active_devices:  %u\n",
+		clk->nr_active_devices);
+	ret +=
+	    sprintf(buf + ret, " + rate: %u\n",
+		    (unsigned int)clk_get_rate(clk));
+	return ret;
+}
+
+static ssize_t clk_ctrl_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	int idx, ret = 0;
+
+	ret += sprintf(buf + ret, "Allowed command:\n");
+
+	for (idx = 0; idx < ARRAY_SIZE(clk_ctrl_token); ++idx)
+		ret += sprintf(buf + ret, " + %s\n", clk_ctrl_token[idx]);
+
+	return ret;
+}
+static ssize_t clk_ctrl_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int i, idx_token, ret = -EINVAL;
+	struct clk *clk = container_of(kobj, struct clk, kobj);
+
+	if (!count)
+		return ret;
+
+	for (i = 0, idx_token = -1; i < ARRAY_SIZE(clk_ctrl_token); ++i)
+		if (!strcmp(buf, clk_ctrl_token[i]))
+			idx_token = i;
+
+	if (idx_token == -EINVAL)
+		return ret;     /* token not valid... */
+
+	switch (idx_token) {
+	case 0:
+		clk->flags |= CLK_EVENT_PROPAGATES;
+		break;
+	case 1:
+		clk->flags &= ~CLK_EVENT_PROPAGATES;
+		break;
+	case 2:
+		clk->flags |= CLK_AUTO_SWITCHING;
+		if (!clk->nr_active_clocks && !clk->nr_active_devices)
+			clk_disable(clk);
+		else if (clk->nr_active_clocks || clk->nr_active_devices)
+			clk_enable(clk);
+		break;
+	case 3:
+		clk->flags &= ~CLK_AUTO_SWITCHING;
+		break;
+	case 4:
+		clk->flags |= CLK_FOLLOW_PARENT;
+		break;
+	case 5:
+		clk->flags &= ~CLK_FOLLOW_PARENT;
+		break;
+	}
+
+	return count;
+}
+
+static ssize_t clk_parent_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct clk *clk = container_of(kobj, struct clk, kobj);
+	struct clk *parent = clk_get(NULL, buf);
+
+	if (!parent)
+		return -EINVAL;
+
+	clk_put(parent);
+	clk_set_parent(clk, parent);
+
+	return count;
+}
+
+static struct kobj_attribute attributes[] = {
+__ATTR(state, S_IRUSR, clk_state_show, NULL),
+__ATTR(rate, S_IRUSR | S_IWUSR, clk_rate_show, clk_rate_store),
+__ATTR(control, S_IRUSR | S_IWUSR, clk_ctrl_show, clk_ctrl_store),
+__ATTR(parent, S_IWUSR, NULL, clk_parent_store)
+};
+
+static struct attribute *clk_attrs[] = {
+	&attributes[0].attr,
+	&attributes[1].attr,
+	&attributes[2].attr,
+	&attributes[3].attr,
+	NULL
+};
+
+static struct attribute_group clk_attr_group = {
+	.attrs = clk_attrs,
+	.name = "attributes"
+};
+
+#if 0
+static inline char *_strsep(char **s, const char *d)
+{
+	int i, len = strlen(d);
+retry:
+	if (!(*s) || !(**s))
+		return NULL;
+	for (i = 0; i < len; ++i) {
+		if (**s != *(d+i))
+			continue;
+		++(*s);
+		goto retry;
+	}
+	return strsep(s, d);
+}
+
+/**
+ * clk_rates_store
+ *
+ * It parses the buf to create multi clocks transaction
+ * via user space
+ * The buffer has to be something like:
+ * clock_A @ rate_A; clock_B @ rate_b; clock_C @ rate_c
+ */
+static ssize_t clk_rates_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int i, ret;
+	int nclock = 0;
+	unsigned long *rates;
+	struct clk **clocks;
+
+	if (!buf)
+		return -1;
+
+	for (i = 0; i < count; ++i)
+		if (buf[i] == '@')
+			++nclock;
+
+	rates = kmalloc(sizeof(long) * nclock, GFP_KERNEL);
+	if (!rates)
+		return -ENOMEM;
+
+	clocks = kmalloc(sizeof(void *) * nclock, GFP_KERNEL);
+	if (!clocks) {
+		ret = -ENOMEM;
+		goto err_0;
+	}
+
+	/* Parse the buffer */
+	for (i = 0; i < nclock; ++i) {
+		char *name;
+		char *nrate;
+		name  = _strsep((char **)&buf, "@ "); ++buf;
+		nrate = _strsep((char **)&buf, " ;"); ++buf;
+		if (!name || !nrate) {
+			ret = -EINVAL;
+			goto err_1;
+			}
+		clocks[i] = clk_get(NULL, name);
+		rates[i]  = simple_strtoul(nrate, NULL, 10);
+		if (!clocks[i]) { /* the clock doesn't exist! */
+			ret = -EINVAL;
+			goto err_1;
+			}
+	}
+
+	ret = clk_set_rates(clocks, rates, nclock);
+	if (ret >= 0)
+		ret = count; /* to say OK */
+
+err_1:
+	kfree(clocks);
+err_0:
+	kfree(rates);
+	return ret;
+}
+
+static struct kobj_attribute clk_rates_attr =
+	__ATTR(rates, S_IWUSR, NULL, clk_rates_store);
+#endif
+
+static int __init clk_add_attributes(struct clk *clk, void *data)
+{
+	int ret;
+
+	ret = sysfs_update_group(&clk->kobj, &clk_attr_group);
+
+	return ret;
+}
+
+static int __init clk_late_init(void)
+{
+	int ret;
+
+	ret = clk_for_each(clk_add_attributes, NULL);
+
+	return ret;
+}
+
+late_initcall(clk_late_init);
+#endif
diff --git a/drivers/base/init.c b/drivers/base/init.c
index 7bd9b6a..2441b26 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -24,6 +24,7 @@ void __init driver_init(void)
 	buses_init();
 	classes_init();
 	firmware_init();
+	clock_init();
 	hypervisor_init();
 
 	/* These are also core pieces, but must come after the
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8b4708e..550d993 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -17,6 +17,8 @@
 #include <linux/bootmem.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/clk.h>
+#include "clk.h"
 
 #include "base.h"
 
@@ -272,9 +274,20 @@ int platform_device_add(struct platform_device *pdev)
 	pr_debug("Registering platform device '%s'. Parent at %s\n",
 		 dev_name(&pdev->dev), dev_name(pdev->dev.parent));
 
+#ifdef CONFIG_GENERIC_CLK_FM
+	clk_add_device(pdev, PDEV_ADDING);
+
+	ret = device_add(&pdev->dev);
+
+	clk_add_device(pdev, (ret ? PDEV_ADD_FAILED : PDEV_ADDED));
+
+	if (ret == 0)
+		return ret;
+#else
 	ret = device_add(&pdev->dev);
 	if (ret == 0)
 		return ret;
+#endif
 
  failed:
 	while (--i >= 0) {
@@ -311,6 +324,9 @@ void platform_device_del(struct platform_device *pdev)
 			if (type == IORESOURCE_MEM || type == IORESOURCE_IO)
 				release_resource(r);
 		}
+#ifdef CONFIG_GENERIC_CLK_FM
+	clk_del_device(pdev);
+#endif
 	}
 }
 EXPORT_SYMBOL_GPL(platform_device_del);
@@ -445,7 +461,18 @@ static int platform_drv_probe(struct device *_dev)
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 
+#ifdef CONFIG_GENERIC_CLK_FM
+	int ret;
+	ret = clk_probe_device(dev, PDEV_PROBEING);
+	if (ret)
+		return ret;
+	ret = drv->probe(dev);
+
+	clk_probe_device(dev, (ret ? PDEV_PROBE_FAILED : PDEV_PROBED));
+	return ret;
+#else
 	return drv->probe(dev);
+#endif
 }
 
 static int platform_drv_probe_fail(struct device *_dev)
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1db9bbf..e537bcd 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -12,6 +12,7 @@
 #define __LINUX_CLK_H
 
 struct device;
+struct platform_device;
 
 /*
  * The base API.
@@ -142,4 +143,254 @@ struct clk *clk_get_parent(struct clk *clk);
  */
 struct clk *clk_get_sys(const char *dev_id, const char *con_id);
 
+/**
+ * clk_set_rates - set the clock rates
+ * @clk: clocks source
+ * @rate: desired clock rates in Hz
+ * @nclks: the number of clocks
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_rates(struct clk **clk, unsigned long *rates, unsigned long nclks);
+
+#ifndef CONFIG_GENERIC_CLK_FM
+
+#define bind_clock(_clk)
+#define pdevice_setclock(_dev, _clk)
+#define pdevice_setclock_byname(_dev, _clkname)
+#define pdevice_num_clocks(_dev)
+#define pdevice_clock(dev, idx)
+
+#else
+
+#include <linux/kobject.h>
+#include <linux/klist.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+
+
+/**
+ * Clock operation -
+ *
+ * It's a set of function pointer to identify all the capability on a clock
+ */
+struct clk_ops {
+/** @init initializes the clock	*/
+	int (*init)(struct clk *);
+/** @enable enables the clock	*/
+	int (*enable)(struct clk *);
+/** @disable disables the clock	*/
+	int (*disable)(struct clk *);
+/** @set_rate sets the new frequency rate */
+	int (*set_rate)(struct clk *, unsigned long value);
+/** @set_parent sets the new parent clock */
+	int (*set_parent)(struct clk *clk, struct clk *parent);
+/** @recalc updates the clock rate when the parent clock is updated	 */
+	void (*recalc)(struct clk *);
+/** @round returns the allowed rate on the required value	*/
+	unsigned long (*round)(struct clk *, unsigned long value);
+/** @eval evaluates the clock rate based on a parent_rate but the
+ * real clock rate is __not__ changed
+ */
+	unsigned long (*eval)(struct clk *, unsigned long parent_rate);
+};
+
+/**
+ * struct clk - clock object
+ */
+struct clk {
+	spinlock_t		lock;
+
+	struct kobject		kobj;
+	struct kobject		*kdevices;
+
+	int			id;
+
+	const char		*name;
+	struct module		*owner;
+
+	struct clk		*parent;
+	struct clk_ops		*ops;
+
+	void			*private_data;
+
+	unsigned long		rate;
+	unsigned long		flags;
+
+	unsigned int		nr_active_clocks;
+	unsigned int		nr_active_devices;
+	unsigned int		nr_clocks;
+
+	void			*towner;/* the transaction owner of the clock */
+
+	struct klist		childs;
+	struct klist		devices;
+
+	struct klist_node	node;		/* for global link	*/
+	struct klist_node	child_node;	/* for child link	*/
+};
+
+#define CLK_ALWAYS_ENABLED		(0x1 << 0)
+#define CLK_EVENT_PROPAGATES		(0x1 << 1)
+#define CLK_RATE_PROPAGATES		CLK_EVENT_PROPAGATES
+/* CLK_AUTO_SWITCHING: enable/disable the clock based on the
+ * current active children
+ */
+#define CLK_AUTO_SWITCHING		(0x1 << 2)
+/* CLK_FOLLOW_PARENT: enable/disable the clock as the parent is
+ * enabled/disabled
+ */
+#define CLK_FOLLOW_PARENT		(0x1 << 3)
+
+/*
+ * Flags to support the system standby
+ */
+#define CLK_PM_EXP_SHIFT	(24)
+#define CLK_PM_EXP_NRBITS	(7)
+#define CLK_PM_RATIO_SHIFT	(16)
+#define CLK_PM_RATIO_NRBITS	(8)
+#define CLK_PM_EDIT_SHIFT	(31)
+#define CLK_PM_EDIT_NRBITS	(1)
+#define CLK_PM_TURNOFF		(((1<<CLK_PM_EXP_NRBITS)-1) << CLK_PM_EXP_SHIFT)
+
+int early_clk_register(struct clk *);
+/**
+ * Registers a new clock into the system
+ */
+int clk_register(struct clk *);
+/**
+ * Unregisters a clock into the system
+ */
+int clk_unregister(struct clk *);
+
+/**
+ * Returns the clock rate if the  parent clock is 'parent_rate'
+ */
+unsigned long clk_evaluate_rate(struct clk *, unsigned long parent_rate);
+
+#define CLK_UNDEFINED_RATE	(-1UL)
+/**
+ * Utility functions in the clock framework
+ */
+int clk_for_each(int (*fn)(struct clk *, void *), void *);
+
+int clk_for_each_child(struct clk *, int (*fn)(struct clk *, void *), void *);
+
+/** struct pdev_clk_info -
+ *
+ *  It's a meta data used to link the device of linux driver model
+ *  to the clock framework.
+ *  The device driver developers has to set only the clk field
+ *  all the other fileds are managed in the clk core code
+ */
+struct pdev_clk_info {
+	/** the device owner    */
+	struct platform_device  *pdev;
+	/** the clock address	*/
+	struct clk		*clk;
+	/** used by the clock core*/
+	struct klist_node	node;
+};
+
+/******************** clk transition notifiers *******************/
+#define	NOTIFY_CLK_ENTERCHANGE	0x1
+#define	NOTIFY_CLK_PRECHANGE	0x2
+#define	NOTIFY_CLK_POSTCHANGE	0x4
+#define NOTIFY_CLK_EXITCHANGE	0x8
+
+/** struct clk_event
+ *
+ * It's the object propagated during a clock transaction.
+ * During a transaction each device will receive an array of 'struct clk_event'
+ * based on the clocks it uses
+ */
+struct clk_event {
+	/** on which clock the event is		*/
+	struct clk *clk;
+	/** the clock rate before the event	*/
+	unsigned long old_rate;
+	/** the clock rate after the event	*/
+	unsigned long new_rate;
+};
+
+enum clk_event_e {
+	_CLK_NOCHANGE,
+	_CLK_ENABLE,
+	_CLK_DISABLE,
+	_CLK_CHANGE
+};
+
+/**
+ * clk_event_decode -
+ *
+ * @event: the events has to be decoded
+ * It's an utility function to identify what each clock
+ * is doing
+ */
+static inline enum clk_event_e clk_event_decode(struct clk_event const *event)
+{
+	if (event->old_rate == event->new_rate)
+		return _CLK_NOCHANGE;
+	if (!event->old_rate && event->new_rate)
+		return _CLK_ENABLE;
+	if (event->old_rate && !event->new_rate)
+		return _CLK_DISABLE;
+	return _CLK_CHANGE;
+}
+
+enum notify_ret_e {
+	NOTIFY_EVENT_HANDLED = 0,		/* event handled	*/
+	NOTIFY_EVENT_NOTHANDLED,		/* event not handled	*/
+};
+
+/* Some macro device oriented static initialization */
+#define bind_clock(_clk)					\
+	.nr_clks = 1,						\
+	.clks = (struct pdev_clk_info[]) { {			\
+		.clk = (_clk),					\
+		} },
+
+#define pdevice_setclock(_dev, _clk)				\
+	(_dev)->clks[0].clk = (_clk);				\
+	(_dev)->nr_clks = 1;
+
+#define pdevice_setclock_byname(_dev, _clkname)			\
+	(_dev)->clks[0].clk = clk_get(NULL, _clkname);		\
+	(_dev)->nr_clks = 1;
+
+#define pdevice_num_clocks(_dev)	((_dev)->nr_clks)
+
+#define pdevice_clock(dev, idx)		((dev)->clks[(idx)].clk)
+
+/**
+ * clk_generic_notify -
+ *
+ * @code: the code event
+ * @dev: the platform_device under transaction
+ * @data: the clock event descriptor
+ *
+ * it's a generic notify function for devie with _only_
+ * one clock. It will :
+ * - accept every 'ENTER' state
+ * - suspend on 'PRE' state
+ * - resume on 'POST' state
+ * - do nothing on 'EXIT' state
+ */
+int clk_generic_notify(unsigned long code, struct platform_device *dev,
+	void *data);
+
+/*
+ * clk_generic_evaluate_rate
+ *
+ * @clk: the analised clock
+ * @prate: the parent rate
+ *
+ * Evaluate the clock rate (without hardware modification) based on a 'prate'
+ * parent clock rate. It's based on 'divisor' relationship
+ * between parent and child
+ */
+unsigned long clk_generic_evaluate_rate(struct clk *clk, unsigned long prate);
+#endif
 #endif
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index b67bb5d..db1989d 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -12,6 +12,7 @@
 #define _PLATFORM_DEVICE_H_
 
 #include <linux/device.h>
+#include <linux/clk.h>
 #include <linux/mod_devicetable.h>
 
 struct platform_device {
@@ -22,6 +23,11 @@ struct platform_device {
 	struct resource	* resource;
 
 	struct platform_device_id	*id_entry;
+#ifdef CONFIG_GENERIC_CLK_FM
+	unsigned long	clk_state;      /* used by the core */
+	unsigned long	nr_clks;
+	struct pdev_clk_info    *clks;
+#endif
 };
 
 #define platform_get_device_id(pdev)	((pdev)->id_entry)
@@ -61,6 +67,9 @@ struct platform_driver {
 	int (*resume_early)(struct platform_device *);
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
+#ifdef CONFIG_GENERIC_CLK_FM
+	int (*notify)(unsigned long code, struct platform_device *, void *);
+#endif
 	struct platform_device_id *id_table;
 };
 
diff --git a/init/Kconfig b/init/Kconfig
index 0682ecc..4254c5f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1042,6 +1042,29 @@ config SLOW_WORK
 
 	  See Documentation/slow-work.txt.
 
+config GENERIC_CLK_FM
+        default n
+	depends on EXPERIMENTAL
+        bool "Generic Clock Framework"
+        help
+          Add the clock framework in the Linux driver model
+          to track the clocks used by each devices and drivers
+
+config CLK_FORCE_GENERIC_EVALUATE
+        depends on GENERIC_CLK_FM
+        default n
+        bool "Force the clk_generic_evaluate_rate"
+        help
+          Say the if you want use the clk_generic_evaluate_rate on every clock
+          without evaluate_rate
+
+config CLK_DEBUG
+        depends on GENERIC_CLK_FM
+        default n
+        bool "Debug the Generic Clk Framework"
+        help
+          Prints some message to debug the clock framework
+
 endmenu		# General setup
 
 config HAVE_GENERIC_DMA_COHERENT
-- 
1.6.2.5


--------------030909070008040302040602--
