From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 6 Jan 2012 12:03:45 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120106120345.8157a839b1c924315d728eea@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-imx/mm-imx5.c between commit 9bdd46257ab3 ("ARM: plat-mxc:
hook special idle handlers to arm_pm_idle") from the arm tree and commit
010dc8af8f28 ("ARM: mx5: use generic irq chip pm interface for pm
functions on") from the arm-soc tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/mm-imx5.c
index 65139a6,bc17dfe..0000000
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@@ -21,9 -22,27 +22,24 @@@
  #include <mach/devices-common.h>
  #include <mach/iomux-v3.h>
  
+ static struct clk *gpc_dvfs_clk;
+ 
  static void imx5_idle(void)
  {
 -	if (!need_resched()) {
 -		/* gpc clock is needed for SRPG */
 -		if (gpc_dvfs_clk == NULL) {
 -			gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
 -			if (IS_ERR(gpc_dvfs_clk))
 -				goto err0;
 -		}
 -		clk_enable(gpc_dvfs_clk);
 -		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
 -		if (tzic_enable_wake())
 -			goto err1;
 -		cpu_do_idle();
 -err1:
 -		clk_disable(gpc_dvfs_clk);
++	/* gpc clock is needed for SRPG */
++	if (gpc_dvfs_clk == NULL) {
++		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
++		if (IS_ERR(gpc_dvfs_clk))
++			goto err0;
+ 	}
++	clk_enable(gpc_dvfs_clk);
 +	mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
++	if (tzic_enable_wake())
++		goto err1;
++	cpu_do_idle();
++err1:
++	clk_disable(gpc_dvfs_clk);
+ err0:
 -	local_irq_enable();
  }
  
  /*
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120106/5097ddd7/attachment.sig>
