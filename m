From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Thu, 6 Sep 2018 11:35:13 +0000
Subject: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI controller
In-Reply-To: <add79e8b-1ab7-e465-5f65-eed6b78161e1@exceet.de>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1535711404-29528-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180904165842.774ed960@bbrezillon>
 <VI1PR04MB1038CE65EF4E98ACBEA9990B99020@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <add79e8b-1ab7-e465-5f65-eed6b78161e1@exceet.de>
Message-ID: <VI1PR04MB1038AB7497A2FD3E73FBA6D699010@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frieder,

> -----Original Message-----
> From: Frieder Schrempf [mailto:frieder.schrempf at exceet.de]
> Sent: Thursday, September 6, 2018 1:56 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Boris Brezillon
> <boris.brezillon@bootlin.com>
> Cc: linux-mtd at lists.infradead.org; marek.vasut at gmail.com; linux-
> spi at vger.kernel.org; devicetree at vger.kernel.org; robh at kernel.org;
> mark.rutland at arm.com; shawnguo at kernel.org; linux-arm-
> kernel at lists.infradead.org; computersforpeace at gmail.com; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI controller
> 
> >> Hi Yogesh,
> >>
> >> On Fri, 31 Aug 2018 16:00:00 +0530
> >> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >>
> >>> - Add a driver for NXP FlexSPI host controller
> >>>
> >>
> >> Yep, I had a quick look at the code and they really look similar. Why
> >> not extending the existing driver instead of creating a new one from scratch?
> >>
> >
> > FlexSPI is different controller not related to the QuadSPI controller
> > in its working behavior Both these controller are having
> > * Different registers name, registers address, registers functionality
> > etc, section 30.5.2[1]
> > * Different programming sequence for initialization of the controller,
> > section 30.8.1[1]
> > * Different programming sequence for performing Read and Write
> > operation using IP, section 30.7.9[1] and AHB mode
> > * Different programming sequence for checking controller current state
> > like busy or not
> > * New mechanism to program for the connected slave device i.e. flash
> > access mode and flash memory map 30.7.4[1] and 30.7.5[1]
> > * New entries added for FlexSPI controller for LUT_XX mode for various
> > commands, section 30.7.8[1]
> >
> > There are few similarities between these two like LUT programming
> > logic is same i.e. LUT needs to be programmed in same sequence of 'INSTR
> PAD  OPCODE', but again LUT register address and LUT command mode values
> are different.
> >
> > Creating common driver for both FlexSPI and QuadSPI controller, would
> involve creation of one more layer between driver/spi/spi-xxx and the actual
> controller driver, this layer would going to have less functionality like doing LUT
> creation programming and then would re-direct calls to the respective controller
> driver functionality to perform desired programming sequence.
> >
> >>>
> >>> (1) The FlexSPI controller is driven by the LUT(Look-up Table)
> >>> registers.
> >>>   The LUT registers are a look-up-table for sequences of instructions.
> >>>   A valid sequence consists of four LUT registers.
> >>>   Maximum 32 LUT sequences can be programmed simultaneously.
> >>>
> >>
> >> Do we really want to have this level of details in the commit message?
> >> I mean, this is something you can document in the driver, but not here.
> >>
> >> BTW, you might want to have a look at [1]. I think we can get rid of
> >> the ->size field you're adding if this driver implements the dirmap hooks.
> >>
> >
> > I need size information for the connected device to program the controller
> register FLSHXXCRO as Flash Chip select is determined by flash access address
> and Flash size setting in register FLSHXXCR0[FLSHz], section 30.7.9[1].
> 
> It's the same situation we had with the QSPI driver before. We decided to
> **not** pass information about flash size directly to the controller for now.
> That's why we currently don't support mapping the flash device in the
> implementation of the QSPI driver.
> 
> I think we should not start this discussion all over again for the FlexSPI driver, but
> stick to what we decided for QSPI.
> 

There is difference between FlexSPI and QuadSPI controller functionality in detecting the current CS.

As per table-10.32[1] for QuadSPI controller, access to flash is being assigned as per the address values provided i.e. it would be CS0 if address is between TOP_ADDR_MEMXX and QSPI_AMBA_BASE and CS1 if access is in between TOP_ADDR_MEMA2 and TOP_ADDR_MEMA1.

But for case of FlexSPI controller, section 30.7.5[2],  CS is being defined as per the address value lies in below range
- Flash A1 address range: 0x00000000 ~ FA1_SIZE
- Flash A2 address range: FA1_SIZE ~ (FA1_SIZE + FA2_SIZE)
- Flash B1 address range: (FA1_SIZE + FA2_SIZE) ~ (FA1_SIZE + FA2_SIZE + FB1_SIZE)
- Flash B2 address range: FA1_SIZE + FA2_SIZE + FB1_SIZE) ~ (FA1_SIZE + FA2_SIZE + FB1_SIZE + FB2_SIZE)
and FAx_SIZE is determined from register FLSHxxCR0[FLASHSZ]

Thus, for QuadSPI controller we can actually go away with the flash size requirement and with the code logic which you have introduced, of using 2 * ahb_buf_size data size for TOP_ADDR_MEMXX bits in SFxxD register, things are working fine.

But for FlexSPI controller its required to have the connected slave device size to detect the current CS.
I have tried the quadspi driver logic in flexspi driver code, but it gives me failure. 
Due, to this reason and requirement I have come-up with this solution of getting the connected device size and programming correct value in FLSHxxCR0[FLASHSZ] register

> >
> > Link for reference of the driver implementing dirmap hooks was missing in mail,
> please share.
> 
> I guess Boris meant to link to his PoC implementation of the direct mapping API
> [1]. When this is available we can easily add support for direct memory
> mappings to the QuadSPI and FlexSPI drivers.
> 

I have checked the link, found that size value is being derived from spi_nor.mtd.size variable.
Same being performed in this patch series to detect the size of the slave device.
As per my understanding developed with Boris's code implementation, when direct mapping API interface are available then both QuadSPI and FlexSPI driver needs to be changed as per new introduced ops structure.

[1] https://www.nxp.com/docs/en/reference-manual/VFXXXRM.pdf
[2] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf

Regards,
Yogesh Gaur

> >
> >>>
> >>> (6) Tested this driver with the mtd_debug and JFFS2 filesystem
> >>> utility on NXP LX2160ARDB and LX2160AQDS targets.
> >>>   LX2160ARDB is having two NOR slave device connected on single bus
> >>> A i.e. A0 and A1 (CS0 and CS1).
> >>>   LX2160AQDS is having two NOR slave device connected on separate
> >>> buses one flash on A0 and second on B1 i.e. (CS0 and CS3).
> >>>   Verified this driver on following SPI NOR flashes:
> >>>      Micron, mt35xu512ab, [Read - 1 bit mode]
> >>>      Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> >>
> >> Ok, that's good to have in the commit message.
> >>
> >>>
> >>> - Add config option entry in 'spi-nor/Kconfig' for FlexSPI driver.
> >>
> >> But this one is useless. If you add a new driver, you have no other
> >> choice but to add a new entry in the Kconfig file.
> >>
> >>>
> >>> - Add entry in the 'spi-nor/Makefile'.
> >>>
> >>
> >> Ditto.
> >>
> >> Before you re-send a new version, I'd like to understand why you
> >> think you need to create a new driver, and I want you to try to
> >> implement the dirmap hook and check if you can get rid of the ->size field
> when doing that.
> >>
> >> I also seem one extra benefit to having a single driver for both
> >> FlexSPI and QuadSPI IPs: you'll help Frieder debug the last remaining
> >> problems you reported on the new QuadSPI driver :-P.
> >
> > Regarding testing of the QuadSPI driver on spi-mem framework, I have already
> given suggestions to the Frieder and my local changes using which flash
> connected at CS0 and CS1 starts working for read/write/erase commands on
> ls1088ardb target.
> >
> > Current v2 which has been shared, data operation for the slave flash device
> connected at CS1 is not working.
> > I have to make changes for the calculation of flash base address for the
> requested chip select and changes in address remapping the buffer in AHB read
> case for CS1 access to work.
> 
> Yes you posted your changes to make the driver work for your board. The
> problem is, that I don't yet understand why they are needed and how they
> actually fix the chip select issue.
> 
> Han has pointed out the reason why ioremap() was added to the driver [2] in the
> first place and this seems unrelated to the CS selection issue.
> 
> Therefore Boris and I have requested more information about how the IP works
> and more tests from other people.
> 
> As long as we don't get more information about the questions posted before
> [3][4], we are kind of blocked.
> 
> [1]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.
> com%2Fbbrezillon%2Flinux%2Fcommits%2Fspi-mem-
> dirmap&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7Ca2b9f169
> 9b2c41dff6f208d613d26342%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C636718191692315469&amp;sdata=3QnzkYXNq53eHWcUnpzUMNILtHyA
> TEemtiU0O9rRUA4%3D&amp;reserved=0
> [2]
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infr
> adead.org%2Fpipermail%2Flinux-mtd%2F2018-
> August%2F083218.html&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.c
> om%7Ca2b9f1699b2c41dff6f208d613d26342%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C636718191692315469&amp;sdata=D6oroCChTr8oHFGI
> 9GHuTU8aQLcponHdbOw9UE2C7Og%3D&amp;reserved=0
> [3]
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infr
> adead.org%2Fpipermail%2Flinux-mtd%2F2018-
> August%2F083209.html&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.c
> om%7Ca2b9f1699b2c41dff6f208d613d26342%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C636718191692325482&amp;sdata=lKK7dxIyRGbLNeHW
> LjkwQ9m%2Bs9y9sI8dsZYy3BjIxlQ%3D&amp;reserved=0
> [4]
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infr
> adead.org%2Fpipermail%2Flinux-mtd%2F2018-
> August%2F083233.html&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.c
> om%7Ca2b9f1699b2c41dff6f208d613d26342%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C636718191692325482&amp;sdata=6kieWJ7zUX2u%2FfE
> BiWiNEqroHoBwh1GeCOPRoHWSQ7U%3D&amp;reserved=0
> 
> Thanks,
> Frieder
