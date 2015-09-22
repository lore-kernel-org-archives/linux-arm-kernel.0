From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 22 Sep 2015 23:15:04 +0100
Subject: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
In-Reply-To: <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
Message-ID: <20150922221504.GA1497@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 10:50:21AM +0100, Hou Zhiqiang wrote:
> Hi Mark,
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland at arm.com]
> > Sent: 2015?9?22? 9:24
> > To: Hou Zhiqiang-B48286; marc.zyngier at arm.com
> > Cc: linux-arm-kernel at lists.infradead.org; Catalin Marinas; Will Deacon;
> > linux-i2c at vger.kernel.org; linux-watchdog at vger.kernel.org; linux-
> > doc at vger.kernel.org; linux-clk at vger.kernel.org; Xie Shaohui-B21989;
> > corbet at lwn.net; Sharma Bhupesh-B45370; mturquette at baylibre.com; wsa at the-
> > dreams.de; sboyd at codeaurora.org; wim at iguana.be; Song Wenbin-B53747; Wood
> > Scott-B07421; Hu Mingkai-B21284; Li Yang-Leo-R58472
> > Subject: Re: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
> >
> > Hi,
> >
> > > +/memreserve/ 0x80000000 0x00010000;
> >
> > Why is this necessary?
> 
> This memory region is pre-reserved for the spin-table/psci, although didn't add
> Enable method of secondary cores.

Your PSCI implementation isn't in secure memory?

> > > +       ifc: ifc at 1530000 {
> > > +               compatible = "fsl,ifc", "simple-bus";
> > > +               reg = <0x0 0x1530000 0x0 0x10000>;
> > > +               interrupts = <0 43 0x4>;
> > > +       };
> >
> > Why simple-bus?
> 
> There are 3 child node located in dtsi file that should be created and added
> to platform device list.

Are they usable even if the kernel knew nothing about the IFC node? If not, the
IFC driver should probe them, and simple-bus should go.

> > > +       memory at 80000000 {
> > > +               device_type = "memory";
> > > +               reg = <0x0 0x80000000 0 0x80000000>;
> > > +                     /* DRAM space 1 - 2 GB DRAM */
> >
> > I don't understand the comment. This describes 2GB at 2GB.
> >
> 
> Yes, there is a 2GB space for DRAM from address 2G.
> The DRAM address 0x0 will be remapped to SoC address 2G, this remap is done by hardware.

I just realised my mistake -- I read this as "1 to 2 GB", when this is actually
"DRAM space 1". Sorry for the noise.

Thanks,
Mark.
