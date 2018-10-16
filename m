From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 16 Oct 2018 16:21:45 +0200
Subject: [PATCH v2 07/22] clk: at91: add pmc_data struct and helpers
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
Message-ID: <20181016142200.19741-8-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new strut to handle references to all the PMC clocks and implement
allocation/free helpers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/pmc.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/at91/pmc.h | 17 ++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 1fa27f4ea538..0f8b3add1b04 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -47,6 +47,50 @@ int of_at91_get_clk_range(struct device_node *np, const char *propname,
 }
 EXPORT_SYMBOL_GPL(of_at91_get_clk_range);
 
+void pmc_data_free(struct pmc_data *pmc_data)
+{
+	kfree(pmc_data->chws);
+	kfree(pmc_data->shws);
+	kfree(pmc_data->phws);
+	kfree(pmc_data->ghws);
+}
+
+struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
+				   unsigned int nperiph, unsigned int ngck)
+{
+	struct pmc_data *pmc_data = kzalloc(sizeof(*pmc_data), GFP_KERNEL);
+
+	if (!pmc_data)
+		return NULL;
+
+	pmc_data->ncore = ncore;
+	pmc_data->chws = kcalloc(ncore, sizeof(struct clk_hw *), GFP_KERNEL);
+	if (!pmc_data->chws)
+		goto err;
+
+	pmc_data->nsystem = nsystem;
+	pmc_data->shws = kcalloc(nsystem, sizeof(struct clk_hw *), GFP_KERNEL);
+	if (!pmc_data->shws)
+		goto err;
+
+	pmc_data->nperiph = nperiph;
+	pmc_data->phws = kcalloc(nperiph, sizeof(struct clk_hw *), GFP_KERNEL);
+	if (!pmc_data->phws)
+		goto err;
+
+	pmc_data->ngck = ngck;
+	pmc_data->ghws = kcalloc(ngck, sizeof(struct clk_hw *), GFP_KERNEL);
+	if (!pmc_data->ghws)
+		goto err;
+
+	return pmc_data;
+
+err:
+	pmc_data_free(pmc_data);
+
+	return NULL;
+}
+
 #ifdef CONFIG_PM
 static struct regmap *pmcreg;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 3dc50267a458..672a79bda88c 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -19,6 +19,17 @@
 
 extern spinlock_t pmc_pcr_lock;
 
+struct pmc_data {
+	unsigned int ncore;
+	struct clk_hw **chws;
+	unsigned int nsystem;
+	struct clk_hw **shws;
+	unsigned int nperiph;
+	struct clk_hw **phws;
+	unsigned int ngck;
+	struct clk_hw **ghws;
+};
+
 struct clk_range {
 	unsigned long min;
 	unsigned long max;
@@ -69,6 +80,12 @@ extern const struct clk_programmable_layout at91rm9200_programmable_layout;
 extern const struct clk_programmable_layout at91sam9g45_programmable_layout;
 extern const struct clk_programmable_layout at91sam9x5_programmable_layout;
 
+#define ndck(a, s) (a[s - 1].id + 1)
+#define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
+struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
+				   unsigned int nperiph, unsigned int ngck);
+void pmc_data_free(struct pmc_data *pmc_data);
+
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range);
 
-- 
2.19.1
