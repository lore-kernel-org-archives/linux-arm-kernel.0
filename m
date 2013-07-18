From: joelf@ti.com (Joel Fernandes)
Date: Thu, 18 Jul 2013 13:57:33 -0500
Subject: [PATCH 1/3] dmaengine: add dma_get_slave_sg_limits()
In-Reply-To: <20130718170825.GZ21614@n2100.arm.linux.org.uk>
References: <1374166001-31340-1-git-send-email-joelf@ti.com>
 <1374166001-31340-2-git-send-email-joelf@ti.com>
 <20130718170825.GZ21614@n2100.arm.linux.org.uk>
Message-ID: <51E83A9D.5020008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2013 12:08 PM, Russell King - ARM Linux wrote:
> On Thu, Jul 18, 2013 at 11:46:39AM -0500, Joel Fernandes wrote:
>> The API is optionally implemented by dmaengine drivers and when
>> unimplemented will return a NULL pointer. A client driver using
>> this API provides the required dma channel, address width, and
>> burst size of the transfer. dma_get_slave_sg_limits() returns an
>> SG limits structure with the maximum number and size of SG segments
>> that the given channel can handle.
> 
> Please look at what's already in struct device:
> 
> struct device {
> ...
>         struct device_dma_parameters *dma_parms;
> ...
> };
> 
> This provides:
> 
> struct device_dma_parameters {
>         /*
>          * a low level driver may set these to teach IOMMU code about
>          * sg limitations.
>          */
>         unsigned int max_segment_size;
>         unsigned long segment_boundary_mask;
> };
> 
> Now, these are helpfully accessed via:
> 
> dma_get_max_seg_size(dev)
> dma_set_max_seg_size(dev)
> dma_get_seg_boundary(dev)
> dma_set_seg_boundary(dev, mask)
> Drivers already use these to work out how to construct the scatterlist
> before passing it to the DMA API, which means that they should also be
> used when creating a scatterlist for the DMA engine (think about it -
> you have to use the DMA API to map the buffers for the DMA engine too.)
> 
> So, we already have two properties defined on a per-device basis: the
> maximum size of a scatterlist segment, and the boundary over which any
> segment must not cross.
> 
> The former ties up with your max_seg_len() property, though arguably it
> may depend on the DMA engine access size.  The problem with implementing
> this new API though is that the subsystems (such as SCSI) which already
> use dma_get_max_seg_size() will be at odds with what is possible via the
> DMA engine.

Not very clear for this particular case, are you saying the DMAEngine
driver implementation should set the max_seg_size of its own struct dev,
and then the drivers retrieve it from the channel they are allocated?

> I strongly suggest using the infrastructure at device level and not
> implementing some private DMA engine API to convey this information.

Certainly see the value. OK with either approach. Can Vinod add to the
discussion here, and we can decide a way forward? Is it ok to use the
new CAPS API added for now so that we can keep AM33xx MMC alive?
seg_size atleast is a real regression, the number of slots limit however
is related more to MMC grabbing a lot of slots. Atleast for -rc cycle
the seg_size and MMC fixes should go in.

> As for the maximum number of scatterlist entries, really that's a bug in
> the DMA engine implementations if they can't accept arbitary lengths.
> I've created DMA engine drivers for implementations where you have to
> program each segment individually, ones which can have the current and
> next segments, as well as those which can walk a list.  Provided you get
> informed of a transfer being completed, there really is no reason for a
> DMA engine driver to limit the number of scatterlist entries that it
> will accept.

Sure, that makes sense. Can you point to such a typical example
implementation to get some ideas?

Thanks,

-Joel
