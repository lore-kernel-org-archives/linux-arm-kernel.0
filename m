From: khilman@ti.com (Kevin Hilman)
Date: Fri, 18 Nov 2011 11:22:40 -0800
Subject: [PATCH 2/2] arm: omap: smartreflex: fix IRQ handling bug
In-Reply-To: <1321644160-19981-1-git-send-email-khilman@ti.com>
References: <1321644160-19981-1-git-send-email-khilman@ti.com>
Message-ID: <1321644160-19981-3-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

fix a bug which has been on this driver since
it was added by the original commit 984aa6db
which would never clear IRQSTATUS bits.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 6a4f683..cf246b3 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -139,7 +139,7 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		sr_write_reg(sr_info, ERRCONFIG_V1, status);
 	} else if (sr_info->ip_type == SR_TYPE_V2) {
 		/* Read the status bits */
-		sr_read_reg(sr_info, IRQSTATUS);
+		status = sr_read_reg(sr_info, IRQSTATUS);
 
 		/* Clear them by writing back */
 		sr_write_reg(sr_info, IRQSTATUS, status);
-- 
1.7.6
