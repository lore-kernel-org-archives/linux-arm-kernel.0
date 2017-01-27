From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 22:38:33 +0100
Subject: [PATCH v5 1/13] mmc: sunxi: Fix clock frequency change sequence
In-Reply-To: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
Message-ID: <7a6cea2cb855613fd7fb3d029e92be00c34b252d.1485553113.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SD specification documents that the clock frequency should only be
changed once gated (Section 3.2.3 - SD Clock Frequency Change Sequence).

The current code first modifies the parent clock, gates it and then
modifies the internal divider. This means that since the parent clock rate
might be changed, the bus clock might be changed as well before it is
gated, which breaks the specification.

Move the gating before the parent rate modification.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Tested-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 drivers/mmc/host/sunxi-mmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b1d1303389a7..ab4324e6eb74 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -761,6 +761,10 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	u32 rval, clock = ios->clock;
 	int ret;
 
+	ret = sunxi_mmc_oclk_onoff(host, 0);
+	if (ret)
+		return ret;
+
 	/* 8 bit DDR requires a higher module clock */
 	if (ios->timing == MMC_TIMING_MMC_DDR52 &&
 	    ios->bus_width == MMC_BUS_WIDTH_8)
@@ -783,10 +787,6 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		return ret;
 	}
 
-	ret = sunxi_mmc_oclk_onoff(host, 0);
-	if (ret)
-		return ret;
-
 	/* clear internal divider */
 	rval = mmc_readl(host, REG_CLKCR);
 	rval &= ~0xff;
-- 
git-series 0.8.11
