From: balbi@ti.com (Felipe Balbi)
Date: Tue, 15 Jul 2014 15:18:12 -0500
Subject: [PATCH] arm: omap: hwmod: drop unnecessary list initialization
Message-ID: <1405455492-1087-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ml->node and sl->node are currently initialized
by means of INIT_LIST_HEAD(). That initialiation
is followed by a list_add() call.

Looking at what both these functions do we will have:

	ml->node.next = &ml->node;
	ml->node.prev = &ml->node;
	oi->master->master_ports.next.prev = &ml->node;
	ml->node.next = &oi->master->master_ports.next;
	ml->node.prev = &oi->master->master_ports;
	oi->master->master_ports.next = &ml->node;

from this, it's clear that both INIT_LIST_HEAD() calls
are unnecessary and can be safely removed.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

found by code inspection, boot tested on am437x SK on today's
linux-next + pending patches.

 arch/arm/mach-omap2/omap_hwmod.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6c074f3..8194990 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2828,12 +2828,10 @@ static int __init _add_link(struct omap_hwmod_ocp_if *oi)
 	_alloc_links(&ml, &sl);
 
 	ml->ocp_if = oi;
-	INIT_LIST_HEAD(&ml->node);
 	list_add(&ml->node, &oi->master->master_ports);
 	oi->master->masters_cnt++;
 
 	sl->ocp_if = oi;
-	INIT_LIST_HEAD(&sl->node);
 	list_add(&sl->node, &oi->slave->slave_ports);
 	oi->slave->slaves_cnt++;
 
-- 
2.0.1.563.g66f467c
