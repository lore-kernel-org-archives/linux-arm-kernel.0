From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 6 Jan 2012 12:03:17 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120106120317.500c45afe95ae20b4b6648a0@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/pm34xx.c between commit e6ab10af962d ("ARM: OMAP:
convert idle handlers from pm_idle to arm_pm_idle") from the arm tree and
commit 2fd149645eb4 ("") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/pm34xx.c
index df5c6bf,fc69875..0000000
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@@ -485,21 -416,12 +416,11 @@@ void omap_sram_idle(void
  	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
  }
  
- int omap3_can_sleep(void)
- {
- 	if (!omap_uart_can_sleep())
- 		return 0;
- 	return 1;
- }
- 
  static void omap3_pm_idle(void)
  {
 -	local_irq_disable();
  	local_fiq_disable();
  
- 	if (!omap3_can_sleep())
- 		goto out;
- 
 -	if (omap_irq_pending() || need_resched())
 +	if (omap_irq_pending())
  		goto out;
  
  	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120106/94399eca/attachment-0001.sig>
