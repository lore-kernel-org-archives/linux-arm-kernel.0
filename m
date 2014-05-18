From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sun, 18 May 2014 22:59:36 +0200 (CEST)
Subject: [PATCH v2 2/3] [media] atmel-isi: convert the pdata from pointer
 to structure
In-Reply-To: <1395744087-5753-3-git-send-email-josh.wu@atmel.com>
References: <1395744087-5753-1-git-send-email-josh.wu@atmel.com>
 <1395744087-5753-3-git-send-email-josh.wu@atmel.com>
Message-ID: <Pine.LNX.4.64.1405182255540.23804@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

I'm still waiting for an update of Ben's patches to then also apply yours, 
but I decided to have a look at yours now to see if I find anything, that 
might be worth changing. A small note to this one below.

On Tue, 25 Mar 2014, Josh Wu wrote:

> Now the platform data is initialized by allocation of isi
> structure. In the future, we use pdata to store the dt parameters.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> v1 --> v2:
>  no change.
> 
>  drivers/media/platform/soc_camera/atmel-isi.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
> index 9d977c5..f4add0a 100644
> --- a/drivers/media/platform/soc_camera/atmel-isi.c
> +++ b/drivers/media/platform/soc_camera/atmel-isi.c

[snip]

> @@ -912,7 +912,7 @@ static int atmel_isi_probe(struct platform_device *pdev)
>  	if (IS_ERR(isi->pclk))
>  		return PTR_ERR(isi->pclk);
>  
> -	isi->pdata = pdata;
> +	memcpy(&isi->pdata, pdata, sizeof(struct isi_platform_data));

I think it'd be better to use

+	memcpy(&isi->pdata, pdata, sizeof(isi->pdata));

This way if the type of the pdata changes at any time in the future this 
line will not have to be changed. If you don't mind I can make this change 
myself, so you don't have to make a new version just for this.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
