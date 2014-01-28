From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Jan 2014 10:16:53 +0100
Subject: [Patch v3 2/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <52E772DF.6000604@metafoo.de>
References: <1390890471-14882-1-git-send-email-agross@codeaurora.org>
 <1390890471-14882-3-git-send-email-agross@codeaurora.org>
 <52E772DF.6000604@metafoo.de>
Message-ID: <4697306.PPWWh8UGTE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 January 2014 10:05:35 Lars-Peter Clausen wrote:
> > +
> > +Clients must use the format described in the dma.txt file, using a three cell
> > +specifier for each channel.
> > +
> > +The three cells in order are:
> > +  1. A phandle pointing to the DMA controller
> > +  2. The channel number
> > +  3. Direction of the fixed unidirectional channel
> > +     0 - Memory to Device
> > +     1 - Device to Memory
> > +     2 - Device to Device
> > +
> 
> Why does the direction needs to be specified in specifier? I see two
> options, either the direction per is fixed in hardware. In that case the DMA
> controller node should describe which channel is which direction. Or the
> direction is not fixed in hardware and can be changed at runtime in which
> case it should be set on a per descriptor basis.

Normally the direction is implied by dmaengine_slave_config().
Note that neither the dma slave API nor the generic DT binding
can actually support device-to-device transfers, since this
normally implies using two dma-request lines rather than one.

There might be a case where the direction is required in order
to allocate a channel, because the engine has specialized channels
per direction, and might connect any of them to any dma request
line. This does not seem to be the case for "bam", because
the DMA specifier already contains a specific channel number, not
a request line or slave ID number.

	Arnd
