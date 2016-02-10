From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Feb 2016 15:38:46 +0000
Subject: [PATCH v2] mfd: Provide MACRO to declare commonly defined MFD cell
 attributes
In-Reply-To: <1455028027-1527-1-git-send-email-lee.jones@linaro.org>
References: <1455028027-1527-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20160210153846.GB26950@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mfd: Provide MACRO to declare commonly defined MFD cell attributes
    
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

---
 include/linux/mfd/core.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index bc6f7e0..1a5a87f 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -16,6 +16,32 @@
 
 #include <linux/platform_device.h>
 
+#define MFD_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+#define MFD_CELL_ALL(_name, _res, _pdata, _id, _compat, _match)		\
+	{								\
+		.name = (_name),					\
+		.resources = (_res),					\
+		.num_resources = MFD_ARRAY_SIZE((_res)),		\
+		.platform_data = (_pdata),				\
+		.pdata_size = MFD_ARRAY_SIZE((_pdata)), 		\
+		.of_compatible = (_compat),				\
+		.acpi_match = (_match),					\
+		.id = _id,						\
+	}
+
+#define OF_MFD_CELL(_name, _res, _pdata, _id, _compat)			\
+		MFD_CELL_ALL(_name, _res, _pdata, _id, _compat, NULL)	\
+
+#define ACPI_MFD_CELL(_name, _res, _pdata, _id, _match)			\
+		MFD_CELL_ALL(_name, _res, _pdata, _id, NULL, _match)	\
+
+#define MFD_CELL_BASIC(_name, _res, _pdata, _id)			\
+		MFD_CELL_ALL(_name, _res, _pdata, _id, NULL, NULL)	\
+
+#define MFD_CELL_NAME(_name)						\
+		MFD_CELL_ALL(_name, NULL, NULL, 0, NULL, NULL)		\
+
 struct irq_domain;
 struct property_set;
