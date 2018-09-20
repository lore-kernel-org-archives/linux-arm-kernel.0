From: leoyang.li@nxp.com (Li Yang)
Date: Thu, 20 Sep 2018 14:07:07 -0500
Subject: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
In-Reply-To: <33eac426-cbb7-f899-5a35-aea28f8e5dc4@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <7d7646dc-9d0b-013d-75d7-a6cb4453f41f@arm.com>
 <fd8ab351-46aa-f73e-593b-502a57de1975@nxp.com>
 <39211e7a-034b-cdca-f182-1b6f6e5fbc53@arm.com>
 <33eac426-cbb7-f899-5a35-aea28f8e5dc4@nxp.com>
Message-ID: <CADRPPNTot7U6vARqtrRrw4XqhDQPSXP1QO9ZbGpNQByJPcU37Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 5:39 AM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
>
>
> On 19.09.2018 17:37, Robin Murphy wrote:
> > On 19/09/18 15:18, Laurentiu Tudor wrote:
> >> Hi Robin,
> >>
> >> On 19.09.2018 16:25, Robin Murphy wrote:
> >>> Hi Laurentiu,
> >>>
> >>> On 19/09/18 13:35, laurentiu.tudor at nxp.com wrote:
> >>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>>
> >>>> This patch series adds SMMU support for NXP LS1043A and LS1046A chips
> >>>> and consists mostly in important driver fixes and the required device
> >>>> tree updates. It touches several subsystems and consists of three main
> >>>> parts:
> >>>>    - changes in soc/drivers/fsl/qbman drivers adding iommu mapping of
> >>>>      reserved memory areas, fixes and defered probe support
> >>>>    - changes in drivers/net/ethernet/freescale/dpaa_eth drivers
> >>>>      consisting in misc dma mapping related fixes and probe ordering
> >>>>    - addition of the actual arm smmu device tree node together with
> >>>>      various adjustments to the device trees
> >>>>
> >>>> Performance impact
> >>>>
> >>>>       Running iperf benchmarks in a back-to-back setup (both sides
> >>>>       having smmu enabled) on a 10GBps port show an important
> >>>>       networking performance degradation of around %40 (9.48Gbps
> >>>>       linerate vs 5.45Gbps). If you need performance but without
> >>>>       SMMU support you can use "iommu.passthrough=1" to disable
> >>>>       SMMU.
> >>>>
> >>>> USB issue and workaround
> >>>>
> >>>>       There's a problem with the usb controllers in these chips
> >>>>       generating smaller, 40-bit wide dma addresses instead of the
> >>>> 48-bit
> >>>>       supported at the smmu input. So you end up in a situation
> >>>> where the
> >>>>       smmu is mapped with 48-bit address translations, but the device
> >>>>       generates transactions with clipped 40-bit addresses, thus smmu
> >>>>       context faults are triggered. I encountered a similar
> >>>> situation for
> >>>>       mmc that I  managed to fix in software [1] however for USB I
> >>>> did not
> >>>>       find a proper place in the code to add a similar fix. The only
> >>>>       workaround I found was to add this kernel parameter which
> >>>> limits the
> >>>>       usb dma to 32-bit size: "xhci-hcd.quirks=0x800000".
> >>>>       This workaround if far from ideal, so any suggestions for a code
> >>>>       based workaround in this area would be greatly appreciated.
> >>>
> >>> If you have a nominally-64-bit device with a
> >>> narrower-than-the-main-interconnect link in front of it, that should
> >>> already be fixed in 4.19-rc by bus_dma_mask picking up DT dma-ranges,
> >>> provided the interconnect hierarchy can be described appropriately (or
> >>> at least massaged sufficiently to satisfy the binding), e.g.:
> >>>
> >>> / {
> >>>       ...
> >>>
> >>>       soc {
> >>>           ranges;
> >>>           dma-ranges = <0 0 10000 0>;
> >>>
> >>>           dev_48bit { ... };
> >>>
> >>>           periph_bus {
> >>>               ranges;
> >>>               dma-ranges = <0 0 100 0>;
> >>>
> >>>               dev_40bit { ... };
> >>>           };
> >>>       };
> >>> };
> >>>
> >>> and if that fails to work as expected (except for PCI hosts where
> >>> handling dma-ranges properly still needs sorting out), please do let us
> >>> know ;)
> >>>
> >>
> >> Just to confirm, Is this [1] the change I was supposed to test?
> >
> > Not quite - dma-ranges is only valid for nodes representing a bus, so
> > putting it directly in the USB device nodes doesn't work (FWIW that's
> > why PCI is broken, because the parser doesn't expect the
> > bus-as-leaf-node case). That's teh point of that intermediate simple-bus
> > node represented by "periph_bus" in my example (sorry, I should have put
> > compatibles in to make it clearer) - often that's actually true to life
> > (i.e. "soc" is something like a CCI and "periph_bus" is something like
> > an AXI NIC gluing a bunch of lower-bandwidth DMA masters to one of the
> > CCI ports) but at worst it's just a necessary evil to make the binding
> > happy (if it literally only represents the point-to-point link between
> > the device master port and interconnect slave port).
> >
>
> Quick update: so I adjusted to device tree according to your example and
> it works so now I can get rid of that nasty kernel arg based workaround,
> yey! :-)

Great that we have a generic solution like I hoped for!  So you will
submit a new revision of the series to include these dts updates,
right?

Regards,
Leo
