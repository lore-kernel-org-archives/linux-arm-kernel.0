From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 22 Sep 2010 09:22:39 -0600 (MDT)
Subject: [PATCH 3/5] OMAP: hwmod: Enable module wakeup if in smartidle
In-Reply-To: <4C99CF3A.9080901@ru.mvista.com>
References: <20100922001834.8621.76144.stgit@twilight.localdomain>
	<20100922001931.8621.46565.stgit@twilight.localdomain>
	<4C99CF3A.9080901@ru.mvista.com>
Message-ID: <alpine.DEB.2.00.1009220920100.21002@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sergei,

On Wed, 22 Sep 2010, Sergei Shtylyov wrote:

>    This line is overindented...

Thanks, updated the patch (below).

- Paul


>From 9980ce53c97392a3dbdc9d1ac3e455d79b4167ed Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 21 Sep 2010 19:58:30 +0530
Subject: [PATCH] OMAP: hwmod: Enable module wakeup if in smartidle
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If a module's OCP slave port is programmed to be in smartidle,
its also necessary that they have module level wakeup enabled.
Update _sysc_enable in hwmod framework to do this.

The thread "[PATCH 7/8] : Hwmod api changes" archived here:

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg34212.html

has additional technical information on the rationale of this patch.

Sergei Shtylyov <sshtylyov@mvista.com> identified an indentation
problem with this patch - thanks, Sergei.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
[paul at pwsan.com: revised patch description]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f320cfb..d694067 100644
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
+		_enable_wakeup(oh);
 }
 
 /**
-- 
1.7.1
