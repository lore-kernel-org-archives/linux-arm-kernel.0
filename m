From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 17 Mar 2015 16:09:19 +0100
Subject: [PATCH 6/9] ARM: dt: dove: add Dove PMU DT entry to dove.dtsi
In-Reply-To: <20150317134335.GV8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7tB-0003mM-1L@rmk-PC.arm.linux.org.uk>
 <55072092.9040207@free-electrons.com>
 <20150317134335.GV8656@n2100.arm.linux.org.uk>
Message-ID: <5508439F.4000507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2015 02:43 PM, Russell King - ARM Linux wrote:
> On Mon, Mar 16, 2015 at 07:27:30PM +0100, Gregory CLEMENT wrote:
>>> +			pmu: power-management at d0000 {
>>> +				compatible = "marvell,dove-pmu";
>>> +				reg = <0xd0000 0x8000>, <0xd8000 0x8000>;
>>
>> Here you overlap some other nodes such as the thermal one (from 0xd001c
>> to 0xd0028), the clock gate one (from 0xd0038 to 0xd003c), the gpio one,
>> the pinctrl one ...
>
> Yes, I'm well aware of that, but here's the thing...
>
> I'm describing the hardware here.
>
> The real problem is that Dove (etc) went down the path of breaking up
> the PMU device into multiple smaller devices each specifying a sub-set
> of the register range.  By doing that, Dove moved away from describing

Russell,

I totally agree that from today's point-of-view having a single pmu
node with sub-nodes would have been the better approach.

> the hardware - instead, we've described the Linux _implementation_ with
> its separate (sub-)devices - its the implementation's choice that we'd
> break up the PMU into these separate devices, almost to the point of
> specifying each individual register.
>
> What could be done to work around this oversight is to mvoe these
> devices beneath the PMU node, which IMHO makes complete sense as these
> are sub-devices of the PMU/PMC rather than separate devices.

If we do this, we should have a look at syscon and potentially also
simple-mfd which will allow us to share the registers and register
platform_devices for the sub-nodes.

The current pmu power/reset/irq can still use the extra locking
and directly access MMIO registers - but for the others we should
really look into using regmaps.

The only thing here is that power domain descriptions are also encoded
as direct sub-nodes of the pmu node, right?

Sebastian
