From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Tue,  9 Jan 2018 11:31:58 +1300
Subject: [PATCH 3/3] EDAC: armada_xp: Add support for more SoCs
In-Reply-To: <20180108223158.21930-1-chris.packham@alliedtelesis.co.nz>
References: <20180108223158.21930-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20180108223158.21930-4-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 38x and other integrated SoCs use a reduced pin count so the
width of the SDRAM interface is smaller than the Armada XP SoCs. This
means that the definition of "full" and "half" width is reduced from
64/32 to 32/16.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/edac/armada_xp_edac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index cb9173b30aa9..40cef261e61b 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -347,6 +347,11 @@ static int armada_xp_mc_edac_probe(struct platform_device *pdev)
 
 	armada_xp_mc_edac_read_config(mci);
 
+	/* These SoCs have a reduced width bus */
+	if (of_machine_is_compatible("marvell,armada380") ||
+	    of_machine_is_compatible("marvell,armadaxp-98dx3236"))
+		drvdata->width /= 2;
+
 	/* configure SBE threshold */
 	/* it seems that SBEs are not captured otherwise */
 	writel(1 << SDRAM_ERR_CTRL_ERR_THR_OFFSET,
-- 
2.15.1
