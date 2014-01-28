From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 28 Jan 2014 08:43:24 +0530
Subject: [PATCH v2] dma: Add Xilinx AXI Video Direct Memory Access
 Engine driver support
In-Reply-To: <CA+mB=1JvnTcyRnuvdnW1BCeiMLSTMrrAbKwVKgwFUmWrVuXzSw@mail.gmail.com>
References: <1390409565-4200-1-git-send-email-sthokal@xilinx.com>
 <1390409565-4200-2-git-send-email-sthokal@xilinx.com>
 <52E0FC22.8060903@metafoo.de>
 <CA+mB=1L6yvCwA3mKCwz83LQbXiVau110REV64rYrSzUhGE4ucA@mail.gmail.com>
 <52E2698B.6070001@metafoo.de> <20140126135933.GD10628@intel.com>
 <52E54849.2000208@metafoo.de>
 <CA+mB=1JvnTcyRnuvdnW1BCeiMLSTMrrAbKwVKgwFUmWrVuXzSw@mail.gmail.com>
Message-ID: <20140128031324.GH10628@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 06:42:36PM +0530, Srikanth Thokala wrote:
> Hi Lars/Vinod,
> >> The question here i think would be waht this device supports? Is the hardware
> >> capable of doing interleaved transfers, then would make sense.
> >
> > The hardware does 2D transfers. The parameters for a transfer are height,
> > width and stride. That's only a subset of what interleaved transfers can be
> > (xt->num_frames must be one for 2d transfers). But if I remember correctly
> > there has been some discussion on this in the past and the result of that
> > discussion was that using interleaved transfers for 2D transfers is
> > preferred over adding a custom API for 2D transfers.
> 
> I went through the prep_interleaved_dma API and I see only one descriptor
> is prepared per API call (i.e. per frame).  As our IP supports upto 16 frame
> buffers (can be more in future), isn't it less efficient compared to the
> prep_slave_sg where we get a single sg list and can prepare all the descriptors
> (of non-contiguous buffers) in one go?  Correct me, if am wrong and let me
> know your opinions.
Well the descriptor maybe one, but that can represent multiple frames, for
example 16 as in your case. Can you read up the documentation of how multiple
frames are passed. Pls see include/linux/dmaengine.h 

/**
 * Interleaved Transfer Request
 * ----------------------------
 * A chunk is collection of contiguous bytes to be transfered.
 * The gap(in bytes) between two chunks is called inter-chunk-gap(ICG).
 * ICGs may or maynot change between chunks.
 * A FRAME is the smallest series of contiguous {chunk,icg} pairs,
 *  that when repeated an integral number of times, specifies the transfer.
 * A transfer template is specification of a Frame, the number of times
 *  it is to be repeated and other per-transfer attributes.
 *
 * Practically, a client driver would have ready a template for each
 *  type of transfer it is going to need during its lifetime and
 *  set only 'src_start' and 'dst_start' before submitting the requests.
 *
 *
 *  |      Frame-1        |       Frame-2       | ~ |       Frame-'numf'  |
 *  |====....==.===...=...|====....==.===...=...| ~ |====....==.===...=...|
 *
 *    ==  Chunk size
 *    ... ICG
 */

-- 
~Vinod
