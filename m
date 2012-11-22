From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Nov 2012 08:57:27 +0100
Subject: [RFC] ARM: mx27: Replace clk_register_clkdev with clock DT lookup
In-Reply-To: <1353532526-12897-1-git-send-email-festevam@gmail.com>
References: <1353532526-12897-1-git-send-email-festevam@gmail.com>
Message-ID: <20121122075727.GX10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 07:15:26PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
> task for the clock devices easier.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Sascha/Shawn,
> 
> Trying the same approach from mx6/mx5 does not work on mx27.
> This patch causes the console to be messed up.
> 
> Any suggestion as to what should be different for mx27?
> 
> Thanks
> 
>  .../devicetree/bindings/clock/imx27-clock.txt      |  111 ++++++++++++++++++++
>  arch/arm/boot/dts/imx27.dtsi                       |    8 ++
>  arch/arm/mach-imx/clk-imx27.c                      |    9 ++
>  arch/arm/mach-imx/imx27-dt.c                       |    3 +-
>  4 files changed, 129 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx27-clock.txt b/Documentation/devicetree/bindings/clock/imx27-clock.txt
> new file mode 100644
> index 0000000..e874a36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx27-clock.txt
> @@ -0,0 +1,111 @@
> +* Clock bindings for Freescale i.MX27
> +
> +Required properties:
> +- compatible: Should be "fsl,imx27-ccm"
> +- reg: Address and length of the register set
> +- #clock-cells: Should be <1>
> +
> +The clock consumer should specify the desired clock by having the clock
> +ID in its "clocks" phandle cell.  The following is a full list of i.MX27
> +clocks and IDs.
> +
> +	Clock			ID
> +	---------------------------
> +	dummy			0 
> +	ckih			1
> +	ckil			2
> +	mpll			3
> +	spll			4
> +	mpll_main2		5
> +	ahb ipg			6
        ^^^^^^^

You could add the following to the clock code, this makes
generating the lists less error prone:

	for (i = 0; i < ARRAY_SIZE(clk); i++)
		pr_err("%-20s %d\n", IS_ERR(clk[i]) ? "-----" : __clk_get_name(clk[i]), i);

BTW you should base this on the imx/soc branch of the arm-soc tree.
There are some changes in the numbering in there.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
