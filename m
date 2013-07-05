From: afzal@ti.com (Afzal Mohammed)
Date: Fri, 5 Jul 2013 20:43:00 +0530
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod: rt address space index for DT
Message-ID: <4bb04ee7bcb8ca73d5fc43049ba029471b9cdda3.1373036932.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Address space is being removed from hwmod database and DT information
in <reg> property is being used. Currently the 0th index of device
address space is used to map for register target address. This is not
always true, eg. cpgmac has it's sysconfig in second address space.

Handle it by specifying index of device address space to be used for
register target. As default value of this field would be zero with
static initialization, existing behaviour of using first address space
for register target while using DT would be kept as such.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 2 +-
 arch/arm/mach-omap2/omap_hwmod.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 7341eff..7f4db12 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2386,7 +2386,7 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 
 		np = of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
 		if (np)
-			va_start = of_iomap(np, 0);
+			va_start = of_iomap(np, oh->mpu_rt_idx);
 	} else {
 		va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
 	}
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index aab33fd..29f7687 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -568,6 +568,7 @@ struct omap_hwmod_link {
  * @voltdm: pointer to voltage domain (filled in at runtime)
  * @dev_attr: arbitrary device attributes that can be passed to the driver
  * @_sysc_cache: internal-use hwmod flags
+ * @mpu_rt_idx: index of device address space for register target (for DT boot)
  * @_mpu_rt_va: cached register target start address (internal use)
  * @_mpu_port: cached MPU register target slave (internal use)
  * @opt_clks_cnt: number of @opt_clks
@@ -612,6 +613,7 @@ struct omap_hwmod {
 	struct list_head		slave_ports; /* connect to *_TA */
 	void				*dev_attr;
 	u32				_sysc_cache;
+	int				mpu_rt_idx;
 	void __iomem			*_mpu_rt_va;
 	spinlock_t			_lock;
 	struct list_head		node;
-- 
1.8.3.1
