From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Wed, 19 Sep 2018 10:51:38 +0000
Subject: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
In-Reply-To: <20180918145201.68adcb8d@bbrezillon>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <9a80752f-2db3-bf76-fbf4-e5efaa3974d7@exceet.de>
 <VI1PR04MB1038EDE4B2F5AFC5B0FDE8DF991D0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20180918145201.68adcb8d@bbrezillon>
Message-ID: <VI1PR04MB103854C46FABEDD88EB2D724991C0@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> Sent: Tuesday, September 18, 2018 6:22 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Frieder Schrempf <frieder.schrempf@exceet.de>; linux-
> mtd at lists.infradead.org; marek.vasut at gmail.com; linux-spi at vger.kernel.org;
> devicetree at vger.kernel.org; robh at kernel.org; mark.rutland at arm.com;
> shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org;
> computersforpeace at gmail.com; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
> 
> Hi Yogesh,
> 
> On Tue, 18 Sep 2018 11:34:18 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > >
> > > Do we really need all those macros for registers and modes, that
> > > aren't even used in the driver? I don't know what the common
> > > practice is, but to me it seems like removing all the unused macros
> > > would make the driver much smaller and more readable.
> > >
> > We don't need all Macros currently, but can be needed in future and
> > then have to add again. Generally, we add them all so that in future
> > don't have to dig in datasheet to add basic register details.
> 
> I guess it's just a matter of taste, but I also prefer when all regs are defined even
> if not all of them are used.
> 
Ok.

> [...]
> 
> > >
> > > You are only considering 3 and 4 byte long addresses, which is fine
> > > for NOR chips, but the SPI mem interface allows to connect other
> > > chips like SPI NAND which also use 1 byte addresses.
> > >
> > > In the QSPI driver Boris worked around this restriction by using
> > > LUT_MODE instead of LUT_ADDRESS.
> > >
> > > Does this restriction also exist for FSPI?
> >
> > Yes, I have seen that implementation and first tries with that same
> > logic, using LUT_MODE instead of LUT_ADDR, but didn?t work for the
> > FlexSPI controller.
> >
> > In this controller, we are having separate LUT_XX for RowAddress and
> > ColumnAddress. For case of the Nand flash, we need to program both
> > RowAddress and ColumnAddress in single LUT sequence.
> 
> Hm, I don't get it. LUT_MODE was just a way to pass raw data on the I/O bus, so
> the row vs column thing has no meaning in this case, and the offset withing the
> QSPI AHB range should just be ignored.
> 
I have tried to pass the address with LUT_MODE and it's not working for me.
I am getting basic Read failure at address 0x00 with CS0 also.

I had discussion with the HW IP owner and they suggest to using LUT_ADDR for sending address byte information.

> >
> > IMO, when support needs to be added for NAND flash, then slight
> > modification can be done in the logic. As per my discussion with
> > controller validation guys, needs to send 16-bit addrlen for
> > RowAddress, LUT_ADDR (0x2) Addrlen can vary for the column-address and
> > needs to be programmed for sequence LUT_CADDR_SDR (0x3)
> 
> And that's again flash specific details leaking into the spi-mem layer, which I'd
> like to avoid (as repeated many times before).

Actually, FlexSPI controller has provided the mechanism to pass the value of the address as Row and Column address required, if needed for slave device.
Thus, if needed, we can use this feature of the FlexSPI controller to pass the address [1], section 30.7.6,

> 
> > >
> > > You are using the remapping procedure as in the QSPI NOR driver.
> > > The original purpose was to start with a rather small mapping size
> > > and increase it when a larger memory device is used.
> > >
> > > At the same time you use the logic from the QSPI SPI mem driver,
> > > that adjusts the data.nbytes of each read op to a maximum of
> > > ahb_buf_size in nxp_fspi_adjust_op_size().
> > > This is the logic that Boris introduced for the QSPI driver until we
> > > replace it with something like dirmap.
> > >
> > > Unless there is something I missed, this means the ramapping is
> > > useless and it's enough to reserve memory with the fixed size of
> > > ahb_buf_size.
> >
> > My concern was for performance and that's why has done remap for the
> > 4MB buffer size so that if any subsequent Read request would come
> > within the range then don?t have to perform remap and can just
> > directly do memcpy()
> >
> > I would re-visit again and see if getting any issue in doing direct
> > memcpy() instead of remap. We need to perform AHB buffer invalidation
> > when using controller in both IP(write, erase etc) and AHB (read)
> > mode.
> 
> Then you should really review my dirmap proposal instead of trying to hack
> things directly into your driver. The only reason I did no send a new version of
> the dirmap patchset is because I got no reviews from people that might need it,
> so please have a look at it, try to implement a backend for your controller, and
> let me know if you face any issues or think things should be done differently.
> 
I tried with similar implementation as being done for QuadSPI driver and with that my AHB read are working without any issue for both CS.
Thus, don?t require to perform the re-map again and again when doing AHB data transfer.
Would send the changes in next version.

Regards
Yogesh Gaur.

[1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf

> Thanks,
> 
> Boris
