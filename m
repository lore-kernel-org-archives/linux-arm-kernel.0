From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 23 May 2014 10:45:34 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20140523104534.467b452b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-mvebu/board-v7.c between commit 8ae2473d96f1 ("ARM: l2c:
mvebu: convert to generic l2c OF initialisation") from the arm tree and
commit 5686a1e5aa43 ("bus: mvebu: pass the coherency availability
information at init time") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-mvebu/board-v7.c
index 48169caa56ea,01cfce6ac20b..000000000000
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@@ -57,8 -75,10 +75,9 @@@ static void __init mvebu_timer_and_clk_
  {
  	of_clk_init(NULL);
  	clocksource_of_init();
+ 	mvebu_scu_enable();
  	coherency_init();
- 	BUG_ON(mvebu_mbus_dt_init());
+ 	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
 -	l2x0_of_init(0, ~0UL);
  
  	if (of_machine_is_compatible("marvell,armada375"))
  		hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
@@@ -121,9 -195,8 +196,10 @@@ static const char * const armada_375_dt
  };
  
  DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
 +	.l2c_aux_val	= 0,
 +	.l2c_aux_mask	= ~0,
  	.init_time	= mvebu_timer_and_clk_init,
+ 	.init_machine	= mvebu_dt_init,
  	.restart	= mvebu_restart,
  	.dt_compat	= armada_375_dt_compat,
  MACHINE_END
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/0f19e078/attachment.sig>
