From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Mar 2012 19:36:41 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120313193641.674b271a134d9dba201cd644@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-ux500/timer.c between commit 8eed6eac103b ("ARM: ux500:
convert to twd_local_timer_register() interface") from the arm tree and
commit b9576623c421 ("ARM: plat-nomadik: get rid of global mtu base
pointer") from the arm-soc tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-ux500/timer.c
index cadf982,fd00024..0000000
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@@ -15,38 -15,22 +15,39 @@@
  #include <mach/setup.h>
  #include <mach/hardware.h>
  
 +#ifdef CONFIG_HAVE_ARM_TWD
 +static DEFINE_TWD_LOCAL_TIMER(u5500_twd_local_timer,
 +			      U5500_TWD_BASE, IRQ_LOCALTIMER);
 +static DEFINE_TWD_LOCAL_TIMER(u8500_twd_local_timer,
 +			      U8500_TWD_BASE, IRQ_LOCALTIMER);
 +
 +static void __init ux500_twd_init(void)
 +{
 +	struct twd_local_timer *twd_local_timer;
 +	int err;
 +
 +	twd_local_timer = cpu_is_u5500() ? &u5500_twd_local_timer :
 +					   &u8500_twd_local_timer;
 +
 +	err = twd_local_timer_register(twd_local_timer);
 +	if (err)
 +		pr_err("twd_local_timer_register failed %d\n", err);
 +}
 +#else
 +#define ux500_twd_init()	do { } while(0)
 +#endif
 +
  static void __init ux500_timer_init(void)
  {
+ 	void __iomem *mtu_timer_base;
  	void __iomem *prcmu_timer_base;
 +	int err;
  
  	if (cpu_is_u5500()) {
- 		mtu_base = __io_address(U5500_MTU0_BASE);
 -#ifdef CONFIG_LOCAL_TIMERS
 -		twd_base = __io_address(U5500_TWD_BASE);
 -#endif
+ 		mtu_timer_base = __io_address(U5500_MTU0_BASE);
  		prcmu_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
  	} else if (cpu_is_u8500()) {
- 		mtu_base = __io_address(U8500_MTU0_BASE);
 -#ifdef CONFIG_LOCAL_TIMERS
 -		twd_base = __io_address(U8500_TWD_BASE);
 -#endif
+ 		mtu_timer_base = __io_address(U8500_MTU0_BASE);
  		prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
  	} else {
  		ux500_unknown_soc();
@@@ -69,9 -53,8 +70,9 @@@
  	 *
  	 */
  
- 	nmdk_timer_init();
+ 	nmdk_timer_init(mtu_timer_base);
  	clksrc_dbx500_prcmu_init(prcmu_timer_base);
 +	ux500_twd_init();
  }
  
  static void ux500_timer_reset(void)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120313/de01efab/attachment.sig>
