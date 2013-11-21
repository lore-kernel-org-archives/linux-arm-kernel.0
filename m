From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 21 Nov 2013 10:49:47 +0200
Subject: Report from 2013 ARM kernel summit
In-Reply-To: <528D1A0F.2000508@wwwdotorg.org>
References: <20131119.114054.663999769447782808.hdoyu@nvidia.com>
 <20131119173524.GK11778@mudshark.cambridge.arm.com>
 <528BCDCE.6070006@gmail.com>
 <20131120.083955.1386179068365424976.hdoyu@nvidia.com>
 <CAL_Jsq+AxEWhkOhxwAZ=+rpzDZ+yC1b3ZV541UhOu9kiwUhUdQ@mail.gmail.com>
 <528D1A0F.2000508@wwwdotorg.org>
Message-ID: <20131121104947.ed22de3061521105e43054d8@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Nov 2013 21:22:39 +0100
Stephen Warren <swarren@wwwdotorg.org> wrote:
...
> >> In PATCHv5[2], we took the following DT binding where multiple cell
> >> properties seem to work ok.
> >>
> >>   smmu_a: iommu at xxxxxxxx {
> >>         #iommu-cells = <2>;
> >>         ....
> >>   };
> >>
> >>   smmu_b: iommu at xxxxxxxx {
> >>         #iommu-cells = <3>;
> >>         ....
> >>   };
> >>
> >>   device_a {
> >>          iommus = <&smmu_a param1 param2>,
> >>                   <&smmu_b param1 param2 param3>;
> >>   };
> >>
> >> This can describe the relation between a device and an iommu
> >> independently. The number of params needed for each IOMMU can be
> >> sepcified by #iommu-cells in its iommu entry.
> >>
> >>   device_a <-> smmu_a, needs 2 params for a device
> >>   device_a <-> smmu_b, needs 3 params for a device
> >>
> >> For example, "smmu_a" can be an bus level global IOMMU where all child
> >> devices can be an master of "smmu_a", and "smmu_b" is a local IOMMU
> >> only for "device_a".
> >>
> >> "memory controller"---"smmu_a"---bus--+--"smmu_b"--"device_a"
> >>                                       |
> >>                                       |
> >>                                       +--"device_b"
> > 
> > I think the above binding would be the correct way to describe things
> > if you have 1 device connected to 2 IOMMUs (directly rather than
> > chained). IIUC, that is something you have on tegra?
> 
> I'm not sure that we do, but perhaps; Hiroshi will have to answer.
> Certainly whenever I personally mentioned chained IOMMUs it was simply
> in the context of making sure the bindings allowed for any potential
> arbitrary HW configuration, not because I had specific knowledge of one
> that actually exists.

In tegra, IOMMUs are chained in a way that:

- "device_a" run in "smmu_b"'s virtual address space.
- "device_a"'s requesting address is transted into "smmu_a"'s virtual
  address via "smmu_b".
- This "smmu_a"'s virtual address is translated into physical address
  via "smmu_a".

"smmu_a" and "smmu_b" are different driver although we haven't
converted "smmu_b" as the standard IOMMU API yet.

> > For the topology above where you are chaining iommu's, I think
> > something like this is more accurately describing the hierarchy:
> > 
> >   smmu_b: iommu at xxxxxxxx {
> >         #iommu-cells = <3>;
> >          iommus = <&smmu_a param1 param2>;
> >        ....
> >   };
> >   device_a {
> >          iommus = <&smmu_b param1 param2 param3>;
> >   };

This describes the dependency between IOMMUs in Tegra. We can populate
"smmu_a" always earlier than "smmu_b". Those dependency/hierarchy can
be stored in IOMMU class(global IOMMU list), which Thierry suggested.
