From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 8 Feb 2010 07:55:19 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1265045354.25750.52.camel@pc1117.cambridge.arm.com>
References: <20100129185434.GH19501@one-eyed-alien.net>
	<1265045354.25750.52.camel@pc1117.cambridge.arm.com>
Message-ID: <20100208065519.GE1290@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > So, let's put this in the HCD drivers and be done with it.
> 
> The patch below is what fixes the I-D cache incoherency issues on ARM. I
> don't particularly like the solution but it seems to be the only one
> available.

Really? It looks like arm should just flush the caches when mapping
executable page to the userspace.... you can't expect all the drivers
to be modified like that...

Plus it does unneccessary flushes on x86, etc...

> @@ -904,6 +906,14 @@ __acquires(priv->lock)
>  			status = 0;
>  	}
>  
> +	if (usb_pipein(urb->pipe) && usb_pipetype(urb->pipe) == PIPE_BULK) {
> +		void *ptr;
> +		for (ptr = urb->transfer_buffer;
> +		     ptr < urb->transfer_buffer + urb->transfer_buffer_length;
> +		     ptr += PAGE_SIZE)
> +			flush_dcache_page(virt_to_page(ptr));
> +	}
> +
>  	/* complete() can reenter this HCD */
>  	usb_hcd_unlink_urb_from_ep(priv_to_hcd(priv), urb);
>  	spin_unlock(&priv->lock);
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
