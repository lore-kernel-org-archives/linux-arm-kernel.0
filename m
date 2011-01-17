From: segoon@openwall.com (Vasiliy Kulikov)
Date: Mon, 17 Jan 2011 13:08:42 +0300
Subject: [PATCH] arm: mach-omap2: potential NULL dereference
Message-ID: <1295258922-31242-1-git-send-email-segoon@openwall.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kzalloc() may fail, if so return -ENOMEM.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Cannot compile this driver, so it is not tested at all.

 arch/arm/mach-omap2/smartreflex.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 77ecebf..871bca9 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -260,7 +260,10 @@ static int sr_late_init(struct omap_sr *sr_info)
 	if (sr_class->class_type == SR_CLASS2 &&
 		sr_class->notify_flags && sr_info->irq) {
 
+		ret = -ENOMEM;
 		name = kzalloc(SMARTREFLEX_NAME_LEN + 1, GFP_KERNEL);
+		if (name == NULL)
+			goto error;
 		strcpy(name, "sr_");
 		strcat(name, sr_info->voltdm->name);
 		ret = request_irq(sr_info->irq, sr_interrupt,
-- 
1.7.0.4
