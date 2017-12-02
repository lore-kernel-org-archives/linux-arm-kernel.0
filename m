From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri,  1 Dec 2017 23:27:42 -0500
Subject: [PATCH V5 5/7] ACPI: properties: Implement get_match_data() callback
In-Reply-To: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
References: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1512188864-773-6-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a get_match_data() callback as part of the firmware node,
implement the ACPI specific piece for it.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/property.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e26ea20..49dd50b 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1271,6 +1271,17 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static void *acpi_fwnode_get_match_data(const struct fwnode_handle *fwnode,
+					const struct device_driver *drv)
+{
+	struct acpi_device *adev = to_acpi_device_node(fwnode);
+
+	if (!adev)
+		return NULL;
+
+	return acpi_get_match_data(adev, drv->acpi_match_table);
+}
+
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
 	const struct fwnode_operations ops = {				\
 		.device_is_available = acpi_fwnode_device_is_available, \
@@ -1289,6 +1300,7 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 			acpi_fwnode_graph_get_remote_endpoint,		\
 		.graph_get_port_parent = acpi_fwnode_get_parent,	\
 		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
+		.get_match_data = acpi_fwnode_get_match_data,		\
 	};								\
 	EXPORT_SYMBOL_GPL(ops)
 
-- 
1.9.1
