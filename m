From: marex@denx.de (Marek Vasut)
Date: Wed, 16 Oct 2013 15:57:40 +0200
Subject: [PATCH 5/6] PCI: imx6: Force Gen1 operation
In-Reply-To: <20131016055427.GB2740@pratyush-vbox>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <1381853200-5534-6-git-send-email-marex@denx.de>
 <20131016055427.GB2740@pratyush-vbox>
Message-ID: <201310161557.41041.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Pratyush Anand,

> On Wed, Oct 16, 2013 at 12:06:39AM +0800, Marek Vasut wrote:
> > Without forcing the PCIe core into Gen1 operation, the PCIe switch
> > attached directly to the PCIe port is not recognised at all. The
> > PCIe switch is Gen2 capable to make this issue even more puzzling.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Frank Li <lznuaa@gmail.com>
> > Cc: Jingoo Han <jg1.han@samsung.com>
> > Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> > Cc: Pratyush Anand <pratyush.anand@st.com>
> > Cc: Richard Zhu <r65037@freescale.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Sean Cross <xobs@kosagi.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> > Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> > Cc: Tim Harvey <tharvey@gateworks.com>
> > Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > ---
> > 
> >  drivers/pci/host/pci-imx6.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index ca8c5de..8402e9a 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -321,6 +321,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
> > 
> >  {
> >  
> >  	int count = 0;
> >  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> > 
> > +	uint32_t tmp;
> > 
> >  	imx6_pcie_assert_core_reset(pp);
> > 
> > @@ -330,13 +331,23 @@ static void imx6_pcie_host_init(struct pcie_port
> > *pp)
> > 
> >  	dw_pcie_setup_rc(pp);
> > 
> > +	/*
> > +	 * FIXME:
> > +	 * Force Gen1 operation. In case the IP block is in Gen2 operation
> > +	 * mode, it does not detect the PCIe switch at all.
> > +	 */
> > +	tmp = readl(pp->dbi_base + 0x7c);
> > +	tmp &= ~0xf;
> > +	tmp |= 0x1;
> > +	writel(tmp, pp->dbi_base + 0x7c);
> > +
> 
> Since you are forcing RC to work in GEN1, so you will not be able to
> connect any device at GEN2 now.

I'd rather prefer to know WHY if the RC is operating in Gen2 mode by default, I 
cannot see the PCIe switch (Pericom PI7C9X2G303) connected to it. I was unable 
to figure this out. Tim pointed out this thread [1] , so it might be related in 
some way.

[1] https://community.freescale.com/message/316162#316162

I tried switching the PCIe RC to Gen2 operation right after LinkUp by writing 
this register with 0x2 again and re-issuing the LinkUp check, which passed and 
the status register reported Gen2 operation, but then the PCIe Intel NIC 
connected to the downstream port of the Pericom switch still reported Gen1 
operation for some reason.

> Yes, There are some buggy PCIe devices which works with GEN1 only host.

The pericom one is Gen2 according to it's datasheet.

> So better solution should be to initialize RC by default at GEN2 or
> highest speed. Further, a parameter say gen_only can be passed from
> DT to force GEN1 only mode.
> 
> What do you say?

I say I'd like to know the root cause of this problem. This Gen2 fix was pulled 
from one of the myriad variants of the FSL PCIe driver, so apparently this issue 
happens to other people as well. But why and how to properly fix this so the 
whole PCIe bus does operate in Gen2 mode, I cannot tell :-(
