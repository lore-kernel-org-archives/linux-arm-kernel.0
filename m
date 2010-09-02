From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 17:30:19 +0100
Subject: invalid address returned by usb_alloc_coherent on dockstar
In-Reply-To: <65B450424E3DC742AA18F68E1AFB214003A58D62@EX06.ad.tulane.edu>
References: <65B450424E3DC742AA18F68E1AFB214003A58D62@EX06.ad.tulane.edu>
Message-ID: <20100902163019.GA9983@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 09:48:33AM -0500, MacLaren, James M wrote:
> I have been working on getting mythtv to run on my dockstar mostly with
> success.  I can record from the hd-homerun a network atsc/qam tv tuner.
> I understand from reading mailing list that a usb recorder (HVR-1950)
> has been made to work on a sheeva plug.  I am trying to get the
> Hauppuage hdpvr to work.  The driver is relatively new but seems to work
> stablely on i386 systems.  I am hoping someone can help with the
> problem.
> 
>  
> 
> The call to 
> 
> mem = usb_alloc_coherent(dev->udev, dev->bulk_in_size, GFP_KERNEL,
> 
> &urb->transfer_dma);
> 
>  
> 
> in hdvpr-video.c
> 
>  
> 
> Returns an address ffc11c00 which is not valid when I check it with
> virt_addr_valid.  So the driver then exits gracefully later on.

Correct.  Addresses returned from dma_alloc_coherent() may be remapped
by architectures if that's what they need to do to achieve coherence.
ARM is such an architecture.

In that case, the returned address will not pass the virt_addr_valid()
test, which only returns true for addresses within the kernel direct-
mapped RAM region.

It sounds like your driver has been written to only support x86.  I
suggest you raise it as a bug against the driver.
