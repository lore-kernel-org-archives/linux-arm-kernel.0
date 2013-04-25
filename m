From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Apr 2013 14:09:22 +0100
Subject: [PATCH 04/32] dmaengine: ste_dma40: Amalgamate DMA source and
 destination channel numbers
In-Reply-To: <CACRpkdbV8yEK0470q_-DWv6Q0hAG2wGntXFi5kaLUMgm9b=e-Q@mail.gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdaauDYTdoBHGG9FO4kKqvCYyCrjY8EGWs5gAQWErGW6_A@mail.gmail.com>
 <20130425090612.GC4623@gmail.com>
 <CACRpkdbV8yEK0470q_-DWv6Q0hAG2wGntXFi5kaLUMgm9b=e-Q@mail.gmail.com>
Message-ID: <20130425130922.GE14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 02:43:16PM +0200, Linus Walleij wrote:
> So while there is no active usecase, Linux surely has the ambition to do
> that as can be seen in:
> 
> /**
>  * enum dma_transfer_direction - dma transfer mode and direction indicator
>  * @DMA_MEM_TO_MEM: Async/Memcpy mode
>  * @DMA_MEM_TO_DEV: Slave mode & From Memory to Device
>  * @DMA_DEV_TO_MEM: Slave mode & From Device to Memory
>  * @DMA_DEV_TO_DEV: Slave mode & From Device to Device
>  */
> enum dma_transfer_direction {
>         DMA_MEM_TO_MEM,
>         DMA_MEM_TO_DEV,
>         DMA_DEV_TO_MEM,
>         DMA_DEV_TO_DEV,
>         DMA_TRANS_NONE,
> };
> 
> I think we need a handshake with Vinod on this.

DEV_TO_DEV was added when the change to dma_transfer_direction happened,
to "fill in" the full pattern.

There's a problem with device to device transfers though - you have to
consider the rate at which the devices produce and consume data, and
whether they both can cope with differing data rates.

Take for instance your audio in to audio out idea - even if they are
both operating at the same bits per sample and sample rate, if they are
independently clocked, chances are that the clocks are not exactly the
same, which means you will either underrun or overrun one of the FIFOs
in the system.
