From: zonque@gmail.com (Daniel Mack)
Date: Mon, 12 Aug 2013 10:37:18 +0200
Subject: [PATCH 5/5] ARM: pxa: ssp: add pxa_ssp_request_of()
In-Reply-To: <1376296638-19804-1-git-send-email-zonque@gmail.com>
References: <1376296638-19804-1-git-send-email-zonque@gmail.com>
Message-ID: <1376296638-19804-6-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to lookup ssp devices from device tree. This way, users
can reference the ssp devices in order to register to them.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/plat-pxa/ssp.c    | 25 +++++++++++++++++++++++++
 include/linux/pxa2xx_ssp.h | 11 +++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index f266135..c83f27b 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -62,6 +62,30 @@ struct ssp_device *pxa_ssp_request(int port, const char *label)
 }
 EXPORT_SYMBOL(pxa_ssp_request);
 
+struct ssp_device *pxa_ssp_request_of(const struct device_node *of_node,
+				      const char *label)
+{
+	struct ssp_device *ssp = NULL;
+
+	mutex_lock(&ssp_lock);
+
+	list_for_each_entry(ssp, &ssp_list, node) {
+		if (ssp->of_node == of_node && ssp->use_count == 0) {
+			ssp->use_count++;
+			ssp->label = label;
+			break;
+		}
+	}
+
+	mutex_unlock(&ssp_lock);
+
+	if (&ssp->node == &ssp_list)
+		return NULL;
+
+	return ssp;
+}
+EXPORT_SYMBOL(pxa_ssp_request_of);
+
 void pxa_ssp_free(struct ssp_device *ssp)
 {
 	mutex_lock(&ssp_lock);
@@ -185,6 +209,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	}
 
 	ssp->use_count = 0;
+	ssp->of_node = dev->of_node;
 
 	mutex_lock(&ssp_lock);
 	list_add(&ssp->node, &ssp_list);
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 467cc63..4944420 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -21,6 +21,8 @@
 
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/of.h>
+
 
 /*
  * SSP Serial Port Registers
@@ -190,6 +192,8 @@ struct ssp_device {
 	int		irq;
 	int		drcmr_rx;
 	int		drcmr_tx;
+
+	struct device_node	*of_node;
 };
 
 /**
@@ -218,11 +222,18 @@ static inline u32 pxa_ssp_read_reg(struct ssp_device *dev, u32 reg)
 #ifdef CONFIG_ARCH_PXA
 struct ssp_device *pxa_ssp_request(int port, const char *label);
 void pxa_ssp_free(struct ssp_device *);
+struct ssp_device *pxa_ssp_request_of(const struct device_node *of_node,
+				      const char *label);
 #else
 static inline struct ssp_device *pxa_ssp_request(int port, const char *label)
 {
 	return NULL;
 }
+static inline struct ssp_device *pxa_ssp_request_of(const struct device_node *n,
+						    const char *name)
+{
+	return NULL;
+}
 static inline void pxa_ssp_free(struct ssp_device *ssp) {}
 #endif
 
-- 
1.8.3.1
