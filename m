From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 5 Jun 2012 12:29:12 +0200
Subject: [PATCH 2/2] ARM i.MX5: Hard reset the IPU during startup
In-Reply-To: <1338888630-25930-3-git-send-email-s.hauer@pengutronix.de>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
 <1338888630-25930-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20429.57208.228315.164637@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer writes:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/mm-imx5.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
> index a4cb441..3b028ef 100644
> --- a/arch/arm/mach-imx/mm-imx5.c
> +++ b/arch/arm/mach-imx/mm-imx5.c
> @@ -214,6 +214,15 @@ static void __init imx51_ipu_mipi_setup(void)
>  		hsc_addr + 0x800);
>  }
>  
> +static void __init imx51_ipu_hardreset(void)
> +{
> +	u32 val;
> +
> +	val = readl(MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
> +	val |= 1 << 3;
> +	writel(val, MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
> +}
> +
>  void __init imx51_soc_init(void)
>  {
>  	/* i.mx51 has the i.mx31 type gpio */
> @@ -233,6 +242,16 @@ void __init imx51_soc_init(void)
>  	platform_device_register_simple("imx31-audmux", 0, imx51_audmux_res,
>  					ARRAY_SIZE(imx51_audmux_res));
>  	imx51_ipu_mipi_setup();
> +	imx51_ipu_hardreset();
> +}
> +
> +static void __init imx53_ipu_hardreset(void)
> +{
> +	u32 val;
> +
> +	val = readl(MX53_IO_ADDRESS(MX53_SRC_BASE_ADDR));
> +	val |= 1 << 3;
> +	writel(val, MX53_IO_ADDRESS(MX53_SRC_BASE_ADDR));
>  }
>  
>  void __init imx53_soc_init(void)
> @@ -257,6 +276,7 @@ void __init imx53_soc_init(void)
>  	/* i.mx53 has the i.mx31 type audmux */
>  	platform_device_register_simple("imx31-audmux", 0, imx53_audmux_res,
>  					ARRAY_SIZE(imx53_audmux_res));
> +	imx53_ipu_hardreset();
>  }
>  
>  void __init imx51_init_late(void)
>
How would you implement a seamless transition from a boot logo to the
application display when resetting the IPU during startup?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
