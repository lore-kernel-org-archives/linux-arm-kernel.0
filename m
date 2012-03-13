From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 13 Mar 2012 22:55:23 +0530
Subject: [PATCH v2 1/2] ARM: omap: hwmod: Restore sysc after a reset
In-Reply-To: <1331659524-7635-1-git-send-email-rnayak@ti.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com>
Message-ID: <1331659524-7635-2-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After a softreset, make sure the sysc settings are correctly
restored.

Reported-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8ac26f2..6c0e7eb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2767,6 +2767,10 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
 
 	spin_lock_irqsave(&oh->_lock, flags);
 	r = _reset(oh);
+	if (oh->class->sysc) {
+		_update_sysc_cache(oh);
+		_enable_sysc(oh);
+	}
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return r;
-- 
1.7.1
