From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 25 Jan 2012 12:30:27 -0700
Subject: How to represent active low ARM GIC interrupts, enabled by
 external inverter?
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178CB8204C@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF178CB81BA2@HQMAIL01.nvidia.com>
 <4F1DF1CB.20707@gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178CB8204C@HQMAIL01.nvidia.com>
Message-ID: <CACxGe6vSvkSOPNWxP4G3SFRZLz=UsorLxqV__r5QN-HxvyJT6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 10:34 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Rob Herring wrote at Monday, January 23, 2012 4:48 PM:
>> On 01/23/2012 03:18 PM, Stephen Warren wrote:
>> > I'd like guidance on how to model one aspect of Tegra's interrupt
>> > structure.
>> >
>> > Tegra has an interrupt input pin for use by a PMU chip.
>> >
>> > The PMC HW module within Tegra can optionally invert this signal, but
>> > otherwise has no control over it; no interrupt status bits, no masking,
>> > etc.
>> >
>> > The (potentially inverted) signal is then fed into the ARM GIC, which
>> > supports level high or rising edge interrupts only.
>> >
>> > So my question is: How to model this.
>> >
>> > I assume the best thing to do is have the PMC be an explicit irq_chip,
>> > and have its .set_type op configure the inversion based on whether
>> > its interrupt source requests low or high, and allow either level or
>> > edge.
>> >
>> > However, the irq_chip for the PMC couldn't implement any mask or shutdown
>> > operation. Is it acceptable to simple provide dummy/no-op functions in
>> > that case? I see that kernel/irq/dummychip.c does exactly that, but I'm
>> > not sure what use-cases that file is supposed to cover.
>> >
>> > That'd result in something like this for device tree:
> ...
>> > Other alternatives:
>> >
>> > 1) Don't hook the PMC driver and binding into the interrupt tree, but
>> > simply have a property that controls the inversion of the signal.
>> > The disadvantage is that the PMU's interrupt specifier would need to
>> > always specify active high even if it was really active low with inversion
>> > activated in the PMC.
>>
>> I think i would go this route considering it's only a single interrupt
>> line and probably just a couple of lines of code to set a bit if a
>> property is present.
>
> True, that's very easy to implement.
>
> One other issue I see with this approach: the PMC driver must initialize
> before the PMU driver, so that it has reprogrammed the interrupt signal
> inverter before the PMU driver requests and enables the interrupt. If not,
> then the interrupt will scream as soon as the PMU driver enables it. If
> PMC were an explicit interrupt controller, that'd feed into the deferred
> device probing feature pretty easily to solve this. Otherwise, how would
> we solve this? I suppose we could do something similar to the explicit
> GIC initialization and force the PMC device to be instantiated before
> instantiating anything else from device tree. Does that seem reasonable?

This probably makes the most sense.  There are always going to be core
SoC setup that just have to be part of the early init setup before
starting the generic driver initialization. Those things don't fit
well into the device model. This may just be one where the right thing
to do is make sure it is set up at or before of_irq_init() gets
called.

g.
