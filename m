From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:30:38 +0100
Subject: [PATCH 1/1] soc: renesas: rcar-sysc: Keep wakeup sources active
 during system suspend
In-Reply-To: <cover.1513936182.git.horms+renesas@verge.net.au>
References: <cover.1513936182.git.horms+renesas@verge.net.au>
Message-ID: <91c719f5ec6671f7b63762d78897af5583dd7693.1513936182.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

If an R-Car SYSC slave device is part of the CPG/MSTP or CPG/MSSR Clock
Domain and to be used as a wakeup source, it must be kept active during
system suspend.

Currently this is handled in device-specific drivers by explicitly
increasing the use count of the module clock when the device is
configured as a wakeup source.  However, the proper way to prevent the
device from being stopped is to inform this requirement to the genpd
core, by setting the GENPD_FLAG_ACTIVE_WAKEUP flag.

Note that this will only affect devices configured as wakeup sources.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 55a47e509e49..52c25a5e2646 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -224,7 +224,7 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 
 	if (!(pd->flags & (PD_CPU | PD_SCU))) {
 		/* Enable Clock Domain for I/O devices */
-		genpd->flags |= GENPD_FLAG_PM_CLK;
+		genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
 		if (has_cpg_mstp) {
 			genpd->attach_dev = cpg_mstp_attach_dev;
 			genpd->detach_dev = cpg_mstp_detach_dev;
-- 
2.11.0
