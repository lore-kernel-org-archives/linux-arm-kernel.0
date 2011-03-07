From: jhnikula@gmail.com (Jarkko Nikula)
Date: Mon, 7 Mar 2011 16:30:47 +0200
Subject: [PATCH] OMAP1: McBSP: fix build break for non-multi-OMAP1 configs
In-Reply-To: <alpine.DEB.2.00.1103041535150.10981@utopia.booyaka.com>
References: <alpine.DEB.2.00.1103041535150.10981@utopia.booyaka.com>
Message-ID: <20110307163047.a65c51d2.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Mar 2011 15:36:46 -0700 (MST)
Paul Walmsley <paul@pwsan.com> wrote:

> 
> Commit 3cf32bba8ca0e0052ca41d74d455a5805b7fea85 ("OMAP: McBSP: Convert
> McBSP to platform device model") in the current omap-for-linus branch
> breaks compilation with non-multi-OMAP1 configs:
> 
>   CC      arch/arm/mach-omap1/mcbsp.o
> arch/arm/mach-omap1/mcbsp.c: In function 'omap1_mcbsp_init':
> arch/arm/mach-omap1/mcbsp.c:384: warning: dereferencing 'void *' pointer
> arch/arm/mach-omap1/mcbsp.c:387: error: invalid use of void expression
> arch/arm/mach-omap1/mcbsp.c:390: warning: dereferencing 'void *' pointer
> arch/arm/mach-omap1/mcbsp.c:393: error: invalid use of void expression
> 
> +#define omap7xx_mcbsp_res_0		omap7xx_mcbsp_res[0]
> +
...
>  	if (cpu_is_omap7xx())
> -		omap_mcbsp_register_board_cfg(omap7xx_mcbsp_res[0],
> +		omap_mcbsp_register_board_cfg(omap7xx_mcbsp_res_0,
>  					OMAP7XX_MCBSP_RES_SZ,
>  					omap7xx_mcbsp_pdata,
>  					OMAP7XX_MCBSP_COUNT);

omapxxx_mcbsp_res_0 doesn't look the best here in readability point of
view but provides the smallest fix as no need to rename array and
modify the _RES_SZ and _COUNT macros. So this fix is needed here and a
small readability update can be done later.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
