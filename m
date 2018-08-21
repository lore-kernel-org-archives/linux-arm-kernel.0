From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Aug 2018 16:53:37 +0800
Subject: [PATCH 1/1] ARM: dts: imx6ull: keep IMX6UL_ prefix for signals
 on both i.MX6UL and i.MX6ULL
In-Reply-To: <20180720102321.23291-1-sebastien.szymanski@armadeus.com>
References: <20180720102321.23291-1-sebastien.szymanski@armadeus.com>
Message-ID: <20180821085336.GB31070@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 12:23:21PM +0200, S?bastien Szymanski wrote:
> Signals available on both i.MX6UL and i.MX6ULL should have the same name
> because it is the case of all others common signals, it avoids to make
> mistakes (use the wrong ones) and it makes writing device tree files
> less complicated. For example:
> 
> imx6ul-imx6ull-board.dtsi:
>  ...
>  pinctrl_uart5: uart5grp {
> 	fsl,pins = <
> 		MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX   0x1b0b1
> 	 	MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX   0x1b0b1
>  	 >;
>  };
> 
> imx6ul-board.dts:
>  #include <imx6ul.dtsi>
>  #include <imx6ul-imx6ull-board.dtsi>
>  ...
> 
> imx6ull-board.dts:
>  #include <imx6ull.dtsi>
>  #include <imx6ul-imx6ull-board.dtsi>
>  ...
> 
> Without this patch, the imx6ull-board.dtb will use
> MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX instead of
> MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX and the uart5 will be
> misconfigured.
> 
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  arch/arm/boot/dts/imx6ull-pinfunc.h | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
> index fdc46bb09cc1..7d7f05f7ea77 100644
> --- a/arch/arm/boot/dts/imx6ull-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
> @@ -14,14 +14,25 @@
>   * The pin function ID is a tuple of
>   * <mux_reg conf_reg input_reg mux_mode input_val>
>   */
> -#define MX6ULL_PAD_UART1_TX_DATA__UART5_DTE_RX                    0x0084 0x0310 0x0644 0x9 0x4
> -#define MX6ULL_PAD_UART1_RX_DATA__UART5_DCE_RX                    0x0088 0x0314 0x0644 0x9 0x5
> -#define MX6ULL_PAD_UART1_CTS_B__UART5_DCE_RTS                     0x008C 0x0318 0x0640 0x9 0x3
> -#define MX6ULL_PAD_UART1_RTS_B__UART5_DTE_RTS                     0x0090 0x031C 0x0640 0x9 0x4
> -#define MX6ULL_PAD_UART5_TX_DATA__UART5_DTE_RX                    0x00BC 0x0348 0x0644 0x0 0x6
> -#define MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX                    0x00C0 0x034C 0x0644 0x0 0x7
> -#define MX6ULL_PAD_ENET1_RX_EN__UART5_DCE_RTS                     0x00CC 0x0358 0x0640 0x1 0x5
> -#define MX6ULL_PAD_ENET1_TX_DATA0__UART5_DTE_RTS                  0x00D0 0x035C 0x0640 0x1 0x6
> +/* signals common for i.MX6UL and i.MX6ULL */
> +#undef MX6UL_PAD_UART1_TX_DATA__UART5_DTE_RX
> +#define MX6UL_PAD_UART1_TX_DATA__UART5_DTE_RX                    0x0084 0x0310 0x0644 0x9 0x4
> +#undef MX6UL_PAD_UART1_RX_DATA__UART5_DCE_RX
> +#define MX6UL_PAD_UART1_RX_DATA__UART5_DCE_RX                    0x0088 0x0314 0x0644 0x9 0x5
> +#undef MX6UL_PAD_UART1_CTS_B__UART5_DCE_RTS
> +#define MX6UL_PAD_UART1_CTS_B__UART5_DCE_RTS                     0x008C 0x0318 0x0640 0x9 0x3
> +#undef MX6UL_PAD_UART1_RTS_B__UART5_DTE_RTS
> +#define MX6UL_PAD_UART1_RTS_B__UART5_DTE_RTS                     0x0090 0x031C 0x0640 0x9 0x4

I do not see these 4 pinfunc in imx6ul-pinfunc.h.  Are they really
available for i.MX6UL?

Shawn

> +#undef MX6UL_PAD_UART5_TX_DATA__UART5_DTE_RX
> +#define MX6UL_PAD_UART5_TX_DATA__UART5_DTE_RX                    0x00BC 0x0348 0x0644 0x0 0x6
> +#undef MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX
> +#define MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX                    0x00C0 0x034C 0x0644 0x0 0x7
> +#undef MX6UL_PAD_ENET1_RX_EN__UART5_DCE_RTS
> +#define MX6UL_PAD_ENET1_RX_EN__UART5_DCE_RTS                     0x00CC 0x0358 0x0640 0x1 0x5
> +#undef MX6UL_PAD_ENET1_TX_DATA0__UART5_DTE_RTS
> +#define MX6UL_PAD_ENET1_TX_DATA0__UART5_DTE_RTS                  0x00D0 0x035C 0x0640 0x1 0x6
> +
> +/* signals for i.MX6ULL only */
>  #define MX6ULL_PAD_ENET2_RX_DATA0__EPDC_SDDO08                    0x00E4 0x0370 0x0000 0x9 0x0
>  #define MX6ULL_PAD_ENET2_RX_DATA1__EPDC_SDDO09                    0x00E8 0x0374 0x0000 0x9 0x0
>  #define MX6ULL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC 0x0378 0x0000 0x9 0x0
> -- 
> 2.16.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
