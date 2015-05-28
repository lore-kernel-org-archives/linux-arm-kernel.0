From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Thu, 28 May 2015 15:41:04 +0000
Subject: [RFC PATCH 2/2] spi: Add support for Zynq Ultrascale+ MPSoC
 GQSPI controller
In-Reply-To: <20150528150356.GA21577@sirena.org.uk>
References: <1432106871-27232-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1432106871-27232-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150522115854.GG21391@sirena.org.uk>
 <CAFcVECJRqebzAjU+rfAtUQFG=7-KoE1GiXet5XJB-4D3i0or6A@mail.gmail.com>
 <20150528150356.GA21577@sirena.org.uk>
Message-ID: <03CA77BA8AF6F1469AEDFBDA1322A7B7495AA317@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Thursday, May 28, 2015 8:34 PM
> To: Harini Katakam
> Cc: Ranjit Abhimanyu Waghmode; Rob Herring; Pawel Moll; Mark Rutland;
> ijc+devicetree at hellion.org.uk; Kumar Gala; Michal Simek; Soren Brinkmann;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; linux-spi; Punnaiah Choudary Kalluri;
> ran27jit at gmail.com
> Subject: Re: [RFC PATCH 2/2] spi: Add support for Zynq Ultrascale+ MPSoC
> GQSPI controller
> 
> On Fri, May 22, 2015 at 08:43:54PM +0530, Harini Katakam wrote:
> > On Fri, May 22, 2015 at 5:28 PM, Mark Brown <broonie@kernel.org> wrote:
> > > On Wed, May 20, 2015 at 12:57:51PM +0530, Ranjit Waghmode wrote:
> 
> > > Why is there a default case here?  That's going to men we try to handle
> > > any random chip select that gets passed in as pointing to this lower
> > > device which doesn't seem right.  The fact that this is trying to handle
> > > mirroring of the chip select to two devices is also raising alarm bells
> > > here...
> 
> > This SPI controller has two CS lines and two data bus.
> > Two devices can be connected to these and either the upper or the
> > lower or both (Explained below) can be selected.
> 
> > When two flash devices are used, one of the HW configurations in
> > which they can be connected is called "parallel" mode where they
> 
> I know what wiring chip selects in parallel is but that's not the
> question - the question is about the handling of the default case.

Yes, we should not handle default case here. We will change this. 

> 
> > >> +static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool
> is_high)
> > >> +{
> 
> > >> +     if (is_high) {
> > >> +             /* Manually start the generic FIFO command */
> > >> +             zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
> > >> +                             zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
> > >> +                             GQSPI_CFG_START_GEN_FIFO_MASK);
> 
> > > No, this is broken - setting the chip select should set the chip select,
> > > it shouldn't have any impact on transfers.  Transfers should be started
> > > in the transfer operations.
> 
> > This is the only way to assert the CS. It doesn't start transferring any data.
> 
> OK, then you can't implement a separate set_cs() operation and shouldn't
> be trying to do so.  This will break in multiple ways when the framework
> tries to use the operations separately.  You probably need to implement
> a single flat transfer() operation.

As we said it will not start any data transfer. In order to set chip select (chip select only) we need to
1. Frame a control word with following parameters like the chip select that we would like to set and hold time
 2. Update the control word to fifo 

To have a performance advantage (may be not trivial) we are executing this fifo entry along with the first
 Data transfer entry in transfer function so that we can avoid waiting for fifo empty in set_cs function.

 We will ensure CS assert by waiting till the fifo empty in set_cs function and justify the what the 
Function supposed do.

Regards,
Punnaiah
