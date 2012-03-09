From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Mar 2012 08:23:50 +0100
Subject: linux-next: manual merge of the arm-soc tree with the sound tree
In-Reply-To: <20120309180647.a27cc03a8997f9b38eb8ad0e@canb.auug.org.au>
References: <20120309180647.a27cc03a8997f9b38eb8ad0e@canb.auug.org.au>
Message-ID: <20120309072350.GV3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 06:06:47PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got conflicts in
> arch/arm/mach-imx/mm-imx3.c and arch/arm/mach-imx/mm-imx5.c between
> commit 3bc34a614335 ("ARM: imx: convert audmux to a platform driver")
> from the sound tree and commits 38bb3630bcba ("ARM: mx35: Setup the AIPS
> registers") and aa6a9fa1f274 ("ARM: mx5: Use common function for
> configuring AIPS") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.

Looks good, thanks

Sascha


> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc arch/arm/mach-imx/mm-imx3.c
> index 9c9b7f9,1646991..0000000
> --- a/arch/arm/mach-imx/mm-imx3.c
> +++ b/arch/arm/mach-imx/mm-imx3.c
> @@@ -177,8 -175,9 +179,12 @@@ void __init imx31_soc_init(void
>   	}
>   
>   	imx_add_imx_sdma("imx31-sdma", MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
> + 
> + 	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS1_BASE_ADDR));
> + 	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS2_BASE_ADDR));
> ++
>  +	platform_device_register_simple("imx31-audmux", 0, imx31_audmux_res,
>  +					ARRAY_SIZE(imx31_audmux_res));
>   }
>   #endif /* ifdef CONFIG_SOC_IMX31 */
>   
> @@@ -267,8 -262,9 +273,13 @@@ void __init imx35_soc_init(void
>   	}
>   
>   	imx_add_imx_sdma("imx35-sdma", MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
> + 
> + 	/* Setup AIPS registers */
> + 	imx_set_aips(MX35_IO_ADDRESS(MX35_AIPS1_BASE_ADDR));
> + 	imx_set_aips(MX35_IO_ADDRESS(MX35_AIPS2_BASE_ADDR));
> ++
>  +	/* i.mx35 has the i.mx31 type audmux */
>  +	platform_device_register_simple("imx31-audmux", 0, imx35_audmux_res,
>  +					ARRAY_SIZE(imx35_audmux_res));
>   }
>   #endif /* ifdef CONFIG_SOC_IMX35 */
> diff --cc arch/arm/mach-imx/mm-imx5.c
> index dc7c4ed,92efece..0000000
> --- a/arch/arm/mach-imx/mm-imx5.c
> +++ b/arch/arm/mach-imx/mm-imx5.c
> @@@ -201,9 -185,10 +201,14 @@@ void __init imx51_soc_init(void
>   
>   	/* i.mx51 has the i.mx35 type sdma */
>   	imx_add_imx_sdma("imx35-sdma", MX51_SDMA_BASE_ADDR, MX51_INT_SDMA, &imx51_sdma_pdata);
> + 
> + 	/* Setup AIPS registers */
> + 	imx_set_aips(MX51_IO_ADDRESS(MX51_AIPS1_BASE_ADDR));
> + 	imx_set_aips(MX51_IO_ADDRESS(MX51_AIPS2_BASE_ADDR));
> ++
>  +	/* i.mx51 has the i.mx31 type audmux */
>  +	platform_device_register_simple("imx31-audmux", 0, imx51_audmux_res,
>  +					ARRAY_SIZE(imx51_audmux_res));
>   }
>   
>   void __init imx53_soc_init(void)
> @@@ -219,7 -204,8 +224,12 @@@
>   
>   	/* i.mx53 has the i.mx35 type sdma */
>   	imx_add_imx_sdma("imx35-sdma", MX53_SDMA_BASE_ADDR, MX53_INT_SDMA, &imx53_sdma_pdata);
> + 
> + 	/* Setup AIPS registers */
> + 	imx_set_aips(MX53_IO_ADDRESS(MX53_AIPS1_BASE_ADDR));
> + 	imx_set_aips(MX53_IO_ADDRESS(MX53_AIPS2_BASE_ADDR));
> ++
>  +	/* i.mx53 has the i.mx31 type audmux */
>  +	platform_device_register_simple("imx31-audmux", 0, imx53_audmux_res,
>  +					ARRAY_SIZE(imx53_audmux_res));
>   }



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
