From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 15 Jul 2016 20:32:24 +0900
Subject: [PATCH 5/8] uio: fix dmem_region_start computation
In-Reply-To: <1468573443-4670-6-git-send-email-anup.patel@broadcom.com>
References: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
 <1468573443-4670-6-git-send-email-anup.patel@broadcom.com>
Message-ID: <20160715113224.GA26029@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 02:34:00PM +0530, Anup Patel wrote:
> From: Jan Viktorin <viktorin@rehivetech.com>
> 
> The variable i contains a total number of resources (including
> IORESOURCE_IRQ). However, we want the dmem_region_start to point
> after the last resource of type IORESOURCE_MEM. The original behaviour
> leads (very likely) to skipping several UIO mapping regions and makes
> them useless. Fix this by computing dmem_region_start from the uiomem
> which points to the last used UIO mapping.
> 
> Fixes: 0a0c3b5a24bd ("Add new uio device for dynamic memory allocation")
> 
> Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
> ---
>  drivers/uio/uio_dmem_genirq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why isn't this patch first in the series, with a stable marking, and
your signed off on it (you are forwarding it on to me, so you need to
add your mark to it as well, I can't take it otherwise.)

> diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
> index 915facb..e1134a4 100644
> --- a/drivers/uio/uio_dmem_genirq.c
> +++ b/drivers/uio/uio_dmem_genirq.c
> @@ -229,7 +229,7 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
>  		++uiomem;
>  	}
>  
> -	priv->dmem_region_start = i;
> +	priv->dmem_region_start = uiomem - &uioinfo->mem[0];

Are you sure about this?  It doesn't look correct at first glance, I'm
loath to take this without a bunch of testing.  Were you able to test
this out to verify it doesn't break working hardware?

thanks,

greg k-h
