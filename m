From: robh@kernel.org (Rob Herring)
Date: Thu, 12 Jul 2018 09:11:24 -0600
Subject: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
In-Reply-To: <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
Message-ID: <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 6:54 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hi Rob,
>
> Thanks for the response.
>
> On Thu, 12 Jul 2018, at 05:34, Rob Herring wrote:
> > On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
> > > Baseboard Management Controllers (BMCs) are embedded SoCs that exist to
> > > provide remote management of (primarily) server platforms. BMCs are
> > > often tightly coupled to the platform in terms of behaviour and provide
> > > many hardware features integral to booting and running the host system.
> > >
> > > Some of these hardware features are simple, for example scratch
> > > registers provided by the BMC that are exposed to both the host and the
> > > BMC. In other cases there's a single bit switch to enable or disable
> > > some of the provided functionality.
> > >
> > > The documentation defines bindings for fields in registers that do not
> > > integrate well into other driver models yet must be described to allow
> > > the BMC kernel to assume control of these features.
> >
> > So we'll get a new binding when that happens? That will break
> > compatibility.
>
> Can you please expand on this? I'm not following.

If we have a subsystem in the future, then there would likely be an
associated binding which would be different. So if you update the DT,
then old kernels won't work with it.


> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >
> > > Since RFC v1:
> > >
> > > * Add a commit message
> > > * Minor changes to documented labels
> > >
> > >  .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++++++++
> > >  MAINTAINERS                                   |   6 +
> > >  2 files changed, 258 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > > new file mode 100644
> > > index 000000000000..2c869fcc7ef2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > > @@ -0,0 +1,252 @@
> > > +BMC Miscellaneous Control Interfaces
> > > +====================================
> > > +
> > > +Baseboard Management Controllers (BMCs) often have an array of hardware
> > > +features that need to be described but are awkward to sensibly expose.
> > > +
> > > +This bindings document provides a generic mechanism for describing such
> > > +features, covering read-only (RO), read-modify-write (RMW) and
> > > +write-1-set/write-1-clear (W1SC) semantics.
> >
> > If we wanted a generic mechanism for single register bits/fields in DT,
> > we'd have one already.
>
> I feel like this is an argument of tradition. Maybe people have been dissuaded from doing so when they don't have a reasonable use-case? I'm not saying that what I'm proposing is unquestionably reasonable, but I don't want to dismiss it out of hand.

One of experience. The one that stands out is clock bindings.
Initially we were doing a node per clock modelling which could end up
being 100s of nodes and is difficult to get right (with DT being an
ABI).

It comes up with system controller type blocks too that just have a
bunch of random registers. Those change in every SoC and not in any
controlled or ordered way that would make describing the individual
sub-functions in DT worthwhile.

>
> > A node per register bit doesn't scale.
>
> It isn't meant to scale in terms of a single system. Using it extensively is very likely wrong. Separately, register-bit-led does pretty much the same thing. Doesn't the scale argument apply there? Who is to stop me from attaching an insane number of LEDs to a system?

Review.

If you look, register-bit-led is rarely used outside of some ARM, Ltd.
boards. It's simply quite rare to have MMIO register bits that have a
fixed function of LED control.

> Obviously if there are lots of systems using it sparingly and legitimately then maybe there's a scale issue, but isn't that just a reality of different hardware designs? Whoever is implementing support for the system is going to have to describe the hardware one way or another.
>
> >
> > Maybe this should be modelled using GPIO binding? There's a line there
> > too as whether the signals are "general purpose" or not.
>
> I don't think so, mainly because some of the things it is intended to be used for are not GPIOs. For instance, take the DAC mux I've described in the patch. It doesn't directly influence anything external to the SoC (i.e. it's certainly not a traditional GPIO in any sense). However, it does *indirectly* influence the SoC's behaviour by muxing the DAC internally between:
>
> 0. VGA device exposed on the host PCIe bus
> 1. The "Graphics CRT" controller
> 2. VGA port A
> 3. VGA port B

And this mux control is fixed in the SoC design?

>
> Maybe this could be modelled by pinmux, but then we still need some way to expose the mux functions to userspace for selection (userspace needs to transition arbitrarily between at least options 0 and 1 at runtime), at which point we haven't achieved much beyond adding a whole heap of infrastructure in the chain.
>
> Given 0 and 1, maybe exposing attributes in relevant drivers would be reasonable, except 0 isn't exposed on the SoC's internal bus so there is no driver on the BMC-side to do so. Taking into account 2 and 3 are also purely hardware paths further dashes the idea, as the configuration doesn't really "belong" to the Graphics CRT device more than it belongs anywhere else, except for the fact that there isn't anywhere else to expose it.
>
> Further, the BMC's kernel can't make the decision as to when to switch the mux as it knows nothing of the host's state. The BMC userspace is controlling the host's boot state and so *does* know when to flip the switch. Finally, the mux is in separate IP to the CRT or VGA blocks: It lives in the System Control Unit.
>
> My current point of view is the DAC mux field is effectively its own device, and we need to control it from userspace, so we need some way to describe it (i.e. not ignore it) in order for its capability to be exposed.
>
> I'm fully aware what I'm proposing isn't awesome as it's not providing any real abstraction, but the problem(s) at hand also seem to defy abstraction, and in order to avoid a plethora of bespoke bindings I thought it was reasonable to define something generic.
>
> All-in-all I appreciate the suggestion, but assuming you agree with my reasoning above do you have thoughts on other alternatives?

Seems the controls are more fixed than I first thought. All the data
you have here could simply be within a driver. Help me understand what
functions are fixed (in the SoC) and which ones vary by board. Only
what's changing per board really needs to go into DT.

Rob
