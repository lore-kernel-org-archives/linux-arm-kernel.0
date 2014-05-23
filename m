From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 23 May 2014 10:53:02 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20140523105302.50b19c91@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-vexpress/v2m.c between commit 86cb8830d957 ("ARM: l2c:
vexpress: convert to generic l2c OF initialisation") from the arm tree
and commits 3b9334ac835b ("mfd: vexpress: Convert custom func API to
regmap") and d2606f81d563 ("ARM: vexpress: Simplify SMP operations for
DT-powered system") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-vexpress/v2m.c
index b2fea70d412d,38f4f6f37770..000000000000
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@@ -369,70 -370,10 +370,9 @@@ MACHINE_START(VEXPRESS, "ARM-Versatile 
  	.init_machine	= v2m_init,
  MACHINE_END
  
- static struct map_desc v2m_rs1_io_desc __initdata = {
- 	.virtual	= V2M_PERIPH,
- 	.pfn		= __phys_to_pfn(0x1c000000),
- 	.length		= SZ_2M,
- 	.type		= MT_DEVICE,
- };
- 
- static int __init v2m_dt_scan_memory_map(unsigned long node, const char *uname,
- 		int depth, void *data)
- {
- 	const char **map = data;
- 
- 	if (strcmp(uname, "motherboard") != 0)
- 		return 0;
- 
- 	*map = of_get_flat_dt_prop(node, "arm,v2m-memory-map", NULL);
- 
- 	return 1;
- }
- 
- void __init v2m_dt_map_io(void)
- {
- 	const char *map = NULL;
- 
- 	of_scan_flat_dt(v2m_dt_scan_memory_map, &map);
- 
- 	if (map && strcmp(map, "rs1") == 0)
- 		iotable_init(&v2m_rs1_io_desc, 1);
- 	else
- 		iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
- 
- #if defined(CONFIG_SMP)
- 	vexpress_dt_smp_map_io();
- #endif
- }
- 
- void __init v2m_dt_init_early(void)
- {
- 	u32 dt_hbi;
- 
- 	vexpress_sysreg_of_early_init();
- 
- 	/* Confirm board type against DT property, if available */
- 	if (of_property_read_u32(of_allnodes, "arm,hbi", &dt_hbi) == 0) {
- 		u32 hbi = vexpress_get_hbi(VEXPRESS_SITE_MASTER);
- 
- 		if (WARN_ON(dt_hbi != hbi))
- 			pr_warning("vexpress: DT HBI (%x) is not matching "
- 					"hardware (%x)!\n", dt_hbi, hbi);
- 	}
- 
- 	versatile_sched_clock_init(vexpress_get_24mhz_clock_base(), 24000000);
- }
- 
- static const struct of_device_id v2m_dt_bus_match[] __initconst = {
- 	{ .compatible = "simple-bus", },
- 	{ .compatible = "arm,amba-bus", },
- 	{ .compatible = "arm,vexpress,config-bus", },
- 	{}
- };
- 
  static void __init v2m_dt_init(void)
  {
- 	of_platform_populate(NULL, v2m_dt_bus_match, NULL, NULL);
 -	l2x0_of_init(0x00400000, 0xfe0fffff);
+ 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
  }
  
  static const char * const v2m_dt_match[] __initconst = {
@@@ -442,11 -383,7 +382,9 @@@
  
  DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
  	.dt_compat	= v2m_dt_match,
 +	.l2c_aux_val	= 0x00400000,
 +	.l2c_aux_mask	= 0xfe0fffff,
- 	.smp		= smp_ops(vexpress_smp_ops),
+ 	.smp		= smp_ops(vexpress_smp_dt_ops),
  	.smp_init	= smp_init_ops(vexpress_smp_init_ops),
- 	.map_io		= v2m_dt_map_io,
- 	.init_early	= v2m_dt_init_early,
  	.init_machine	= v2m_dt_init,
  MACHINE_END
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/08c29dd2/attachment-0001.sig>
