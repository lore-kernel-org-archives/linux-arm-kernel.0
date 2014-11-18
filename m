From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Nov 2014 18:53:03 +0000
Subject: [PATCH v2 08/13] irqchip: GICv3: ITS: device allocation and
 configuration
In-Reply-To: <1416336788-22634-1-git-send-email-marc.zyngier@arm.com>
References: <1416336788-22634-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1416336788-22634-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ITS has a notion of "device" that can write to it in order to
generate an interrupt.

Conversly, the driver maintains a per-ITS list of devices, together
with their configuration information, and uses this to configure
the HW.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 74 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 03f9831..d687fd4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -981,3 +981,77 @@ static void its_cpu_init_collection(void)
 
 	spin_unlock(&its_lock);
 }
+
+static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
+{
+	struct its_device *its_dev = NULL, *tmp;
+
+	raw_spin_lock(&its->lock);
+
+	list_for_each_entry(tmp, &its->its_device_list, entry) {
+		if (tmp->device_id == dev_id) {
+			its_dev = tmp;
+			break;
+		}
+	}
+
+	raw_spin_unlock(&its->lock);
+
+	return its_dev;
+}
+
+static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
+					    int nvecs)
+{
+	struct its_device *dev;
+	unsigned long *lpi_map;
+	void *itt;
+	int lpi_base;
+	int nr_lpis;
+	int cpu;
+	int sz;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	sz = nvecs * its->ite_size;
+	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
+	itt = kmalloc(sz, GFP_KERNEL);
+	lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
+
+	if (!dev || !itt || !lpi_map) {
+		kfree(dev);
+		kfree(itt);
+		kfree(lpi_map);
+		return NULL;
+	}
+
+	dev->its = its;
+	dev->itt = itt;
+	dev->nr_ites = nvecs;
+	dev->lpi_map = lpi_map;
+	dev->lpi_base = lpi_base;
+	dev->nr_lpis = nr_lpis;
+	dev->device_id = dev_id;
+	INIT_LIST_HEAD(&dev->entry);
+
+	raw_spin_lock(&its->lock);
+	list_add(&dev->entry, &its->its_device_list);
+	raw_spin_unlock(&its->lock);
+
+	/* Bind the device to the first possible CPU */
+	cpu = cpumask_first(cpu_online_mask);
+	dev->collection = &its->collections[cpu];
+
+	/* Map device to its ITT */
+	its_send_mapd(dev, 1);
+
+	return dev;
+}
+
+static void its_free_device(struct its_device *its_dev)
+{
+	raw_spin_lock(&its_dev->its->lock);
+	list_del(&its_dev->entry);
+	raw_spin_unlock(&its_dev->its->lock);
+	kfree(its_dev->itt);
+	kfree(its_dev);
+}
-- 
2.1.3
