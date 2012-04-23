From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Apr 2012 10:50:13 +0100
Subject: [PATCH 5/9] dmaengine: provide a common function for
 completing a dma descriptor
In-Reply-To: <056201cd2135$10ea5b70$32bf1250$%kim@samsung.com>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
 <056201cd2135$10ea5b70$32bf1250$%kim@samsung.com>
Message-ID: <20120423095013.GL24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 06:40:06PM +0900, Boojin Kim wrote:
> I met a problem on DMA cyclic mode (DMA_CYCLIC) for sound playback.
> Kernel BUG occurs during DMA transfer with DMA cyclic mode.
> This patch makes the cookies into zero. But, cookies should be kept
> during cyclic mode because cyclic mode re-uses the cookies.

The protection is there to prevent cookies being accidentally re-used.
If you're running a cyclic transfer, even then you shouldn't be completing
the same cookie time and time again - I think Vinod also concurs with this.

I think our preference is for cyclic transfers to entire remain uncompleted,
or to get a new cookie each time they allegedly "complete".
