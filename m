From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 21 May 2013 10:16:21 -0400
Subject: [PATCH 6/9] arm: mvebu: move cache and mvebu-mbus
 initialization later
In-Reply-To: <1369132414-18959-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130521141621.GU31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 12:33:31PM +0200, Thomas Petazzoni wrote:
> Current, the L2 cache and the mvebu-mbus drivers are initialized at
> ->init_early() time. However, at ->init_early() time, ioremap() only
> works if a static I/O mapping has already been put in place. If it's
> not the case, it tries to do a memory allocation with kmalloc() which
> is not possible so early at this stage of the initialization.
> 
> Since we want to get rid of the static I/O mapping, we cannot
> initialize the L2 cache driver and the mvebu-mbus driver so early. So,
> we move their initialization to the ->init_time() level, which is
> slightly later (so ioremap() works properly), but sufficiently early
> to be before the call of the ->smp_prepare_cpus() hook, which creates
> an address decoding window for the BootROM, which requires the
> mvebu-mbus driver to be properly initialized.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/armada-370-xp.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

This doesn't apply when based on mvebu/cleanup because of:

  49ed97f ARM: Orion: Remove redundant init_dma_coherent_pool_size()

I tried hacking it up to put it in mvebu/soc-internal_regs for a few
rounds of testing in linux-next during review, however, I'd prefer you
rebase this on top of mvebu/cleanup.

My version ended up looking like:

---8<----
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index b9319c4..75ebf56 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -44,14 +44,11 @@ static void __init armada_370_xp_map_io(void)
 
 static void __init armada_370_xp_timer_and_clk_init(void)
 {
+	char *mbus_soc_name;
+
 	mvebu_clocks_init();
 	armada_370_xp_timer_init();
 	coherency_init();
-}
-
-static void __init armada_370_xp_init_early(void)
-{
-	char *mbus_soc_name;
 
 	/*
 	 * This initialization will be replaced by a DT-based
@@ -87,7 +84,6 @@ DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= armada_370_xp_dt_init,
 	.map_io		= armada_370_xp_map_io,
-	.init_early	= armada_370_xp_init_early,
 	.init_time	= armada_370_xp_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_xp_dt_compat,
