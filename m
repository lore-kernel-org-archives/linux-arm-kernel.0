From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Sep 2010 20:23:13 +0200
Subject: [PATCH 2/2] Adding cs89x0, standard ethernet driver for iMX31
	platform.
In-Reply-To: <1285861655-6513-2-git-send-email-ian@opensource.wolfsonmicro.com>
References: <1285861655-6513-1-git-send-email-ian@opensource.wolfsonmicro.com>
	<1285861655-6513-2-git-send-email-ian@opensource.wolfsonmicro.com>
Message-ID: <20100930182313.GT29811@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 04:47:35PM +0100, Ian Lartey wrote:
> Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
> ---
>  arch/arm/configs/mx3_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
> index 161f907..b0b3409 100644
> --- a/arch/arm/configs/mx3_defconfig
> +++ b/arch/arm/configs/mx3_defconfig
> @@ -68,6 +68,8 @@ CONFIG_NET_ETHERNET=y
>  CONFIG_SMSC911X=y
>  CONFIG_DNET=y
>  CONFIG_FEC=y
> +CONFIG_CS89x0=y
> +CONFIG_CS89x0_NONISA_IRQ=y
>  # CONFIG_NETDEV_1000 is not set
>  # CONFIG_NETDEV_10000 is not set
>  # CONFIG_INPUT is not set
This change is bad for two reasons:

 - I just tested a kernel with CONFIG_CS89x0=y on a Phytec Phycore
   pcm043 using your updated defconfig and it barfs:

	...
	cs89x0:cs89x0_probe(0x0)
	Unable to handle kernel paging request at virtual address f402030a
	pgd = c0004000
	[f402030a] *pgd=00000000
	Internal error: Oops: 5 [#1] PREEMPT
	last sysfs file: 
	Modules linked in:
	CPU: 0    Not tainted  (2.6.36-rc6-00104-g1374af3 #13)
	PC is at cs89x0_probe1+0xb4/0x6cc
	LR is at kmem_cache_alloc+0x94/0xa4
	pc : [<c00188dc>]    lr : [<c009da7c>]    psr: 60000013
	sp : c781df08  ip : c036d1cc  fp : 00000000
	r10: 00000000  r9 : 00000000  r8 : c0018670
	r7 : f4020300  r6 : f4020300  r5 : c79f2800  r4 : c79f2b20
	r3 : 00000000  r2 : 0000000a  r1 : f402030f  r0 : c79f9cc0
	Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
	Control: 00c5387d  Table: 80004008  DAC: 00000017
	Process swapper (pid: 1, stack limit = 0xc781c268)
	Stack: (0xc781df08 to 0xc781e000)
	df00:                   00000000 c781df7c c79f2803 00000002 c031f56c ffffffff
	df20: c031f56e c79f2800 3860d7ff c017daac ff0a0210 ffffffff 00000000 c781df40
	df40: ff0a0210 00000000 c79f2800 00000000 00000000 c0018670 00000000 00000000
	df60: c00224ec c79f2800 00000000 00000000 c0018670 00000000 00000000 c0018f80
	df80: 00000000 c00224b8 00000001 c0018634 c0025f2c 00000000 00000001 c0025f2c
	dfa0: 00000013 c00186f0 c001fa44 c001f9b0 c001fa44 c00243fc 00000039 00000000
	dfc0: 00000000 000000f4 c036edfc c001f9b0 c001fa44 c0025f2c 00000013 00000000
	dfe0: 00000000 c0008408 00000000 00000000 c0008370 c0025f2c fd59f476 ffdddbee
	[<c00188dc>] (cs89x0_probe1+0xb4/0x6cc) from [<c0018f80>] (cs89x0_probe+0x8c/0xe4)
	[<c0018f80>] (cs89x0_probe+0x8c/0xe4) from [<c0018634>] (probe_list2+0x34/0x70)
	[<c0018634>] (probe_list2+0x34/0x70) from [<c00186f0>] (net_olddevs_init+0x80/0xc8)
	[<c00186f0>] (net_olddevs_init+0x80/0xc8) from [<c00243fc>] (do_one_initcall+0xc4/0x190)
	[<c00243fc>] (do_one_initcall+0xc4/0x190) from [<c0008408>] (kernel_init+0x98/0x150)
	[<c0008408>] (kernel_init+0x98/0x150) from [<c0025f2c>] (kernel_thread_exit+0x0/0x8)
	Code: eb09cd60 ea000012 e3c77003 e3a0200a (e1d730ba) 
	---[ end trace feac84c64e9ed5aa ]---
	Kernel panic - not syncing: Attempted to kill init!
	[<c002a6b0>] (unwind_backtrace+0x0/0xec) from [<c028bd28>] (panic+0x60/0x18c)
	[<c028bd28>] (panic+0x60/0x18c) from [<c0040ad8>] (do_exit+0x64/0x634)
	[<c0040ad8>] (do_exit+0x64/0x634) from [<c0028bc0>] (die+0x2bc/0x2fc)
	[<c0028bc0>] (die+0x2bc/0x2fc) from [<c002b534>] (__do_kernel_fault+0x64/0x84)
	[<c002b534>] (__do_kernel_fault+0x64/0x84) from [<c002b7b0>] (do_bad_area+0x6c/0x78)
	[<c002b7b0>] (do_bad_area+0x6c/0x78) from [<c002b85c>] (do_translation_fault+0xa0/0xb0)
	[<c002b85c>] (do_translation_fault+0xa0/0xb0) from [<c00242d4>] (do_DataAbort+0x34/0x94)
	[<c00242d4>] (do_DataAbort+0x34/0x94) from [<c0024a4c>] (__dabt_svc+0x4c/0x80)
	Exception stack(0xc781dec0 to 0xc781df08)
	dec0: c79f9cc0 f402030f 0000000a 00000000 c79f2b20 c79f2800 f4020300 f4020300
	dee0: c0018670 00000000 00000000 00000000 c036d1cc c781df08 c009da7c c00188dc
	df00: 60000013 ffffffff
	[<c0024a4c>] (__dabt_svc+0x4c/0x80) from [<c00188dc>] (cs89x0_probe1+0xb4/0x6cc)
	[<c00188dc>] (cs89x0_probe1+0xb4/0x6cc) from [<c0018f80>] (cs89x0_probe+0x8c/0xe4)
	[<c0018f80>] (cs89x0_probe+0x8c/0xe4) from [<c0018634>] (probe_list2+0x34/0x70)
	[<c0018634>] (probe_list2+0x34/0x70) from [<c00186f0>] (net_olddevs_init+0x80/0xc8)
	[<c00186f0>] (net_olddevs_init+0x80/0xc8) from [<c00243fc>] (do_one_initcall+0xc4/0x190)
	[<c00243fc>] (do_one_initcall+0xc4/0x190) from [<c0008408>] (kernel_init+0x98/0x150)
	[<c0008408>] (kernel_init+0x98/0x150) from [<c0025f2c>] (kernel_thread_exit+0x0/0x8)

   (Did I already mention that this cs89x0 driver is ugly and needs a
   general overhaul?)

 - adding "CONFIG_CS89x0_NONISA_IRQ=y" is redundant as it is always on
   for MACH_MX31ADS.

So I suggest to just add CONFIG_CS89x0=m

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
