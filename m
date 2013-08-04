From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 4 Aug 2013 19:11:10 +0800
Subject: [PATCH 02/25] ARM: mxs: Fix BUG() when invoking mxs_restart()
 from interrupt context
In-Reply-To: <1375279690-16893-1-git-send-email-LW@KARO-electronics.de>
References: <1375279690-16893-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20130804111108.GD18119@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 04:08:10PM +0200, Lothar Wa?mann wrote:
> The mxs_restart() function uses of_iomap() which triggers the
> following BUG_ON(in_interrupt()) when called in interrupt context
> (e.g. thru SYSRQ-B):
> 
>       SysRq : Resetting
>       ------------[ cut here ]------------
>       kernel BUG at mm/vmalloc.c:1310!
>       Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
>       Modules linked in: i2c_dev
>       CPU: 0 PID: 0 Comm: swapper Not tainted 3.11.0-rc2-next-20130729-karo+ #196
>       task: c04e1c38 ti: c04d8000 task.ti: c04d8000
>       PC is at __get_vm_area_node.clone.25+0x34/0x140
>       LR is at get_vm_area_caller+0x38/0x44
>       pc : [<c008a988>]    lr : [<c008b434>]    psr: 20000013
>       sp : c04d9db0  ip : 00000001  fp : 00000001
>       r10: c8800000  r9 : 00000000  r8 : 000000d0
>       r7 : 00002000  r6 : 00000001  r5 : 00000001  r4 : 00002000
>       r3 : 00010000  r2 : 00000001  r1 : c04d9db0  r0 : 00002000
>       Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>       Control: 0005317f  Table: 46920000  DAC: 00000017
>       Process swapper (pid: 0, stack limit = 0xc04d81b8)
> 
> Add an initcall to do the mapping beforehand.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/mach-mxs/mach-mxs.c |   35 ++++++++++++++++++++++-------------
>  1 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 1868f32..de879e3 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -451,33 +451,42 @@ static void __init mxs_machine_init(void)
>  /*
>   * Reset the system. It is called by machine_restart().
>   */
> +static void __iomem *reset_addr;
> +
>  static void mxs_restart(enum reboot_mode mode, const char *cmd)
>  {
> +	if (reset_addr) {
> +		/* reset the chip */
> +		__mxs_setl(MXS_CLKCTRL_RESET_CHIP, reset_addr);
> +
> +		pr_err("Failed to assert the chip reset\n");
> +
> +		/* Delay to allow the serial port to show the message */
> +		mdelay(50);
> +	}
> +
> +	/* We'll take a jump through zero as a poor second */
> +	soft_restart(0);
> +}
> +
> +static int mxs_restart_init(void)
> +{
>  	struct device_node *np;
> -	void __iomem *reset_addr;
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,clkctrl");
>  	reset_addr = of_iomap(np, 0);
>  	if (!reset_addr)
> -		goto soft;
> +		return -ENODEV;
>  
>  	if (of_device_is_compatible(np, "fsl,imx23-clkctrl"))
>  		reset_addr += MX23_CLKCTRL_RESET_OFFSET;
>  	else
>  		reset_addr += MX28_CLKCTRL_RESET_OFFSET;
> +	of_node_put(np);
>  
> -	/* reset the chip */
> -	__mxs_setl(MXS_CLKCTRL_RESET_CHIP, reset_addr);
> -
> -	pr_err("Failed to assert the chip reset\n");
> -
> -	/* Delay to allow the serial port to show the message */
> -	mdelay(50);
> -
> -soft:
> -	/* We'll take a jump through zero as a poor second */
> -	soft_restart(0);
> +	return 0;
>  }
> +arch_initcall(mxs_restart_init);

The mxs is part of multiplatform build now.  We should not use the
initcall like that, which will be invoked on other platforms that are
part of multiplatform kernel image.

Calling it from machine specific hook like .init_machine should be fine.

Shawn

>  
>  static void __init mxs_timer_init(void)
>  {
> -- 
> 1.7.2.5
> 
