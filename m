From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Feb 2012 16:54:13 -0800
Subject: [PATCH 5/7] ARM: OMAP2+: Fix devexit for smartreflex when
 CONFIG_HOTPLUG is not set
In-Reply-To: <20120224005324.16794.73852.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
Message-ID: <20120224005413.16794.28517.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we get:

`omap_sr_remove' referenced in section `.data' of arch/arm/mach-omap2/built-in.o:
defined in discarded section `.devexit.text' of arch/arm/mach-omap2/built-in.o

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 7e755bb..47c77a1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1012,7 +1012,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver smartreflex_driver = {
-	.remove         = omap_sr_remove,
+	.remove         = __devexit_p(omap_sr_remove),
 	.driver		= {
 		.name	= "smartreflex",
 	},
