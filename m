From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jul 2016 17:20:04 +0100
Subject: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on
 transfer completion
In-Reply-To: <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-3-peter.ujfalusi@ti.com>
 <20160718103409.GH5783@n2100.arm.linux.org.uk>
 <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com>
Message-ID: <20160719162004.GK5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 03:35:18PM +0300, Peter Ujfalusi wrote:
> On 07/18/16 13:34, Russell King - ARM Linux wrote:
> > On Thu, Jul 14, 2016 at 03:42:37PM +0300, Peter Ujfalusi wrote:
> >> Before looking for the next descriptor to start, complete the just finished
> >> cookie.
> > 
> > This change will reduce performance as we no longer have an overlap
> > between the next request starting to be dealt with in the hardware
> > vs the previous request being completed.
> 
> vchan_cookie_complete() will only mark the cookie completed, adds the vd to
> the desc_completed list (it was deleted from desc_issued list when it was
> started by omap_dma_start_desc) and schedule the tasklet to deal with the real
> completion later.
> Marking the just finished descriptor/cookie done first then looking for
> possible descriptors in the queue to start feels like a better sequence.

I deliberately arranged the code in the original order so that the next
transfer was started on the hardware with the least amount of work by
the CPU.  Yes, there may not be much in it, but everything you mention
above adds to the number of CPU cycles that need to be executed before
the next transfer can be started.

More CPU cycles wasted means higher latency between transfers, which
means lower performance.

> After a quick grep in the kernel source: only omap-dma.c was starting the
> next transfer before marking the current completed descriptor/cookie done.

Right, because I've thought about the issue, having been the author of
both virt-dma and omap-dma.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
