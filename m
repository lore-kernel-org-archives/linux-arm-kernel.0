From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Dec 2012 14:55:32 +0200
Subject: [PATCH v2] ARM: OMAP2: hwmod: Fix "register offset NULL check" bug
In-Reply-To: <1355835378-23437-1-git-send-email-gururaja.hebbar@ti.com>
References: <1355835378-23437-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20121218125338.GA31383@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 06:26:18PM +0530, Hebbar Gururaja wrote:
> From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
> 
> omap4_cminst_wait_module_ready() checks if register offset is NULL.
> 
> int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
> 				   u16 clkctrl_offs)
> {
> 	int i = 0;
> 
> 	if (!clkctrl_offs)
> 		return 0;
> 
> In case of AM33xx, CLKCTRL register offset for different clock domains
> are not uniformly placed. An example of this would be the RTC clock
> domain with CLKCTRL offset at 0x00.
> In such cases the module ready check is skipped which leads to a data
> abort during boot-up when RTC registers is accessed.
> 
> Since the actual base address is verified in
> omap4_cminst_read_inst_reg(), this check here is not required at all
> and hence can be removed.
> 
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> Changes in v2:
> 	- update commit message to reflect the actual cause. Previous
> 	message conveyed a wrong/opposite message.
> 
> :100644 100644 7f9a464... 40545ff... M	arch/arm/mach-omap2/cminst44xx.c
>  arch/arm/mach-omap2/cminst44xx.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
> index 7f9a464..40545ff 100644
> --- a/arch/arm/mach-omap2/cminst44xx.c
> +++ b/arch/arm/mach-omap2/cminst44xx.c
> @@ -271,9 +271,6 @@ int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
>  {
>  	int i = 0;
>  
> -	if (!clkctrl_offs)
> -		return 0;
> -
>  	omap_test_timeout(_is_module_ready(part, inst, cdoffs, clkctrl_offs),
>  			  MAX_MODULE_READY_TIME, i);
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121218/415e2a5c/attachment.sig>
