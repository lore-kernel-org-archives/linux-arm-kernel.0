From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Mar 2014 12:04:47 +0000
Subject: arm64: dts: Add PMU node for APM X-Gene Storm SOC
In-Reply-To: <CAPrCYkeFwRVNUtP4mbv=Atejb8F9kR=OBrCZ7GGvVrwqnmH6jA@mail.gmail.com>
References: <1395048095-32745-1-git-send-email-vkale@apm.com>
 <20140317103353.GD8070@e106331-lin.cambridge.arm.com>
 <CAPrCYkfxGVey_fQ47RO=XNnWYNM0qckdj9gMUZtZHkz6hR85xQ@mail.gmail.com>
 <20140317114421.GH8070@e106331-lin.cambridge.arm.com>
 <CAPrCYkeFwRVNUtP4mbv=Atejb8F9kR=OBrCZ7GGvVrwqnmH6jA@mail.gmail.com>
Message-ID: <20140317120447.GI8070@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 12:01:56PM +0000, Vinayak Kale wrote:
> On Mon, Mar 17, 2014 at 5:14 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Mar 17, 2014 at 11:22:55AM +0000, Vinayak Kale wrote:
> >> On Mon, Mar 17, 2014 at 4:03 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Mon, Mar 17, 2014 at 09:21:35AM +0000, Vinayak Kale wrote:
> >> >> This patch adds the PMU device tree node for APM X-Gene Storm SOC.
> >> >>
> >> >> Please note that this patch has dependancy on a GIC driver patch [1] which is
> >> >> yet to be approved by maintainers.
> >> >>
> >> >> [1]- https://lkml.org/lkml/2014/2/27/605
> >> >> (irqchip:gic: change access of gicc_ctrl register to read modify write)
> >> >>
> >> >> Signed-off-by: Vinayak Kale <vkale@apm.com>
> >> >> ---
> >> >>  arch/arm64/boot/dts/apm-storm.dtsi | 5 +++++
> >> >>  1 file changed, 5 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
> >> >> index d37d736..587348d 100644
> >> >> --- a/arch/arm64/boot/dts/apm-storm.dtsi
> >> >> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> >> >> @@ -97,6 +97,11 @@
> >> >>               clock-frequency = <50000000>;
> >> >>       };
> >> >>
> >> >> +     pmu {
> >> >> +             compatible = "arm,armv8-pmuv3";
> >> >> +             interrupts = <1 12 0xff04>;
> >> >> +     };
> >> >
> >> > Do Potenza CPUs only have the PMUv3 events, and nothing
> >> > Potenza-specific?
> >> On top of PMUv3 events, Potenza CPU do have few implementation defined events.
> >
> > Ok. So Potenza is compatible with PMUv3 (and can have it in the list),
> > but also has additional features for which there should be a string.
> >
> >> >
> >> > I would have expected something like:
> >> >
> >> > compatible = "apm,potenza-pmu", "arm,armv8-pmuv3";
> >> PMUv3 allows to have implementation defined events. And as such the
> >> driver doesn't have any dependency on such events. Do you still think
> >> we need additional compatible string for Potenza CPU?
> >
> > I do. This is precisely the reason for the compatible list. Being as
> > explicit as possible with the compatible list entries and having a
> > series of fallbacks is the sensible thing to do.
> >
> > Having the additional string allows things to work now with the standard
> > events, and possibly later with the full set of events, without
> > requiring every single DTB to be updated. It also allows us to target
> > workarounds more precisely, for any issues we might not currently be
> > aware of.
> 
> Okay, will add the new string in next version.
> 
> For documentation of bindings for "apm,potenza-pmu", can I insert it
> in existing arm-pmu bindings file
> (i.e.Documentation/devicetree/bindings/arm/pmu.txt) or shall I create
> new file?

Drop it in the existing file.

Mark.
