From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 May 2013 12:16:06 +0200
Subject: [PATCH 1/4] ARM: mmu: Call debug_ll_io_init if no map_io function is
 specified
In-Reply-To: <1368440169-29088-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368440169-29088-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368440169-29088-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More and more sub-architectures are using only the debug_ll_io_init
function as the map_io function. Make the core code call this function
if no function is specified in the machine description to remove some
boilerplate code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e0d8565..faa36d7 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1232,6 +1232,8 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	 */
 	if (mdesc->map_io)
 		mdesc->map_io();
+	else
+		debug_ll_io_init();
 	fill_pmd_gaps();
 
 	/* Reserve fixed i/o space in VMALLOC region */
-- 
1.8.1.2
