From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Apr 2014 17:00:36 -0500
Subject: [PATCH V2 06/19] bus: omap_l3_noc: un-obfuscate l3_targ address
 computation
In-Reply-To: <1397767775-10965-7-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
 <1397767775-10965-7-git-send-email-nm@ti.com>
Message-ID: <20140417220036.GE8504@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 17, 2014 at 03:49:22PM -0500, Nishanth Menon wrote:
> just simplify derefencing that is equivalent.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> V2: just ordering change
> V1: https://patchwork.kernel.org/patch/3984201/
>  drivers/bus/omap_l3_noc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
> index c8facb0..f7d3bf4 100644
> --- a/drivers/bus/omap_l3_noc.c
> +++ b/drivers/bus/omap_l3_noc.c
> @@ -76,7 +76,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
>  			err_src = __ffs(err_reg);
>  
>  			/* Read the stderrlog_main_source from clk domain */
> -			l3_targ_base = base + *(l3_targ[i] + err_src);
> +			l3_targ_base = base + l3_targ[i][err_src];

hmmm, wasn't it so that pointer arithmetic was slightly faster than
array indexing ? In that case would it be best to:

l3_targ_base = base + *(l3_targ + i + err_src);

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140417/d8d70108/attachment-0001.sig>
