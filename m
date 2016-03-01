From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 1 Mar 2016 17:18:07 +0530
Subject: [RFC PATCH] ARM: OMAP2+: Fix updating of sysconfig register
Message-ID: <1456832887-5312-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 127500ccb766f ("ARM: OMAP2+: Only write the sysconfig on idle
when necessary") talks about verification of sysconfig cache value before
updating it, only during idle path. But the patch is adding the
verification in the enable path. So, adding the check in a proper place
as per the commit description.

Not keeping this check during enable path as there is a chance of losing
context and it is safe to do on idle as the context of the register will
never be lost while the device is active.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e9f65fe..71b3747 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1416,9 +1416,7 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	    (sf & SYSC_HAS_CLOCKACTIVITY))
 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
 
-	/* If the cached value is the same as the new value, skip the write */
-	if (oh->_sysc_cache != v)
-		_write_sysconfig(v, oh);
+	_write_sysconfig(v, oh);
 
 	/*
 	 * Set the autoidle bit only after setting the smartidle bit
@@ -1481,7 +1479,9 @@ static void _idle_sysc(struct omap_hwmod *oh)
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
-	_write_sysconfig(v, oh);
+	/* If the cached value is the same as the new value, skip the write */
+	if (oh->_sysc_cache != v)
+		_write_sysconfig(v, oh);
 }
 
 /**
-- 
2.1.4
