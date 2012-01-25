From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 25 Jan 2012 16:16:08 +0100
Subject: [PATCH 06/21] OMAP3+: Smartreflex: fix err interrupt disable sequence
In-Reply-To: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
Message-ID: <1327504583-13408-7-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

sr_modify_mask takes mask, value as parameters, the usage
currently is value, mask which is wrong, as a result
vpboundint_st which was supposed to have been disabled,
does not get disabled.

Change-Id: Id59aea06bc7e980345ae2d522592b2abc1feeede
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 7e755bb..ee224df 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -447,8 +447,8 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
 		sr_errconfig);
 
 	/* Enabling the interrupts if the ERROR module is used */
-	sr_modify_reg(sr, errconfig_offs,
-		vpboundint_en, (vpboundint_en | vpboundint_st));
+	sr_modify_reg(sr, errconfig_offs, (vpboundint_en | vpboundint_st),
+		      vpboundint_en);
 
 	return 0;
 }
-- 
1.7.5.4
