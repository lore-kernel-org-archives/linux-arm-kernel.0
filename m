From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Aug 2012 18:38:36 +0900
Subject: [PATCH 14/14] drivers/spi/spi-s3c24xx.c: fix error return code
In-Reply-To: <1345365870-29831-15-git-send-email-Julia.Lawall@lip6.fr>
References: <1345365870-29831-1-git-send-email-Julia.Lawall@lip6.fr>
 <1345365870-29831-15-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1b3201cd8049$e753f720$b5fbe560$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Julia Lawall wrote:
> 
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Initialize return variable before exiting on an error path.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if at p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret at p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> 
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

(Cc'ed Mark Brown who is handling spi for a moment)

> ---
> Perhaps -EINVAL is not the right value in this case.
> 
Well, if (pin_cs < 0) is true, it is really invalid value. So I think, it
makes sense :-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

>  drivers/spi/spi-s3c24xx.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
> index 8ee7d79..a2a080b 100644
> --- a/drivers/spi/spi-s3c24xx.c
> +++ b/drivers/spi/spi-s3c24xx.c
> @@ -611,6 +611,7 @@ static int __devinit s3c24xx_spi_probe(struct
> platform_device *pdev)
>  	if (!pdata->set_cs) {
>  		if (pdata->pin_cs < 0) {
>  			dev_err(&pdev->dev, "No chipselect pin\n");
> +			err = -EINVAL;
>  			goto err_register;
>  		}
> 
