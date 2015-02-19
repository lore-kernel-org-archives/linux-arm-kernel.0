From: daniel@zonque.org (Daniel Mack)
Date: Thu, 19 Feb 2015 11:29:26 +0100
Subject: [PATCH v2 1/2] dma: mmp_dma: add support for legacy transition
In-Reply-To: <1424205547-15429-1-git-send-email-robert.jarzmik@free.fr>
References: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
 <1424205547-15429-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <54E5BB06.6000106@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

Thanks for pushing this topic :)

On 02/17/2015 09:39 PM, Robert Jarzmik wrote:
> In order to achieve smooth transition of pxa drivers from old legacy dma
> handling to new dmaengine, introduce a function to "hide" dma physical
> channels from dmaengine.
> 
> This is temporary situation where pxa dma will be handled in 2 places :
>  - arch/arm/plat-pxa/dma.c
>  - drivers/dma/mmp_pdma.c
> 
> The resources, ie. dma channels, will be controlled by mmp_dma. The
> legacy code will request or release a channel with
> mmp_pdma_toggle_reserved_channel().
> 
> This is not very pretty, but it ensures both legacy and dmaengine
> consumers can live in the same kernel until the conversion is done.

I like the approach. I actually thought the legacy DMA driver would
claim the io port range, which would have made the two drivers mutually
exclusive. But it doesn't, so this can in fact work, even though it's
really not pretty. Also, it's limited to one single instance of the
mmp-pdma driver, but that reflects reality, so I'm fine.

One minor nit:

> +int mmp_pdma_toggle_reserved_channel(int legacy_channel)
> +{
> +	if (legacy_unavailable & (1 << legacy_channel))
> +		return -EBUSY;
> +	legacy_reserved ^= 1 << legacy_channel;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mmp_pdma_toggle_reserved_channel);

My concern is that if pxa_request_dma() is called more than once for
whatever reason by a legacy implementation, the toggled bit mask might
get out of sync. As we know exactly on the caller site what we want to
achieve, let's make the API explicit with something like:

int mmp_pdma_set_reserved_channel(int legacy_channel, bool reserved)


Thanks,
Daniel
