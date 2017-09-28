From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 11:45:59 +0100
Subject: [RESEND][PATCH 1/4] of: platform: populate /firmware/ node from
 of_platform_default_populate_init()
In-Reply-To: <1506595562-10592-1-git-send-email-sudeep.holla@arm.com>
References: <1506595562-10592-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1506595562-10592-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since "/firmware" does not have its own "compatible" property as it's
just collection of nodes representing firmware interface, it's sub-nodes
are not populated during system initialization.

Currently different firmware drivers search the /firmware/ node and
populate the sub-node devices selectively. Instead we can populate
the /firmware/ node during init to avoid more drivers continuing to
populate the devices selectively.

To generalize the solution this patch populates the /firmware/ node
explicitly from of_platform_default_populate_init().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/of/platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index ac15d0e3d27d..3a213a6aee89 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -515,6 +515,10 @@ static int __init of_platform_default_populate_init(void)
 			of_platform_device_create(node, NULL, NULL);
 	}
 
+	node = of_find_node_by_path("/firmware");
+	if (node)
+		of_platform_populate(node, NULL, NULL, NULL);
+
 	/* Populate everything else. */
 	of_platform_default_populate(NULL, NULL, NULL);
 
-- 
2.7.4
