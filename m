From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Jan 2014 08:56:56 -0200
Subject: [PATCH V2] ARM: imx: correct usecount of IPG,
 ARM and MMDC clk on i.mx6sl
In-Reply-To: <1390301452-10143-1-git-send-email-b20788@freescale.com>
References: <1390301452-10143-1-git-send-email-b20788@freescale.com>
Message-ID: <CAOMZO5DjGn+-gLvm0U2UNWju_4aoVmRFo52GN-_85FJ9wUJD9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 8:50 AM, Anson Huang <b20788@freescale.com> wrote:
> IPG, ARM and MMDC's clock should be enabled during kernel boot up,
> so we need to maintain their use count, otherwise, they may be
> disabled unexpectedly if their children's clock are turned off,
> which is not allowed.
>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6sl.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
> index 78f3bd6..047f4ff 100644
> --- a/arch/arm/mach-imx/clk-imx6sl.c
> +++ b/arch/arm/mach-imx/clk-imx6sl.c
> @@ -291,6 +291,22 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
>                 pr_warn("%s: failed to set AHB clock rate %d!\n",
>                         __func__, ret);
>
> +       /*
> +        * Make sure those always on clocks are enabled to maintain the correct
> +        * usecount and enabling/disabling of parent PLLs.
> +        */
> +       ret = clk_prepare_enable(clks[IMX6SL_CLK_IPG]);
> +       if (ret)
> +               pr_warn("%s: failed to enable IPG clock %d\n", __func__, ret);

What about adding WARN_ON(!ret ) ?

Regards,

Fabio Estevam
