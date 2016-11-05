From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Sat, 05 Nov 2016 13:06:50 +0100
Subject: Low network throughput on i.MX28
In-Reply-To: <963717394.159124.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
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
Message-ID: <1478347610.353.2.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vinod,

as recommanded by Stefan Wahren I'm turning on you about this issue.
Please see below... 

On Sat, 2016-11-05 at 12:33 +0100, Stefan Wahren wrote:
> Hi J?rg,
> 
> > J?rg Krause <joerg.krause@embedded.rocks> hat am 4. November 2016
> > um 23:42
> > geschrieben:
> > 
> > 
> > Hi Stefan,
> > 
> > sorry, I forget the link in the previous mail.
> > 
> > On Fri, 2016-11-04 at 20:30 +0100, Stefan Wahren wrote:
> > > Hi J?rg,
> > > 
> > > > J?rg Krause <joerg.krause@embedded.rocks> hat am 4. November
> > > > 2016
> > > > um 19:44
> > > > geschrieben:
> > > > 
> > > > 
> > > > Hi Shawn,
> > > > 
> > > > On Wed, 2016-11-02 at 09:24 +0100, Stefan Wahren wrote:
> > > > > Am 02.11.2016 um 09:14 schrieb J?rg Krause:
> > > > > > On Sat, 2016-10-29 at 11:08 +0200, Stefan Wahren wrote:
> > > > > > > > J?rg Krause <joerg.krause@embedded.rocks> hat am 29.
> > > > > > > > Oktober
> > > > > > > > 2016
> > > > > > > > um 01:07
> > > > > > > > geschrieben:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > You mentioned [1] an optimization in the Freescale
> > > > > > > > vendor
> > > > > > > > Linux
> > > > > > > > kernel
> > > > > > > > [2]. I would really like to see this optimization in
> > > > > > > > the
> > > > > > > > mainline
> > > > > > > > kernel.
> > > > > > > > 
> > > > > > > > Did you ever tried to port this code from Freescale to
> > > > > > > > mainline?
> > > > > > > 
> > > > > > > Yes, i tried once but i was frustrated soon because of
> > > > > > > the
> > > > > > > lot of
> > > > > > > required
> > > > > > > changes and resulting issues.
> > > > > > 
> > > > > > I got the PIO mode working for the mxs-mmc driver. For this
> > > > > > I
> > > > > > ported
> > > > > > the PIO code from the vendor kernel and removed the usage
> > > > > > of
> > > > > > the
> > > > > > DMA
> > > > > > engine entirely.
> > > > > 
> > > > > Good job
> > > > > 
> > > > > > 
> > > > > > Testing network bandwidth with iperf, I get about
> > > > > > ~10Mbit/sec
> > > > > > with
> > > > > > PIO
> > > > > > mode compared to ~6.5Mbit/sec with DMA mode for UDP and
> > > > > > about
> > > > > > ~6.5Mbit/sec compared to ~4.5Mbit/sec with DMA mode for
> > > > > > TCP.
> > > > > 
> > > > > And how about MMC / sd card performance?
> > > > 
> > > > I noticed poor performance with the i.MX28 MMC and/or DMA
> > > > driver
> > > > using
> > > > the mainline kernel compared to the vendor Freescale kernel
> > > > 2.6.35.
> > > > I've seen that hou have added the drivers to mainline some
> > > > years
> > > > ago.
> > > > 
> > > > My custom i.MX28 board has a wifi chip attached to the SSP2
> > > > interface.
> > > > Comparing the bandwith with iperf I get >20Mbits/sec on the
> > > > vendor
> > > > kernel and <5Mbits/sec on the mainline kernel.
> > > 
> > > there is one thing about the clock handling. I noticed that the
> > > Vendor Kernel
> > > round up the clock frequency and the Mainline Kernel round down
> > > the
> > > clock
> > > frequency [1]. So don't trust the clock ratings from DT / board
> > > code.
> > > Better
> > > verify the register settings or check it with an osci.
> > > 
> > > [1] - http://www.spinics.net/lists/linux-mmc/msg09132.html
> > 
> > I checked the clock rate setting by reading the register 0x80014070
> > (HW_SSP2_TIMING). CLOCK_DIVIDE is 0x2 and CLOCK_RATE is 0x0. As SSP
> > CLK
> > is 96MHz this makes a clock rate of 48MHz.
> > 
> > There was a discussion on the mailing list [1] about that tasklets
> > might be slow.
> > 
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-Febr
> > uary
> > /043395.html
> 
> if i unterstand it right the tasklet is not the problem, but the
> design of the
> MXS DMA driver. Please refer to the chapter "General Design Notes" to
> the
> documentation of the DMA provider [2].
> I think the MXS DMA driver is affected. Maybe you should ask Vinod
> Koul about
> this.
> 
> [2] - https://www.kernel.org/doc/Documentation/dmaengine/provider.txt

@ Vinod
In short, I noticed poor performance in the SSP2 (MMC/SD/SDIO)
interface on a custom i.MX28 board with a wifi chip attached. Comparing
the bandwith with iperf I get >20Mbits/sec on the vendor kernel and
<5Mbits/sec on the mainline kernel. I am trying to investigate what the
bottleneck is.

@ Stefan, all
My understanding is that the tasklet in this case is responsible for
reading the response registers of the DMA controller and return the
response to the MMC host driver.

The vendor kernel does this in the interrupt routine of mxs-mmc by
issueing a complete whereas the mainline kernel does this in the
interrupt routine in mxs-dma by scheduling the tasklet.

To check if this makes any difference I replaced the tasklet() usage
with using the complete() infrastructure. For this I hacked the DMA
engine and the MXS DMA driver. However, the performance stays the same.

So, if I understand correctly, this is not an issue here, right? So if
not the tasklet, what do you suspect?

J?rg
