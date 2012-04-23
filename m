From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 23 Apr 2012 15:31:18 +0530
Subject: [PATCH 5/9] dmaengine: provide a common function for
 completing a dma descriptor
In-Reply-To: <20120423095013.GL24211@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
 <056201cd2135$10ea5b70$32bf1250$%kim@samsung.com>
 <20120423095013.GL24211@n2100.arm.linux.org.uk>
Message-ID: <1335175278.31825.108.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-04-23 at 10:50 +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 23, 2012 at 06:40:06PM +0900, Boojin Kim wrote:
> > I met a problem on DMA cyclic mode (DMA_CYCLIC) for sound playback.
> > Kernel BUG occurs during DMA transfer with DMA cyclic mode.
> > This patch makes the cookies into zero. But, cookies should be kept
> > during cyclic mode because cyclic mode re-uses the cookies.
> 
> The protection is there to prevent cookies being accidentally re-used.
> If you're running a cyclic transfer, even then you shouldn't be completing
> the same cookie time and time again - I think Vinod also concurs with this.
Right :)
I recently committed patch for imx-dma which doesn't mark the cyclic
descriptor as complete. Descriptor represents a transaction and makes no
sense to complete t if the transaction is still continuing.
> 
> I think our preference is for cyclic transfers to entire remain uncompleted,
> or to get a new cookie each time they allegedly "complete".
No it is not complete. Cyclic never completes, it aborts when user
wants. The "notification" interrupt is for updating the
counters/notifying (timestamp/periods elapsed in sound), and shouldn't
be used for anything else

-- 
~Vinod
