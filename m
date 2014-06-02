From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 2 Jun 2014 10:49:57 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20140602104957.21878870@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-exynos/exynos.c between commits dfbdd3d55403 ("ARM: l2c:
exynos: remove cache size override"), 25a9ef63cd2b ("ARM: l2c: exynos:
convert to common l2c310 early resume functionality") and 15b0bc4041ba
("ARM: l2c: exynos: convert to generic l2c OF initialisation (and
thereby fix it)") from the arm tree and commit b5b9324a6296 ("ARM:
exynos: don't run exynos4 l2x0 setup on other platforms") from the
arm-soc tree.

I fixed it up (the former removes the code updated by the latter) and
can carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-exynos/exynos.c
index a763c0862da9,bc43e22693b7..000000000000
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@@ -305,17 -246,25 +243,6 @@@ void __init exynos_init_io(void
  	exynos_map_io();
  }
  
- struct bus_type exynos_subsys = {
- 	.name		= "exynos-core",
- 	.dev_name	= "exynos-core",
- };
- 
- static int __init exynos_core_init(void)
 -static int __init exynos4_l2x0_cache_init(void)
--{
- 	return subsys_system_register(&exynos_subsys, NULL);
 -	int ret;
 -
 -	if (!soc_is_exynos4())
 -		return 0;
 -
 -	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
 -	if (ret)
 -		return ret;
 -
 -	if (IS_ENABLED(CONFIG_S5P_SLEEP)) {
 -		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
 -		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
 -	}
 -	return 0;
--}
- core_initcall(exynos_core_init);
 -early_initcall(exynos4_l2x0_cache_init);
--
  static void __init exynos_dt_machine_init(void)
  {
  	struct device_node *i2c_np;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140602/83e7bc5f/attachment.sig>
