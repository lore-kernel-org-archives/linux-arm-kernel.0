From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Jul 2016 12:26:49 +0100
Subject: [PATCH 1/3] mfd: Provide MACRO to declare commonly defined MFD cell
 attributes
In-Reply-To: <20160713112651.14539-1-lee.jones@linaro.org>
References: <20160713112651.14539-1-lee.jones@linaro.org>
Message-ID: <20160713112651.14539-2-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/core.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 99c0395..c6018f4 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -16,6 +16,35 @@
 
 #include <linux/platform_device.h>
 
+#define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
+
+#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, _match)\
+	{								\
+		.name = (_name),					\
+		.resources = (_res),					\
+		.num_resources = MFD_RES_SIZE((_res)),			\
+		.platform_data = (_pdata),				\
+		.pdata_size = (_pdsize),				\
+		.of_compatible = (_compat),				\
+		.acpi_match = (_match),					\
+		.id = (_id),						\
+	}
+
+#define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat)		\
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)	\
+
+#define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match)	\
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)	\
+
+#define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
+
+#define MFD_CELL_RES(_name, _res)					\
+	MFD_CELL_ALL(_name, _res, _pdata, 0, 0, NULL, NULL)		\
+
+#define MFD_CELL_NAME(_name)						\
+	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)		\
+
 struct irq_domain;
 struct property_entry;
 
-- 
2.9.0
