From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 10 Nov 2016 09:33:15 -0700
Subject: [PATCH fpga 9/9] fpga: Remove support for non-sg drivers
In-Reply-To: <bad801c5-fe3a-665b-de67-bf69c42fb2b4@gmail.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-10-git-send-email-jgunthorpe@obsidianresearch.com>
 <bad801c5-fe3a-665b-de67-bf69c42fb2b4@gmail.com>
Message-ID: <20161110163315.GB22004@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  struct fpga_manager_ops {
> >  	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
> > -	int (*write_init)(struct fpga_manager *mgr, u32 flags,
> > -			  const char *buf, size_t count);
> > -	int (*write)(struct fpga_manager *mgr, const char *buf, size_t count);
> >  	int (*write_init_sg)(struct fpga_manager *mgr, u32 flags,
> >  			     struct sg_table *sgt);
> >  	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
> > @@ -118,6 +113,8 @@ struct fpga_manager {
> >  
> >  int fpga_mgr_buf_load(struct fpga_manager *mgr, u32 flags,
> >  		      const char *buf, size_t count);
> > +int fpga_mgr_buf_load_sg(struct fpga_manager *mgr, u32 flags,
> > +			 struct sg_table *sgt);
> >  
> >  int fpga_mgr_firmware_load(struct fpga_manager *mgr, u32 flags,
> >  			   const char *image_name);
> I don't have any feeling either way about switching to scatter-gather.
> (Not zynq or socfpga user)
> But I do object to renaming the API.
> write_init() and write() do not imply a particular implementation, nor even that
> the buffer is coherent.

Neither the sg or old linear interface imply any particular
underlying driver implementation.

All that is being changed is how the list of physical pages gets
passed to the driver. The linear interface requires them to be
contiguously mapped (eg in a vmap) while the SG interface
directly passes a list of physical page addresses.

Any alogrithm that works with the old interface can run on the new
interface, and the new interface can support much better options for
DMA drivers, while not requiring the higher layers to perform a high
order allocation (vmap or otherwise) to create the contiguous memory.

The reason the old interface is being deleted here is so the fpga mgr
API can be expanded to accept a sg list directly. Since we cannot
convert a general sg list to linear memory the liner option must be
totally removed.

> I am working to merge an fpga manager which uses SPI to load the bitstream
> (see https://www.spinics.net/lists/arm-kernel/msg539328.html)
> Any dma in use there would come from the spi driver. write_init_sg, and write_sg
> don't make any sense in my case.

No, it still make lots of sense.

SPI has been slowly transforming to use the same sort of SG scheme
universally, including facing the client. (see
6ad45a27cbe343ec8d7888e5edf6335499a4b555)

Some day your driver can just pass the SGs directly to spi and
everything will be great.

In the mean time it can do sg_miter_next to get mapped buffers.

> Would it not make sense to keep the top level API the same?

Fundamentally no.

Jason
