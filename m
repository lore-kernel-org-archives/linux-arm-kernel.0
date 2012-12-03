From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Dec 2012 16:57:17 +1100
Subject: linux-next: manual merge of the arm-soc tree with the devicetree tree
Message-ID: <20121203165717.c0a658649d824c9f5d5a2db3@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-vexpress/v2m.c between commit 465aac6d496a ("Fix build when
CONFIG_W1_MASTER_GPIO=m b exporting "allnodes"") from the devicetree tree
and commit 0891642cf117 ("ARM: vexpress: Start using new Versatile
Express infrastructure") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-vexpress/v2m.c
index 359f782,4e168e8..0000000
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@@ -580,20 -420,13 +420,13 @@@ void __init v2m_dt_map_io(void
  
  void __init v2m_dt_init_early(void)
  {
- 	struct device_node *node;
  	u32 dt_hbi;
  
- 	node = of_find_compatible_node(NULL, NULL, "arm,vexpress-sysreg");
- 	v2m_sysreg_base = of_iomap(node, 0);
- 	if (WARN_ON(!v2m_sysreg_base))
- 		return;
+ 	vexpress_sysreg_of_early_init();
  
  	/* Confirm board type against DT property, if available */
 -	if (of_property_read_u32(allnodes, "arm,hbi", &dt_hbi) == 0) {
 +	if (of_property_read_u32(of_allnodes, "arm,hbi", &dt_hbi) == 0) {
- 		int site = v2m_get_master_site();
- 		u32 id = readl(v2m_sysreg_base + (site == SYS_CFG_SITE_DB2 ?
- 				V2M_SYS_PROCID1 : V2M_SYS_PROCID0));
- 		u32 hbi = id & SYS_PROCIDx_HBI_MASK;
+ 		u32 hbi = vexpress_get_hbi(VEXPRESS_SITE_MASTER);
  
  		if (WARN_ON(dt_hbi != hbi))
  			pr_warning("vexpress: DT HBI (%x) is not matching "
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121203/17eeabe1/attachment.sig>
