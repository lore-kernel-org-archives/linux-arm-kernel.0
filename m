From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jun 2013 14:16:47 +0100
Subject: [PATCH 3/3] ARM: OMAP: dma: Fix the kfree ordering
In-Reply-To: <1371128960-24822-4-git-send-email-rnayak@ti.com>
References: <1371128960-24822-1-git-send-email-rnayak@ti.com>
 <1371128960-24822-4-git-send-email-rnayak@ti.com>
Message-ID: <20130613131647.GS21614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 06:39:20PM +0530, Rajendra Nayak wrote:
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 8a71f75..8e16503 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -2111,8 +2111,8 @@ exit_dma_irq_fail:
>  	}
>  
>  exit_dma_lch_fail:
> -	kfree(p);
>  	kfree(d);
> +	kfree(p);

Err.

        p = pdev->dev.platform_data;
        d                       = p->dma_attr;

Why is it kfree'ing platform data in the first place?  This means that
a failed bind can't be reattempted later.  It also means that an unbind
plus rebind in userspace will free the platform data leaving stale
pointers behind.

This is totally nonsense.  Don't kfree() data in your driver which you
haven't allocated yourself!
