From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 6 Jul 2010 08:59:07 +0200
Subject: [PATCH] [arm l2x0] Extend cache-l2x0 to support the 16-way
	PL310 (v3)
In-Reply-To: <1272985254-5675-2-git-send-email-jason.mcmullan@netronome.com>
References: <1272985254-5675-1-git-send-email-jason.mcmullan@netronome.com>
	<1272985254-5675-2-git-send-email-jason.mcmullan@netronome.com>
Message-ID: <20100706065907.GH26079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 11:00:54AM -0400, Jason S. McMullan wrote:
> The L310 cache controller's interface is almost identical
> to the L210. One major difference is that the PL310 can
> have up to 16 ways.
> 
> This change uses the cache's part ID and the Assciativity
> bits in the AUX_CTRL register to determine the number of ways.
> 
> Also prints out the # of ways, CACHE_ID and AUX_CTRL registers.

As I realized now this patch breaks l210 cache support on i.MX35. Before
this patch the number of ways was hardcoded to 8. With this patch the
number of ways is calculated from the L2X0_AUX_CTRL register value.
Unforunately on i.MX35 the reset value of this register is some bogus
value resulting in a 0-way cache. The following patch fixes it but I
could also write some sane values before calling l2x0_init if that's
preferred.

Sascha


commit 7cb529f07fb864816d56000374b2b4aeccba00f0
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue Jul 6 08:53:55 2010 +0200

    [arm l2x0] Do not rely on reset defaults of L2X0_AUX_CTRL
    
    On i.MX35 the L2X0_AUX_CTRL register does not have sensible reset
    default values. Allow them to be overwritten with the aux_val/aux_mask
    arguments passed to l2x0_init().
    
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9819869..df49558 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -218,6 +218,9 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	cache_id = readl(l2x0_base + L2X0_CACHE_ID);
 	aux = readl(l2x0_base + L2X0_AUX_CTRL);
 
+	aux &= aux_mask;
+	aux |= aux_val;
+
 	/* Determine the number of ways */
 	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
 	case L2X0_CACHE_ID_PART_L310:
@@ -248,8 +251,6 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	if (!(readl(l2x0_base + L2X0_CTRL) & 1)) {
 
 		/* l2x0 controller is disabled */
-		aux &= aux_mask;
-		aux |= aux_val;
 		writel(aux, l2x0_base + L2X0_AUX_CTRL);
 
 		l2x0_inv_all();
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
