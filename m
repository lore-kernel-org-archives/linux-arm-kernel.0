From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Tue, 4 Apr 2017 20:47:59 +0000
Subject: at91: serial: Can't use DMA on 4.x kernels in RS-485 mode on
 at91sam9x5
In-Reply-To: <20170404203249.GA4416@gradator.net>
References: <DM5PR05MB2954D56C2E266AF16B250ACCBB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <20170404203249.GA4416@gradator.net>
Message-ID: <DM5PR05MB295425DD88B5A8ADF88B81F8BB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

> -----Original Message-----
> From: Sylvain Rochet [mailto:sylvain.rochet at finsecur.com]
> Sent: Tuesday, April 04, 2017 4:33 PM
> To: Bryan Evenson <bevenson@melinkcorp.com>
> Cc: linux-arm-kernel at lists.infradead.org; Nicolas Ferre
> <nicolas.ferre@atmel.com>
> Subject: Re: at91: serial: Can't use DMA on 4.x kernels in RS-485 mode on
> at91sam9x5
> 
> Hi Bryan,
> 
> On Tue, Apr 04, 2017 at 08:28:34PM +0000, Bryan Evenson wrote:
> >
> > With the 3.10 kernel, I had to use the TX DMA only.  For some reason
> > receive wouldn't work for me with the DMA.  Now with the latest on the
> > linux-4.4-at91 branch I can't use the TX DMA.  The data is transmitted
> > correctly out the USART (verified on a receiving device), but then the
> > return message is not received.  I verified the same results when both
> > RX&TX DMA was enabled and only when the TX DMA was enabled.  If I use
> > only the RX DMA, everything works fine if I have only one device on
> > the RS-485 port.  As soon as I daisy chain more than one device on an
> > RS-485 port, then I start dropping messages.  If I turn off both the
> > RX and TX DMA, then all data transfers work just fine.
> >
> > I'd like to get both TX and RX DMA working for all three RS-485 ports.
> > Anyone have any suggestions for what to look at to get DMA working
> > while in RS-485 mode?  I'm planning to start trying a git bisect, but
> > given these are different branches I wasn't sure how well that was
> > going to work.
> 
> Did you check that you didn't run out of available DMA channels on each
> DMA controller ? AT91SAM9G25 unfortunately doesn't have much of them.
> 

Here's what dmesg is telling me about the DMA channel access when I am enabling DMA on TX only.

root at at91sam9x5ek:~# dmesg | grep -E '(DMA|dma)'
[    0.109375] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.210937] at_hdmac ffffec00.dma-controller: Atmel AHB DMA Controller ( cpy set slave sg-cpy ), 8 channels
[    0.218750] at_hdmac ffffee00.dma-controller: Atmel AHB DMA Controller ( cpy set slave sg-cpy ), 8 channels
[    0.234375] at91_i2c f8010000.i2c: using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
[    0.765625] atmel_nand 40000000.nand: Using dma0chan2 for DMA transfers.
[    0.914062] atmel_spi f0004000.spi: Using dma1chan0 (tx) and dma1chan1 (rx) for DMA transfers
[   22.351562] atmel_usart f8020000.serial: using dma0chan3 for tx DMA transfers
[   22.406250] atmel_usart f8028000.serial: using dma1chan2 for tx DMA transfers
[   23.078125] atmel_usart f801c000.serial: using dma0chan4 for tx DMA transfers

It looks like there should be enough DMA channels left (eight by my count) for me to also enable RX DMA on all three USARTs.

Thanks,
Bryan

> Sylvain
