From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 22 Nov 2018 13:11:42 +1300
Subject: [PATCH v7 9/9] EDAC: armada_xp: Add support for more SoCs
In-Reply-To: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
References: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20181122001142.19187-10-chris.packham@alliedtelesis.co.nz>
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
index 3759a4fbbdee..7f227bdcbc84 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -332,6 +332,11 @@ static int axp_mc_probe(struct platform_device *pdev)
 
 	axp_mc_read_config(mci);
 
+	/* These SoCs have a reduced width bus */
+	if (of_machine_is_compatible("marvell,armada380") ||
+	    of_machine_is_compatible("marvell,armadaxp-98dx3236"))
+		drvdata->width /= 2;
+
 	/* configure SBE threshold */
 	/* it seems that SBEs are not captured otherwise */
 	writel(1 << SDRAM_ERR_CTRL_THR_OFFSET, drvdata->base + SDRAM_ERR_CTRL_REG);
-- 
2.19.1
