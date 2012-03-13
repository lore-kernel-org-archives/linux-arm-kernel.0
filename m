From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Mar 2012 19:42:43 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120313194243.4b330327115d48b34bc556c4@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-vexpress/ct-ca9x4.c between commit e9f07fbc5f5b ("ARM:
plat-versatile: convert to twd_local_timer_register() interface") from
the arm tree and commit 98ed4ceb93ba ("ARM: vexpress: Get rid of
MMIO_P2V") from the arm-soc tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-vexpress/ct-ca9x4.c
index b391538,73791f0..0000000
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@@ -54,44 -42,17 +42,28 @@@ static struct map_desc ct_ca9x4_io_desc
  static void __init ct_ca9x4_map_io(void)
  {
  	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 -#ifdef CONFIG_LOCAL_TIMERS
 -	twd_base = ioremap(A9_MPCORE_TWD, SZ_32);
 -#endif
  }
  
 +#ifdef CONFIG_HAVE_ARM_TWD
 +static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, A9_MPCORE_TWD, IRQ_LOCALTIMER);
 +
 +static void __init ca9x4_twd_init(void)
 +{
 +	int err = twd_local_timer_register(&twd_local_timer);
 +	if (err)
 +		pr_err("twd_local_timer_register failed %d\n", err);
 +}
 +#else
 +#define ca9x4_twd_init()	do {} while(0)
 +#endif
 +
  static void __init ct_ca9x4_init_irq(void)
  {
- 	gic_init(0, 29, MMIO_P2V(A9_MPCORE_GIC_DIST),
- 		 MMIO_P2V(A9_MPCORE_GIC_CPU));
+ 	gic_init(0, 29, ioremap(A9_MPCORE_GIC_DIST, SZ_4K),
+ 		 ioremap(A9_MPCORE_GIC_CPU, SZ_256));
 +	ca9x4_twd_init();
  }
  
- #if 0
- static void __init ct_ca9x4_timer_init(void)
- {
- 	writel(0, MMIO_P2V(CT_CA9X4_TIMER0) + TIMER_CTRL);
- 	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
- 
- 	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1), "ct-timer1");
- 	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0,
- 		"ct-timer0");
- }
- 
- static struct sys_timer ct_ca9x4_timer = {
- 	.init	= ct_ca9x4_timer_init,
- };
- #endif
- 
  static void ct_ca9x4_clcd_enable(struct clcd_fb *fb)
  {
  	v2m_cfg_write(SYS_CFG_MUXFPGA | SYS_CFG_SITE_DB1, 0);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120313/6f4ef4c5/attachment.sig>
