From: tero.kristo@nokia.com (Tero Kristo)
Date: Tue, 15 Feb 2011 18:30:28 +0200
Subject: [PATCHv2] omap2/3: dmtimer: Enable autoidle
Message-ID: <1297787428-5717-1-git-send-email-tero.kristo@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This saves some power. OMAP4 version should check for GPT module ID, as
autoidle is only supported on a subset of these.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 1d706cf..ee9f6eb 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -342,6 +342,10 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 	l |= 0x02 << 3;  /* Set to smart-idle mode */
 	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
 
+	/* Enable autoidle on OMAP2 / OMAP3 */
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		l |= 0x1 << 0;
+
 	/*
 	 * Enable wake-up on OMAP2 CPUs.
 	 */
-- 
1.7.1
