From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 16 Mar 2012 17:45:46 +1100
Subject: linux-next: manual merge of the arm-soc tree with the s5p tree
Message-ID: <20120316174546.5121be30a86c2937579bd3f5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-exynos/common.c between commit 1d7233ac478a ("Merge branch
'next/soc-exynos5250-arch-gpio' into for-next") from the s5p tree and
commit 853a0231e057 ("Merge branch 'samsung/soc' into next/soc2") from
the arm-soc tree.

These merge commits both looks suspect, but I fixed it up as best I could
(see below).
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-exynos/common.c
index 4e1d0b7,e6cc50e..0000000
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@@ -593,6 -586,14 +593,13 @@@ static int __init exynos4_l2x0_cache_in
  	if (soc_is_exynos5250())
  		return 0;
  
 -	int ret;
+ 	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
+ 	if (!ret) {
+ 		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
+ 		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
+ 		return 0;
+ 	}
+ 
  	if (!(__raw_readl(S5P_VA_L2CC + L2X0_CTRL) & 0x1)) {
  		l2x0_saved_regs.phy_base = EXYNOS4_PA_L2CC;
  		/* TAG, Data Latency Control: 2 cycles */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120316/83d2ab85/attachment.sig>
