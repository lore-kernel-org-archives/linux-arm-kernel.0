From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Jan 2012 03:18:16 -0700
Subject: [PATCH 4/7] ARM: OMAP2+: hwmod: provide a function to return the
 address space of the MPU RT
In-Reply-To: <20120130101251.10450.58423.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
Message-ID: <20120130101815.10450.39272.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A subsequent patch will need to know the struct omap_hwmod_addr_space
record corresponding to the module's register target, used by the MPU.
So, convert _find_mpu_rt_base() into _find_mpu_rt_addr_space().  Then
modify its sole current user, _populate_mpu_rt_base(), to extract the
MPU RT base address itself from the struct omap_hwmod_addr_space record.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   57 ++++++++++++++++++++++----------------
 1 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c991bd7..4e8d332 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -917,24 +917,22 @@ static int __init _find_mpu_port_index(struct omap_hwmod *oh)
 }
 
 /**
- * _find_mpu_rt_base - find hwmod register target base addr accessible by MPU
+ * _find_mpu_rt_addr_space - return MPU register target address space for @oh
  * @oh: struct omap_hwmod *
  *
- * Return the virtual address of the base of the register target of
- * device @oh, or NULL on error.
+ * Returns a pointer to the struct omap_hwmod_addr_space record representing
+ * the register target MPU address space; or returns NULL upon error.
  */
-static void __iomem * __init _find_mpu_rt_base(struct omap_hwmod *oh, u8 index)
+static struct omap_hwmod_addr_space * __init _find_mpu_rt_addr_space(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
 	struct omap_hwmod_addr_space *mem;
-	int i = 0, found = 0;
-	void __iomem *va_start;
+	int found = 0, i = 0;
 
-	if (!oh || oh->slaves_cnt == 0)
+	if (!oh || oh->_int_flags & _HWMOD_NO_MPU_PORT || oh->slaves_cnt == 0)
 		return NULL;
 
-	os = oh->slaves[index];
-
+	os = oh->slaves[oh->_mpu_port_index];
 	if (!os->addr)
 		return NULL;
 
@@ -944,20 +942,7 @@ static void __iomem * __init _find_mpu_rt_base(struct omap_hwmod *oh, u8 index)
 			found = 1;
 	} while (!found && mem->pa_start != mem->pa_end);
 
-	if (found) {
-		va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
-		if (!va_start) {
-			pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
-			return NULL;
-		}
-		pr_debug("omap_hwmod: %s: MPU register target at va %p\n",
-			 oh->name, va_start);
-	} else {
-		pr_debug("omap_hwmod: %s: no MPU register target found\n",
-			 oh->name);
-	}
-
-	return (found) ? va_start : NULL;
+	return (found) ? mem : NULL;
 }
 
 /**
@@ -2031,19 +2016,43 @@ int __init omap_hwmod_register(struct omap_hwmod **ohs)
 
 /*
  * _populate_mpu_rt_base - populate the virtual address for a hwmod
+ * @oh: struct omap_hwmod *
+ * @data: (unused)
  *
  * Must be called only from omap_hwmod_setup_*() so ioremap works properly.
  * Assumes the caller takes care of locking if needed.
  */
 static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *data)
 {
+	struct omap_hwmod_addr_space *mem;
+	void __iomem *va_start;
+
+	if (!oh)
+		return 0;
+
 	if (oh->_state != _HWMOD_STATE_REGISTERED)
 		return 0;
 
 	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
 		return 0;
 
-	oh->_mpu_rt_va = _find_mpu_rt_base(oh, oh->_mpu_port_index);
+	mem = _find_mpu_rt_addr_space(oh);
+	if (!mem) {
+		pr_debug("omap_hwmod: %s: no MPU register target found\n",
+			 oh->name);
+		return 0;
+	}
+
+	va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
+	if (!va_start) {
+		pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
+		return 0;
+	}
+
+	pr_debug("omap_hwmod: %s: MPU register target at va %p\n",
+		 oh->name, va_start);
+
+	oh->_mpu_rt_va = va_start;
 
 	return 0;
 }
