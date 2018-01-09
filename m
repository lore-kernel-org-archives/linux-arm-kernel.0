From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 9 Jan 2018 17:22:43 +0100
Subject: [PATCH 12/12] power: reset: account for const type of
 of_device_id.data
In-Reply-To: <1514899688-27844-13-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-13-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20180109162243.g3g3daq76gr7n3xj@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 02, 2018 at 02:28:08PM +0100, Julia Lawall wrote:
> This driver creates a const structure that it stores in the data
> field of an of_device_id array.
> 
> Add const to the declaration of the location that receives a value
> from the data field to ensure that the compiler will continue to check
> that the value is not modified and remove the const-dropping cast on
> the access to the data field.
> 
> Done using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/at91-sama5d2_shdwc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -u -p a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -68,7 +68,7 @@ struct shdwc_config {
>  };
>  
>  struct shdwc {
> -	struct shdwc_config *cfg;
> +	const struct shdwc_config *cfg;
>  	void __iomem *at91_shdwc_base;
>  };
>  
> @@ -260,7 +260,7 @@ static int __init at91_shdwc_probe(struc
>  	}
>  
>  	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
> -	at91_shdwc->cfg = (struct shdwc_config *)(match->data);
> +	at91_shdwc->cfg = match->data;
>  
>  	sclk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(sclk))
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/4c51cf66/attachment.sig>
