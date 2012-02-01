From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed,  1 Feb 2012 09:49:48 +0100
Subject: [PATCH 09/20] ARM: OMAP3+: SmartReflex: introduce class init,
 deinit and priv data
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Message-ID: <1328086199-28486-10-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Certain class drivers such as class 1.5 drivers, will need specific
notification that they have to be inited up or deinited independent
of smart reflex operation. They also may need private data to be
used for operations of their own, provide the same.
This allows the class driver to initialize it's internal data structures
on a need basis in preparation for the specific domain's autocomp usage.
The resultant operation is as follows:
when autocomp is set to 1 -> class drivers' init is called
The existing enable/disable is still used as before by the SmartReflex
core driver to enable disable the class operation.
When autocomp is set to 0 -> class drivers' deinit is called, signaling
the end of usage for that domain.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   15 +++++++++++++++
 arch/arm/mach-omap2/smartreflex.h |    6 ++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 6dea30d..5fd9cb1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -218,6 +218,13 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
 		return;
 	}
 
+	if (sr_class->init &&
+	    sr_class->init(sr->voltdm, sr_class->class_priv_data)) {
+		dev_err(&sr->pdev->dev,
+			"%s: SRClass initialization failed\n", __func__);
+		return;
+	}
+
 	if (!sr_class->enable(sr->voltdm))
 		sr->autocomp_active = true;
 }
@@ -233,6 +240,14 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
 
 	if (sr->autocomp_active) {
 		sr_class->disable(sr->voltdm, 1);
+		if (sr_class->deinit &&
+		    sr_class->deinit(sr->voltdm,
+			    sr_class->class_priv_data)) {
+			dev_err(&sr->pdev->dev,
+				"%s: SR[%d]Class deinitialization failed\n",
+				__func__, sr->srid);
+		}
+
 		sr->autocomp_active = false;
 	}
 }
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 5809141..dd5b21e 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -177,6 +177,8 @@ struct omap_smartreflex_dev_attr {
  *
  * @enable:		API to enable a particular class smaartreflex.
  * @disable:		API to disable a particular class smartreflex.
+ * @init:		API to do class specific initialization (optional)
+ * @deinit:		API to do class specific deinitialization (optional)
  * @configure:		API to configure a particular class smartreflex.
  * @notify:		API to notify the class driver about an event in SR.
  *			Not needed for class3.
@@ -184,14 +186,18 @@ struct omap_smartreflex_dev_attr {
  * @class_type:		specify which smartreflex class.
  *			Can be used by the SR driver to take any class
  *			based decisions.
+ * @class_priv_data:	Class specific private data (optional)
  */
 struct omap_sr_class_data {
 	int (*enable)(struct voltagedomain *voltdm);
 	int (*disable)(struct voltagedomain *voltdm, int is_volt_reset);
+	int (*init)(struct voltagedomain *voltdm, void *class_priv_data);
+	int (*deinit)(struct voltagedomain *voltdm, void *class_priv_data);
 	int (*configure)(struct voltagedomain *voltdm);
 	int (*notify)(struct voltagedomain *voltdm, u32 status);
 	u8 notify_flags;
 	u8 class_type;
+	void *class_priv_data;
 };
 
 /**
-- 
1.7.5.4
