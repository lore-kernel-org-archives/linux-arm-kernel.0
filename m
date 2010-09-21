From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Sep 2010 10:34:44 -0600
Subject: [PATCH 02/11] OMAP: hwmod: Do not disable clocks if hwmod already in
	idle
In-Reply-To: <20100921163021.20258.87587.stgit@twilight.localdomain>
References: <20100921163021.20258.87587.stgit@twilight.localdomain>
Message-ID: <20100921163442.20258.7393.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

The disable function was disabling clocks and dependencies
from both enable and idle state. Since idle function is already
disabling both, an enable -> idle -> disable sequence will
try to disable twice the clocks and thus generate a
"Trying disable clock XXX with 0 usecount" warning.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8bf19a7..5bb25e3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -982,9 +982,13 @@ static int _shutdown(struct omap_hwmod *oh)
 
 	if (oh->class->sysc)
 		_sysc_shutdown(oh);
-	_del_initiator_dep(oh, mpu_oh);
-	/* XXX what about the other system initiators here? DMA, tesla, d2d */
-	_disable_clocks(oh);
+
+	/* clocks and deps are already disabled in idle */
+	if (oh->_state == _HWMOD_STATE_ENABLED) {
+		_del_initiator_dep(oh, mpu_oh);
+		/* XXX what about the other system initiators here? dma, dsp */
+		_disable_clocks(oh);
+	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
 	/* XXX mux any associated balls to safe mode */
