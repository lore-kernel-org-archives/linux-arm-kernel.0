From: joshc@ni.com (Josh Cartwright)
Date: Tue, 12 May 2015 10:12:05 -0500
Subject: [PATCH] ARM: zynq: Set bit 22 in PL310 AuxCtrl register (6395/1)
In-Reply-To: <812979c5a158a3306d8036e7f9731947c58a3ab7.1431411716.git.michal.simek@xilinx.com>
References: <812979c5a158a3306d8036e7f9731947c58a3ab7.1431411716.git.michal.simek@xilinx.com>
Message-ID: <20150512151205.GS669@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Something tells me that Russell's patch system won't like to accept a
patch with a duplicate ID (although, I could be wrong).

On Tue, May 12, 2015 at 08:22:01AM +0200, Michal Simek wrote:
> From: Thomas Betker <thomas.betker@rohde-schwarz.com>
> 
> This patch is based on the
> commit 1a8e41cd672f ("ARM: 6395/1: VExpress: Set bit 22 in the PL310
> (cache controller) AuxCtlr register")
> 
> Clearing bit 22 in the PL310 Auxiliary Control register (shared
> attribute override enable) has the side effect of transforming Normal
> Shared Non-cacheable reads into Cacheable no-allocate reads.
> 
> Coherent DMA buffers in Linux always have a cacheable alias via the
> kernel linear mapping and the processor can speculatively load cache
> lines into the PL310 controller. With bit 22 cleared, Non-cacheable
> reads would unexpectedly hit such cache lines leading to buffer
> corruption.
> 
> For Zynq, this fix avoids memory inconsistencies between Gigabit
> Ethernet controller (GEM) and CPU when DMA_CMA is disabled.

In practice, we've seen corruption not only with the GEM but also the
UDC (and likely other things as well).  So, this patch is welcome!

> Suggested-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> Signed-off-by: Thomas Betker <thomas.betker@rohde-schwarz.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

This feels like stable material as well, to me.  (Although, I'd expect a
bit of manual work to get it backported, with the fairly recent L2
reworking).

Thanks,
  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/f8e77e05/attachment.sig>
