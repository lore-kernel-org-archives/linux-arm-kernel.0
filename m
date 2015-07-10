From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 10 Jul 2015 13:35:42 +0530
Subject: [PATCH linux-next v2 1/1] dmaengine: at_hdmac: fix residue
 computation
In-Reply-To: <b9630cef4224b93939138b3a8c1950ea44cbcf59.1434626239.git.cyrille.pitchen@atmel.com>
References: <cover.1434626239.git.cyrille.pitchen@atmel.com>
 <b9630cef4224b93939138b3a8c1950ea44cbcf59.1434626239.git.cyrille.pitchen@atmel.com>
Message-ID: <20150710080542.GD836@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 01:25:41PM +0200, Cyrille Pitchen wrote:
> As claimed by the programmer datasheet and confirmed by the IP designer,
> the Block Transfer Size (BTSIZE) bitfield of the Channel x Control A
> Register (CTRLAx) always refers to a number of Source Width (SRC_WIDTH)
> transfers.
> 
> Both the SRC_WIDTH and BTSIZE bitfields can be extacted from the CTRLAx
> register to compute the DMA residue. So the 'tx_width' field is useless
> and can be removed from the struct at_desc.
> 
> Before this patch, atc_prep_slave_sg() was not consistent: BTSIZE was
> correctly initialized according to the SRC_WIDTH but 'tx_width' was always
> set to reg_width, which was incorrect for MEM_TO_DEV transfers. It led to
> bad DMA residue when 'tx_width' != SRC_WIDTH.
> 
> Also the 'tx_width' field was mostly set only in the first and last
> descriptors. Depending on the kind of DMA transfer, this field remained
> uninitialized for intermediate descriptors. The accurate DMA residue was
> computed only when the currently processed descriptor was the first or the
> last of the chain. This algorithm was a little bit odd. An accurate DMA
> residue can always be computed using the SRC_WIDTH and BTSIZE bitfields
> in the CTRLAx register.
> 
> Finally, the test to check whether the currently processed descriptor is
> the last of the chain was wrong: for cyclic transfer, last_desc->lli.dscr
> is NOT equal to zero, since set_desc_eol() is never called, but logically
> equal to first_desc->txd.phys. This bug has a side effect on the
> drivers/tty/serial/atmel_serial.c driver, which uses cyclic DMA transfer
> to receive data. Since the DMA residue was wrong each time the DMA
> transfer reaches the second (and last) period of the transfer, no more
> data were received by the USART driver till the cyclic DMA transfer loops
> back to the first period.
> 
Applied, thanks

-- 
~Vinod
