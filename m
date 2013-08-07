From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 7 Aug 2013 13:10:59 -0700
Subject: VM Kernel bug with CONFIG_DEBUG_VM
In-Reply-To: <CACVXFVNt5j6cJGkRJuUv-yS+wqXN+Hzx2R7jY-2DPkxsNPkdcQ@mail.gmail.com>
References: <20130807054111.GQ16694@cbox>
 <CACVXFVNt5j6cJGkRJuUv-yS+wqXN+Hzx2R7jY-2DPkxsNPkdcQ@mail.gmail.com>
Message-ID: <20130807201059.GT16694@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 03:50:42PM +0800, Ming Lei wrote:
> On Wed, Aug 7, 2013 at 1:41 PM, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > Hi all,
> >
> > I've found that booting a recent kernel (and as far back as 3.9 at
> > least) I get a kernel bug during boot with VM debugging enabled.  I
> > haven't had time to dig further into it, but wanted to check if this is
> > a known issue?
> 
> Remember Catalin introduced the flush_dcache_page() to fix
> cache incoherency problem when PIO reading from USB mass
> storage device to mapped page, so the flush should not need
> for pages not in page cache.
> 
> Care to test below patch to see if the problem can be fixed?
> 
> diff --git a/drivers/usb/host/isp1760-hcd.c b/drivers/usb/host/isp1760-hcd.c
> index 2facee5..9d47c71 100644
> --- a/drivers/usb/host/isp1760-hcd.c
> +++ b/drivers/usb/host/isp1760-hcd.c
> @@ -707,8 +707,12 @@ __acquires(priv->lock)
>  		void *ptr;
>  		for (ptr = urb->transfer_buffer;
>  		     ptr < urb->transfer_buffer + urb->transfer_buffer_length;
> -		     ptr += PAGE_SIZE)
> -			flush_dcache_page(virt_to_page(ptr));
> +		     ptr += PAGE_SIZE) {
> +			struct page *page = virt_to_page(ptr);
> +			if (PageSlab(page))
> +				break;
> +			flush_dcache_page(page);
> +		}
>  	}
> 
>  	/* complete() can reenter this HCD */
> 
Yep, that fixes it. Thanks!!

-Christoffer
