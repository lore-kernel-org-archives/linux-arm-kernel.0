From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 27 Feb 2012 22:37:07 -0700
Subject: [PATCH v2 7/8] ARM: OMAP2+: hwmod: add
 omap_hwmod_get_resource_byname()
In-Reply-To: <20120228053524.16278.59430.stgit@dusk>
References: <20120228053524.16278.59430.stgit@dusk>
Message-ID: <20120228053704.16278.5820.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer integration code pokes around in hwmod data structures.
Those data structures are about to change.  Define a function,
omap_hwmod_get_resource_byname(), for the timer integration code to
use instead.

The original patch has been changed to use struct resource by Tony's
request, although the caller of this function should not be a driver._
Platform drivers should get their data through the regular platform_*
functions; DT drivers through the appropriate of_* functions.  This a
function is only for use by OMAP core code in arch/arm/*omap*.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |  208 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 
 2 files changed, 210 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 88b6d96..f9fca98 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -886,6 +886,147 @@ static int _count_ocp_if_addr_spaces(struct omap_hwmod_ocp_if *os)
 }
 
 /**
+ * _get_mpu_irq_by_name - fetch MPU interrupt line number by name
+ * @oh: struct omap_hwmod * to operate on
+ * @name: pointer to the name of the MPU interrupt number to fetch (optional)
+ * @irq: pointer to an unsigned int to store the MPU IRQ number to
+ *
+ * Retrieve a MPU hardware IRQ line number named by @name associated
+ * with the IP block pointed to by @oh.  The IRQ number will be filled
+ * into the address pointed to by @dma.  When @name is non-null, the
+ * IRQ line number associated with the named entry will be returned.
+ * If @name is null, the first matching entry will be returned.  Data
+ * order is not meaningful in hwmod data, so callers are strongly
+ * encouraged to use a non-null @name whenever possible to avoid
+ * unpredictable effects if hwmod data is later added that causes data
+ * ordering to change.  Returns 0 upon success or a negative error
+ * code upon error.
+ */
+static int _get_mpu_irq_by_name(struct omap_hwmod *oh, const char *name,
+				unsigned int *irq)
+{
+	int i;
+	bool found = false;
+
+	if (!oh->mpu_irqs)
+		return -ENOENT;
+
+	i = 0;
+	while (oh->mpu_irqs[i].irq != -1) {
+		if (name == oh->mpu_irqs[i].name ||
+		    !strcmp(name, oh->mpu_irqs[i].name)) {
+			found = true;
+			break;
+		}
+		i++;
+	}
+
+	if (!found)
+		return -ENOENT;
+
+	*irq = oh->mpu_irqs[i].irq;
+
+	return 0;
+}
+
+/**
+ * _get_sdma_req_by_name - fetch SDMA request line ID by name
+ * @oh: struct omap_hwmod * to operate on
+ * @name: pointer to the name of the SDMA request line to fetch (optional)
+ * @dma: pointer to an unsigned int to store the request line ID to
+ *
+ * Retrieve an SDMA request line ID named by @name on the IP block
+ * pointed to by @oh.  The ID will be filled into the address pointed
+ * to by @dma.  When @name is non-null, the request line ID associated
+ * with the named entry will be returned.  If @name is null, the first
+ * matching entry will be returned.  Data order is not meaningful in
+ * hwmod data, so callers are strongly encouraged to use a non-null
+ * @name whenever possible to avoid unpredictable effects if hwmod
+ * data is later added that causes data ordering to change.  Returns 0
+ * upon success or a negative error code upon error.
+ */
+static int _get_sdma_req_by_name(struct omap_hwmod *oh, const char *name,
+				 unsigned int *dma)
+{
+	int i;
+	bool found = false;
+
+	if (!oh->sdma_reqs)
+		return -ENOENT;
+
+	i = 0;
+	while (oh->sdma_reqs[i].dma_req != -1) {
+		if (name == oh->sdma_reqs[i].name ||
+		    !strcmp(name, oh->sdma_reqs[i].name)) {
+			found = true;
+			break;
+		}
+		i++;
+	}
+
+	if (!found)
+		return -ENOENT;
+
+	*dma = oh->sdma_reqs[i].dma_req;
+
+	return 0;
+}
+
+/**
+ * _get_addr_space_by_name - fetch address space start & end by name
+ * @oh: struct omap_hwmod * to operate on
+ * @name: pointer to the name of the address space to fetch (optional)
+ * @pa_start: pointer to a u32 to store the starting address to
+ * @pa_end: pointer to a u32 to store the ending address to
+ *
+ * Retrieve address space start and end addresses for the IP block
+ * pointed to by @oh.  The data will be filled into the addresses
+ * pointed to by @pa_start and @pa_end.  When @name is non-null, the
+ * address space data associated with the named entry will be
+ * returned.  If @name is null, the first matching entry will be
+ * returned.  Data order is not meaningful in hwmod data, so callers
+ * are strongly encouraged to use a non-null @name whenever possible
+ * to avoid unpredictable effects if hwmod data is later added that
+ * causes data ordering to change.  Returns 0 upon success or a
+ * negative error code upon error.
+ */
+static int _get_addr_space_by_name(struct omap_hwmod *oh, const char *name,
+				   u32 *pa_start, u32 *pa_end)
+{
+	int i, j;
+	struct omap_hwmod_ocp_if *os;
+	bool found = false;
+
+	for (i = 0; i < oh->slaves_cnt; i++) {
+		os = oh->slaves[i];
+
+		if (!os->addr)
+			return -ENOENT;
+
+		j = 0;
+		while (os->addr[j].pa_start != os->addr[j].pa_end) {
+			if (name == os->addr[j].name ||
+			    !strcmp(name, os->addr[j].name)) {
+				found = true;
+				break;
+			}
+			j++;
+		}
+
+		if (found)
+			break;
+	}
+
+	if (!found)
+		return -ENOENT;
+
+	*pa_start = os->addr[j].pa_start;
+	*pa_end = os->addr[j].pa_end;
+
+	return 0;
+}
+
+/**
  * _find_mpu_port_index - find hwmod OCP slave port ID intended for MPU use
  * @oh: struct omap_hwmod *
  *
@@ -2402,6 +2543,10 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
 	return r;
 }
 
+/*
+ * IP block data retrieval functions
+ */
+
 /**
  * omap_hwmod_count_resources - count number of struct resources needed by hwmod
  * @oh: struct omap_hwmod *
@@ -2485,6 +2630,69 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
 }
 
 /**
+ * omap_hwmod_get_resource_byname - fetch IP block integration data by name
+ * @oh: struct omap_hwmod * to operate on
+ * @type: one of the IORESOURCE_* constants from include/linux/ioport.h
+ * @name: pointer to the name of the data to fetch (optional)
+ * @rsrc: pointer to a struct resource, allocated by the caller
+ *
+ * Retrieve MPU IRQ, SDMA request line, or address space start/end
+ * data for the IP block pointed to by @oh.  The data will be filled
+ * into a struct resource record pointed to by @rsrc.  The struct
+ * resource must be allocated by the caller.  When @name is non-null,
+ * the data associated with the matching entry in the IRQ/SDMA/address
+ * space hwmod data arrays will be returned.  If @name is null, the
+ * first array entry will be returned.  Data order is not meaningful
+ * in hwmod data, so callers are strongly encouraged to use a non-null
+ * @name whenever possible to avoid unpredictable effects if hwmod
+ * data is later added that causes data ordering to change.  This
+ * function is only intended for use by OMAP core code.  Device
+ * drivers should not call this function - the appropriate bus-related
+ * data accessor functions should be used instead.  Returns 0 upon
+ * success or a negative error code upon error.
+ */
+int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
+				   const char *name, struct resource *rsrc)
+{
+	int r;
+	unsigned int irq, dma;
+	u32 pa_start, pa_end;
+
+	if (!oh || !rsrc)
+		return -EINVAL;
+
+	if (type == IORESOURCE_IRQ) {
+		r = _get_mpu_irq_by_name(oh, name, &irq);
+		if (r)
+			return r;
+
+		rsrc->start = irq;
+		rsrc->end = irq;
+	} else if (type == IORESOURCE_DMA) {
+		r = _get_sdma_req_by_name(oh, name, &dma);
+		if (r)
+			return r;
+
+		rsrc->start = dma;
+		rsrc->end = dma;
+	} else if (type == IORESOURCE_MEM) {
+		r = _get_addr_space_by_name(oh, name, &pa_start, &pa_end);
+		if (r)
+			return r;
+
+		rsrc->start = pa_start;
+		rsrc->end = pa_end;
+	} else {
+		return -EINVAL;
+	}
+
+	rsrc->flags = type;
+	rsrc->name = name;
+
+	return 0;
+}
+
+/**
  * omap_hwmod_get_pwrdm - return pointer to this module's main powerdomain
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 6470101..ff4d7f9 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -581,6 +581,8 @@ int omap_hwmod_softreset(struct omap_hwmod *oh);
 
 int omap_hwmod_count_resources(struct omap_hwmod *oh);
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
+int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
+				   const char *name, struct resource *res);
 
 struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh);
 void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh);
