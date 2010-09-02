From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 19:57:44 +0100
Subject: invalid address returned by usb_alloc_coherent on dockstar
In-Reply-To: <65B450424E3DC742AA18F68E1AFB214003A59142@EX06.ad.tulane.edu>
References: <65B450424E3DC742AA18F68E1AFB214003A58D62@EX06.ad.tulane.edu>
	<20100902163019.GA9983@n2100.arm.linux.org.uk>
	<65B450424E3DC742AA18F68E1AFB214003A59142@EX06.ad.tulane.edu>
Message-ID: <20100902185744.GB26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 01:28:33PM -0500, MacLaren, James M wrote:
> Thanks for the clarification.  I will contact the author of the driver.
> 
> I am sure this is an ignorant question but how does one then use that
> address if it has been remapped?  

Memory returned by dma_alloc_coherent() is guaranteed to be directly
addressible by the CPU.  The DMA address is also provided by
dma_alloc_coherent() for the device doing DMA (which is the struct
device passed into dma_alloc_coherent.)

Such a buffer is _guaranteed_ to be cache coherent with the DMA agent -
the only remaining issue is that caused by weakly ordered memory models
which is solved via barriers.

> In following through the hdpvr driver the address get stored for that
> urb by usb_fill_bulk_urb 
> 
> The driver fails when it later calls  usb_submit_urb and that address is
> checked in dma_map_single by virt_addr_valid

That's where it's going wrong.  Buffers allocated by dma_alloc_coherent()
are already DMA coherent and must not be passed to dma_map_single().  I
believe USB has some way to be told that the buffer is already suitable
for DMA without needing additional handling.
