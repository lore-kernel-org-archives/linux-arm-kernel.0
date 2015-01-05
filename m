From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 05 Jan 2015 12:48:41 +0100
Subject: [PATCH v5 1/5] regulator: Copy config passed during registration
In-Reply-To: <1420458525-22576-1-git-send-email-k.kozlowski@samsung.com>
References: <1420458525-22576-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1420458525-22576-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy the 'regulator_config' structure passed to regulator_register()
function so the driver could safely modify it after parsing init data.

The driver may want to change the config as a result of specific init
data parsed by regulator core (e.g. when core handled parsing device
tree).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e225711bb8bc..c13b557a560e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3581,20 +3581,21 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
  */
 struct regulator_dev *
 regulator_register(const struct regulator_desc *regulator_desc,
-		   const struct regulator_config *config)
+		   const struct regulator_config *cfg)
 {
 	const struct regulation_constraints *constraints = NULL;
 	const struct regulator_init_data *init_data;
+	struct regulator_config *config = NULL;
 	static atomic_t regulator_no = ATOMIC_INIT(0);
 	struct regulator_dev *rdev;
 	struct device *dev;
 	int ret, i;
 	const char *supply = NULL;
 
-	if (regulator_desc == NULL || config == NULL)
+	if (regulator_desc == NULL || cfg == NULL)
 		return ERR_PTR(-EINVAL);
 
-	dev = config->dev;
+	dev = cfg->dev;
 	WARN_ON(!dev);
 
 	if (regulator_desc->name == NULL || regulator_desc->ops == NULL)
@@ -3624,6 +3625,16 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (rdev == NULL)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * Duplicate the config so the driver could override it after
+	 * parsing init data.
+	 */
+	config = kmemdup(cfg, sizeof(*cfg), GFP_KERNEL);
+	if (config == NULL) {
+		kfree(rdev);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	init_data = regulator_of_get_init_data(dev, regulator_desc,
 					       &rdev->dev.of_node);
 	if (!init_data) {
@@ -3752,6 +3763,7 @@ add_dev:
 	rdev_init_debugfs(rdev);
 out:
 	mutex_unlock(&regulator_list_mutex);
+	kfree(config);
 	return rdev;
 
 unset_supplies:
-- 
1.9.1
