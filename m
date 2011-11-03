From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 3 Nov 2011 16:24:24 +0530
Subject: [PATCH 2/3] ARM: OMAP: hwmod: Update/Clear module specific context
	lost counters
In-Reply-To: <1320317665-6381-1-git-send-email-rnayak@ti.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com>
Message-ID: <1320317665-6381-3-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the module specific context_lost_counter just after
enabling the module, and clear the context register just
before disabling the module.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d7f9dd1..ac17748 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1510,6 +1510,7 @@ static int _enable(struct omap_hwmod *oh)
 
 	_enable_clocks(oh);
 	_enable_module(oh);
+	_update_context_lost(oh);
 
 	r = _wait_target_ready(oh);
 	if (!r) {
@@ -1563,6 +1564,7 @@ static int _idle(struct omap_hwmod *oh)
 	if (oh->class->sysc)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
+	_clear_context_lost(oh);
 	_disable_module(oh);
 	ret = _wait_target_disable(oh);
 	if (ret)
-- 
1.7.1
