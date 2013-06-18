From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 08:25:26 -0300
Subject: [PATCH v3 01/12] bus: mvebu-mbus: Factor out initialization details
In-Reply-To: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1371554737-25319-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We introduce a common initialization function mvebu_mbus_common_init()
that will be used by both legacy and device-tree initialization code.
This patch is an intermediate step, which will allow to introduce the
DT binding for this driver in a less intrusive way.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 33c6947..d0feee5 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -830,26 +830,14 @@ static __init int mvebu_mbus_debugfs_init(void)
 }
 fs_initcall(mvebu_mbus_debugfs_init);
 
-int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
-			   size_t mbuswins_size,
-			   phys_addr_t sdramwins_phys_base,
-			   size_t sdramwins_size)
+static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
+					 phys_addr_t mbuswins_phys_base,
+					 size_t mbuswins_size,
+					 phys_addr_t sdramwins_phys_base,
+					 size_t sdramwins_size)
 {
-	struct mvebu_mbus_state *mbus = &mbus_state;
-	const struct of_device_id *of_id;
 	int win;
 
-	for (of_id = of_mvebu_mbus_ids; of_id->compatible; of_id++)
-		if (!strcmp(of_id->compatible, soc))
-			break;
-
-	if (!of_id->compatible) {
-		pr_err("could not find a matching SoC family\n");
-		return -ENODEV;
-	}
-
-	mbus->soc = of_id->data;
-
 	mbus->mbuswins_base = ioremap(mbuswins_phys_base, mbuswins_size);
 	if (!mbus->mbuswins_base)
 		return -ENOMEM;
@@ -870,3 +858,28 @@ int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
 
 	return 0;
 }
+
+int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
+			   size_t mbuswins_size,
+			   phys_addr_t sdramwins_phys_base,
+			   size_t sdramwins_size)
+{
+	const struct of_device_id *of_id;
+
+	for (of_id = of_mvebu_mbus_ids; of_id->compatible; of_id++)
+		if (!strcmp(of_id->compatible, soc))
+			break;
+
+	if (!of_id->compatible) {
+		pr_err("could not find a matching SoC family\n");
+		return -ENODEV;
+	}
+
+	mbus_state.soc = of_id->data;
+
+	return mvebu_mbus_common_init(&mbus_state,
+			mbuswins_phys_base,
+			mbuswins_size,
+			sdramwins_phys_base,
+			sdramwins_size);
+}
-- 
1.8.1.5
