From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 07 Mar 2012 19:38:23 -0700
Subject: [PATCH 01/12] ARM: OMAP2+: hwmod: add _find_mpu_rt_port()
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Message-ID: <20120308023821.8205.21191.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most IP blocks on the OMAP SoC have an interconnect link that is
intended to be used by the MPU to communicate with the IP block.
Several parts of the hwmod code need to be able to identify this link.
Currently, this is open-coded.  However, future patches will change
the way that interconnect links are represented and will make
identifying the link more complex.  So to avoid code duplication, this
patch centralizes the MPU port link identification code into a new
function, _find_mpu_rt_port().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   39 ++++++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3462dc5..503047a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1061,6 +1061,27 @@ static int __init _find_mpu_port_index(struct omap_hwmod *oh)
 }
 
 /**
+ * _find_mpu_rt_port - return omap_hwmod_ocp_if accessible by the MPU
+ * @oh: struct omap_hwmod *
+ *
+ * Given a pointer to a struct omap_hwmod record @oh, return a pointer
+ * to the struct omap_hwmod_ocp_if record that is used by the MPU to
+ * communicate with the IP block.  This interface need not be directly
+ * connected to the MPU (and almost certainly is not), but is directly
+ * connected to the IP block represented by @oh.  Returns a pointer
+ * to the struct omap_hwmod_ocp_if * upon success, or returns NULL upon
+ * error or if there does not appear to be a path from the MPU to this
+ * IP block.
+ */
+static struct omap_hwmod_ocp_if *_find_mpu_rt_port(struct omap_hwmod *oh)
+{
+	if (!oh || oh->_int_flags & _HWMOD_NO_MPU_PORT || oh->slaves_cnt == 0)
+		return NULL;
+
+	return oh->slaves[oh->_mpu_port_index];
+};
+
+/**
  * _find_mpu_rt_addr_space - return MPU register target address space for @oh
  * @oh: struct omap_hwmod *
  *
@@ -1073,10 +1094,7 @@ static struct omap_hwmod_addr_space * __init _find_mpu_rt_addr_space(struct omap
 	struct omap_hwmod_addr_space *mem;
 	int found = 0, i = 0;
 
-	if (!oh || oh->_int_flags & _HWMOD_NO_MPU_PORT || oh->slaves_cnt == 0)
-		return NULL;
-
-	os = oh->slaves[oh->_mpu_port_index];
+	os = _find_mpu_rt_port(oh);
 	if (!os->addr)
 		return NULL;
 
@@ -1334,12 +1352,11 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 	if (!oh)
 		return -EINVAL;
 
-	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+	if (oh->flags & HWMOD_NO_IDLEST)
 		return 0;
 
-	os = oh->slaves[oh->_mpu_port_index];
-
-	if (oh->flags & HWMOD_NO_IDLEST)
+	os = _find_mpu_rt_port(oh);
+	if (!os)
 		return 0;
 
 	/* XXX check module SIDLEMODE */
@@ -2709,6 +2726,7 @@ int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
 struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 {
 	struct clk *c;
+	struct omap_hwmod_ocp_if *oi;
 
 	if (!oh)
 		return NULL;
@@ -2716,9 +2734,10 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 	if (oh->_clk) {
 		c = oh->_clk;
 	} else {
-		if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+		oi = _find_mpu_rt_port(oh);
+		if (!oi)
 			return NULL;
-		c = oh->slaves[oh->_mpu_port_index]->_clk;
+		c = oi->_clk;
 	}
 
 	if (!c->clkdm)
