From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 20 Sep 2017 13:38:21 +0530
Subject: [PATCH 3/4] irqchip/gic: Handle return value of kasprintf
In-Reply-To: <1505894901-9403-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1505894901-9403-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1505894901-9403-4-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/irqchip/irq-gic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 651d726..ec4a7e6 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1209,9 +1209,13 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 
 	if (static_key_true(&supports_deactivate) && gic == &gic_data[0]) {
 		name = kasprintf(GFP_KERNEL, "GICv2");
+		if (!name)
+			return -ENOMEM;
 		gic_init_chip(gic, NULL, name, true);
 	} else {
 		name = kasprintf(GFP_KERNEL, "GIC-%d", (int)(gic-&gic_data[0]));
+		if (!name)
+			return -ENOMEM;
 		gic_init_chip(gic, NULL, name, false);
 	}
 
-- 
1.9.1
