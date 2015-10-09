From: Minghuan.Lian@freescale.com (Lian M.H.)
Date: Fri, 9 Oct 2015 08:46:08 +0000
Subject: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
 support
In-Reply-To: <CY1PR0301MB07483282288CA4B9F02D6C3F87340@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1442482127-32674-1-git-send-email-Minghuan.Lian@freescale.com>
 <1442482127-32674-2-git-send-email-Minghuan.Lian@freescale.com>
 <CALRxmdChWu7UBK4v4fzuA3KZ5XXRQGoGxAgt_UB0zgJ0ten_uw@mail.gmail.com>
 <CY1PR0301MB07483282288CA4B9F02D6C3F87340@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <DM2PR0301MB06402FBAD3D7F70BCB1453C5E2340@DM2PR0301MB0640.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stuart,

Please see my comments inline.

Thanks,
Minghuan

> -----Original Message-----
> From: Yoder Stuart-B08248
> Sent: Friday, October 09, 2015 8:52 AM
> To: Lian Minghuan-B31939 <Minghuan.Lian@freescale.com>
> Cc: linux-arm-kernel at lists.infradead.org; Jason Cooper
> <jason@lakedaemon.net>; Hu Mingkai-B21284 <Mingkai.Hu@freescale.com>;
> Zang Roy-R61911 <tie-fei.zang@freescale.com>; Thomas Gleixner
> <tglx@linutronix.de>; Li Yang-Leo-R58472 <LeoLi@freescale.com>
> Subject: RE: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
> support
> 
> 
> 
> > -----Original Message-----
> > From: Stuart Yoder [mailto:b08248 at gmail.com]
> > Sent: Thursday, October 08, 2015 7:48 PM
> > To: Yoder Stuart-B08248
> > Subject: Fwd: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI
> > controller support
> >
> > ---------- Forwarded message ----------
> > From: Minghuan Lian <Minghuan.Lian@freescale.com>
> > Date: Thu, Sep 17, 2015 at 4:28 AM
> > Subject: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
> > support
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: Jason Cooper <jason@lakedaemon.net>, Hu Mingkai-B21284
> > <B21284@freescale.com>, Yoder Stuart-B08248
> > <stuart.yoder@freescale.com>, Zang Roy-R61911 <r61911@freescale.com>,
> > Minghuan Lian <Minghuan.Lian@freescale.com>, Thomas Gleixner
> > <tglx@linutronix.de>, Li Yang <leoli@freescale.com>
> >
> >
> > Some SoC of Freescale Layerscape provide a kind of MSI controller
> > which uses two registers MSIIR and MSIR to support 32 MSI interrupts
> > for each PCIe controller. The patch is to support it.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > ---
> >  .../bindings/interrupt-controller/fsl,ls1-msi.txt  |  26 +++
> >  arch/arm/mach-imx/Kconfig                          |   1 +
> >  drivers/irqchip/Kconfig                            |   5 +
> >  drivers/irqchip/Makefile                           |   1 +
> >  drivers/irqchip/irq-ls1-msi.c                      | 247
> +++++++++++++++++++++
> >  5 files changed, 280 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/interrupt-controller/fsl,ls1-msi.txt
> >  create mode 100644 drivers/irqchip/irq-ls1-msi.c
> >
> > diff --git
> > a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls1-msi.t
> > xt
> > b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls1-msi.t
> > xt
> > new file mode 100644
> > index 0000000..29296c1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls1-m
> > +++ si.txt
> > @@ -0,0 +1,26 @@
> > +* Freescale Layerscape PCIe MSI controller
> > +
> > +Required properties:
> > +
> > +- compatible: should be "fsl,<chip>-msi" to identify
> > +             Layerscape PCIe MSI controller block.
> > +- msi-controller: indicates that this is a PCIe MSI controller node
> > +- reg: Should contain msiir and msir registers location and length.
> > +       MSIIR is a MSI index register to trigger interrupts.
> > +       MSIR indicates which of the 32 interrupt sources have pending
> interrupt.
> > +- reg-names: should be "msiir" and "msir".
> > +- interrupts: A interrupt of the controller.
> > +
> > +Each PCIe node needs to have property msi-parent that points to MSI
> > +controller node
> > +
> > +Examples:
> > +
> > +       msi1: msi-controller1 at 1571000 {
> > +               compatible = "fsl,1s1043a-msi";
> > +               reg = <0x0 0x1571000 0x0 0x4>,
> > +                     <0x0 0x1571004 0x0 0x4>;
> > +               reg-names = "msiir", "msir";
> > +               msi-controller;
> > +               interrupts = <0 116 0x4>;
> > +       };
> 
> Why does this binding explicitly define registers like this?  The 2 registers are
> in consecutive words, so why isn't a reg property defining both regs enough?
> Why do you have a reg-names property?  It does not seem to be used by the
> driver.
> 
[Lian Minghuan-B31939] Because the register MSIIR and MSIR on our PowerPC implementation is discontinuous, even the offset between them is different for different MSI controller. So I defines the register separately. Maybe I thought too much. If they are  always continuous on all the Layerscape MSI implementation, I will remove 'reg-names'.

> Stuart
