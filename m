From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 30 May 2018 01:38:22 +0000
Subject: [PATCH] soc: imx: gpcv2: correct PGC offset
In-Reply-To: <0e0690c89b24b4b028e4a0dab63334af4b37fdd3.camel@nxp.com>
References: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com>
 <0e0690c89b24b4b028e4a0dab63334af4b37fdd3.camel@nxp.com>
Message-ID: <AM3PR04MB1315EFC9F5CA9DBD7CBC54B5F56C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Leonard

Anson Huang
Best Regards!


> -----Original Message-----
> From: Leonard Crestez
> Sent: Tuesday, May 29, 2018 10:03 PM
> To: Anson Huang <anson.huang@nxp.com>; shawnguo at kernel.org; Andrey
> Smirnov <andrew.smirnov@gmail.com>
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; s.hauer at pengutronix.de;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>; Abel Vesa
> <abel.vesa@nxp.com>; Richard Liu <xuegang.liu@nxp.com>
> Subject: Re: [PATCH] soc: imx: gpcv2: correct PGC offset
> 
> On Tue, 2018-05-29 at 16:02 +0800, Anson Huang wrote:
> > Correct MIPI/PCIe/USB_HSIC's PGC offset based on design RTL, the value
> > on Reference Manual are incorrect.
> >
> > The correct offset should be as below:
> >
> > -#define PGC_MIPI			4
> > -#define PGC_PCIE			5
> > -#define PGC_USB_HSIC			8
> > +#define PGC_MIPI			16
> > +#define PGC_PCIE			17
> > +#define PGC_USB_HSIC			20
> >  #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
> >  #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
> 
> This gpcv2 driver is currently only used for PCI, it probably only works because
> domains happen to be turned on by default?
 
I think so.

> 
> On imx7d upstream platform suspend is not yet supported but even doing
> device-level suspend causes a hang on resume somewhere in PCI on first read.
> This patch fixes that immediate hang.

I just added the imx7d platform suspend/resume support using psci in u-boot, patches
are sent out for review. 

I did notice PCI resume cause system hang, the root cause is PCI controller registers
can NOT be accessed after resume, and the PCI PHY PLL is NOT locked when issue happen,
the PCI driver should implement suspend/resume and redo the init flow after resume, since
its power VDD1P0D are OFF after suspend.

I saw you sent out patch to fix it, thanks.

Anson.

> 
> After suspend/resume lspci is broken (device doesn't properly resume), that
> probably requires more imx pci patches and unrelated to pgc.
> 
> --
> Regards,
> Leonard
