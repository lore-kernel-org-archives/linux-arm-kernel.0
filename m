From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Sep 2014 13:17:08 -0700
Subject: [GIT PULL] omap wake-up regression fix for v3.17
In-Reply-To: <20140917145906.GA14505@atomide.com>
References: <20140917145906.GA14505@atomide.com>
Message-ID: <20140918201708.GP14505@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [140917 08:00]:
> The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:
> 
>   Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fix-v3.17-io-chain-v3
> 
> for you to fetch changes up to 7db143b89137de06ed289cf8b302f3bbbc5baa1f:
> 
>   ARM: OMAP3: Fix I/O chain clock line assertion timed out error (2014-09-16 15:09:44 -0700)
> 
> ----------------------------------------------------------------
> Regression fix for early omap3 revisions for wake-up events that
> too some time to narrow down. Although a bit intrusive, this would
> be good to get into the -rc cycle as there are quite a few boards
> out there with omap3 es2.1 and es3.0, and we have those in at least
> three boot test systems too that show errors without this patch.

This can also cause a merge conflict for linux next,
here's the merge resolution for reference.

Regards,

Tony

--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@@ -662,18 -680,13 +686,25 @@@ static int omap3xxx_prm_late_init(void
  	if (!(prm_features & PRM_HAS_IO_WAKEUP))
  		return 0;
  
 +	if (of_have_populated_dt()) {
 +		struct device_node *np;
 +		int irq_num;
 +
 +		np = of_find_matching_node(NULL, omap3_prm_dt_match_table);
 +		if (np) {
 +			irq_num = of_irq_get(np, 0);
 +			if (irq_num >= 0)
 +				omap3_prcm_irq_setup.irq = irq_num;
 +		}
 +	}
 +
+ 	if (omap3_has_io_chain_ctrl())
+ 		omap3_prcm_irq_setup.reconfigure_io_chain =
+ 			omap3_prm_reconfigure_io_chain;
+ 	else
+ 		omap3_prcm_irq_setup.reconfigure_io_chain =
+ 			omap3430_pre_es3_1_reconfigure_io_chain;
+ 
  	omap3xxx_prm_enable_io_wakeup();
  	ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
  	if (!ret)
