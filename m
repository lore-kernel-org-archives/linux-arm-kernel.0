From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:19:10 +0900
Subject: [PATCH 18/21] ARM: shmobile: lager: fix error return code check from
 clk_get()
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <7a543d8124e7e23190d36e7c57d3b9c394c4e4c1.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

The lager_add_standard_devices() function calls clk_get() but then fails
to check that it returns an error pointer instead of NULL on failure.

This was added by 4a606af2 ("ARM: shmobile: lager-reference: Instantiate
clkdevs for SCIF and CMT") patch in Simon Horman's renesas-boards2-for-v3.14
tag.

The issue is not serious as it does not cause a crash and seems to not be
actually causing any issues now the other clock bugs have been fixed.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[horms+renesas at verge.net.au: tweaked changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index a6e271d..dc8d76b 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -44,14 +44,14 @@ static void __init lager_add_standard_devices(void)
 
 	for (i = 0; i < ARRAY_SIZE(scif_names); ++i) {
 		clk = clk_get(NULL, scif_names[i]);
-		if (clk) {
+		if (!IS_ERR(clk)) {
 			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
 			clk_put(clk);
 		}
 	}
 
 	clk = clk_get(NULL, "cmt0");
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		clk_register_clkdev(clk, NULL, "sh_cmt.0");
 		clk_put(clk);
 	}
-- 
1.8.5.2
