From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Mar 2013 09:28:49 +0000
Subject: [RFCv2 0/2] Representing interrupt affinity in devicetree
In-Reply-To: <20130304025115.05D413E17F8@localhost>
References: <1355417368-6861-1-git-send-email-mark.rutland@arm.com>
 <20130304025115.05D413E17F8@localhost>
Message-ID: <20130305092849.GA15661@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 04, 2013 at 02:51:14AM +0000, Grant Likely wrote:
> On Thu, 13 Dec 2012 16:49:26 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> > [This is an updated version of my previous RFC, which can be found at
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/128205.html]
> > 
> > Current devicetree bindings for devices which use cpu-affine shared interrupts
> > assume that interrupts are listed in ascending order of physical cpu id
> > (MPIDR.Aff{2,1,0}). This is problematic for drivers because:
> > 
> > (1) The driver must convert each physical id to a logical id for the purpose of
> >     managing interrupts.
> > 
> > (2) In multi-cluster systems the physical ids are not necessarily contiguous,
> >     and drivers cannot simply iterate over ids from 0 to NR_CPUS.
> > 
> > (3) It is not possible to specify sets of interrupts which are wired to a
> >     subset of cpus (i.e. clusters) not starting at physical id 0, as we can't
> >     specify which cpu to start from, and can't skip cpus. This makes it
> >     impossible to represent some devices (e.g. cpu PMUs) which may not exist
> >     in the first cluster.
> > 
> > (4) Some devices may either be wired with PPIs or SPIs. It is not possible to
> >     differentiate the two cases in general from the interrupts list (e.g. when
> >     a device has multiple PPIs wired to all cpus).
> > 
> > To represent the general case, we require a mechanism to describe the cpu
> > affinity of a device, and a consistent way to map each interrupt to a cpu (or
> > set of cpus). So far, the only workable mechanism I've been able to come up
> > with is the following:
> > 
> > In addition to the interrupts list we add an optional 'interrupts-affinity'
> > list which describes how to map an interrupt to cpu(s). Each interrupt would
> > have a corresponding element in the interrupts-affinity list.
> > 
> > Each element consists of a pair of cells specifying how to test if a cpu is
> > affine. This test specification consists of a most significant affinity level
> > to match, and values for the MPIDR affinity bits down to this level. Each pair
> > of cells has the form:
> > 
> >     < N 0x00AABBCC >
> >        \   \ \ \ \__ MPIDR.Aff0
> >         \   \ \ \___ MPIDR.Aff1
> >          \   \ \____ MPIDR.Aff2
> >           \   \_____ [must be zero]
> >            \________ level-specifier
> > 
> > The level-specifier is in the range [0-3]. When the value is 3, MPIDR affinity
> > levels 2,1,0 are ignored, and thus all cpus are matched. When the value is 0,
> > levels 2,1,0 must all be matched for a cpu to be considered affine. Affinity
> > bits which are not to be matched should be set to zero.
> > 
> > In practice, use of the binding would look something like:
> > 
> > > device at 0 {
> > > 	compatible = "example,example-affine-device";
> > > 	interrupts = <0 130 4>,
> > > 	             <0 131 4>,
> > > 	             <1 12 4>;
> > > 	interrupts-affinity = <0 0x00000000>,
> > >	                      <0 0x00000001>,
> > > 	                      <1 0x00000100>;
> > > };
> > 
> > To request/free interrupts, drivers would walk over all interrupts, and request
> > the affine cpu(s), which can be automatically mapped to logical ids by common
> > code. This fixes issues 1, 2, and 3. 4 is partially solved, in that we know
> > whether an interrupt is targeted at a single cpu or multiple cpus (i.e.
> > whether it's an SPI or a PPI), but we can't differentiate multiple interrupts
> > targeted at the same cpu. We could solve this with an additional
> > "interrupt-names" property, or something of that sort.
> > 
> > The following patches implement common code that could be used by drivers to
> > deal with this affinity information, allowing drivers to extract a (logical)
> > cpumask specifying the affinity of each interrupt, and additional information
> > specifying whether an interrupt targets multiple cpus.
> > 
> > The patches are based on rmk's for-next branch.
> > 
> > Any thoughts?
> 
> Hi Mark,

Hi,

> 
> I could use some more context for how this will be used. Do device
> drivers need to be aware of which CPU can handle an interrupt for a
> device, or is it the sort of thing that can be done in the background
> when an irq is requested? What are some examples of device drivers using
> this interface.

The main users I can think of for this would be PMUs in multi-cluster systems,
where we may have differing PMUs in each cluster. The driver for each needs to
know the set of CPUs it's handling, and which CPU each interrupt is affine to.

With the above binding scheme, we'd describe the A15x2 A7x3 CoreTile's PMUs
something like:

pmu_a15s {
	compatible = "arm,cortex-a15-pmu";
	interrupts = <0 68 4>,
	             <0 69 4>;
	interrupts-affinity = <0 0x0>,
	                      <0 0x1>;
};

pmu_a7s {
	compatible = arm,cortex-a7-pmu";
	interrupts = <0 128 4>,
	             <0 129 4>,
	             <0 130 4>;
	interrupts-affinity = <0 0x100>,
	                      <0 0x101>,
	                      <0 0x102>;
};

> 
> Part of the reason why I ask is I see a new function for parsing the
> affinity, but no code that links it into the existing irq
> infrastructure. Would this need to be called automatically when a DT
> interrupt is parsed? Or when the irq is requested? Some guidance would
> help me here.

I envisage that each driver that requires this information would request it
manually when parsing the dt, and storing what it needs in an appropriate
datastructure. For PMUs this could be something like:

struct irq_affinity {
	cpumask_t mask;
	int irq;
} interrupt_data[];

When setting up or tearing down interrupts, each CPU can find which
interrupt(s) it needs, and whether it's a PPI or SPI by iterating over the list
and checking against a cpumask, and perform the appropriate steps to setup or
teardown.

Other devices may need affinity information (e.g. which CPUs are connected to
the ACE ports on CCI) and can be handled by a similar binding.

Thanks,
Mark.
