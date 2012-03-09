From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 9 Mar 2012 18:37:32 +1100
Subject: linux-next: manual merge of the cpuidle-cons tree with the arm-soc
 tree
Message-ID: <20120309183732.512d3676599da324f4747219@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Today's linux-next merge of the cpuidle-cons tree got a conflict in
arch/arm/mach-at91/cpuidle.c between commit 00482a4078f4 ("ARM: at91:
implement the standby function for pm/cpuidle") from the arm-soc tree and
commit 7a1f6e72dce1 ("ARM: at91: Consolidate time keeping and irq
enable") from the cpuidle-cons tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-at91/cpuidle.c
index 555d956,d40b3f3..0000000
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@@ -37,23 -33,15 +33,8 @@@ static int at91_enter_idle(struct cpuid
  			struct cpuidle_driver *drv,
  			       int index)
  {
- 	struct timeval before, after;
- 	int idle_time;
- 
- 	local_irq_disable();
- 	do_gettimeofday(&before);
- 	if (index == 0)
- 		/* Wait for interrupt state */
- 		cpu_do_idle();
- 	else if (index == 1)
- 		at91_standby();
 -	u32 saved_lpr;
 -
 -	__asm__("b 1f; .align 5; 1:\n"
 -	"	mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
 -
 -	saved_lpr = sdram_selfrefresh_enable();
 -	cpu_do_idle();
 -	sdram_selfrefresh_disable(saved_lpr);
++	at91_standby();
  
- 	do_gettimeofday(&after);
- 	local_irq_enable();
- 	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
- 			(after.tv_usec - before.tv_usec);
- 
- 	dev->last_residency = idle_time;
  	return index;
  }
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/bef900de/attachment-0001.sig>
