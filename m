From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Tue, 18 Sep 2018 08:28:23 +0000
Subject: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
In-Reply-To: <9529c765-cb3b-02f9-df15-4f79cfa48e47@exceet.de>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180917133751.453ea6ed@bbrezillon>
 <9529c765-cb3b-02f9-df15-4f79cfa48e47@exceet.de>
Message-ID: <VI1PR04MB1038A85DC36665244DF2104A991D0@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frieder,

> -----Original Message-----
> From: Frieder Schrempf [mailto:frieder.schrempf at exceet.de]
> Sent: Tuesday, September 18, 2018 1:52 PM
> To: Boris Brezillon <boris.brezillon@bootlin.com>; Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd at lists.infradead.org; marek.vasut at gmail.com; linux-
> spi at vger.kernel.org; devicetree at vger.kernel.org; robh at kernel.org;
> mark.rutland at arm.com; shawnguo at kernel.org; linux-arm-
> kernel at lists.infradead.org; computersforpeace at gmail.com; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
> 
> Hi Boris, Yogesh,
> 
> On 17.09.2018 13:37, Boris Brezillon wrote:
> > Hi Yogesh,
> >
> > On Mon, 17 Sep 2018 15:18:26 +0530
> > Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >
> >> +
> >> +	/*
> >> +	 * R/W functions for big- or little-endian registers:
> >> +	 * The FSPI controller's endianness is independent of
> >> +	 * the CPU core's endianness. So far, although the CPU
> >> +	 * core is little-endian the FSPI controller can use
> >> +	 * big-endian or little-endian.
> >> +	 */
> >> +	if (of_property_read_bool(np, "big-endian")) {
> >> +		f->write = fspi_writel_be;
> >> +		f->read = fspi_readl_be;
> >> +	} else {
> >> +		f->write = fspi_writel;
> >> +		f->read = fspi_readl;
> >> +	}
> >
> > Hm, isn't it something you can extract from the compatible string? I'd
> > rather not allow users to set that in their DT if it's not something
> > you can change.
> 
> This was copied from the QSPI driver, but I think Boris is right. This seems to be a
> fixed SOC-specific setting and we shouldn't set it in the DT. This applies to QSPI
> and FSPI alike.
> 

Yes, it can be modified. Instead of reading endianness property from device tree can be moved to the platform structure nxp_fspi_devtype_data which is linked with the compatible string
{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, }

Thanks.

Would send the changes in next version.

--
Regards,
Yogesh Gaur.

> Regards,
> Frieder
> 
> >
> > Regards,
> >
> > Boris
> >
