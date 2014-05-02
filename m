From: agross@codeaurora.org (Andy Gross)
Date: Fri, 2 May 2014 13:08:27 -0500
Subject: [PATCH] dmaengine: qcom_bam_dma: Add descriptor flag APIs
In-Reply-To: <20140502162841.GZ32284@intel.com>
References: <1397772242-4048-1-git-send-email-agross@codeaurora.org>
 <20140502162841.GZ32284@intel.com>
Message-ID: <20140502180827.GA9476@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 09:58:41PM +0530, Vinod Koul wrote:
> On Thu, Apr 17, 2014 at 05:04:02PM -0500, Andy Gross wrote:
> > This patch adds APIs that allow for BAM hardware flags to be set per
> > descriptor.  Each one of the new flags informs the attached peripheral of a
> > special behavior that is required.
> > 
> > The EOT flag requests that the peripheral assert an end of transaction interrupt
> > when that descriptor is complete.  It also results in special signaling protocol
> > that is used between the attached peripheral and the core using the DMA
> > controller.
> DMA_PREP_INTERRUPT ??

I have 3 different IRQs that can be asserted based on the bit I set in the
hardware descriptor.  The normal IRQ is the INT bit.  However, in some cases the
peripheral protocol requires the use of the EOT or EOB interrupt instead.  The
DMA_PREP_INTERRUPT would only work if I had only 2 choices.

> 
> > 
> > The NWD flag requests that the peripheral wait until the data has been fully
> > processed before signaling an interrupt.
> interrupt for transaction complete or DMA request?

This is a special signaling mechanism that holds off the DMA interrupt until the
peripheral actually acks that the data has been processed completely.  This is
required in many cases by the peripheral.  One example is the SPI controller.
At the end of a transaction you are supposed to set the NWD so that the chip
select is de-asserted.

<snip>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
