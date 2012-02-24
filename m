From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Fri, 24 Feb 2012 14:17:24 +0100
Subject: [PATCH v3] S3C24XX DMA resume regression fix
In-Reply-To: <1330087227-10450-1-git-send-email-dron0gus@gmail.com>
References: <1330087227-10450-1-git-send-email-dron0gus@gmail.com>
Message-ID: <201202241417.24652.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 24. Februar 2012, 13:40:27 schrieb Gusakov Andrey:
> s3c2410_dma_suspend suspends channels from 0 to dma_channels.
> s3c2410_dma_resume resumes channels in reverse order. So
> pointer should be decremented insted of being incremented.
> ---
>  arch/arm/plat-s3c24xx/dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
> index 57abec9..16510d5 100644
> --- a/arch/arm/plat-s3c24xx/dma.c
> +++ b/arch/arm/plat-s3c24xx/dma.c
> @@ -1249,7 +1249,7 @@ static void s3c2410_dma_resume(void)
>  	struct s3c2410_dma_chan *cp = s3c2410_chans + dma_channels - 1;
>  	int channel;
> 
> -	for (channel = dma_channels - 1; channel >= 0; cp++, channel--)
> +	for (channel = dma_channels - 1; channel >= 0; cp--, channel--)
>  		s3c2410_dma_resume_chan(cp);
>  }

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

it's interesting, that this is broken since april 2011, so I guess it's time 
to fix it :-)
