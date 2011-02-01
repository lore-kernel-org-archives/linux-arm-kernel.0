From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Feb 2011 15:11:00 +0100
Subject: [PATCH] mmci: make sure DMA transfers wait for FIFO drain
In-Reply-To: <20110201110348.GB31216@n2100.arm.linux.org.uk>
References: <1296509980-29987-1-git-send-email-linus.walleij@linaro.org>
	<20110201110348.GB31216@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik=HJELkKL3v8CsxCvX4-V-Y8evVc7zhgFkQNK+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Jan 31, 2011 at 10:39:40PM +0100, Linus Walleij wrote:
>> The DMA mode also needs to wait until the FIFO is drained before
>> enabling the MCI_DATAEND IRQ.
>
> Hmm. ?This will cause attempted DMA usage on ARM MMCI primecells to get
> stuck as we'll wait for the never-delivered callback.
>
> With the code I have in place, you'll notice I have:
>
> ? ? ? ?/* Wait up to 1ms for the DMA to complete */
> ? ? ? ?for (i = 0; ; i++) {
> ? ? ? ? ? ? ? ?status = readl(host->base + MMCISTATUS);
> ? ? ? ? ? ? ? ?if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
> ? ? ? ? ? ? ? ? ? ? ? ?break;
> ? ? ? ? ? ? ? ?udelay(10);
> ? ? ? ?}
>
> This waits for the DMA controller to read the last data out of the FIFO
> before allowing the request to complete. ?As it has a timeout, it is
> able to detect ARMs broken DMA setup on their MMCI/DMAC, and disable DMA
> support for this primecell rather than getting stuck.
>
> This may be sufficient without using the DMA callbacks.

Seems like so. When I try it with the last patch to use the FIFO
for small xfers it works nicely.

So we'll drop this approach for now.

Linus Walleij
