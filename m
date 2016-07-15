From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 Jul 2016 17:52:39 +0100
Subject: [PATCH 7/8] uio: bind uio_dmem_genirq via OF
In-Reply-To: <CAALAos9KVS3SveQzGWGhcdxZNPapWnmTwZe+4y2g3LNGP3muDA@mail.gmail.com>
References: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
 <1468573443-4670-8-git-send-email-anup.patel@broadcom.com>
 <20160715132835.GC19840@leverpostej>
 <CAALAos9KVS3SveQzGWGhcdxZNPapWnmTwZe+4y2g3LNGP3muDA@mail.gmail.com>
Message-ID: <20160715165239.GG19840@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 09:57:28PM +0530, Anup Patel wrote:
> On Fri, Jul 15, 2016 at 6:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Jul 15, 2016 at 02:34:02PM +0530, Anup Patel wrote:
> >> +static char uio_of_dma_bits_prop[128] = "uio,dma-bits";
> >> +static char uio_of_dmem_count_prop[128] = "uio,number-of-dynamic-regions";
> >> +static char uio_of_dmem_sizes_prop[128] = "uio,dynamic-regions-sizes";
> >
> > What are these proeprties? What is a "dynamic region" in hardware terms?
> 
> "Dynamic region" is DMAble memory alloced using dma_alloc_xxx() APIs
> for the device.
> 
> For DMA-capable devices accessed from user-space, we need DMAble
> memory available to user-space. Sometime such devices are also
> cache-coherent (or IO-coherent) so in such case user-space will need
> cacheable DMAble memory.
> 
> Number of "Dynamic regions" required by UIO dmem device depends
> on the type of HW device hence we describe number of "Dynamic regions"
> and size of "Dynamic regions" via DT attributes.

So this is something akin to the number of DMA channels a device might
use.

Either that's implicit knowledge of the device (if fixed), which doesn't
need to be in the DT, or a real property that should be described
explicitly in the device binding, that has nothing to do with UIO.

In general, a device which you might want to use with UIO may not
require such properties, so this is imposing a requirement on DTBs
purely for the sake of userspace software.

> > Why must they be in the DT, and why are the *property names* arbitrarily
> > overridable as module parameters? What exactly do you expect there to be
> > in a DT?
> 
> They must be in DT for platform devices created using DT probing. The
> number of "Dynamic regions" required by UIO device will depend on the
> nature of device. We cannot have same number and sizes of "Dynamic
> regions" for different UIO dmem devices.

If the devices are so different, they should not be handled by the same
driver that has no knowledge of those differences. Platform VFIO has the
same problem, and requires device-specific reset drivers.

> The UIO dmem driver is a generic driver and not specific to any type of
> HW. In fact, UIO dmem driver is generic enough to access variety of
> platform devices from user-space using UIO framework.
> 
> Based on this Rob had previously suggested to not have any (or enforce
> any) DT bindings for UIO dmem driver.
> 
> Refer, https://lkml.org/lkml/2016/5/18/457

I don't follow. Here Rob stated:

  DT describes h/w. UIO is not a h/w block, so this does not belong in DT. A
  UIO vs. kernel driver is purely a kernel decision which shouldn't
  require a DT change.

  The properties should be part of match data for a compatible string that
  needs them set. Or if they can be defined in a way that is actually a
  property of the h/w, then it would be acceptible. You'd still need to
  define compatible strings that the properties apply to.

Above, you have come up with a default set of property names which you
go looking for, and you expect a class of property, even if you don't
expect specific names. That constitutes a binding, and a poorly-defined
one at that.

Per my reading, Rob's point in https://lkml.org/lkml/2016/5/23/539 was
that providing the *values* as module parameters was fine, not providing
the *property names*.

> Link to original Jan's patchset is https://lkml.org/lkml/2016/5/17/141
> 
> We had two options:
> 1) Get details of "Dynamic regions" via module parameter but this
> would mean using same number and sizes of "Dynamic regions" for
> all UIO dmem devices.
> 2) Pass names of DT attributes used by UIO dmem driver as
> module parameters.
> 
> > DT bindings need documentation, but there was none as part of this series.
> >
> > I do not think this makes sense from a DT perspective.
> 
> As explained above, we are not fixing DT compatible string and
> DT attributes names for UIO dmem driver instead we pass all
> these as module parameters (preferable via kernel args or at
> time of module insertion). Due to this we don't require DT bindings
> document.

If you're looking for properties in the DT, you're assuming a binding of
some sort, regardless of whether you expect particular names.

To be clear, NAK to this as it stands.

Thanks,
Mark.
