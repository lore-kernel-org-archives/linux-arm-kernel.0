From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 7 Jul 2011 02:10:52 -0600 (MDT)
Subject: [PATCH v3 04/13] OMAP: hwmod: Wait the idle status to be disabled
In-Reply-To: <20110705182144.GA10846@google.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
	<1309554558-19819-5-git-send-email-b-cousson@ti.com>
	<20110705182144.GA10846@google.com>
Message-ID: <alpine.DEB.2.00.1107070029570.31498@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Todd,

Beno?t is away right now, so I'll deal with the straightforward aspects of 
your comments, and leave the more complex parts for him when he gets 
back.

On Tue, 5 Jul 2011, Todd Poynor wrote:

> On Fri, Jul 01, 2011 at 11:09:09PM +0200, Benoit Cousson wrote:
> > It is mandatory to wait for a module to be in disabled state before
> > potentially disabling source clock or re-asserting a reset.
> > 
> > omap_hwmod_idle and omap_hwmod_shutdown does not wait for
> > the module to be fully idle.
> > 
> > Add a cm_xxx accessor to wait the clkctrl idle status to be disabled.
> > Fix hwmod_[idle|shutdown] to use this API.
> ...
> > +int omap4_cm_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
> 
> Technically this waits for a module slave to enter "full idle" --
> "interface idle" not good enough, and if the module is also a master
> its standby status could possibly be different... personally, these
> details make my brain hurt, but thought I'd mention this in case
> the naming of this interface should capture any of these distinctions.

This is probably going to need clarification from someone who knows the 
PRCM state machine.

> 
> > +{
> > +	int i = 0;
> > +
> > +	if (!clkctrl_offs)
> > +		return 0;
> > +
> > +	omap_test_timeout(
> > +		_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) == 0x3,
> > +		MAX_MODULE_READY_TIME, i);
> 
> The numeric constant may already have an equivalent symbol defined, or
> suggest adding one.

Added.

> 
> >  /**
> > + * _wait_target_disable - wait for a module to be disabled
> > + * @oh: struct omap_hwmod *
> > + *
> > + * Wait for a module @oh to leave slave idle.  Returns 0 if the module
> > + * does not have an IDLEST bit or if the module successfully leaves
> > + * slave idle; otherwise, pass along the return value of the
> > + * appropriate *_cm_wait_module_ready() function.
> 
> This paragraph probably c&p from a function with opposite meaning.

Fixed.

> >  static int _idle(struct omap_hwmod *oh)
> >  {
> > +	int ret;
> > +
> >  	pr_debug("omap_hwmod: %s: idling\n", oh->name);
> >  
> >  	if (oh->_state != _HWMOD_STATE_ENABLED) {
> > @@ -1351,6 +1383,10 @@ static int _idle(struct omap_hwmod *oh)
> >  		_idle_sysc(oh);
> >  	_del_initiator_dep(oh, mpu_oh);
> >  	_disable_clocks(oh);
> > +	ret = _wait_target_disable(oh);
> > +	if (ret)
> > +		pr_debug("omap_hwmod: %s: _wait_target_disable failed\n",
> > +			   oh->name);
> 
> Should callers see an error function return in this case?

I don't know, but I've changed the pr_debug() to pr_warn() so that these 
aren't hidden.  That will result in some warnings on boot.  The goal is to 
'inspire' someone to fix those issues in the -rc series or 3.2.

The updated patch is below.


- Paul

From: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 1 Jul 2011 23:09:09 +0200
Subject: [PATCH] OMAP: hwmod: Wait the idle status to be disabled

It is mandatory to wait for a module to be in disabled state before
potentially disabling source clock or re-asserting a reset.

omap_hwmod_idle and omap_hwmod_shutdown does not wait for
the module to be fully idle.

Add a cm_xxx accessor to wait the clkctrl idle status to be disabled.
Fix hwmod_[idle|shutdown] to use this API.

Based on Rajendra's initial patch.

Please note that most interconnects hwmod will return one timeout because
it is impossible for them to be in idle since the processor is accessing
the registers though the interconnect.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Todd Poynor <toddpoynor@google.com>
[paul at pwsan.com: move cpu_is_*() tests to the top of _wait_target_disable();
 incorporate some feedback from Todd]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   27 +++++++++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.h |    1 +
 arch/arm/mach-omap2/omap_hwmod.c |   40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 3f65ce0..61e4382 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -33,6 +33,8 @@
 #include "prm44xx.h"
 #include "prcm_mpu44xx.h"
 
+#define CLKCTRL_IDLEST_DISABLED			0x3
+
 static u32 _cm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
 	[OMAP4430_INVALID_PRCM_PARTITION]	= 0,
 	[OMAP4430_PRM_PARTITION]		= OMAP4430_PRM_BASE,
@@ -244,3 +246,28 @@ int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_of
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
 
+/**
+ * omap4_cminst_wait_module_idle - wait for a module to be in 'disabled'
+ * state
+ * @part: PRCM partition ID that the CM_CLKCTRL register exists in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ *
+ * Wait for the module IDLEST to be disabled. Some PRCM transition,
+ * like reset assertion or parent clock de-activation must wait the
+ * module to be fully disabled.
+ */
+int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
+{
+	int i = 0;
+
+	if (!clkctrl_offs)
+		return 0;
+
+	omap_test_timeout((_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) ==
+			   CLKCTRL_IDLEST_DISABLED),
+			  MAX_MODULE_READY_TIME, i);
+
+	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+}
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index 8eba2ae..a985400 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -18,6 +18,7 @@ extern void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs);
 extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
 
 extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
+extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
 
 /*
  * In an ideal world, we would not export these low-level functions,
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 39c8831..fee80a8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1013,6 +1013,36 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 }
 
 /**
+ * _wait_target_disable - wait for a module to be disabled
+ * @oh: struct omap_hwmod *
+ *
+ * Wait for a module @oh to enter slave idle.  Returns 0 if the module
+ * does not have an IDLEST bit or if the module successfully enters
+ * slave idle; otherwise, pass along the return value of the
+ * appropriate *_cm*_wait_module_idle() function.
+ */
+static int _wait_target_disable(struct omap_hwmod *oh)
+{
+	/* TODO: For now just handle OMAP4+ */
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		return 0;
+
+	if (!oh)
+		return -EINVAL;
+
+	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+		return 0;
+
+	if (oh->flags & HWMOD_NO_IDLEST)
+		return 0;
+
+	return omap4_cminst_wait_module_idle(oh->clkdm->prcm_partition,
+					     oh->clkdm->cm_inst,
+					     oh->clkdm->clkdm_offs,
+					     oh->prcm.omap4.clkctrl_offs);
+}
+
+/**
  * _lookup_hardreset - fill register bit info for this hwmod/reset line
  * @oh: struct omap_hwmod *
  * @name: name of the reset line in the context of this hwmod
@@ -1319,6 +1349,8 @@ static int _enable(struct omap_hwmod *oh)
  */
 static int _idle(struct omap_hwmod *oh)
 {
+	int ret;
+
 	if (oh->_state != _HWMOD_STATE_ENABLED) {
 		WARN(1, "omap_hwmod: %s: idle state can only be entered from "
 		     "enabled state\n", oh->name);
@@ -1331,6 +1363,10 @@ static int _idle(struct omap_hwmod *oh)
 		_idle_sysc(oh);
 	_del_initiator_dep(oh, mpu_oh);
 	_disable_clocks(oh);
+	ret = _wait_target_disable(oh);
+	if (ret)
+		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
+			oh->name);
 
 	/* Mux pins for device idle if populated */
 	if (oh->mux && oh->mux->pads_dynamic)
@@ -1427,6 +1463,10 @@ static int _shutdown(struct omap_hwmod *oh)
 		_del_initiator_dep(oh, mpu_oh);
 		/* XXX what about the other system initiators here? dma, dsp */
 		_disable_clocks(oh);
+		ret = _wait_target_disable(oh);
+		if (ret)
+			pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
+				oh->name);
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
-- 
1.7.5.4
