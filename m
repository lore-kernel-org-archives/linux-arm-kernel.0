From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 13 Jun 2016 22:32:29 +0530
Subject: [PATCH] dma: xilinx-vdma: add some sanity checks
In-Reply-To: <1465830523-2484498-1-git-send-email-arnd@arndb.de>
References: <1465830523-2484498-1-git-send-email-arnd@arndb.de>
Message-ID: <20160613170229.GJ16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 05:07:33PM +0200, Arnd Bergmann wrote:
> The newly added xilinx_dma_prep_dma_cyclic function sometimes causes
> a gcc warning about the use of the segment function in case
> we never run into the inner loop of the function:
> 
> dma/xilinx/xilinx_vdma.c: In function 'xilinx_dma_prep_dma_cyclic':
> dma/xilinx/xilinx_vdma.c:1808:23: error: 'segment' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    segment->hw.control |= XILINX_DMA_BD_SOP;
> 
> This can only happen if the period len is zero (which would cause other
> problems earlier), or if the buffer is shorter than a period. Neither
> of them should ever happen, but by adding an explicit check for these two
> cases, we can abort in a more controlled way, and the compiler is
> able to see that we never use uninitialized data.

Applied after fixing subsystem name

Thanks
-- 
~Vinod
