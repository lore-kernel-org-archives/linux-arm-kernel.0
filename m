From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 24 Jun 2018 04:23:34 +0000
Subject: [RFC] Configure i.MX6 RGMII pad group control registers from
 device tree
In-Reply-To: <5ab5c58a-dc44-d1bc-2132-8704d05bf1de@ysoft.com>
References: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
 <5ab5c58a-dc44-d1bc-2132-8704d05bf1de@ysoft.com>
Message-ID: <AM0PR04MB42111E25172F6068F937ECCB804B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy Andy & Frank,

> -----Original Message-----
> From: Michal Vok?? [mailto:michal.vokac at ysoft.com]
> Sent: Tuesday, June 12, 2018 11:10 PM
> To: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> Estevam <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> devicetree at vger.kernel.org; A.s. Dong <aisheng.dong@nxp.com>; Fabio
> Estevam <festevam@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> Stefan Agner <stefan@agner.ch>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Linus Walleij <linus.walleij@linaro.org>; linux-
> kernel at vger.kernel.org
> Subject: Re: [RFC] Configure i.MX6 RGMII pad group control registers from
> device tree
> 
> On 11.6.2018 14:36, Michal Vok?? wrote:
> > Ahoj,
> >
> > To configure individual pad's characteristics on i.MX6 SoC a fsl,pins
> > = <PIN_FUNC_ID CONFIG> property can be used. Is there any convenient
> > way to configure the pad group control registers?
> >
> > The issue is that some bits (DDR_SEL and ODT) in the individual RGMII
> > pad control registers are read-only. To tweak those parameters (signal
> > voltage and termination resistors) one need to write to the pad group
> > control registers for the whole RGMII pad group. Namely
> > IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE_RGMII and
> > IOMUXC_SW_PAD_CTL_GRP_RGMII_TERM. The group registers in general
> are not accessible from the list in arch/arm/boot/dts/imx6dl-pinfunc.h.
> >
> > I could not find any other way to change the group registers than
> > hacking-in some lines into the imx6q_init_machine(void) function in
> > arch/arm/mach-imx/mach-imx6q.c source. As I work towards upstreaming
> > my board this should be done from my device tree or solved in some
> universal way.
> >
> > Any hints will be much appreciated.
> > Michal
> 
> I figured out this is more "pinctrl-imx.c" than "device-tree" related so I am
> kindly adding maintainers of that file in hope somebody will shed some light
> to it.
> 
> I am diving deeper into the code and it seems there really is no generic
> option to set the i.MX6 pad group control registers from device tree.
> Or am I looking at the problem from a wrong angle?
> 

Yes, there's a few special pad group ctrl registers (e.g. DRAM and RGMII for mx6q)
which are not added In the pinctrl driver support.

> How should we deal with boards that need to configure some pad
> characteristics available only through the pad group control registers?
> 

Andy,
How do we handle it internally?

> I also raised this question at the NXP community forum [1] and get quite
> unsatisfying answer so far. I would love to find/implement a proper and
> universal solution.
> 

There're probably two ways to do it:
1) handle it in fec driver by parsing a specific property
2) Add a new pad group into pinctrl driver support
e.g.
MX6Q_PAD_CTL_GRP_RGMII_TERM
MX6Q_PAD_CTL_GRP_DDR_TYPE_RGMII

I may prefer to 2).

Regards
Dong Aisheng

> Thanks in advance for your time,
> Michal
> 
> [1]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fco
> mmunity.nxp.com%2Fthread%2F477464&data=02%7C01%7Caisheng.dong%4
> 0nxp.com%7Ca3e5463eb06a47f1121008d5d0768a04%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C1%7C636644129914162495&sdata=xqtBS8uX%2BSzq
> 5m6tbNaLzCkB7ezgHSnyu9GQ3K13cW8%3D&reserved=0
