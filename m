From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Sep 2014 20:27:14 +0100
Subject: [PATCH 3/8] spi: sirf: enable RX_IO_DMA_INT interrupt
In-Reply-To: <1409648468-5436-4-git-send-email-Barry.Song@csr.com>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-4-git-send-email-Barry.Song@csr.com>
Message-ID: <20140904192714.GQ29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 05:01:03PM +0800, Barry Song wrote:

> in spi interrupt handler, we need check RX_IO_DMA status to ensure
> rx fifo have received the specify count data.

> if not set, the while statement in spi isr function will keep loop,
> at last, make the kernel hang.

This changelog says we must check the status in the interrupt handler
but...

>  		writel(SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN |
>  			SIRFSOC_SPI_TX_UFLOW_INT_EN |
> -			SIRFSOC_SPI_RX_OFLOW_INT_EN,
> +			SIRFSOC_SPI_RX_OFLOW_INT_EN |
> +			SIRFSOC_SPI_RX_IO_DMA_INT_EN,
>  			sspi->base + SIRFSOC_SPI_INT_EN);
>  		writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
>  			sspi->base + SIRFSOC_SPI_TX_RX_EN);

...the change is actually just unmasking a bit in the interrupt mask
register and doesn't add anything to the interrupt handler?  Looking at
the code it seems that the actual issue is that the mask register causes
the interrupt handler not to see the mask bit since the mask not only
disables the interrupt but also causes the bit not to report in the
status register. 

That makes sense so I've applied this but please try to be clear about
things like this, it's hard to review code where the changelog doesn't
clearly match the code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140904/9698c51a/attachment.sig>
