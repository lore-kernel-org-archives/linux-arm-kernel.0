From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 08:25:27 -0300
Subject: [PATCH v3 02/12] bus: mvebu-mbus: Introduce device tree binding
In-Reply-To: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1371554737-25319-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the most fundamental device-tree initialization.
We only introduce what's required to be able to probe the mvebu-mbus
driver from the DT. Follow-up patches will extend the device tree binding,
allowing to describe static address decoding windows.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/mbus.h     |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index d0feee5..23f6ae6 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -883,3 +883,39 @@ int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
 			sdramwins_phys_base,
 			sdramwins_size);
 }
+
+#ifdef CONFIG_OF
+int __init mvebu_mbus_dt_init(void)
+{
+	struct resource mbuswins_res, sdramwins_res;
+	struct device_node *np;
+	const struct of_device_id *of_id;
+	int ret;
+
+	np = of_find_matching_node(NULL, of_mvebu_mbus_ids);
+	if (!np) {
+		pr_err("could not find a matching SoC family\n");
+		return -ENODEV;
+	}
+
+	of_id = of_match_node(of_mvebu_mbus_ids, np);
+	mbus_state.soc = of_id->data;
+
+	if (of_address_to_resource(np, 0, &mbuswins_res)) {
+		pr_err("cannot get MBUS register address\n");
+		return -EINVAL;
+	}
+
+	if (of_address_to_resource(np, 1, &sdramwins_res)) {
+		pr_err("cannot get SDRAM register address\n");
+		return -EINVAL;
+	}
+
+	ret = mvebu_mbus_common_init(&mbus_state,
+				     mbuswins_res.start,
+				     resource_size(&mbuswins_res),
+				     sdramwins_res.start,
+				     resource_size(&sdramwins_res));
+	return ret;
+}
+#endif
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index dba482e..a93c62b 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -68,5 +68,6 @@ int mvebu_mbus_del_window(phys_addr_t base, size_t size);
 int mvebu_mbus_init(const char *soc, phys_addr_t mbus_phys_base,
 		    size_t mbus_size, phys_addr_t sdram_phys_base,
 		    size_t sdram_size);
+int mvebu_mbus_dt_init(void);
 
 #endif /* __LINUX_MBUS_H */
-- 
1.8.1.5
