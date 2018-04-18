From: stefan@agner.ch (Stefan Agner)
Date: Wed, 18 Apr 2018 13:41:13 +0200
Subject: [PATCH v6 1/4] clk: imx: Add CLK_IS_CRITICAL flag for busy
 divider and busy mux
In-Reply-To: <1521512644-25265-1-git-send-email-ping.bai@nxp.com>
References: <1521512644-25265-1-git-send-email-ping.bai@nxp.com>
Message-ID: <2da28adb2c0478f5303473f3be327237@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bai,

On 20.03.2018 03:24, Bai Ping wrote:
> The busy divider and busy mux is actually used by the system critical clocks,
> so add 'CLK_IS_CRITICAL' to clocks registered with these two type.

This seems that this patch breaks i.MX 6ULL. Our Colibri iMX6ULL freezes
with v4.17-rc1:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.17.0-rc1-00002-g7529efa14a7c-dirty
(ags at trochilidae) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11))
#517 SMP Wed Apr 18 11:11:07 CEST 2018
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7),
cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: Toradex Colibri iMX6ULL 512MB on
Colibri Evaluation Board V3
[    0.000000] earlycon: ec_imx6q0 at MMIO 0x02020000 (options
'115200n8')
[    0.000000] bootconsole [ec_imx6q0] enabled
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 256 MiB at 0x90000000
[    0.000000] On node 0 totalpages: 131072
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 131072 pages, LIFO batch:31
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s35084 r8192
d22260 u65536
[    0.000000] pcpu-alloc: s35084 r8192 d22260 u65536 alloc=16*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
130048
[    0.000000] Kernel command line:
mtdparts=gpmi-nand:512k(mx6ull-bcb),1536k(u-boot1)ro,1536k(u-boot2)ro,512k(u-boot-env),-(ubi)
earlycon user_debug=31 ignore_loglevel ubi.mtd=ubi root=ubi0:rootfs rw
rootfstype=ubifs ubi.fm_autoconvert=1 consoleblank=0
no_console_suspend=1 console=tty1 console=ttymxc0,115200n8
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.000000] Memory: 243904K/524288K available (8192K kernel code,
365K rwdata, 2720K rodata, 1024K init, 389K bss, 18240K reserved,
262144K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (9184 kB)
[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 366 kB)
[    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 390 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1,
Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16,
nr_cpu_ids=1
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
<freeze>

Yet need to understand what is exactly going on.

--
Stefan


> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  change from V3->v4:
>  - fix a typo in commit log
>  change from v4->v5:
>  - optimize the commit subject
>  change from v5->v6:
>  - no change
> ---
>  drivers/clk/imx/clk-busy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
> index 6df3389..9903652 100644
> --- a/drivers/clk/imx/clk-busy.c
> +++ b/drivers/clk/imx/clk-busy.c
> @@ -101,7 +101,7 @@ struct clk *imx_clk_busy_divider(const char *name,
> const char *parent_name,
>  
>  	init.name = name;
>  	init.ops = &clk_busy_divider_ops;
> -	init.flags = CLK_SET_RATE_PARENT;
> +	init.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL;
>  	init.parent_names = &parent_name;
>  	init.num_parents = 1;
>  
> @@ -175,7 +175,7 @@ struct clk *imx_clk_busy_mux(const char *name,
> void __iomem *reg, u8 shift,
>  
>  	init.name = name;
>  	init.ops = &clk_busy_mux_ops;
> -	init.flags = 0;
> +	init.flags = CLK_IS_CRITICAL;
>  	init.parent_names = parent_names;
>  	init.num_parents = num_parents;
