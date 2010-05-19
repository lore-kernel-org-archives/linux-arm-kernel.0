From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 May 2010 20:18:47 -0600
Subject: [PATCH 08/22] OMAP: hwmod: Do not exit the iteration if one clock
	init failed
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Message-ID: <20100519021846.19716.52695.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

During the _init_clocks phase, the iteration is stopped but the
status is still change from _HWMOD_STATE_REGISTERED to
_HWMOD_STATE_CLKS_INITED.
Since the _setup phase will be done nevertheless, it might be
better to keep initializing the others clocks nodes and just
keep the warning.
It is much easier to debug when a important number of clocks
name are wrong during the early debug phase of a new platform.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5d3a3ea..b624ad6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -783,9 +783,10 @@ static int _init_clocks(struct omap_hwmod *oh)
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
 
-	oh->_state = _HWMOD_STATE_CLKS_INITED;
+	if (!ret)
+		oh->_state = _HWMOD_STATE_CLKS_INITED;
 
-	return ret;
+	return 0;
 }
 
 /**
