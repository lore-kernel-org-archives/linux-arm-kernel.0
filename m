From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 24 Apr 2013 16:54:17 +1000
Subject: linux-next: manual merge of the arm-soc tree with the pm tree
Message-ID: <20130424165417.5e2b74a01728d307e454750f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-exynos/cpuidle.c between commit 554c06ba3ee2 ("cpuidle:
remove en_core_tk_irqen flag") from the pm tree and commit 2eb89f893e44
("ARM: EXYNOS: factor out the idle states") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-exynos/cpuidle.c
index 498a7a2,e2689d1..0000000
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@@ -58,6 -46,20 +46,19 @@@ static DEFINE_PER_CPU(struct cpuidle_de
  static struct cpuidle_driver exynos4_idle_driver = {
  	.name			= "exynos4_idle",
  	.owner			= THIS_MODULE,
 -	.en_core_tk_irqen	= 1,
+ 	.states = {
+ 		[0] = ARM_CPUIDLE_WFI_STATE,
+ 		[1] = {
+ 			.enter			= exynos4_enter_lowpower,
+ 			.exit_latency		= 300,
+ 			.target_residency	= 100000,
+ 			.flags			= CPUIDLE_FLAG_TIME_VALID,
+ 			.name			= "C1",
+ 			.desc			= "ARM power down",
+ 		},
+ 	},
+ 	.state_count = 2,
+ 	.safe_state_index = 0,
  };
  
  /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130424/af841451/attachment.sig>
