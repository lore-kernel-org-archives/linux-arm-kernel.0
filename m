From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Sat, 05 Nov 2016 23:37:13 +0100
Subject: Low network throughput on i.MX28
In-Reply-To: <1478360733.3405.17.camel@intel.com>
References: <1476313753.2065.11.camel@embedded.rocks>
 <20161013084807.6a231fdb@ipc1.ka-ro>
 <A57BCA39-0977-43C4-B22D-ED60F5E4B06D@embedded.rocks>
 <20161014081349.1afb22c6@ipc1.ka-ro>
 <1476521171.1670.2.camel@embedded.rocks>
 <2131339088.8778.d47a56f6-921e-4d6c-9a5c-2e77bfd5d281.open-xchange@email.1und1.de>
 <8C3BD5BA-252F-4A95-B938-50356A23974E@embedded.rocks>
 <2003579366.391192.0cc5acd0-af27-4ef7-892f-3c2dd86176ba.open-xchange@email.1und1.de>
 <1477696028.31471.3.camel@embedded.rocks>
 <1143135945.89173.6f7a3a9a-5120-4cc2-a76b-92a516ab6500.open-xchange@email.1und1.de>
 <1478074489.19127.7.camel@embedded.rocks>
 <ac897803-47e5-6b0b-5664-6dc165c56c23@i2se.com>
 <1478285097.26659.2.camel@embedded.rocks>
 <1783642995.185945.5e54a2af-ba2c-4901-93f6-1967dd432939.open-xchange@email.1und1.de>
 <1478299359.26659.5.camel@embedded.rocks>
 <963717394.159124.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
 <1478347610.353.2.camel@embedded.rocks> <1478349578.3405.5.camel@intel.com>
 <1478351681.353.5.camel@embedded.rocks>
 <1478360733.3405.17.camel@intel.com>
Message-ID: <1478385433.1801.1.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2016-11-05 at 15:45 +0000, Koul, Vinod wrote:
> On Sat, 2016-11-05 at 14:14 +0100, J?rg Krause wrote:
> > On Sat, 2016-11-05 at 12:39 +0000, Koul, Vinod wrote:
> > > 
> > > On Sat, 2016-11-05 at 13:06 +0100, J?rg Krause wrote:
> > > > 
> > > > @ Vinod
> > > > In short, I noticed poor performance in the SSP2 (MMC/SD/SDIO)
> > > > interface on a custom i.MX28 board with a wifi chip attached.
> > > > Comparing
> > > > the bandwith with iperf I get >20Mbits/sec on the vendor kernel
> > > > and
> > > > <5Mbits/sec on the mainline kernel. I am trying to investigate
> > > > what
> > > > the
> > > > bottleneck is.
> > > 
> > > is this imx-dma or imx-sdma..
> > > 
> > > > 
> > > > 
> > > > @ Stefan, all
> > > > My understanding is that the tasklet in this case is
> > > > responsible
> > > > for
> > > > reading the response registers of the DMA controller and return
> > > > the
> > > > response to the MMC host driver.
> > > > 
> > > > The vendor kernel does this in the interrupt routine of mxs-mmc 
> > > > by
> > > > issueing a complete whereas the mainline kernel does this in
> > > > the
> > > > interrupt routine in mxs-dma by scheduling the tasklet.
> > > 
> > > Is vendor kernel using dmaengine APIs or not?
> > 
> > It's this engine [1].
> > 
> > [1] http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tre
> > e/a
> > r
> > ch/arm/plat-mxs/dmaengine.c?h=imx_2.6.35_1.1.0
> 
> Thanks for info, this looks okay.
> 
> First can you confirm that register configuration for DMA transaction
> is
> same in both cases.

They are almost identical. The difference is that the mainline MMC
driver has SDIO IRQ enabled and the APB bus has burst mode enable. Both
don't have any influence.

> Second, looking at the driver I see that interrupt handler is not
> pushing next descriptor. Also the tasklet is doing callback action
> and
> not pushing any descriptors, did I miss anything in this?

Right. However, after observing the registers I noticed that the vendor
MMC kernel driver only issues one DMA command, whereas the mainline
driver issues two chained DMA commands. The relevant function in both
drivers is mxs_mmc_adtc().

The mainline function issues a DMA transaction with setting the PIO
words only and appends the data from the MMC host.

The vendor function copies the MMC host data from the scatterlist into
an owned DMA buffer, sets the buffer address as the next command
address and issues the descriptor to the DMA engine.

> For good dma throughput, you should have multiple dma transactions
> queued up and submitted as fast as possible. Can you check if this is
> being done.?
> 
> We need to minimize/eliminate the delay between two transactions.
> This
> can be done in SW or HW based on support from HW. If HW supports
> chaining of descriptors then next transaction which is given to
> dmaengine driver should be appended at the end. If not submit the
> descriptor to hw immediately on interrupt.?

I see! In this particular case, the vendor driver reduces the chaining
of descriptors, whereas the mainline driver chains two DMA commands.
Note, that the i.MX28 hardware does support chaining. So, might this be
an issue for poor performance?

J?rg
