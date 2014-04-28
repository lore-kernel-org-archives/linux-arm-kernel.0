From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 28 Apr 2014 11:33:59 +1000
Subject: linux-next: manual merge of the mvebu tree with the arm tree
Message-ID: <20140428113359.95298f9a895dda6fbbb06f12@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
arch/arm/mach-mvebu/board-v7.c between commit b21770945fa2 ("ARM: l2c:
remove unnecessary UL-suffix to mask values") from the arm tree and
commit 2865b82e9e19 ("ARM: mvebu: remove unnecessary ifdef around
l2x0_of_init") from the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-mvebu/board-v7.c
index c6bd79f64744,bc0283f0dd88..000000000000
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@@ -57,11 -75,10 +75,10 @@@ static void __init mvebu_timer_and_clk_
  {
  	of_clk_init(NULL);
  	clocksource_of_init();
+ 	mvebu_scu_enable();
  	coherency_init();
- 	BUG_ON(mvebu_mbus_dt_init());
- #ifdef CONFIG_CACHE_L2X0
+ 	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
 -	l2x0_of_init(0, ~0UL);
 +	l2x0_of_init(0, ~0);
- #endif
  
  	if (of_machine_is_compatible("marvell,armada375"))
  		hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/f75916de/attachment.sig>
