From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Jul 2016 12:07:37 +0100
Subject: [PATCH v2] xen/arm: register clocks used by the hypervisor
In-Reply-To: <b2431af6-f415-41db-5651-8cb8d3b08822@de.bosch.com>
References: <1467701423-31138-1-git-send-email-dirk.behme@de.bosch.com>
 <20160705103917.GC20478@leverpostej>
 <b2431af6-f415-41db-5651-8cb8d3b08822@de.bosch.com>
Message-ID: <20160705110736.GD20478@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 05, 2016 at 12:45:34PM +0200, Dirk Behme wrote:
> On 05.07.2016 12:39, Mark Rutland wrote:
> >On Tue, Jul 05, 2016 at 08:50:23AM +0200, Dirk Behme wrote:
> >>+- clocks: one or more clocks to be registered.
> >>+  Xen hypervisor drivers might replace native drivers, resulting in
> >>+  clocks not registered by these native drivers. To avoid that these
> >>+  unregistered clocks are disabled by the Linux kernel initialization
> >>+  register them in the hypervisor node.
> >>+  An example for this are the clocks of a serial driver already enabled
> >>+  by the firmware. If the clocks used by the serial hardware interface
> >>+  are not registered by the serial driver itself the serial output
> >>+  might stop once the Linux kernel initialization disables the 'unused'
> >>+  clocks.
> >
> >The above describes the set of problems, but doesn't set out the actual
> >contract. It also covers a number of Linux implementation details in
> >abstract.
> 
> Could you kindly be a little more specific which 'implementation
> details' you don't like?

The fact that we disable some clocks at init time is a driver model
thing that depends on various factors (e.g. cmdline options), and it's
something that could be moved around. We only mention disabling, and not
rate change (which could happen, even if it doesn't today).

I don't think that we need to describe the Linux behaviour at all.

> E.g. to my understanding, the 'implementation detail' that Linux
> disables unregistered clocks is needed for the description.
> 
> If you have a different wording in mind, could you kindly share that?

Something like:

- clocks: a list of phandle + clock-specifier pairs 
  Clocks described by this property are reserved for use by Xen, and the
  OS must not alter their state any way, such as disabling or gating a
  clock, or modifying its rate. Ensuring this may impose constraints on
  parent clocks or other resources used by the clock tree.

  Note: this property is used to proxy clocks for devices Xen has taken
  ownership of, such as UARTs, for which the associated clock
  controller(s) remain under the control of Dom0.

> >As I commented previously [1], the binding should describe the set of
> >guarantees that you rewquire (e.g. that the clocks must be left as-is,
> >not gated, and their rates left unchanged).
> >
> >Please describe the specific set of guarantees that you require.
> 
> To my understanding this is done, already: "avoid that these ...
> clocks are disabled"

My point of contention here is that while this might tell a dts author
what to place in this property, it doesn't specify what the OS should
do.

Thanks,
Mark.
