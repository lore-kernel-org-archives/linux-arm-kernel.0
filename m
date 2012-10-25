From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 25 Oct 2012 17:21:22 -0600
Subject: [PATCH 12/13] ARM: OMAP2+: hwmod: call to _omap4_disable_module()
 should use the SoC-specific call
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Message-ID: <20121025232121.17558.53104.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hwmod code unconditionally calls _omap4_disable_module() on all
SoCs when a module doesn't enable correctly.  This "worked" due to the
weak function omap4_cminst_wait_module_idle() in
arch/arm/mach-omap2/prcm.c, which was a no-op.  But now those weak
functions are going away - they should not be used.  So this patch
will now call the SoC-specific disable_module code, assuming it
exists.

Needs to be done before the weak function is removed, otherwise AM33xx
will crash early in boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bc891e9..85e8874 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2062,7 +2062,8 @@ static int _enable(struct omap_hwmod *oh)
 			_enable_sysc(oh);
 		}
 	} else {
-		_omap4_disable_module(oh);
+		if (soc_ops.disable_module)
+			soc_ops.disable_module(oh);
 		_disable_clocks(oh);
 		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
 			 oh->name, r);
