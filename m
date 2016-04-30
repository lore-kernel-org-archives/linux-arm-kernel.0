From: stefan@agner.ch (Stefan Agner)
Date: Fri, 29 Apr 2016 19:04:33 -0700
Subject: [RFC PATCH 1/1] clk: imx7d: move clk setting out of
 imx7d_clocks_init
In-Reply-To: <1461923115-16563-1-git-send-email-aisheng.dong@nxp.com>
References: <alpine.DEB.2.11.1604271212290.3941@nanos>
 <1461923115-16563-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <8f51102517f264794edb4caca936b01a@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-04-29 02:45, Dong Aisheng wrote:
> During kernel early booting(e.g. in time_init()), there's only one
> init idle task running, and the idle sched class indicates that it's
> not valid to schedule for idle task. If it happens the kernel
> will complain with a error message as follows:
> [    0.000000] bad: scheduling from the idle thread!
> 
> We can observe this warning on an i.MX7D SDB board. See full log below.
> It is caused by imx7d_clocks_init function called in time_init
> invokes a lot clk_prepare_enable to enable many clocks and it happens
> that the Audio/Video PLLs need large delay causes a sleep.
> 
> Since we should not sleep during time_init, this patch fundamentally
> moves all clk_prepare_enable and clk_set_parent out of imx7d_clocks_init
> and use a postcore init function imx7d_clocks_setup to do it later instead.
> Then we simply reply on the bootloader settings to do early boot.

Is this really a good idea? What happens if something requests a clock
before postcore initcalls get called? E.g. clock source is initialized
before that, which might request a clock...

Ok, we can just say that all those clocks need to be bootloader on, but
how do we know? Do we catch if the bootloader does not adhere to that? 

--
Stefan


> 
> [    0.000000] bad: scheduling from the idle thread!
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W      
> 4.6.0-rc3-00064-gded8bc08fb45-dirty #836
> [    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [    0.000000] Backtrace:
> [    0.000000] [<c010c42c>] (dump_backtrace) from [<c010c624>]
> (show_stack+0x18/0x1c)
> [    0.000000]  r6:60000053 r5:00000000 r4:c0d21f9c r3:00000000
> [    0.000000] [<c010c60c>] (show_stack) from [<c03e0228>]
> (dump_stack+0xb4/0xe8)
> [    0.000000] [<c03e0174>] (dump_stack) from [<c0154388>]
> (dequeue_task_idle+0x20/0x30)
> [    0.000000]  r10:c08f5554 r9:c0d02b0c r8:c0d06844 r7:ef7c14d0
> r6:00000001 r5:ef7c14c0
> [    0.000000]  r4:ef7c14c0 r3:00000000
> [    0.000000] [<c0154368>] (dequeue_task_idle) from [<c014c968>]
> (deactivate_task+0x64/0x68)
> [    0.000000]  r4:c0d06500 r3:c0154368
> [    0.000000] [<c014c904>] (deactivate_task) from [<c08f50bc>]
> (__schedule+0x2e8/0x738)
> [    0.000000]  r6:c0d06500 r5:ef7c14c0 r4:c0c744c0 r3:00000002
> [    0.000000] [<c08f4dd4>] (__schedule) from [<c08f5554>] (schedule+0x48/0xa0)
> [    0.000000]  r10:000001b6 r9:00000003 r8:00000036 r7:00000000
> r6:0007a120 r5:00000000
> [    0.000000]  r4:c0d00000
> [    0.000000] [<c08f550c>] (schedule) from [<c08f9cc8>]
> (schedule_hrtimeout_range_clock+0xac/0x12c)
> [    0.000000]  r4:0006ddd0 r3:c0d06500
> [    0.000000] [<c08f9c1c>] (schedule_hrtimeout_range_clock) from
> [<c08f9d6c>] (schedule_hrtimeout_range+0x24/0x2c)
> [    0.000000]  r7:c0d5d434 r6:c0d02100 r5:ffff8ad1 r4:ef00c040
> [    0.000000] [<c08f9d48>] (schedule_hrtimeout_range) from
> [<c08f97a4>] (usleep_range+0x54/0x5c)
> [    0.000000] [<c08f9750>] (usleep_range) from [<c06984c8>]
> (clk_pllv3_wait_lock+0x7c/0xb4)
> [    0.000000] [<c069844c>] (clk_pllv3_wait_lock) from [<c069852c>]
> (clk_pllv3_prepare+0x2c/0x30)
> [    0.000000]  r6:00000000 r5:c15603f4 r4:ef007680 r3:0000201b
> [    0.000000] [<c0698500>] (clk_pllv3_prepare) from [<c0691eb8>]
> (clk_core_prepare+0x98/0xc8)
> [    0.000000] [<c0691e20>] (clk_core_prepare) from [<c06923d4>]
> (clk_prepare+0x20/0x38)
> [    0.000000]  r5:c15603f4 r4:ef00c100
> [    0.000000] [<c06923b4>] (clk_prepare) from [<c0c4a55c>]
> (imx7d_clocks_init+0x6108/0x6188)
> [    0.000000]  r4:ef00c100 r3:00000001
> [    0.000000] [<c0c44454>] (imx7d_clocks_init) from [<c0c30e38>]
> (of_clk_init+0x10c/0x1d4)
> [    0.000000]  r10:00000001 r9:c0d01f68 r8:00000000 r7:c0d01f60
> r6:ef7e3d60 r5:ef004340
> [    0.000000]  r4:00000002
> [    0.000000] [<c0c30d2c>] (of_clk_init) from [<c0c048b0>]
> (time_init+0x2c/0x38)
> [    0.000000]  r10:efffcac0 r9:c0c5ca48 r8:c0d76000 r7:c0d028c0
> r6:ffffffff r5:c0d76000
> [    0.000000]  r4:00000000
> [    0.000000] [<c0c04884>] (time_init) from [<c0c00b7c>]
> (start_kernel+0x218/0x398)
> [    0.000000] [<c0c00964>] (start_kernel) from [<8000807c>] (0x8000807c)
> [    0.000000]  r10:00000000 r9:410fc075 r8:8000406a r7:c0d07e8c
> r6:c0c5ca44 r5:c0d0296c
> [    0.000000]  r4:c0d76294
> [    0.000000] Architected cp15 timer(s) running at 8.00MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0x1d854df40, max_idle_ns: 440795202120 ns
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/clk/imx/clk-imx7d.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index 7912be83c4af..3be2e9371491 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -378,7 +378,6 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  {
>  	struct device_node *np;
>  	void __iomem *base;
> -	int i;
>  
>  	clks[IMX7D_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
>  	clks[IMX7D_OSC_24M_CLK] = of_clk_get_by_name(ccm_node, "osc");
> @@ -409,13 +408,6 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_PLL_AUDIO_MAIN_BYPASS] =
> imx_clk_mux_flags("pll_audio_main_bypass", base + 0xf0, 16, 1,
> pll_audio_bypass_sel, ARRAY_SIZE(pll_audio_bypass_sel),
> CLK_SET_RATE_PARENT);
>  	clks[IMX7D_PLL_VIDEO_MAIN_BYPASS] =
> imx_clk_mux_flags("pll_video_main_bypass", base + 0x130, 16, 1,
> pll_video_bypass_sel, ARRAY_SIZE(pll_video_bypass_sel),
> CLK_SET_RATE_PARENT);
>  
> -	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
> -	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
> -	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
> -	clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
> -	clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
> -	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
> -
>  	clks[IMX7D_PLL_ARM_MAIN_CLK] = imx_clk_gate("pll_arm_main_clk",
> "pll_arm_main_bypass", base + 0x60, 13);
>  	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk",
> "pll_dram_main_bypass", base + 0x70, 13);
>  	clks[IMX7D_PLL_SYS_MAIN_CLK] = imx_clk_gate("pll_sys_main_clk",
> "pll_sys_main_bypass", base + 0xb0, 13);
> @@ -846,6 +838,13 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clk_data.clk_num = ARRAY_SIZE(clks);
>  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>  
> +}
> +CLK_OF_DECLARE(imx7d, "fsl,imx7d-ccm", imx7d_clocks_init);
> +
> +static int __init imx7d_clocks_setup(void)
> +{
> +	int i;
> +
>  	/* TO BE FIXED LATER
>  	 * Enable all clock to bring up imx7, otherwise system will be halt and block
>  	 * the other part upstream Because imx7d clock design changed, clock framework
> @@ -855,6 +854,13 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	for (i = 0; i < IMX7D_CLK_END; i++)
>  		clk_prepare_enable(clks[i]);
>  
> +	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
> +	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
> +	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
> +	clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
> +	clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
> +	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
> +
>  	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter freq */
>  	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
>  
> @@ -874,5 +880,6 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  
>  	imx_register_uart_clocks(uart_clks);
>  
> +	return 0;
>  }
> -CLK_OF_DECLARE(imx7d, "fsl,imx7d-ccm", imx7d_clocks_init);
> +postcore_initcall(imx7d_clocks_setup);
