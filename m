From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 8 Mar 2013 10:58:36 -0600
Subject: [PATCH V2 15/17] ARM: OMAP2+: Detect incorrectly aligned GPMC base
 address
In-Reply-To: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
References: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1362761918-8696-16-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each GPMC chip-select can be configured to map 16MB, 32MB, 64MB or 128MB
of address space. The physical base address where a chip-select starts
is also configurable and must be aligned on a boundary that is equal to
or greater than the size of the address space mapped bt the chip-select.
When enabling a GPMC chip-select, ensure that the base address is aligned
to the appropriate boundary.

Reported-by: Mark Jackson <mpfj-list@mimc.co.uk>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 6dd110e..4d662ce 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -403,11 +403,18 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	return 0;
 }
 
-static void gpmc_cs_enable_mem(int cs, u32 base, u32 size)
+static int gpmc_cs_enable_mem(int cs, u32 base, u32 size)
 {
 	u32 l;
 	u32 mask;
 
+	/*
+	 * Ensure that base address is aligned on a
+	 * boundary equal to or greater than size.
+	 */
+	if (base & (size - 1))
+		return -EINVAL;
+
 	mask = (1 << GPMC_SECTION_SHIFT) - size;
 	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
 	l &= ~0x3f;
@@ -416,6 +423,8 @@ static void gpmc_cs_enable_mem(int cs, u32 base, u32 size)
 	l |= ((mask >> GPMC_CHUNK_SHIFT) & 0x0f) << 8;
 	l |= GPMC_CONFIG7_CSVALID;
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG7, l);
+
+	return 0;
 }
 
 static void gpmc_cs_disable_mem(int cs)
@@ -526,7 +535,9 @@ static int gpmc_cs_remap(int cs, u32 base)
 	ret = gpmc_cs_insert_mem(cs, base, size);
 	if (IS_ERR_VALUE(ret))
 		return ret;
-	gpmc_cs_enable_mem(cs, base, size);
+	ret = gpmc_cs_enable_mem(cs, base, size);
+	if (IS_ERR_VALUE(ret))
+		return ret;
 
 	return 0;
 }
@@ -556,7 +567,12 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	if (r < 0)
 		goto out;
 
-	gpmc_cs_enable_mem(cs, res->start, resource_size(res));
+	r = gpmc_cs_enable_mem(cs, res->start, resource_size(res));
+	if (IS_ERR_VALUE(r)) {
+		release_resource(res);
+		goto out;
+	}
+
 	*base = res->start;
 	gpmc_cs_set_reserved(cs, 1);
 out:
-- 
1.7.10.4
