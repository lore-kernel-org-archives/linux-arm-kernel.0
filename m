From: robherring2@gmail.com (Rob Herring)
Date: Thu, 19 May 2011 13:28:23 -0500
Subject: [PATCH 1/2] dt: check for devices already created fron DT scan
In-Reply-To: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
Message-ID: <1305829704-11774-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

of_platform_bus_create may create duplicate devices if already
added when scanning other buses like amba bus.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/of/platform.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9b785be..7bf74fb 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -234,6 +234,13 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
+	/* Has the device already been registered? */
+	if (of_find_device_by_node(bus)) {
+		pr_debug("%s() - skipping %s, already registered\n",
+			 __func__, bus->full_name);
+		return 0;
+	}
+
 	dev = of_platform_device_create(bus, NULL, parent);
 	if (!dev || !of_match_node(matches, bus))
 		return 0;
@@ -326,4 +333,5 @@ int of_platform_populate(struct device_node *root,
 	of_node_put(root);
 	return rc;
 }
+EXPORT_SYMBOL(of_platform_populate);
 #endif /* !CONFIG_SPARC */
-- 
1.7.4.1
