From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Oct 2009 17:14:53 -0700
Subject: [PATCH 6/6] omap: McBSP: Fix incorrect receiver stop in
	omap_mcbsp_stop
In-Reply-To: <20091014001233.6116.84749.stgit@localhost>
References: <20091014001233.6116.84749.stgit@localhost>
Message-ID: <20091014001453.6116.76836.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jarkko Nikula <jhnikula@gmail.com>

This small typo written by author causes that McBSP receiver is disabled on
OMAP2430 and OMAP3430 even if only transmitter is stopped. This was noted
with ALSA SoC where simultaneous recording halted if playback was stopped
first.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 88ac976..e664b91 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -595,7 +595,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 	rx &= 1;
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		w = OMAP_MCBSP_READ(io_base, RCCR);
-		w |= (tx ? RDISABLE : 0);
+		w |= (rx ? RDISABLE : 0);
 		OMAP_MCBSP_WRITE(io_base, RCCR, w);
 	}
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
