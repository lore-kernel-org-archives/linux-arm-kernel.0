From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jan 2011 14:53:32 +0100
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <20110131104009.GC8948@n2100.arm.linux.org.uk>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<AANLkTi=HzzOkVmD9z=9uRdzHsaixFAfOv9BmxoY=u7uf@mail.gmail.com>
	<20110131102726.GA8948@n2100.arm.linux.org.uk>
	<AANLkTinBbXN-fxppo1Pa33DxiS6QYSdwqFsadFDxmPPy@mail.gmail.com>
	<20110131104009.GC8948@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimTbn-rQik+PvC-GyLd3HBAuGi3f8kR-T2GcvK8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 11:40 AM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

What can happen is you receive the DATAEND interrupt,
> which tears down the data side of the request, and starts the stop
> command.  Meanwhile there's still data left in the FIFO for the CPU
> to read.
>
> I suspect there's a similar race between DMA and the host CPU too as
> you leave the DATAEND interrupt on.  I suspect for reliability, we
> need to have the DMA controller callback function in place to enable
> the DATAEND interrupt.  Or something like that.
>

Yes I get it now, well, what we do is essentially create three state
variables that are all checked at end of DMA (by adding a
DMA termination callback), end of PIO or DATAEND IRQ arrival.
So a little bit like:

if (dataend && (pio_end || dma_end))
   complete;

I'll cook up some patch ASAP, just need to backport some
stuff on top of your latest MMCI patches.

Linus Walleij
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110131/8faa2c07/attachment.html>
