From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 06 Jul 2016 17:53:38 -0700
Subject: [PATCH v2] clk: imx7d: do not set parent of ethernet time/ref
 clocks
In-Reply-To: <20160703174813.13970-1-stefan@agner.ch>
References: <20160703174813.13970-1-stefan@agner.ch>
Message-ID: <146785281774.73491.10999943518898018619@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stefan Agner (2016-07-03 10:48:13)
> All device trees currently in mainline specify the time clock parent
> using the assigned-clocks/assigned-clock-parents method, there is no
> need to statically assign the parent in the core clock driver.
> Also all current boards provide an Ethernet reference clock for the
> PHY externally, hence configuring the internal PHY reference clock.
> 
> Furthermore, and the actual driver of this patch, specify ethernet
> related parents at that early point in boot leads to a warning:
> bad: scheduling from the idle thread!
> 
> The reason for the warning is that setting the parent enables the ENET
> PLL since we are using CLK_OPS_PARENT_ENABLE. Enabling the ENET PLL can
> cause clk_pllv3_wait_lock to sleep. See also:
> commit fc8726a2c021 ("clk: core: support clocks which requires parents
> enable (part 2)").
> 
> Note that setting the ENET AXI root clock parent also requires ENET
> PLL to be enabled. However, U-Boot typically leaves the ENET PLL on,
> hence when the framework sets the parent of the first clock, it does
> not need to wait for the PLL to come up. But because there is currently
> no user of that clock, the PLL gets disabled after setting the parent.
> Therefore, subsequent reparenting calls of any clock which somehow rely
> on the ENET PLL, need to reenable the ENET PLL which leads to a sleep.
> Removing those subsequent reparenting calls works around this issue.
> 
> Also remove comments. The code is really verbose enough.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied.

Regards,
Mike

> ---
> Changes since v1:
> - Also remove PHY REF clock
> 
> Hi All,
> 
> Fabio, thanks for testing v1.
> 
> With v2, the warnings should definitly be gone. However, that might
> break some boards...
> 
> What is the IMX7D_ENET_PHY_REF_ROOT_SRC clock for anyway? It sounds
> like it should provide a clock for the PHY. However, there is also
> IMX7D_ENET1_REF_ROOT_CLK and IMX7D_ENET2_REF_ROOT_CLK...
> 
> Our first design used to use a clock provided by the SoC, by muxing
> a pad to CCM_ENET1_REF_CLK and enabling IMX7D_ENET1_REF_ROOT_CLK
> it seemd to work just fine, there was no need for
> IMX7D_ENET_PHY_REF_ROOT_SRC.
> 
> Dong, can you shed some light on this?
> 
> Otherwise, in case a board does not work with that change, something
> like this should do the same using device tree. You probably would
> have to add this to all FEC instances since this seems to be a shared
> clock.
> 
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_enet1>;
>         assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
> -                         <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
> -       assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
> +                         <&clks IMX7D_ENET1_TIME_ROOT_CLK>,
> +                         <&clks IMX7D_ENET_PHY_REF_ROOT_SRC>;
> +       assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>, <0>,
> +                                <&clks IMX7D_PLL_ENET_MAIN_25M_CLK>;
>         assigned-clock-rates = <0>, <100000000>;
>         phy-mode = "rgmii";
>         phy-handle = <&ethphy0>;
> 
> --
> Stefan
> 
>  drivers/clk/imx/clk-imx7d.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index 79293ed..6ed4f8f 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -860,16 +860,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>         /* use old gpt clk setting, gpt1 root clk must be twice as gpt counter freq */
>         clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
>  
> -       /*
> -        * init enet clock source:
> -        *      AXI clock source is 250MHz
> -        *      Phy refrence clock is 25MHz
> -        *      1588 time clock source is 100MHz
> -        */
>         clk_set_parent(clks[IMX7D_ENET_AXI_ROOT_SRC], clks[IMX7D_PLL_ENET_MAIN_250M_CLK]);
> -       clk_set_parent(clks[IMX7D_ENET_PHY_REF_ROOT_SRC], clks[IMX7D_PLL_ENET_MAIN_25M_CLK]);
> -       clk_set_parent(clks[IMX7D_ENET1_TIME_ROOT_SRC], clks[IMX7D_PLL_ENET_MAIN_100M_CLK]);
> -       clk_set_parent(clks[IMX7D_ENET2_TIME_ROOT_SRC], clks[IMX7D_PLL_ENET_MAIN_100M_CLK]);
>  
>         /* set uart module clock's parent clock source that must be great then 80MHz */
>         clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
> -- 
> 2.9.0
> 
