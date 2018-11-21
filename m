From: christophe.leroy@c-s.fr (Christophe LEROY)
Date: Wed, 21 Nov 2018 11:45:26 +0100
Subject: [PATCH 2/4] soc/fsl/qe: fix potential NULL pointer dereference in
 ucc_of_parse_tdm
In-Reply-To: <1542786111-18648-1-git-send-email-wen.yang99@zte.com.cn>
References: <1542786111-18648-1-git-send-email-wen.yang99@zte.com.cn>
Message-ID: <d69e7c77-e9fa-470a-db9f-ff9cd0476334@c-s.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Le 21/11/2018 ? 08:41, Wen Yang a ?crit?:
> This patch fixes a possible null pointer dereference in
> ucc_of_parse_tdm, detected by the semantic patch
> deref_null.cocci, with the following warning:
> 
> ./drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
> 
> The following code has potential null pointer references:
>          pdev = of_find_device_by_node(np2);
>          if (!pdev) {
>                  ret = -EINVAL;
>                  pr_err("%pOFn: failed to lookup pdev\n", np2);
>                  of_node_put(np2);
>                  goto err_miss_siram_property;
>          }
> ...
> err_miss_siram_property:
>          devm_iounmap(&pdev->dev, utdm->si_regs);
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> ---
>   drivers/soc/fsl/qe/qe_tdm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
> index f78c346..166378b 100644
> --- a/drivers/soc/fsl/qe/qe_tdm.c
> +++ b/drivers/soc/fsl/qe/qe_tdm.c
> @@ -174,7 +174,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>   	return ret;
>   
>   err_miss_siram_property:
> -	devm_iounmap(&pdev->dev, utdm->si_regs);
> +	if (pdev)
> +		devm_iounmap(&pdev->dev, utdm->si_regs);

You are just hiding the issue, not fixing it.

The problem is that pdev gets modified, so in any case that 
devm_iounmap() will fail even when the new pdev is valid, because the 
iomap was done with a different pdev.

Christophe



>   	return ret;
>   }
>   EXPORT_SYMBOL(ucc_of_parse_tdm);
> 
