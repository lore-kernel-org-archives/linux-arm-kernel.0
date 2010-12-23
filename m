From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Dec 2010 00:10:12 +0000
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
Message-ID: <20101223001012.GF29368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 22, 2010 at 03:45:39PM -0800, Dan Williams wrote:
> 3.6 Constraints:
> 1/ Calls to async_<operation> are not permitted in IRQ context.  Other
>    contexts are permitted provided constraint #2 is not violated.

BTW, this is misleading.  Have the functions been renamed dma_async_xxx(),
eg dma_async_memcpy_buf_to_buf etc, or are you referring just to:

	async_dmaengine_get
	async_dmaengine_put
	async_dma_find_channel
	async_dma_find_channel
	async_tx_ack
	async_tx_clear_ack
	async_tx_test_ack

Beware of just renaming it to dma_async_<operation> as there's other
functions in that namespace which may not be appropriate.

Eg, is it really illegal to issue call dma_async_issue_pending() from
IRQ context?  That'd make it exceedingly difficult to use the DMA
engine with the slave API in a lot of device drivers.
