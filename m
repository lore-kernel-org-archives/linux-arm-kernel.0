From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:16:09 +0200
Subject: [PATCH 2/5] soc: renesas: rcar-sysc: Fix uninitialized error code in
 rcar_sysc_pd_init()
In-Reply-To: <cover.1467292648.git.horms+renesas@verge.net.au>
References: <cover.1467292648.git.horms+renesas@verge.net.au>
Message-ID: <1023578ec38ec1bae085917134ba985da755503e.1467292648.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On success, rcar_sysc_pd_init() returns an uninitialized error code.
Use the return value of of_genpd_add_provider_onecell() to fix this.

This went unnoticed, as early_initcall() doesn't care about the return
value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index a43ca24699be..59a8152681a5 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -398,7 +398,7 @@ static int __init rcar_sysc_pd_init(void)
 		domains->domains[area->isr_bit] = &pd->genpd;
 	}
 
-	of_genpd_add_provider_onecell(np, &domains->onecell_data);
+	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
 
 out_put:
 	of_node_put(np);
-- 
2.7.0.rc3.207.g0ac5344
