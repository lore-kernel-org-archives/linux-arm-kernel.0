From: jim2101024@gmail.com (Jim Quinlan)
Date: Fri, 21 Sep 2018 14:00:39 -0400
Subject: [PATCH v5 02/12] dt-bindings: pci: add DT docs for Brcmstb PCIe
 device
In-Reply-To: <CAOiHx=mEKoHz6t=PbnG801e2u8GG=ct7ypMTKZ=EALKJhBZf=g@mail.gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-3-git-send-email-jim2101024@gmail.com>
 <CAOiHx=mEKoHz6t=PbnG801e2u8GG=ct7ypMTKZ=EALKJhBZf=g@mail.gmail.com>
Message-ID: <CANCKTBs1VqJCFFJAseJ8Kk8_d7PnniD55dc20-NwAKj8f6jFmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 5:06 AM Jonas Gorski <jonas.gorski@gmail.com> wrote:
>
> On 19 September 2018 at 16:31, Jim Quinlan <jim2101024@gmail.com> wrote:
> > The DT bindings description of the Brcmstb PCIe device is described.
> > This node can be used by almost all Broadcom settop box chips, using
> > ARM, ARM64, or MIPS CPU architectures.
>
> Oh, hey, *one* email made it finally through :P

Sigh, I'm still having email issues, my apologies.

>
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/pci/brcmstb-pcie.txt       | 59 ++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt b/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
> > new file mode 100644
> > index 0000000..a1a9ad5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
> > @@ -0,0 +1,59 @@
> > +Brcmstb PCIe Host Controller Device Tree Bindings
> > +
> > +Required Properties:
> > +- compatible
> > +  "brcm,bcm7425-pcie" -- for 7425 family MIPS-based SOCs.
> > +  "brcm,bcm7435-pcie" -- for 7435 family MIPS-based SOCs.
> > +  "brcm,bcm7445-pcie" -- for 7445 and later ARM based SOCs (not including
> > +      the 7278).
> > +  "brcm,bcm7278-pcie"  -- for 7278 family ARM-based SOCs.
> > +
> > +- reg -- the register start address and length for the PCIe reg block.
> > +- interrupts -- two interrupts are specified; the first interrupt is for
> > +     the PCI host controller and the second is for MSI if the built-in
> > +     MSI controller is to be used.
> > +- interrupt-names -- names of the interrupts (above): "pcie" and "msi".
> > +- #address-cells -- set to <3>.
> > +- #size-cells -- set to <2>.
> > +- #interrupt-cells: set to <1>.
> > +- interrupt-map-mask and interrupt-map, standard PCI properties to define the
> > +     mapping of the PCIe interface to interrupt numbers.
> > +- ranges: ranges for the PCI memory and I/O regions.
> > +- linux,pci-domain -- should be unique per host controller.
> > +
> > +Optional Properties:
> > +- clocks -- phandle of pcie clock.
> > +- clock-names -- set to "sw_pcie" if clocks is used.
> > +- dma-ranges -- Specifies the inbound memory mapping regions when
> > +     an "identity map" is not possible.
> > +- msi-controller -- this property is typically specified to have the
> > +     PCIe controller use its internal MSI controller.
> > +- msi-parent -- set to use an external MSI interrupt controller.
> > +- brcm,enable-ssc -- (boolean) indicates usage of spread-spectrum clocking.
> > +- max-link-speed --  (integer) indicates desired generation of link:
> > +     1 => 2.5 Gbps (gen1), 2 => 5.0 Gbps (gen2), 3 => 8.0 Gbps (gen3).
> > +
> > +Example Node:
> > +
> > +pcie0: pcie at f0460000 {
> > +               reg = <0x0 0xf0460000 0x0 0x9310>;
> > +               interrupts = <0x0 0x0 0x4>;
>
> Your binding says two interrupts, your example has three - what's the
> third interrupt for?

Actually that's a single interrupt with three cells.  I need to add
another interrupt.  Note that we have #interrupt-cells set to 1
because that is for the legacy interrupts given in the interrupt-map.

> Also you define the same for MSI and PCIe (I assume) - is that expected?
No, these will be updated to two different interrupts.

Are there systems where they are
> different? I would expect the msi interrupt to be optional for the
> case where its the same as the pcie one, and only required if it is
> different.
>
> Also your binding requires an interrupt-names propery, but it's
> missing from the example.
Will fix.

Thanks,
Jim
>
> > +               compatible = "brcm,bcm7445-pcie";
> > +               #address-cells = <3>;
> > +               #size-cells = <2>;
> > +               ranges = <0x02000000 0x00000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x08000000
> > +                         0x02000000 0x00000000 0x08000000 0x00000000 0xc8000000 0x00000000 0x08000000>;
> > +               #interrupt-cells = <1>;
> > +               interrupt-map-mask = <0 0 0 7>;
> > +               interrupt-map = <0 0 0 1 &intc 0 47 3
> > +                                0 0 0 2 &intc 0 48 3
> > +                                0 0 0 3 &intc 0 49 3
> > +                                0 0 0 4 &intc 0 50 3>;
> > +               clocks = <&sw_pcie0>;
> > +               clock-names = "sw_pcie";
> > +               msi-parent = <&pcie0>;  /* use PCIe's internal MSI controller */
> > +               msi-controller;         /* use PCIe's internal MSI controller */
> > +               brcm,ssc;
> > +               max-link-speed = <1>;
> > +               linux,pci-domain = <0>;
> > +       };
> > --
> > 1.9.0.138.g2de3478
> >
>
> Regards
> Jonas
