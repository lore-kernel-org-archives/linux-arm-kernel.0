From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 21 Jan 2013 01:54:17 +0000 (UTC)
Subject: [PATCH v2 0/5] ARM: OMAP4: Enable AESS IP.
In-Reply-To: <50F9608A.8060102@ti.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
 <50F9608A.8060102@ti.com>
Message-ID: <alpine.DEB.2.00.1301210152220.31667@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jan 2013, Sebastien Guiriec wrote:

> Paul, Benoit,
> 
> Any comments before I resend the serie with the minor comment for Felipe?

Not from me.  The series has been queued for 3.9 with Felipe's comment 
fix; thanks Felipe.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 20 Jan 2013 18:52:09 -0700
Subject: [PATCH] ARM: OMAP2+: hwmod: add enable_preprogram hook

After setup/enable, some IP blocks need some additional setting to
indicate the PRCM that they are inactive until they are configured.
Some examples on OMAP4 include the AESS and FSUSB IP blocks.

To fix this cleanly, this patch adds another optional function
pointer, enable_preprogram, to the IP block's hwmod data.  The function
that is pointed to is called by the hwmod code immediately after the
IP block is reset.

This version of the patch includes a patch description fix from Felipe.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: P?ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h |    2 ++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4653efb..f37d22c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2053,6 +2053,23 @@ static int _omap4_get_context_lost(struct omap_hwmod *oh)
 }
 
 /**
+ * _enable_preprogram - Pre-program an IP block during the _enable() process
+ * @oh: struct omap_hwmod *
+ *
+ * Some IP blocks (such as AESS) require some additional programming
+ * after enable before they can enter idle.  If a function pointer to
+ * do so is present in the hwmod data, then call it and pass along the
+ * return value; otherwise, return 0.
+ */
+static int __init _enable_preprogram(struct omap_hwmod *oh)
+{
+	if (!oh->class->enable_preprogram)
+		return 0;
+
+	return oh->class->enable_preprogram(oh);
+}
+
+/**
  * _enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -2156,6 +2173,7 @@ static int _enable(struct omap_hwmod *oh)
 				_update_sysc_cache(oh);
 			_enable_sysc(oh);
 		}
+		r = _enable_preprogram(oh);
 	} else {
 		if (soc_ops.disable_module)
 			soc_ops.disable_module(oh);
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 3ae852a..41066b4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -501,6 +501,7 @@ struct omap_hwmod_omap4_prcm {
  * @rev: revision of the IP class
  * @pre_shutdown: ptr to fn to be executed immediately prior to device shutdown
  * @reset: ptr to fn to be executed in place of the standard hwmod reset fn
+ * @enable_preprogram:  ptr to fn to be executed during device enable
  *
  * Represent the class of a OMAP hardware "modules" (e.g. timer,
  * smartreflex, gpio, uart...)
@@ -524,6 +525,7 @@ struct omap_hwmod_class {
 	u32					rev;
 	int					(*pre_shutdown)(struct omap_hwmod *oh);
 	int					(*reset)(struct omap_hwmod *oh);
+	int					(*enable_preprogram)(struct omap_hwmod *oh);
 };
 
 /**
-- 
1.7.10.4
