From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Tue, 23 Oct 2018 09:12:52 +0000
Subject: [PATCH RESEND v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
In-Reply-To: <20181023110634.26ff2629@bbrezillon>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1540284888-32307-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181023110634.26ff2629@bbrezillon>
Message-ID: <VI1PR04MB1038247D1A2B65268F76F8F099F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> Sent: Tuesday, October 23, 2018 2:37 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd at lists.infradead.org; marek.vasut at gmail.com;
> broonie at kernel.org; linux-spi at vger.kernel.org; devicetree at vger.kernel.org;
> robh at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org; linux-arm-
> kernel at lists.infradead.org; computersforpeace at gmail.com;
> frieder.schrempf at exceet.de; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH RESEND v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI
> controller
> 
> On Tue, 23 Oct 2018 08:56:46 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > +struct nxp_fspi {
> > +	void __iomem *iobase;
> > +	void __iomem *ahb_addr;
> > +	u32 memmap_phy;
> > +	u32 memmap_phy_size;
> > +	struct clk *clk, *clk_en;
> > +	struct device *dev;
> > +	struct completion c;
> > +	const struct nxp_fspi_devtype_data *devtype_data;
> > +	struct mutex lock;
> > +	struct pm_qos_request pm_qos_req;
> > +	int selected;
> > +	void (*write)(u32 val, void __iomem *addr);
> > +	u32 (*read)(void __iomem *addr);
> 
> I think I already commented on this aspect, and I keep thinking having a function
> pointer is overkill here.
> Just declare 2 functions and do the f->devtype_data->little_endian check in
> there:
> 
> static u32 fspi_readl(struct nxp_fspi *f, void __iomem *addr) {
> 	if (f->devtype_data->little_endian)
> 		return ioread32(addr);
> 
> 	return ioread32be(addr);
> }
> 
> static void fspi_writel(struct nxp_fspi *f, u32 val, void __iomem *addr) {
> 	if (f->devtype_data->little_endian)
> 		iowrite32(val, addr);
> 
> 	iowrite32be(val, addr);
> }

This, I have kept same as being done in spi-fsl-qspi.c driver file as Frieder have got the comment to remove the condition in read/write path and he has introduced these hooks there.

Would remove in next version. Please review other changes and complete driver file.

--
Regards
Yogesh Gaur
