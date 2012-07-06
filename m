From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 6 Jul 2012 18:51:32 +0530
Subject: [PATCH] ARM: OMAP: hwmod: Disable module when hwmod enable fails
Message-ID: <1341580892-1028-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

Clock and module mode are explictly enable when hwmod is enabled. But if
the hwmod doesn't get ready on time, clocks are disabled but module is left
enabled.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7731936..26888b6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1834,6 +1834,7 @@ static int _enable(struct omap_hwmod *oh)
 			_enable_sysc(oh);
 		}
 	} else {
+		_omap4_disable_module(oh);
 		_disable_clocks(oh);
 		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
 			 oh->name, r);
-- 
1.7.1
