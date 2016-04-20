From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 20 Apr 2016 10:55:40 -0500
Subject: SoCFPGA with CONFIG_THUMB2_KERNEL boot error
In-Reply-To: <20160420110643.GI31470@pengutronix.de>
References: <20160419140220.GA9503@pengutronix.de>
 <20160420110643.GI31470@pengutronix.de>
Message-ID: <5717A67C.4010007@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2016 06:06 AM, Sascha Hauer wrote:
> 
> Related to this issue, does anybody have an idea why the SoCFPGA
> secondary startup code goes through hoops before jumping to
> secondary_startup? The following patch seems to work fine, anyone an
> idea what the jump through the cpu1start_addr register is good for?
> 
> Sascha
> 
> ----------------------------------8<--------------------------
> 
> diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
> index 575195b..776b960 100644
> --- a/arch/arm/mach-socfpga/core.h
> +++ b/arch/arm/mach-socfpga/core.h
> @@ -48,7 +48,7 @@ extern unsigned int socfpga_sdram_self_refresh_sz;
>  
>  extern char secondary_trampoline, secondary_trampoline_end;
>  
> -extern unsigned long socfpga_cpu1start_addr;
> +extern unsigned long socfpga_boot_fn;
>  
>  #define SOCFPGA_SCU_VIRT_BASE   0xfee00000
>  
> diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
> index 5d94b7a..e486670 100644
> --- a/arch/arm/mach-socfpga/headsmp.S
> +++ b/arch/arm/mach-socfpga/headsmp.S
> @@ -9,27 +9,14 @@
>   */
>  #include <linux/linkage.h>
>  #include <linux/init.h>
> -#include <asm/memory.h>
> -#include <asm/assembler.h>
>  
> -	.arch	armv7-a
> +	.arm
>  
>  ENTRY(secondary_trampoline)
> -	/* CPU1 will always fetch from 0x0 when it is brought out of reset.
> -	 * Thus, we can just subtract the PAGE_OFFSET to get the physical
> -	 * address of &cpu1start_addr. This would not work for platforms
> -	 * where the physical memory does not start at 0x0.
> -	*/
> -ARM_BE8(setend	be)
> -	adr	r0, 1f
> -	ldmia	r0, {r1, r2}
> -	sub	r2, r2, #PAGE_OFFSET
> -	ldr	r3, [r2]
> -	ldr	r4, [r3]
> -ARM_BE8(rev	r4, r4)
> -	bx	r4
> +	ldr	pc, 1f
> +ENDPROC(secondary_trampoline)
> +	.globl	socfpga_boot_fn
> +socfpga_boot_fn:
> +1:	.space	4
>  
> -	.align
> -1:	.long	.
> -	.long	socfpga_cpu1start_addr
>  ENTRY(secondary_trampoline_end)
> diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
> index 0794574..f278351 100644
> --- a/arch/arm/mach-socfpga/platsmp.c
> +++ b/arch/arm/mach-socfpga/platsmp.c
> @@ -33,15 +33,14 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
>  
> -	if (socfpga_cpu1start_addr) {
> +	if (1) {
>  		/* This will put CPU #1 into reset. */
>  		writel(RSTMGR_MPUMODRST_CPU1,
>  		       rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
>  
> -		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
> +		socfpga_boot_fn = virt_to_phys(secondary_startup);
>  
> -		writel(virt_to_phys(secondary_startup),
> -		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x000000ff));
> +		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
>  
>  		flush_cache_all();
>  		smp_wmb();
> @@ -58,13 +57,13 @@ static int socfpga_a10_boot_secondary(unsigned int cpu, struct task_struct *idle
>  {
>  	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
>  
> -	if (socfpga_cpu1start_addr) {
> +	if (1) {
>  		writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr +
>  		       SOCFPGA_A10_RSTMGR_MODMPURST);
> -		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
>  
> -		writel(virt_to_phys(secondary_startup),
> -		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x00000fff));
> +		socfpga_boot_fn = virt_to_phys(secondary_startup);
> +
> +		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
>  
>  		flush_cache_all();
>  		smp_wmb();
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index 7e0aad2..5d7079a 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -30,7 +30,6 @@
>  void __iomem *sys_manager_base_addr;
>  void __iomem *rst_manager_base_addr;
>  void __iomem *sdr_ctl_base_addr;
> -unsigned long socfpga_cpu1start_addr;
>  
>  void __init socfpga_sysmgr_init(void)
>  {
> @@ -38,14 +37,6 @@ void __init socfpga_sysmgr_init(void)
>  
>  	np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
>  
> -	if (of_property_read_u32(np, "cpu1-start-addr",
> -			(u32 *) &socfpga_cpu1start_addr))
> -		pr_err("SMP: Need cpu1-start-addr in device tree.\n");
> -
> -	/* Ensure that socfpga_cpu1start_addr is visible to other CPUs */
> -	smp_wmb();
> -	sync_cache_w(&socfpga_cpu1start_addr);
> -
>  	sys_manager_base_addr = of_iomap(np, 0);
>  
>  	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
> 

Your proposed patch is causing this failure during a CPU hotlpug, and
ultimately CPU1 doesn't seem to be able to comeback online at all:

# echo 0 > /sys/devices/system/cpu/cpu1/online
[   53.664085] CPU1: shutdown
# echo 1 > /sys/devices/system/cpu/cpu1/online

[   60.394169] Unable to handle kernel paging request at virtual address
c0118668
[   60.401394] pgd = ef63c000
[   60.404097] [c0118668] *pgd=0001141e(bad)
[   60.408126] Internal error: Oops: 80d [#1] SMP ARM
[   60.412904] Modules linked in:
[   60.415969] CPU: 0 PID: 672 Comm: sh Tainted: G        W
4.6.0-rc4-next-20160420-00001-g56ca101 #1
[   60.425421] Hardware name: Altera SOCFPGA
[   60.429422] task: eececfc0 ti: ef696000 task.ti: ef696000
[   60.434818] PC is at socfpga_boot_secondary+0x44/0xa4
[   60.439859] LR is at arm_heavy_mb+0x18/0x38
[   60.444033] pc : [<c0118774>]    lr : [<c0114860>]    psr: 600f0013
[   60.444033] sp : ef697dd8  ip : 00101480  fp : 0000002b
[   60.455475] r10: c094648c  r9 : 2f189000  r8 : 00000003
[   60.460685] r7 : c0948bc8  r6 : 00000000  r5 : 00000008  r4 : c0948d68
[   60.467190] r3 : c0118668  r2 : 00000008  r1 : c0118664  r0 : c0000000
[   60.473699] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment none
[   60.480811] Control: 10c5387d  Table: 2f63c04a  DAC: 00000051
[   60.486540] Process sh (pid: 672, stack limit = 0xef696218)
[   60.492095] Stack: (0xef697dd8 to 0xef698000)
[   60.496441] 7dc0:
   c0948ba0 00000001
[   60.504601] 7de0: ef4aef40 c010cf5c ef4af2a8 00000001 00000001
c011c9bc c0907df4 c011c9d4
[   60.512760] 7e00: 00000000 c0852244 00000001 c011bc4c ffffff10
ffff0a01 ef697e54 ef9db244
[   60.520919] 7e20: 00000002 c0907e24 c0907df4 00000001 00000003
00000000 00055891 c011be48
[   60.529077] 7e40: 00000001 c0852244 2f189000 0000002b ef9db244
ef4f5c80 00000000 c011d0d8
[   60.537236] 7e60: c0949200 00000001 0000002b ef9db044 ef4f5c8c
00000002 ef697f80 c011d194
[   60.545395] 7e80: 00000002 ef9db010 c03cb6e8 c03c7448 00000000
00000002 ef9db010 c03c74d0
[   60.553555] 7ea0: ef5050d0 011c4990 ef578690 ef4f5800 ef4f5800
c03c51dc 00000002 c026f250
[   60.561714] 7ec0: c026f20c 00000000 00000000 c026e82c 00000000
00000000 c060f13c 000a9408
[   60.569873] 7ee0: ef7ef0c0 ef697f80 00000002 ef696000 000a9408
c020cbc8 00000000 00000046
[   60.578032] 7f00: 00000000 00000000 00000000 ef697f10 eed54c38
00000000 00000001 00000020
[   60.586190] 7f20: 0000000a ef4fb300 ef4fdec0 0000000a 0000000a
00000000 00000400 ef7ef0c0
[   60.594350] 7f40: ef7ef0c0 000a9408 00000002 ef697f80 00000002
c020dfc4 00060003 eee84a80
[   60.602509] 7f60: ef4fb300 00000000 00000000 ef7ef0c0 ef7ef0c0
00000002 000a9408 c020e24c
[   60.610667] 7f80: 00000000 00000000 ef7ef0c0 b6f40a78 00000002
000a9408 00000004 c01078c4
[   60.618825] 7fa0: 00000000 c0107700 b6f40a78 00000002 00000001
000a9408 00000002 00000000
[   60.626984] 7fc0: b6f40a78 00000002 000a9408 00000004 00000000
00000000 000a3074 00055891
[   60.635144] 7fe0: 00000000 bea379f4 b6eb0b77 b6ee725c 400f0010
00000001 00000000 00000000
[   60.643313] [<c0118774>] (socfpga_boot_secondary) from [<c010cf5c>]
(__cpu_up+0x90/0x134)
[   60.651479] [<c010cf5c>] (__cpu_up) from [<c011c9d4>]
(bringup_cpu+0x18/0x90)
[   60.658596] [<c011c9d4>] (bringup_cpu) from [<c011bc4c>]
(cpuhp_invoke_callback+0x44/0x158)
[   60.666930] [<c011bc4c>] (cpuhp_invoke_callback) from [<c011be48>]
(cpuhp_up_callbacks+0x2c/0xb8)
[   60.675782] [<c011be48>] (cpuhp_up_callbacks) from [<c011d0d8>]
(_cpu_up+0xa4/0xf8)
[   60.683424] [<c011d0d8>] (_cpu_up) from [<c011d194>]
(do_cpu_up+0x68/0x90)
[   60.690290] [<c011d194>] (do_cpu_up) from [<c03c7448>]
(device_online+0x64/0x88)
[   60.697676] [<c03c7448>] (device_online) from [<c03c74d0>]
(online_store+0x64/0x6c)
[   60.705319] [<c03c74d0>] (online_store) from [<c03c51dc>]
(dev_attr_store+0x18/0x24)
[   60.713057] [<c03c51dc>] (dev_attr_store) from [<c026f250>]
(sysfs_kf_write+0x44/0x48)
[   60.720962] [<c026f250>] (sysfs_kf_write) from [<c026e82c>]
(kernfs_fop_write+0xb8/0x1b4)
[   60.729125] [<c026e82c>] (kernfs_fop_write) from [<c020cbc8>]
(__vfs_write+0x2c/0xd8)
[   60.736941] [<c020cbc8>] (__vfs_write) from [<c020dfc4>]
(vfs_write+0x90/0x14c)
[   60.744239] [<c020dfc4>] (vfs_write) from [<c020e24c>]
(SyS_write+0x40/0x8c)
[   60.751273] [<c020e24c>] (SyS_write) from [<c0107700>]
(ret_fast_syscall+0x0/0x3c)
[   60.758829] Code: e3a06000 e2460440 e59fc058 e28cc440 (e583c000)
[   60.764908] ---[ end trace 9cc1d11b1965e042 ]---
