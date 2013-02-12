From: s-anna@ti.com (Suman Anna)
Date: Mon, 11 Feb 2013 22:57:10 -0600
Subject: [PATCH v2 11/13] mailbox/omap: check iomem resource before
 dereferencing it
In-Reply-To: <1360645032-9668-1-git-send-email-s-anna@ti.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Message-ID: <1360645032-9668-12-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a NULL check for iomem resource in mailbox probe functions.

Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/mailbox-omap1.c | 3 +++
 drivers/mailbox/mailbox-omap2.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mailbox/mailbox-omap1.c b/drivers/mailbox/mailbox-omap1.c
index 295c32a..5b0f2c1 100644
--- a/drivers/mailbox/mailbox-omap1.c
+++ b/drivers/mailbox/mailbox-omap1.c
@@ -179,6 +179,9 @@ static int omap1_mbox_probe(struct platform_device *pdev)
 	list[0]->irq = platform_get_irq_byname(pdev, "dsp");
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENOMEM;
+
 	mbox_base = ioremap(mem->start, resource_size(mem));
 	if (!mbox_base)
 		return -ENOMEM;
diff --git a/drivers/mailbox/mailbox-omap2.c b/drivers/mailbox/mailbox-omap2.c
index d3a3d84..9fbd491 100644
--- a/drivers/mailbox/mailbox-omap2.c
+++ b/drivers/mailbox/mailbox-omap2.c
@@ -293,6 +293,11 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
 	mbox_base = ioremap(mem->start, resource_size(mem));
 	if (!mbox_base) {
 		ret = -ENOMEM;
-- 
1.8.1.2
