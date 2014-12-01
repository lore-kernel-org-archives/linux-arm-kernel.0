From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 01 Dec 2014 18:12:21 +0100
Subject: [PATCH] ARM: imx: irq: fix buggy usage of irq_data irq field
In-Reply-To: <1417451109-30276-1-git-send-email-marc.zyngier@arm.com>
References: <1417451109-30276-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417453941.4624.26.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Am Montag, den 01.12.2014, 16:25 +0000 schrieb Marc Zyngier:
> mach-imx directly references to the irq field in
> struct irq_data, and uses this to directly poke hardware register.
> 
> But irq is the *virtual* irq number, something that has nothing
> to do with the actual HW irq (stored in the hwirq field). And once
> we put the stacked domain code in action, the whole thing explodes,
> as these two values are *very* different.
> 
> Just replacing all instances of irq with hwirq fixes the issue.

I have tried this on next-20141128, but due to 
	struct irq_data *iomuxc_irq_data = irq_get_irq_data(32); /* now returns NULL */
in arch/arm/mach-imx/pm-imx6q.c it still explodes:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = 80004000
[00000008] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.18.0-rc6-next-20141128+ #8437
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
task: 808520e8 ti: 80846000 task.ti: 80846000
PC is at imx_gpc_irq_unmask+0x14/0x54
LR is at imx6q_set_lpm+0x6c/0xe0
pc : [<8001ec90>]    lr : [<8001fb6c>]    psr: 800001d3
sp : 80847ea0  ip : 8001ec90  fp : 80847eac
r10: 00000000  r9 : 80891c4c  r8 : c0818080
r7 : 00000000  r6 : 00000000  r5 : 00000078  r4 : 80892068
r3 : c0818000  r2 : 00000079  r1 : 00000020  r0 : 00000000
Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 1000404a  DAC: 00000015
Process swapper/0 (pid: 0, stack limit = 0x80846240)
Stack: (0x80847ea0 to 0x80848000)
7ea0: 80847ecc 80847eb0 8001fb6c 8001ec88 80891c94 af01e080 8083f9e8 80891c94
7ec0: 80847f54 80847ed0 807dddd0 8001fb0c c0818060 00000018 00000000 80891c4c
7ee0: 00000000 80891c4c c0818024 af6644c0 c081803c c0818020 c0818060 c0818038
7f00: c0818028 c0818034 c0818048 c0818024 c081802c c0818014 8001e3dc c081801c
7f20: 80891c4c c0818000 016e3600 00000001 af6644c0 af002740 808801e4 00200200
7f40: 00100100 00000000 80847f94 80847f58 80807710 807da4bc 80880180 00000001
7f60: 00000000 00000000 00000000 00000000 808917c0 00000001 ffffffff 80820808
7f80: 8084e480 808917c0 80847fa4 80847f98 807d57b8 80807608 80847ff4 80847fa8
7fa0: 807d1bd4 807d5794 ffffffff ffffffff 807d16d0 00000000 00000000 affff9c0
7fc0: 00000000 80820808 00000000 80891a54 8084e4fc 80820804 808531c4 1000406a
7fe0: 412fc09a 00000000 00000000 80847ff8 10008074 807d1960 00000000 00000000
Backtrace: 
[<8001ec7c>] (imx_gpc_irq_unmask) from [<8001fb6c>] (imx6q_set_lpm+0x6c/0xe0)
[<8001fb00>] (imx6q_set_lpm) from [<807dddd0>] (imx6q_clocks_init+0x3920/0x392c)
 r7:80891c94 r6:8083f9e8 r5:af01e080 r4:80891c94
[<807da4b0>] (imx6q_clocks_init) from [<80807710>] (of_clk_init+0x114/0x1a4)
 r10:00000000 r9:00100100 r8:00200200 r7:808801e4 r6:af002740 r5:af6644c0
 r4:00000001
[<808075fc>] (of_clk_init) from [<807d57b8>] (time_init+0x30/0x38)
 r10:808917c0 r9:8084e480 r8:80820808 r7:ffffffff r6:00000001 r5:808917c0
 r4:00000000
[<807d5788>] (time_init) from [<807d1bd4>] (start_kernel+0x280/0x3dc)
[<807d1954>] (start_kernel) from [<10008074>] (0x10008074)
 r10:00000000 r9:412fc09a r8:1000406a r7:808531c4 r6:80820804 r5:8084e4fc
 r4:80891a54
Code: e92dd800 e24cb004 e52de004 ebffdbbb (e5903008) 
---[ end trace cb88537fdc8fa200 ]---

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-imx/gpc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index 82ea74e..1455829 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -56,14 +56,14 @@ void imx_gpc_post_resume(void)
>  
>  static int imx_gpc_irq_set_wake(struct irq_data *d, unsigned int on)
>  {
> -	unsigned int idx = d->irq / 32 - 1;
> +	unsigned int idx = d->hwirq / 32 - 1;
>  	u32 mask;
>  
>  	/* Sanity check for SPI irq */
> -	if (d->irq < 32)
> +	if (d->hwirq < 32)
>  		return -EINVAL;
>  
> -	mask = 1 << d->irq % 32;
> +	mask = 1 << d->hwirq % 32;
>  	gpc_wake_irqs[idx] = on ? gpc_wake_irqs[idx] | mask :
>  				  gpc_wake_irqs[idx] & ~mask;
>  
> @@ -97,12 +97,12 @@ void imx_gpc_irq_unmask(struct irq_data *d)
>  	u32 val;
>  
>  	/* Sanity check for SPI irq */
> -	if (d->irq < 32)
> +	if (d->hwirq < 32)
>  		return;
>  
> -	reg = gpc_base + GPC_IMR1 + (d->irq / 32 - 1) * 4;
> +	reg = gpc_base + GPC_IMR1 + (d->hwirq / 32 - 1) * 4;
>  	val = readl_relaxed(reg);
> -	val &= ~(1 << d->irq % 32);
> +	val &= ~(1 << d->hwirq % 32);
>  	writel_relaxed(val, reg);
>  }
>  
> @@ -112,12 +112,12 @@ void imx_gpc_irq_mask(struct irq_data *d)
>  	u32 val;
>  
>  	/* Sanity check for SPI irq */
> -	if (d->irq < 32)
> +	if (d->hwirq < 32)
>  		return;
>  
> -	reg = gpc_base + GPC_IMR1 + (d->irq / 32 - 1) * 4;
> +	reg = gpc_base + GPC_IMR1 + (d->hwirq / 32 - 1) * 4;
>  	val = readl_relaxed(reg);
> -	val |= 1 << (d->irq % 32);
> +	val |= 1 << (d->hwirq % 32);
>  	writel_relaxed(val, reg);
>  }
>  
