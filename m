From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 1 Oct 2018 11:09:46 +0200
Subject: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
In-Reply-To: <VI1PR04MB10381FD703F054F33B9BA6BE99EF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537525323-20730-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180929174023.51b1e284@bbrezillon>
 <7c10ced6-91af-187a-0c34-ce9b3e897e2e@exceet.de>
 <VI1PR04MB10381FD703F054F33B9BA6BE99EF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Message-ID: <20181001110946.5330a90e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Oct 2018 09:02:32 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > static void fspi_writel(struct nxp_fspi *f, u32 val, void __iomem
> > > *addr) {
> > > 	if (f->big_endian)
> > > 		iowrite32be(val, addr);
> > > 	else
> > > 		iowrite32(val, addr);
> > > }
> > >
> > >
> > > static u32 fspi_readl(struct nxp_fspi *f, void __iomem *addr) {
> > > 	if (f->big_endian)
> > > 		return ioread32be(addr);
> > > 	else
> > > 		return ioread32(addr);
> > > }  
> > 
> > I introduced the ->read/write() hooks in the QSPI driver because I
> > was told to remove the conditional in the read/write path, but I
> > can't really tell if this really makes any difference.
> >   
> Yes, I have taken these hooks by looking into the comments received
> for Frieder's QSPI patch series. For me this looks more clean and can
> be decided in the controller initialization sequence which hook would
> going to be invoked.


Well, depending on your CPU, the indirect branch (caused by the
function pointer call) might have an higher cost than the conditional
branch. Not sure we care about such micro-optimizations though.
Regarding the readability aspect, I still prefer my version, but I
guess that's a matter of taste.
