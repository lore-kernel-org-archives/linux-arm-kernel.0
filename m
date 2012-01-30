From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Jan 2012 03:18:17 -0700
Subject: [PATCH 5/7] ARM: OMAP2+: hwmod: add omap_hwmod_get_mpu_irq() and
 omap_hwmod_get_mpu_rt_pa()
In-Reply-To: <20120130101251.10450.58423.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
Message-ID: <20120130101816.10450.2624.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer integration code pokes around in hwmod data structures.
Those data structures are about to change.  Define some functions for
the timer integration code to use instead.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   82 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +
 2 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4e8d332..f7bf759 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2794,3 +2794,85 @@ int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx)
 
 	return 0;
 }
+
+/*
+ * IP block data retrieval functions
+ */
+
+/**
+ * omap_hwmod_get_mpu_irq - return a hwmod's MPU IRQ line ID, if it only has one
+ * @oh: struct omap_hwmod * to examine MPU IRQs on
+ *
+ * If the IP block represented by @oh only has one IRQ line, return its
+ * ID; otherwise, return -ENOENT if the IP block has no MPU IRQs, or -EINVAL
+ * if @oh is null or hasn't yet been registered.
+ */
+int omap_hwmod_get_mpu_irq(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_irq_info *ii;
+
+	if (!oh)
+		return -EINVAL;
+
+	if (oh->_state == _HWMOD_STATE_UNKNOWN)
+		return -EINVAL;
+
+	if (!oh->mpu_irqs)
+		return -ENOENT;
+
+	ii = &oh->mpu_irqs[0];
+
+	if (ii->irq == -1)
+		return -ENOENT;
+
+	return ii->irq;
+}
+
+/**
+ * omap_hwmod_get_mpu_rt_pa - get the register target physical start & end addrs
+ * @oh: struct omap_hwmod * to retrieve physical address information for
+ * @pa_start: ptr to a u32 to return the starting physical address of the RT
+ * @pa_end: ptr to a u32 to return the ending physical address of the RT
+ *
+ * For a given hwmod @oh, return the starting MPU physical address of
+ * @oh's register target address space in the u32 pointed to by
+ * @pa_start, and return the ending MPU physical address of @oh's
+ * register target address space in the u32 pointed to by @pa_end.
+ * (Device registers, particularly the OCP header registers, are
+ * expected to reside in this space.)  The previous contents of the
+ * data pointed to by @pa_start and @pa_end are ignored and
+ * overwritten.  @pa_start is usually (but not always) the same as the
+ * device's "base address."  Note that @pa_start and @pa_end are
+ * currently only guaranteed to be valid addresses for the MPU, not
+ * for other interconnect initiators.
+ *
+ * Returns 0 upon success, -EINVAL if any arguments are null or if the
+ * hwmod hasn't been registered, or -ENOENT if @oh has no MPU register
+ * target address space.
+ */
+int omap_hwmod_get_mpu_rt_pa(struct omap_hwmod *oh, u32 *pa_start, u32 *pa_end)
+{
+	struct omap_hwmod_addr_space *mem;
+
+	if (!oh || !pa_start || !pa_end)
+		return -EINVAL;
+
+	if (oh->_state == _HWMOD_STATE_UNKNOWN)
+		return -EINVAL;
+
+	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+		return -ENOENT;
+
+	mem = _find_mpu_rt_addr_space(oh);
+	if (!mem) {
+		pr_debug("omap_hwmod: %s: no MPU register target found\n",
+			 oh->name);
+		return -ENOENT;
+	}
+
+	*pa_start = mem->pa_start;
+	*pa_end = mem->pa_end;
+
+	return 0;
+}
+
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 6470101..0d95c86 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -610,6 +610,9 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
 
 int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx);
 
+int omap_hwmod_get_mpu_irq(struct omap_hwmod *oh);
+int omap_hwmod_get_mpu_rt_pa(struct omap_hwmod *oh, u32 *pa_start, u32 *pa_end);
+
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
