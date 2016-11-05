From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Sat, 05 Nov 2016 13:47:35 +0100
Subject: Low network throughput on i.MX28
In-Reply-To: <1478349578.3405.5.camel@intel.com>
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
Message-ID: <1478350055.353.4.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2016-11-05 at 12:39 +0000, Koul, Vinod wrote:
> On Sat, 2016-11-05 at 13:06 +0100, J?rg Krause wrote:
> > @ Vinod
> > In short, I noticed poor performance in the SSP2 (MMC/SD/SDIO)
> > interface on a custom i.MX28 board with a wifi chip attached.
> > Comparing
> > the bandwith with iperf I get >20Mbits/sec on the vendor kernel and
> > <5Mbits/sec on the mainline kernel. I am trying to investigate what
> > the
> > bottleneck is.
> 
> is this imx-dma or imx-sdma..

Its' mxs-dma.

> 
> > 
> > @ Stefan, all
> > My understanding is that the tasklet in this case is responsible
> > for
> > reading the response registers of the DMA controller and return the
> > response to the MMC host driver.
> > 
> > The vendor kernel does this in the interrupt routine of mxs-mmc by
> > issueing a complete whereas the mainline kernel does this in the
> > interrupt routine in mxs-dma by scheduling the tasklet.
> 
> Is vendor kernel using dmaengine APIs or not?

No. It's using a custom dmaengine.

> 
> Okay, if we talk about getting best performance, I always advise
> folks
> to issue next transaction in the interrupt routine and then do
> descriptor management and callback in tasklet.
> 
> Some drivers do that correctly but some don't..

Do you have an example for a driver doing it correctly?

> Tasklet can be an issue but only if there is a huge scheduling delay
> for
> the tasklet. You can check using tracing tools and confirm.

Don't think the tasklets is an issue here as I replaced the tasklets in
the dmaengine API by completion (which the vendor kernel uses) and
there are no performance benefits. However, I am not a Linux kernel
developer...

J?rg
