From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Sep 2010 18:19:34 -0600
Subject: [PATCH 3/5] OMAP: hwmod: Enable module wakeup if in smartidle
In-Reply-To: <20100922001834.8621.76144.stgit@twilight.localdomain>
References: <20100922001834.8621.76144.stgit@twilight.localdomain>
Message-ID: <20100922001931.8621.46565.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

If a module's OCP slave port is programmed to be in smartidle,
its also necessary that they have module level wakeup enabled.
Update _sysc_enable in hwmod framework to do this.

The thread "[PATCH 7/8] : Hwmod api changes" archived here:

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg34212.html

has additional technical information on the rationale of this patch.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
[paul at pwsan.com: revised patch description]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f320cfb..3f3d61a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -691,8 +691,6 @@ static void _sysc_enable(struct omap_hwmod *oh)
 		_set_module_autoidle(oh, idlemode, &v);
 	}
 
-	/* XXX OCP ENAWAKEUP bit? */
-
 	/*
 	 * XXX The clock framework should handle this, by
 	 * calling into this code.  But this must wait until the
@@ -703,6 +701,10 @@ static void _sysc_enable(struct omap_hwmod *oh)
 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
 
 	_write_sysconfig(v, oh);
+
+	/* If slave is in SMARTIDLE, also enable wakeup */
+	if ((sf & SYSC_HAS_SIDLEMODE) && !(oh->flags & HWMOD_SWSUP_SIDLE))
+			_enable_wakeup(oh);
 }
 
 /**
