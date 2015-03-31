From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 31 Mar 2015 15:02:05 +0200
Subject: [PATCH v2 7/8] net/macb: fix the peripheral version test
In-Reply-To: <1427806926-18887-1-git-send-email-nicolas.ferre@atmel.com>
References: <1427806926-18887-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1427806926-18887-8-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently need two checks of the peripheral version in MACB_MID register.
One of them got out of sync after modification by 8a013a9c71b2 (net: macb:
Include multi queue support for xilinx ZynqMP ethernet version).
Fix this in macb_configure_caps() so that xilinx ZynqMP will be considered
as a GEM flavor.

Fixes: 8a013a9c71b2 ("net: macb: Include multi queue support for xilinx ZynqMP
ethernet version")

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Cc: <stable@vger.kernel.org> #4.0 (if it doesn't make it for -final)
---

Changes in v2:
- fix peripheral version test

 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index babe972a7c32..4412895cf4a8 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -2139,7 +2139,7 @@ static void macb_configure_caps(struct macb *bp, const struct macb_config *dt_co
 	if (dt_conf)
 		bp->caps = dt_conf->caps;
 
-	if (MACB_BFEXT(IDNUM, macb_readl(bp, MID)) == 0x2)
+	if (MACB_BFEXT(IDNUM, macb_readl(bp, MID)) >= 0x2)
 		bp->caps |= MACB_CAPS_MACB_IS_GEM;
 
 	if (macb_is_gem(bp)) {
-- 
2.1.3
