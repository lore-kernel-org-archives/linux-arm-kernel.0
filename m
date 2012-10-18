From: marex@denx.de (Marek Vasut)
Date: Thu, 18 Oct 2012 10:16:06 +0200
Subject: [PATCH] dma: add new DMA control commands
In-Reply-To: <507FB495.7050104@freescale.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
 <201210180914.58527.marex@denx.de> <507FB495.7050104@freescale.com>
Message-ID: <201210181016.06782.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

> ? 2012?10?18? 15:14, Marek Vasut ??:
> > Dear Huang Shijie,
> > 
> > Why such massive CC ?
> > 
> >> ? 2012?10?18? 14:18, Vinod Koul ??:
> >>> Why cant you do start (prepare clock etc) when you submit the
> >>> descriptor to dmaengine. Can be done in tx_submit callback.
> >>> Similarly remove the clock when dma transaction gets completed.
> >> 
> >> I ever thought this method too.
> >> 
> >> But it will become low efficient in the following case:
> >>     Assuming the gpmi-nand driver has to read out 1024 pages in one
> >> 
> >> _SINGLE_ read operation.
> >> The gpmi-nand will submit the descriptor to dmaengine per page.
> > 
> > It will? Then GPMI NAND is flat our broken ... again.
> 
> yes.
> 
> Please read the NAND chip spec about the comand READ PAGE(00h-30h) and
> the code
> nand_do_read_ops(). The nand chip limits us only read one page out one
> time. So the driver will submit the descriptor to dmaengine per page.

So we can't stream data from the chip? About time to adjust the MTD framework to 
allow that. Maybe implement a command queue?

> >> So with
> >> your method,
> >> the system will repeat the enable/disable dma clock 1024 time.
> > 
> > Yes, it is the driver that's wrong.
> 
> not the driver.
> 
> >> At every
> >> enable/disable dma clock,
> >> the system has to enable the clock chain and it's parents ...
> >> 
> >> But with this patch, we only need to enable/disable dma clock one time,
> >> just at we select the nand chip.
> > 
> > You are fixing a driver problem at a framework level, wrong.
> > 
> > So, check how the MXS SPI driver handles descriptor chaining. Indeed, the
> > Sigmatel screwed the DMA stuff good. But if you analyze the SPI driver,
> > you'll notice a few important points that might come handy when you fix
> > the GPMI NAND driver properly.
> > 
> > The direction to take here is:
> > 1) Implement DMA chaining into the GPMI NAND driver
> 
> How can i implement the DMA chain if the nand chip READ-PAGE command
> gives us the one page limit?

This smells like a time to extend the MTD api ?

> thanks
> Huang Shijie
> 
> > 2) You might need to do one PIO transfer to reconfigure the IP registers
> > between each segment of the DMA chain (just as MXS SPI does it)
> > 3) You might run out of DMA descriptors when doing too long chains -- so
> > you might need to fix that part of the mxs DMA driver.

Best regards,
Marek Vasut
