From: robherring2@gmail.com (Rob Herring)
Date: Thu, 17 Nov 2011 11:15:30 -0600
Subject: [PATCH] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <CACxGe6ub2QBO0ZLwNdSvMxP1U087pqL-qL+dfWAbn-08gBQyvg@mail.gmail.com>
References: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com>
 <4EC52BCF.7020609@gmail.com>
 <20111117155428.GS19069@tbergstrom-lnx.Nvidia.com>
 <CACxGe6ub2QBO0ZLwNdSvMxP1U087pqL-qL+dfWAbn-08gBQyvg@mail.gmail.com>
Message-ID: <4EC54132.5070908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2011 10:53 AM, Grant Likely wrote:
> 
> On Nov 17, 2011 8:54 AM, "Peter De Schrijver" <pdeschrijver@nvidia.com
> <mailto:pdeschrijver@nvidia.com>> wrote:
>>
>> On Thu, Nov 17, 2011 at 04:44:15PM +0100, Rob Herring wrote:
>> > On 11/17/2011 09:07 AM, Peter De Schrijver wrote:
>> > > Convert tegra20 IRQ intialization to the GIC devicetree binding.
> Modify the
>> > > interrupt definitions in the dts files according to
>> > > Documentation/devicetree/bindings/arm/gic.txt
>> > >
>> > > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com
> <mailto:pdeschrijver@nvidia.com>>
>> >
>> > One minor comment below, but otherwise:
>> >
>> > Acked-by: Rob Herring <rob.herring@calxeda.com
> <mailto:rob.herring@calxeda.com>>
>> >
>> > > ---
>> > >  arch/arm/boot/dts/tegra-paz00.dts |    2 +-
>> > >  arch/arm/boot/dts/tegra20.dtsi    |   52
> ++++++++++++++++++------------------
>> > >  arch/arm/mach-tegra/irq.c         |   18 +++++++++++-
>> > >  3 files changed, 43 insertions(+), 29 deletions(-)
>> > >
>> > > diff --git a/arch/arm/boot/dts/tegra-paz00.dts
> b/arch/arm/boot/dts/tegra-paz00.dts
>> > > index 15a949f..7ff8f6f 100644
>> > > --- a/arch/arm/boot/dts/tegra-paz00.dts
>> > > +++ b/arch/arm/boot/dts/tegra-paz00.dts
>> > > @@ -32,7 +32,7 @@
>> > >             #size-cells = <0>;
>> > >             compatible = "nvidia,nvec";
>> > >             reg = <0x7000C500 0x100>;
>> > > -           interrupts = <124>;
>> > > +           interrupts = <0 92 0x04>;
>> > >             clock-frequency = <80000>;
>> > >             request-gpios = <&gpio 170 0>;
>> > >             slave-addr = <138>;
>> > > diff --git a/arch/arm/boot/dts/tegra20.dtsi
> b/arch/arm/boot/dts/tegra20.dtsi
>> > > index 795b921..cd01b01 100644
>> > > --- a/arch/arm/boot/dts/tegra20.dtsi
>> > > +++ b/arch/arm/boot/dts/tegra20.dtsi
>> > > @@ -5,9 +5,9 @@
>> > >     interrupt-parent = <&intc>;
>> > >
>> > >     intc: interrupt-controller at 50041000 {
>> > > -           compatible = "nvidia,tegra20-gic";
>> > > +           compatible = "arm,cortex-a9-gic";
>> > >             interrupt-controller;
>> >
>> > You should add an "interrupt-parent;" here so the gic's parent is null
>> > and not the gic.
>>
>> Ok. I will add that in the next version.
> 
> No, there is no need to do that, nor is it convention. The gic node
> doesn't have an interrupts property, so the interrupt-parent is irrelevant.
> 
Can't resist the inbox? Go back to your sabbatical.. :) We discussed
this before and I though agreed this was the correct approach.

It inherits the interrupt-parent from the parent node. Originally
of_irq_find_parent would return that node, but this was fixed. So it
doesn't really matter from a functional standpoint.

So is no interrupt parent defined as no interrupts property or
interrupt-parent being null phandle?

> Rob, perhaps we should adjust of_init_irq() to only set the parent
> pointer if interrupts is present.
> 

It works correctly already either way.

Rob
