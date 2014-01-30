From: agross@codeaurora.org (Andy Gross)
Date: Thu, 30 Jan 2014 00:23:27 -0600
Subject: [Patch v3 2/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <4697306.PPWWh8UGTE@wuerfel>
References: <1390890471-14882-1-git-send-email-agross@codeaurora.org>
 <1390890471-14882-3-git-send-email-agross@codeaurora.org>
 <52E772DF.6000604@metafoo.de> <4697306.PPWWh8UGTE@wuerfel>
Message-ID: <20140130062327.GA18356@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 10:16:53AM +0100, Arnd Bergmann wrote:
> On Tuesday 28 January 2014 10:05:35 Lars-Peter Clausen wrote:
> > > +
> > > +Clients must use the format described in the dma.txt file, using a three cell
> > > +specifier for each channel.
> > > +
> > > +The three cells in order are:
> > > +  1. A phandle pointing to the DMA controller
> > > +  2. The channel number
> > > +  3. Direction of the fixed unidirectional channel
> > > +     0 - Memory to Device
> > > +     1 - Device to Memory
> > > +     2 - Device to Device
> > > +
> > 
> > Why does the direction needs to be specified in specifier? I see two
> > options, either the direction per is fixed in hardware. In that case the DMA
> > controller node should describe which channel is which direction. Or the
> > direction is not fixed in hardware and can be changed at runtime in which
> > case it should be set on a per descriptor basis.
> 
> Normally the direction is implied by dmaengine_slave_config().
> Note that neither the dma slave API nor the generic DT binding
> can actually support device-to-device transfers, since this
> normally implies using two dma-request lines rather than one.
> 
> There might be a case where the direction is required in order
> to allocate a channel, because the engine has specialized channels
> per direction, and might connect any of them to any dma request
> line. This does not seem to be the case for "bam", because
> the DMA specifier already contains a specific channel number, not
> a request line or slave ID number.

After some deliberation, I think the best solution is removing the direction
from the DT for now.  It doesn't add anything except some verification
of direction.

As for the device to device:
As I mentioned before, each bam dma node is attached to a specific peripheral
(with one exception, but lets skip over that).  The peripherals allow for more
than one execution environment to access the peripheral and attached bam.  2 bam
channels can be connected to form a unidirectional pipe from one execution
environment to another.  Once the pipe is configured, the actually transfer
resembles a cyclical dma transfer and continues until you explicitly stop it.

That functionality will come later.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
