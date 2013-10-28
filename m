From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 28 Oct 2013 15:13:10 +0100
Subject: ARM/kirkwood: v3.12-rc6: kernel BUG at mm/util.c:390!
In-Reply-To: <20131027195115.208f40f3@tom-ThinkPad-T410>
References: <20131024200730.GB17447@blackmetal.musicnaut.iki.fi>
 <20131026143617.GA14034@mudshark.cambridge.arm.com>
 <20131027195115.208f40f3@tom-ThinkPad-T410>
Message-ID: <20131028141310.GA4970@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 27, 2013 at 07:51:15PM +0800, Ming Lei wrote:
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index a685c8a..eea8806 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -577,7 +577,7 @@ void sg_miter_stop(struct sg_mapping_iter *miter)
>  		miter->__offset += miter->consumed;
>  		miter->__remaining -= miter->consumed;
>  
> -		if (miter->__flags & SG_MITER_TO_SG)
> +		if ((miter->__flags & SG_MITER_TO_SG) && !PageSlab(page))

This is what I was going to propose, but I would have used
!PageSlab(miter->page) ;-)

>  			flush_kernel_dcache_page(miter->page);

With this, a kernel with DEBUG_VM now boots on Kirkwood. 


- Simon
