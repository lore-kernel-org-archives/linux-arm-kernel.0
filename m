From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Tue, 11 Apr 2017 18:32:20 +0000
Subject: at91: serial: Can't use DMA on 4.x kernels in RS-485 mode on
 at91sam9x5
In-Reply-To: <DM5PR05MB29548291A13C348889156EDDBB0C0@DM5PR05MB2954.namprd05.prod.outlook.com>
References: <DM5PR05MB2954D56C2E266AF16B250ACCBB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <20170404203249.GA4416@gradator.net>
 <DM5PR05MB295425DD88B5A8ADF88B81F8BB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <DM5PR05MB29548291A13C348889156EDDBB0C0@DM5PR05MB2954.namprd05.prod.outlook.com>
Message-ID: <DM5PR05MB2954F35F2EBB9EEE987F3401BB000@DM5PR05MB2954.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I found the commit that is causing problems for me.  More details below.

> -----Original Message-----
> From: Bryan Evenson
> Sent: Friday, April 07, 2017 10:22 AM
> To: Bryan Evenson <bevenson@melinkcorp.com>; Sylvain Rochet
> <sylvain.rochet@finsecur.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: at91: serial: Can't use DMA on 4.x kernels in RS-485 mode on
> at91sam9x5
> 
> All,
> 
> > -----Original Message-----
> > From: linux-arm-kernel [mailto:linux-arm-kernel-
> > bounces at lists.infradead.org] On Behalf Of Bryan Evenson
> > Sent: Tuesday, April 04, 2017 4:48 PM
> > To: Sylvain Rochet <sylvain.rochet@finsecur.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>; linux-arm-
> > kernel at lists.infradead.org
> > Subject: RE: at91: serial: Can't use DMA on 4.x kernels in RS-485 mode
> > on
> > at91sam9x5
> >
> >
> > Hi Sylvain,
> >
> > > -----Original Message-----
> > > From: Sylvain Rochet [mailto:sylvain.rochet at finsecur.com]
> > > Sent: Tuesday, April 04, 2017 4:33 PM
> > > To: Bryan Evenson <bevenson@melinkcorp.com>
> > > Cc: linux-arm-kernel at lists.infradead.org; Nicolas Ferre
> > > <nicolas.ferre@atmel.com>
> > > Subject: Re: at91: serial: Can't use DMA on 4.x kernels in RS-485
> > > mode on
> > > at91sam9x5
> > >
> > > Hi Bryan,
> > >
> > > On Tue, Apr 04, 2017 at 08:28:34PM +0000, Bryan Evenson wrote:
> > > >
> > > > With the 3.10 kernel, I had to use the TX DMA only.  For some
> > > > reason receive wouldn't work for me with the DMA.  Now with the
> > > > latest on the
> > > > linux-4.4-at91 branch I can't use the TX DMA.  The data is
> > > > transmitted correctly out the USART (verified on a receiving
> > > > device), but then the return message is not received.  I verified
> > > > the same results when both RX&TX DMA was enabled and only when
> the
> > > > TX DMA was enabled.  If I use only the RX DMA, everything works
> > > > fine if I have only one device on the RS-485 port.  As soon as I
> > > > daisy chain more than one device on an
> > > > RS-485 port, then I start dropping messages.  If I turn off both
> > > > the RX and TX DMA, then all data transfers work just fine.
> > > >
> > > > I'd like to get both TX and RX DMA working for all three RS-485 ports.
> > > > Anyone have any suggestions for what to look at to get DMA working
> > > > while in RS-485 mode?  I'm planning to start trying a git bisect,
> > > > but given these are different branches I wasn't sure how well that
> > > > was going to work.
> 
> I found a working version with my setup.  Back at commit
> 1e1257860fd10487795b782f1dbb5b5f2c203474
> (https://github.com/linux4sam/linux-
> at91/commit/1e1257860fd10487795b782f1dbb5b5f2c203474) I can use both
> RX and TX DMA on the RS-485 ports.  As recent as commit
> b6f9cb564bcbfff46dc618bb7c246369194dfe11
> (https://github.com/linux4sam/linux-
> at91/commit/b6f9cb564bcbfff46dc618bb7c246369194dfe11) neither the RX
> or TX DMA work for my RS-485 ports.  I've been trying to bisect, but this has
> been slow going as I keep getting builds that don't boot (probably because I
> get a commit that is in the middle of a series).  I'm assuming the change
> either has to do with the Atmel device tree, the Atmel DMA driver or the
> Atmel serial port driver.  My current git bisect I started as follows:
> 
> git bisect start -- arch/arm/boot/dts/at91* drivers/tty/serial/atmel_serial.c
> drivers/dma/at_*
> 
> If there a section of source code that I should also focus on or if someone
> knows of a specific change I should test, I'd appreciate the suggestion.

I narrowed my issues down to this commit: https://github.com/linux4sam/linux-at91/commit/0058f0871efe7b01c6f2b3046c68196ab73e96da 

	tty/serial: atmel: fix RS485 half duplex with DMA

	When using DMA, half duplex doesn't work properly because rx is not stopped
	before starting tx. Ensure we call atmel_stop_rx() in the DMA case.

	Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
	Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
	Cc: stable <stable@vger.kernel.org>
	Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

If I revert this commit, I can use both TX and RX DMA on all three RS-485 ports (USART0, USART1 and USART3) with the current head of linux-4.4-at91 and linux-4.1-at91 on Atmel's fork.  I have not yet tried the mainline releases, but I see that atmel_start_tx() (the function modified by this commit) is identical in mainline so I'm assuming I'll have the same results.  In my case I am using my RS-485 ports in half-duplex mode, so the call to atmel_stop_rx() inside of atmel_start_tx() is the cause of my problems.

Anyone know why this would be a problem?  The commit makes sense to me and I don't see a good reason why it would break things.  I'm willing to test things out to see why this is causing a problem.

Thanks,
Bryan

> 
> Thanks,
> Bryan
> 
> > >
> > > Did you check that you didn't run out of available DMA channels on
> > > each DMA controller ? AT91SAM9G25 unfortunately doesn't have much
> of
> > them.
> > >
> >
> > Here's what dmesg is telling me about the DMA channel access when I am
> > enabling DMA on TX only.
> >
> > root at at91sam9x5ek:~# dmesg | grep -E '(DMA|dma)'
> > [    0.109375] DMA: preallocated 256 KiB pool for atomic coherent allocations
> > [    0.210937] at_hdmac ffffec00.dma-controller: Atmel AHB DMA Controller
> (
> > cpy set slave sg-cpy ), 8 channels
> > [    0.218750] at_hdmac ffffee00.dma-controller: Atmel AHB DMA Controller
> (
> > cpy set slave sg-cpy ), 8 channels
> > [    0.234375] at91_i2c f8010000.i2c: using dma0chan0 (tx) and dma0chan1
> (rx)
> > for DMA transfers
> > [    0.765625] atmel_nand 40000000.nand: Using dma0chan2 for DMA
> > transfers.
> > [    0.914062] atmel_spi f0004000.spi: Using dma1chan0 (tx) and dma1chan1
> > (rx) for DMA transfers
> > [   22.351562] atmel_usart f8020000.serial: using dma0chan3 for tx DMA
> > transfers
> > [   22.406250] atmel_usart f8028000.serial: using dma1chan2 for tx DMA
> > transfers
> > [   23.078125] atmel_usart f801c000.serial: using dma0chan4 for tx DMA
> > transfers
> >
> > It looks like there should be enough DMA channels left (eight by my
> > count) for me to also enable RX DMA on all three USARTs.
> >
> > Thanks,
> > Bryan
> >
> > > Sylvain
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
