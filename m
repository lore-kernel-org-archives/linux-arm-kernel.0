From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 19 Jul 2018 14:35:24 +1000
Subject: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc.
 BMC control fields
In-Reply-To: <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
 <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
 <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
 <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
 <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
Message-ID: <9787b471abc49c0b3db60e3471473a7a5b45ade7.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-19 at 11:58 +0930, Andrew Jeffery wrote:
> > > I agree
> > > that not using /dev/mem is a good thing, but there are several ways
> > > you could do that independent of any DT binding.
> > 
> > Such as ? The only other option is to have one or more kernel drivers
> > that have built-in the precise and complete list of those tunables that
> > need to be exposed.
> > 
> > It's not impossible, but I worry that it's not going to scale terribly
> > well, and that vendors will constantly "fork" that driver to add
> > different things to that list.
> 
> Picking on that last point, "different things" doesn't necessarily
> mean "different fields in the SoC" (though it may). We could just
> need to use different initial values for the fields already
> described. 

I don't worry about initial values too much. Those could be specified
by userspace. It would be trivial to have something akin to
/etc/sysctl.conf that contains the initial values and a script blasting
them early. In fact I prefer this being in userspace to be frank. It
could be in the initramfs if we want it done early enough, maybe with a
usermode helper.

Unless we have some demonstrable reasons why some of these must be set
before the various kernel drivers initialize.

> So taking that into account, the field descriptions could vary wildly
> from platform to platform - where "platform" here is the combination
> of the BMC, its host system, and the host system's required
> configuration - not just referring to the BMC in isolation.  That in
> turn may cause a fork of the driver (changes that are incompatible
> with other platforms), or not scale terribly well as Ben suggests.

I really only worry about the actual set of registers/fields. I think
folding in initial values goes a bit too far.

> The initial value concept can help reduce the impact on userspace as
> userpace may no-longer need to care about it, so I think it's a
> desirable property.

I don't worry too much about userspace containing system specific bits
and pieces such as a config file with the appropriate initial values
for the platform. Userspace will have to contain platform specific
stuff regardless (if anything, stuff like thermal control is
intrinsicly different from one platform to the next).

>  With respect to devicetree, the field definitions will stay in the
> SoC dtsi, but the initial values would be described on a per-platform 
> basis in the dts.

If the fields are in the SoC dtsi, then Rob has a reasonable argument
that the list of fields is rather fixed for a given SoC and thus could
be hard wired in the driver.... 

I think at this stage, we need to create more clarity. In order to do
that, I think we need to come up with a list, as exhaustive as we can,
of what are the fields/register we need for our platforms, and find any
reason why userspace wouldn't be a good enough location to stick the
initial values.

Then we need Dell and Yadro (and maybe others) to help with their
variant of that list for the same SoCs to begin with.

With that, we'll get an idea of whether we think we can get a
reasonable stable long term list that's appropriate for most vendors.

If that's the case, then my objections to have it in the kernel instead
of the DT fade away a bit.

If one or two of those fields absolutely must have their defaults
early, then we can consider a specific set of one or two properties in
the SoC node for that SoC family that provides those specific defaults.

But unless we have that list, I think we'll be throwing too many
hypotheticals around to convince Rob and others.

Andrew, can you start with a list that shows what you expect us to need
on our systems ?

Cheers,
Ben
