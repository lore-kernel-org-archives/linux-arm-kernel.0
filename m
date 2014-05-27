From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 May 2014 10:45:26 +1000
Subject: linux-next: manual merge of the arm-soc tree with the  tree
Message-ID: <20140527104526.5c6f819e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/omap-mpuss-lowpower.c between commit 4e4bb5c72f6b
("ARM: l2c: omap2: avoid reading directly from the L2 registers in
platform code") from the arm tree and commit edfaf05c2fcb ("ARM:
OMAP2+: raw read and write endian fix") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 61cb77f8cf12,eb76e47091ad..000000000000
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@@ -187,15 -187,19 +187,15 @@@ static void l2x0_pwrst_prepare(unsigne
   * in every restore MPUSS OFF path.
   */
  #ifdef CONFIG_CACHE_L2X0
 -static void save_l2x0_context(void)
 +static void __init save_l2x0_context(void)
  {
- 	__raw_writel(l2x0_saved_regs.aux_ctrl,
- 		     sar_base + L2X0_AUXCTRL_OFFSET);
- 	__raw_writel(l2x0_saved_regs.prefetch_ctrl,
- 		     sar_base + L2X0_PREFETCH_CTRL_OFFSET);
 -	u32 val;
 -	void __iomem *l2x0_base = omap4_get_l2cache_base();
 -	if (l2x0_base) {
 -		val = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 -		writel_relaxed(val, sar_base + L2X0_AUXCTRL_OFFSET);
 -		val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
 -		writel_relaxed(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
 -	}
++	writel_relaxed(l2x0_saved_regs.aux_ctrl,
++		       sar_base + L2X0_AUXCTRL_OFFSET);
++	writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
++		       sar_base + L2X0_PREFETCH_CTRL_OFFSET);
  }
  #else
 -static void save_l2x0_context(void)
 +static void __init save_l2x0_context(void)
  {}
  #endif
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/3657f3b5/attachment.sig>
