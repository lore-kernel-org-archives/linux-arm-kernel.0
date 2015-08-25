From: dianders@chromium.org (Doug Anderson)
Date: Tue, 25 Aug 2015 16:55:41 -0700
Subject: [RESEND PATCH v16 4/4] ARM: dts: add the support power-domain
 node on RK3288 SoCs
In-Reply-To: <7htwrn6l7g.fsf@deeprootsystems.com>
References: <1440487486-6154-1-git-send-email-wxt@rock-chips.com>
 <1440487486-6154-5-git-send-email-wxt@rock-chips.com>
 <7hfv37axhj.fsf@deeprootsystems.com>
 <CAD=FV=V6oG+9U=W_JZmqCuNo-9-5wW8ffZzG7ZE_3cnSTNAjFQ@mail.gmail.com>
 <7htwrn6l7g.fsf@deeprootsystems.com>
Message-ID: <CAD=FV=WAjXcgft8H8orrDcJ9OXaUDoOKSFEmibFMm51a9kHkBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Tue, Aug 25, 2015 at 3:45 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> To put things in a
>> concrete way, for pd_vio we'd go through the entire device tree
>> ourselves and find all properties that look like "power-domains =
>> <&power RK3288_PD_VIO>;".  We'd then find the parent of those
>> properties and look for a property named "clocks".  We'd then iterate
>> over all those clocks and turn those on.  Did I get that right?
>
> ... but you make it sound like more work than it is.  The genpd already
> keeps a list of devices that refer to the power domain.  In fact, the
> genpd 'attach' method can be platform-specific, so could be used to keep
> track of a list (or a subset) of clocks which are needed for reset.

OK.  I'll need to dig through and figure out how this works.  So this
list will include devices whose drivers are compiled out and also
devices that are marked as 'status = "disabled";' in the device tree?
It would need to do this in case someone had a board that didn't use
one of these peripherals (since we still need to clock it as we make
the domain go up and down).

I took a quick gander and didn't see code that would do this.  Can you
give me a quick pointer?

We also need to really make sure that there are no probe order issues...


>> 2. If we absolutely need to turn all clocks and we get clocks from
>> device tree nodes on then it means we need device tree nodes for every
>> device in the domain.
>
> Isn't that the end goal?

In the ideal world, yes.  ...but it's possibly years before all
drivers are added, or possibly they never will be.  To name a concrete
example, unless I'm mistaken, the "hardware crypto" device present in
exynos5250 still isn't anywhere in upstream despite several years
having passed.  There are just so many devices in these SoCs that
aren't used.


>> These would be needed even if there are no
>> accepted bindings for this device yet.  So we'd need to do one of: A)
>> Block power domain patches on feature complete bindings for all
>> drivers; B) Make up non-approved compatible strings for all devices
>> and throw them into the DTS; C) Add nodes in the DTS without a
>> compatible string just to satisfy the power domain requirements.  None
>> of these seem terribly appealing.
>
> well, I think we can be slightly more accomodating than that and go for
> somewhere in between:
>
> D) In the power-domain DTS, clearly describe why each clock is needed by
> the power-domain.  In particular list out clocks that are not device
> clocks (and why they need to be asserted for reset) and separate those
> from device clocks which are only listed in the power-domain because
> there is not *yet* a driver/binding for that device node.
>
> Doing it that way also makes it clear that when a new driver/binding is
> added, the clocks should be removed from the power-domain node and put
> into the device node.
>
> Also, this addresses my primary concern that the DTS acurately describes
> the hardware.  IOW, in hardware, most of these clocks are are properties
> of devices, not power-domains, and the DT should reflect that.
>
> IMO, if it's not describing the hardware, and is a placeholder until a
> driver/binding is in place, it should be properly documented.

Agreed that more documentation about why each clock is needed would go
a long way to helping.

I'd say that the clocks are properties of the device, but I'd again
assert that not all clocks that are owned by the device are relevant
to turning power domains on and off.  If you really wanted to be
correct, you'd add a property like this to devices:

power-on-clocks = <..>;

...this would be a list of clocks needed to power on the device
properly.  If such a property was added that would erase my objection
to that.  Note that you could say that if "power-on-clocks" wasn't
present then you could fall back to "clocks".  I do worry a little bit
about over-engineering, so I guess this could just be a future
improvement...


>> 3. It is entirely possible that there are clocks that will be listed
>> in the individual devices that aren't needed for powering on the power
>> domain.  I'd tend to believe that PCLK_EDP_CTRL (the pixel clock)
>> doesn't really need to be turned on when adjusting the "VIO" power
>> domain.  Right now Caesar has it listed, but it probably isn't needed
>> (Caesar: can you confirm?).
>
> Yes, I suspect there are several of those, which is also why I'd like to
> see the clocks in the power-domain node described in detail, and exacly
> why they're needed to be enabled.

I guess my point was that this was a reason for doing something like
"power-on-clocks" because it would let you avoid turning on
PCLK_EDP_CTRL (which is listed in the "clocks" of the EDP device but
maybe not needed while powering on/off the domain).  ...or just have
the list as part of the power domain.  :-P


> Also, in the current proposed DTS, clocks that are listed in both device
> nodes and the power domain are also suspicous, especially when the
> device node doesn't have a power-domain property.  (c.f. vop[bl] nodes
> and ACLK_VOP[01] clocks.)  For that matter, this series doesn't add any
> devices to the power domains, which makes it even more confusing about
> how this is meant to work.  IOW, with no devices belonging to
> power-domains, how are the power-domain power_on/power_off callbacks
> being called?

I totally believe that our current hardware definition isn't so
correct (though it does seem to work).  I'd be that devices that never
turn off often don't have a power domain defined (though they
technically have one) because that power domain always happens to be
on and no amount of specifying will allow it to turn off.  An
advantage of what you're pushing for is that it really forces us to
think about exactly what clocks are needed and forces us to specify
power domains more correctly.


>> 4. It seems just slightly brittle to be reaching into other device
>> nodes and making assumptions about their properties.  Yeah, it's
>> probably safe to assume that "clocks" has a list of clocks and
>> "power-domains" will point to something whose first entry is a
>> phandle, but it still seems just a tad bit like violating an
>> abstraction barrier.
>
> shmobile is already doing this with platform-specific genpd attach
> callbacks, and using the pm_clk API.  I don't see any issues with that.

I can see it working.  It's more of a feeling of unease.  ...but
that's not a good enough reason to reject something...

-Doug
