From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Thu, 3 Sep 2015 13:25:00 +0000
Subject: [LINUX RFC v2 0/4] spi: add dual parallel mode support in Zynq
 MPSoC GQSPI controller
In-Reply-To: <201509022056.09635.marex@denx.de>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <201508260856.22258.marex@denx.de>
 <7CFCFE83B8145347A1D424EC939F1C3C014AFF00@XAP-PVEXMBX01.xlnx.xilinx.com>
 <201509022056.09635.marex@denx.de>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3C014B08B2@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Marek Vasut [mailto:marex at denx.de]
> Sent: Thursday, September 03, 2015 12:26 AM
> To: Ranjit Abhimanyu Waghmode
> Cc: dwmw2 at infradead.org; computersforpeace at gmail.com;
> broonie at kernel.org; Michal Simek; Soren Brinkmann; zajec5 at gmail.com;
> ben at decadent.org.uk; b32955 at freescale.com; knut.wohlrab at de.bosch.com;
> juhosg at openwrt.org; beanhuo at micron.com; linux-mtd at lists.infradead.org;
> linux-kernel at vger.kernel.org; linux-spi at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Harini Katakam; Punnaiah Choudary Kalluri
> Subject: Re: [LINUX RFC v2 0/4] spi: add dual parallel mode support in Zynq
> MPSoC GQSPI controller
> 
> On Wednesday, September 02, 2015 at 07:12:14 PM, Ranjit Abhimanyu
> Waghmode
> wrote:
> > Hi Marek,
> >
> > > -----Original Message-----
> > > From: Marek Vasut [mailto:marex at denx.de]
> > > Sent: Wednesday, August 26, 2015 12:26 PM
> > > To: Ranjit Abhimanyu Waghmode
> > > Cc: dwmw2 at infradead.org; computersforpeace at gmail.com;
> > > broonie at kernel.org; Michal Simek; Soren Brinkmann; zajec5 at gmail.com;
> > > ben at decadent.org.uk; b32955 at freescale.com;
> > > knut.wohlrab at de.bosch.com; juhosg at openwrt.org;
> beanhuo at micron.com;
> > > linux-mtd at lists.infradead.org; linux-kernel at vger.kernel.org;
> > > linux-spi at vger.kernel.org; linux-arm- kernel at lists.infradead.org;
> > > Harini Katakam; Punnaiah Choudary Kalluri
> > > Subject: Re: [LINUX RFC v2 0/4] spi: add dual parallel mode support
> > > in Zynq MPSoC GQSPI controller
> > >
> > > On Wednesday, August 26, 2015 at 08:26:03 AM, Ranjit Waghmode wrote:
> > > > This series adds dual parallel mode support for Zynq Ultrascale+
> > > > MPSoC GQSPI controller driver.
> > > >
> > > > What is dual parallel mode?
> > > > ---------------------------
> > > > ZynqMP GQSPI controller supports Dual Parallel mode with following
> > > > functionalities: 1) Supporting two SPI flash memories operating in
> > > > parallel. 8 I/O lines. 2) Chip selects and clock are shared to
> > > > both the flash devices
> > > > 3) This mode is targeted for faster read/write speed and also
> > > > doubles the size 4) Commands/data can be transmitted/received from
> > > > both the devices(mirror), or only upper or only lower flash memory
> devices.
> > > >
> > > > 5) Data arrangement:
> > > >    With stripe enabled,
> > > >    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
> > > >    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.
> > >
> > > This might be a dumb question, but why don't you just treat this as
> > > an SPI NOR flash with 8-bit bus ?
> >
> > In case of dual parallel configuration of this controller there are
> > different modes like single, dual and quad mode. Whatever you are
> > suggesting would fit only in the case of Quad mode operation as both
> > buses would have 4 lines each. In case of single mode of parallel
> > configuration, there would be two buses; but the line on each bus
> > would one. So altogether there will be two lines. And in case of dual
> > mode of parallel configuration each bus will be having two lines. So
> > altogether 4 lines will be there. So keeping 8 lines would not support
> > above two modes of parallel configuration correctly.
> >
> > Logically it is a single flash with 8 IO lines but physically it's a
> > two flash devices and each has 4 IO lines. So, in this case, read and
> > write addresses should be always even and minimum data that can be
> > accessed is 2 bytes.
> 
> Oh, I see what the issue is now. It has to do with configuring the flash into
> correct bus-width mode, right ?
Yes.
> 
> Best regards,
> Marek Vasut
