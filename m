From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Sep 2018 22:53:13 +0200
Subject: [PATCH 1/6] PCI: iproc: Update iProc PCI binding for INTx support
In-Reply-To: <20180918134152.GA31440@e107981-ln.cambridge.arm.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-2-git-send-email-ray.jui@broadcom.com>
 <CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com>
 <20180918134152.GA31440@e107981-ln.cambridge.arm.com>
Message-ID: <CAK8P3a3cWHK=DNCFn+p_NjSyXhoLQw07EVedVf5-UFdz4V4OPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 3:42 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Jun 04, 2018 at 09:17:49AM -0500, Rob Herring wrote:
> > +Arnd
> >
> > On Tue, May 29, 2018 at 4:58 PM, Ray Jui <ray.jui@broadcom.com> wrote:
> > > Update the iProc PCIe binding document for better modeling of the legacy
> > > interrupt (INTx) support
> > >
> > > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > > ---
> > >  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++++++++++++++-----
> > >  1 file changed, 24 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> > > index b8e48b4..7ea24dc 100644
> > > --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> > > +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> > > @@ -13,9 +13,6 @@ controller, used in Stingray
> > >    PAXB-based root complex is used for external endpoint devices. PAXC-based
> > >  root complex is connected to emulated endpoint devices internal to the ASIC
> > >  - reg: base address and length of the PCIe controller I/O register space
> > > -- #interrupt-cells: set to <1>
> > > -- interrupt-map-mask and interrupt-map, standard PCI properties to define the
> > > -  mapping of the PCIe interface to interrupt numbers
> > >  - linux,pci-domain: PCI domain ID. Should be unique for each host controller
> > >  - bus-range: PCI bus numbers covered
> > >  - #address-cells: set to <3>
> > > @@ -41,6 +38,16 @@ Required:
> > >  - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
> > >  address used by the iProc PCIe core (not the PCIe address)
> > >
> > > +Legacy interrupt (INTx) support (optional):
> > > +
> > > +Note INTx is for PAXB only.
> > > +
> > > +- interrupt-controller: claims itself as an interrupt controller for INTx
> > > +- #interrupt-cells: set to <1>
> > > +- interrupt-map-mask and interrupt-map, standard PCI properties to define
> > > +the mapping of the PCIe interface to interrupt numbers
> > > +- interrupts: interrupt line wired to the generic GIC for INTx support
> > > +
> > >  MSI support (optional):
> > >
> > >  For older platforms without MSI integrated in the GIC, iProc PCIe core provides
> > > @@ -77,9 +84,14 @@ Example:
> > >                 compatible = "brcm,iproc-pcie";
> > >                 reg = <0x18012000 0x1000>;
> > >
> > > +               interrupt-controller;
> > >                 #interrupt-cells = <1>;
> > > -               interrupt-map-mask = <0 0 0 0>;
> > > -               interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
> > > +               interrupt-map-mask = <0 0 0 7>;
> > > +               interrupt-map = <0 0 0 1 &pcie0 1>,
> >
> > Are you sure this works? The irq parsing code will ignore
> > interrupt-map if interrupt-controller is found. In other words, you
> > should have one or the other, but not both.
> >
> > Maybe it happens to work because "pcie0" is this node and your irq
> > numbers are the same.
> >
> > Arnd, any thoughts on this?
>
> To start with, I think the destination IRQ number is wrong, what the
> mappings actually do is mapping the PCI interrupt line (ie #INTA, #INTB,
> #INTC, #INTD) to input {0,1,2,3} of the PCI host bridge (pseudo)
> interrupt controller.
>
> I really want to clean this up since currently there are different
> DT bindings defining this in different ways which resulted in
> non-consistent kernel code.
>
> AFAICS, the Aardvark PCIe controller bindings define the mapping
> as I expect:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/aardvark-pci.txt?h=v4.19-rc4
>
> but I would like to get Rob and Arnd viewpoint on this so that
> we can close this topic once for all.

It seems ambiguous at best, as Rob suggested it may only
work by accident. Since there is only one upstream interrupt,
could we simply list <GIC_SPI 100 IRQ_TYPE_NONE> as
the destination for any IntX?

        Arnd
