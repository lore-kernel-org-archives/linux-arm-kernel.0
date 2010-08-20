From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 Aug 2010 19:03:57 +0200
Subject: [PATCH v3] mx51_babbage: Add FEC support
In-Reply-To: <523928.5825.qm@web51004.mail.re2.yahoo.com>
References: <523928.5825.qm@web51004.mail.re2.yahoo.com>
Message-ID: <20100820170357.GL27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Aug 19, 2010 at 08:45:25AM -0700, Fabio Estevam wrote:
> Add FEC support on MX51 Babbage board.
> 
>   * The naming convention for the pad modes is MX51_PAD_<padname>__<padmode>
>   * If <padname> or <padmode> refers to a GPIO, it is named GPIO_<unit>_<num>
> @@ -105,11 +112,17 @@ typedef enum iomux_config {
>  #define MX51_PAD_EIM_A27__GPIO_2_21             IOMUX_PAD(0x45c, 0x0c8, 1, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_EB0__EIM_EB0               IOMUX_PAD(0x460, 0x0cc, 0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_EB1__EIM_EB1               IOMUX_PAD(0x464, 0x0d0, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_EIM_EB2__FEC_MDIO		IOMUX_PAD(0x468, 0x0d4, 3, 0x0,   0, MX51_PAD_CTRL_1 | PAD_CTL_PUS_22K_UP)
> +#define MX51_PAD_EIM_EB3__FEC_RDAT1		IOMUX_PAD(0x46c, 0x0d8, 3, 0x0,   0, MX51_PAD_CTRL_2)

What I meant by ordered is that all modes for a single pad go together,
like this:

#define MX51_PAD_EIM_EB1__EIM_EB1               IOMUX_PAD(0x464, 0x0d0, 0, 0x0,   0, NO_PAD_CTRL)
#define MX51_PAD_EIM_EB2__GPIO_2_22             IOMUX_PAD(0x468, 0x0d4, 1, 0x0,   0, NO_PAD_CTRL)
#define MX51_PAD_EIM_EB2__FEC_MDIO              IOMUX_PAD(0x468, 0x0d4, 3, 0x0,   0, MX51_PAD_CTRL_1 | PAD_CTL_PUS_22K_UP)
#define MX51_PAD_EIM_EB3__GPIO_2_23             IOMUX_PAD(0x46c, 0x0d8, 1, 0x0,   0, NO_PAD_CTRL)
#define MX51_PAD_EIM_EB3__FEC_RDAT1             IOMUX_PAD(0x46c, 0x0d8, 3, 0x0,   0, MX51_PAD_CTRL_2)


Sascha


>  #define MX51_PAD_EIM_EB2__GPIO_2_22             IOMUX_PAD(0x468, 0x0d4, 1, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_EB3__GPIO_2_23             IOMUX_PAD(0x46c, 0x0d8, 1, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_OE__GPIO_2_24              IOMUX_PAD(0x470, 0x0dc, 1, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_CS0__GPIO_2_25             IOMUX_PAD(0x474, 0x0e0, 1, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_CS1__GPIO_2_26             IOMUX_PAD(0x478, 0x0e4, 1, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_EIM_CS2__FEC_RDAT2		IOMUX_PAD(0x47c, 0x0e8, 3, 0x0,   0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_EIM_CS3__FEC_RDAT3		IOMUX_PAD(0x480, 0x0ec, 3, 0x0,   0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_EIM_CS4__FEC_RX_ER		IOMUX_PAD(0x484, 0x0f0, 3, 0x0,   0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_EIM_CS5__FEC_CRS		IOMUX_PAD(0x488, 0x0f4, 3, 0x0,   0, MX51_PAD_CTRL_2)
>  #define MX51_PAD_EIM_CS2__GPIO_2_27             IOMUX_PAD(0x47c, 0x0e8, 1, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_CS3__GPIO_2_28             IOMUX_PAD(0x480, 0x0ec, 1, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_EIM_CS4__GPIO_2_29             IOMUX_PAD(0x484, 0x0f0, 1, 0x0,   0, NO_PAD_CTRL)
> @@ -125,17 +138,28 @@ typedef enum iomux_config {
>  #define MX51_PAD_NANDF_WP_B__GPIO_3_7           IOMUX_PAD(0x4F4, 0x118, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_RB0__GPIO_3_8            IOMUX_PAD(0x4F8, 0x11C, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_RB1__GPIO_3_9            IOMUX_PAD(0x4FC, 0x120, 3, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_NANDF_RB2__FEC_COL		IOMUX_PAD(0x500, 0x124, 1, 0x0, 0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_NANDF_RB3__FEC_RXCLK		IOMUX_PAD(0x504, 0x128, 1, 0x0, 0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_NANDF_RB7__FEC_TDAT0		IOMUX_PAD(0x5E0, 0x138, 1, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_RB6__FEC_RDAT0		IOMUX_PAD(0x5DC, 0x134, 1, 0x0, 0, MX51_PAD_CTRL_4)
>  #define MX51_PAD_NANDF_RB2__GPIO_3_10           IOMUX_PAD(0x500, 0x124, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_RB3__GPIO_3_11           IOMUX_PAD(0x504, 0x128, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_GPIO_NAND__GPIO_3_12           IOMUX_PAD(0x514, 0x12C, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_CS0__GPIO_3_16           IOMUX_PAD(0x518, 0x130, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_CS1__GPIO_3_17           IOMUX_PAD(0x51C, 0x134, 3, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_NANDF_CS2__FEC_TX_ER		IOMUX_PAD(0x520, 0x138, 2, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_CS3__FEC_MDC		IOMUX_PAD(0x524, 0x13C, 2, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_CS4__FEC_TDAT1		IOMUX_PAD(0x528, 0x140, 2, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_CS5__FEC_TDAT2		IOMUX_PAD(0x52C, 0x144, 2, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_CS6__FEC_TDAT3		IOMUX_PAD(0x530, 0x148, 2, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_CS7__FEC_TX_EN		IOMUX_PAD(0x534, 0x14C, 1, 0x0, 0, MX51_PAD_CTRL_5)
>  #define MX51_PAD_NANDF_CS2__GPIO_3_18           IOMUX_PAD(0x520, 0x138, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_CS3__GPIO_3_19           IOMUX_PAD(0x524, 0x13C, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_CS4__GPIO_3_20           IOMUX_PAD(0x528, 0x140, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_CS5__GPIO_3_21           IOMUX_PAD(0x52C, 0x144, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_CS6__GPIO_3_22           IOMUX_PAD(0x530, 0x148, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_CS7__GPIO_3_23           IOMUX_PAD(0x534, 0x14C, 3, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_NANDF_RDY_INT__FEC_TX_CLK	IOMUX_PAD(0x538, 0x150, 1, 0x0, 0, MX51_PAD_CTRL_4)
>  #define MX51_PAD_NANDF_RDY_INT__GPIO_3_24       IOMUX_PAD(0x538, 0x150, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_D15__GPIO_3_25           IOMUX_PAD(0x53C, 0x154, 3, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_NANDF_D14__GPIO_3_26           IOMUX_PAD(0x540, 0x158, 3, 0x0,   0, NO_PAD_CTRL)
> -- 
> 1.6.0.4
> 
> 
> 
> 
>       
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
