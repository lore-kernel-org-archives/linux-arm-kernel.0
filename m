From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 18 Jan 2017 09:49:29 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20170118094929.7d79bb55@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/mach-ux500/platsmp.c

between commit:

  6996cbb23721 ("ARM: 8641/1: treewide: Replace uses of virt_to_phys with __pa_symbol")

from the arm tree and commit:

  9e634cae7256 ("ARM: ux500: simplify secondary boot")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-ux500/platsmp.c
index 8c8f26389067,e0ee139fdebf..000000000000
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@@ -92,7 -73,19 +73,19 @@@ static void __init ux500_smp_prepare_cp
  
  static int ux500_boot_secondary(unsigned int cpu, struct task_struct *idle)
  {
- 	wakeup_secondary();
+ 	/*
+ 	 * write the address of secondary startup into the backup ram register
+ 	 * at offset 0x1FF4, then write the magic number 0xA1FEED01 to the
+ 	 * backup ram register at offset 0x1FF0, which is what boot rom code
+ 	 * is waiting for. This will wake up the secondary core from WFE.
+ 	 */
 -	writel(virt_to_phys(secondary_startup),
++	writel(__pa_symbol(secondary_startup),
+ 	       backupram + UX500_CPU1_JUMPADDR_OFFSET);
+ 	writel(0xA1FEED01,
+ 	       backupram + UX500_CPU1_WAKEMAGIC_OFFSET);
+ 
+ 	/* make sure write buffer is drained */
+ 	mb();
  	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
  	return 0;
  }
