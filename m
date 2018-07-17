From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 17 Jul 2018 10:34:30 +0930
Subject: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
In-Reply-To: <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
Message-ID: <1531789470.3129371.1442980448.3B48B4EC@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jul 2018, at 23:25, Rob Herring wrote:
> On Fri, Jul 13, 2018 at 12:31 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Hi Rob, Ben,
> >
> > I've replied to you both inline below, hopefully it's clear enough from the context.
> >
> > On Fri, 13 Jul 2018, at 10:25, Benjamin Herrenschmidt wrote:
> > > On Thu, 2018-07-12 at 09:11 -0600, Rob Herring wrote:
> > > > On Wed, Jul 11, 2018 at 6:54 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > Thanks for the response.
> > > > >
> > > > > On Thu, 12 Jul 2018, at 05:34, Rob Herring wrote:
> > > > > > On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
> > > > > > > Baseboard Management Controllers (BMCs) are embedded SoCs that exist to
> > > > > > > provide remote management of (primarily) server platforms. BMCs are
> > > > > > > often tightly coupled to the platform in terms of behaviour and provide
> > > > > > > many hardware features integral to booting and running the host system.
> > > > > > >
> > > > > > > Some of these hardware features are simple, for example scratch
> > > > > > > registers provided by the BMC that are exposed to both the host and the
> > > > > > > BMC. In other cases there's a single bit switch to enable or disable
> > > > > > > some of the provided functionality.
> > > > > > >
> > > > > > > The documentation defines bindings for fields in registers that do not
> > > > > > > integrate well into other driver models yet must be described to allow
> > > > > > > the BMC kernel to assume control of these features.
> > > > > >
> > > > > > So we'll get a new binding when that happens? That will break
> > > > > > compatibility.
> > > > >
> > > > > Can you please expand on this? I'm not following.
> > > >
> > > > If we have a subsystem in the future, then there would likely be an
> > > > associated binding which would be different. So if you update the DT,
> > > > then old kernels won't work with it.
> > >
> > > What kind of "subsystem" ? There is almost no way there could be one
> > > for that sort of BMC tunables. We've look at several BMC chips out
> > > there and requirements from several vendors, BIOS and system
> > > manufacturers and it's all over the place.
> >
> > Right - This is the fundamental principle backing these patches: There will never be a coherent subsystem catering to any of what we want to describe with these bindings.
> 
> I never said they would. Saying "do not integrate well into other
> driver models YET" implies at some point they will. No point in
> beating this any further, just remove "yet"...

Right, there should have been a comma before 'yet'. Sorry for the confusion.

*snip*

> > > > >
> > > > > Maybe this could be modelled by pinmux, but then we still need some
> > > > > way to expose the mux functions to userspace for selection
> > > > > (userspace needs to transition arbitrarily between at least options
> > > > > 0 and 1 at runtime), at which point we haven't achieved much beyond
> > > > > adding a whole heap of infrastructure in the chain.
> > > > >
> > > > > Given 0 and 1, maybe exposing attributes in relevant drivers would
> > > > > be reasonable, except 0 isn't exposed on the SoC's internal bus so
> > > > > there is no driver on the BMC-side to do so. Taking into account 2
> > > > > and 3 are also purely hardware paths further dashes the idea, as
> > > > > the configuration doesn't really "belong" to the Graphics CRT
> > > > > device more than it belongs anywhere else, except for the fact that
> > > > > there isn't anywhere else to expose it.
> > > > >
> > > > > Further, the BMC's kernel can't make the decision as to when to
> > > > > switch the mux as it knows nothing of the host's state. The BMC
> > > > > userspace is controlling the host's boot state and so *does* know
> > > > > when to flip the switch. Finally, the mux is in separate IP to the
> > > > > CRT or VGA blocks: It lives in the System Control Unit.
> > > > >
> > > > > My current point of view is the DAC mux field is effectively its
> > > > > own device, and we need to control it from userspace, so we need
> > > > > some way to describe it (i.e. not ignore it) in order for its
> > > > > capability to be exposed.
> > > > >
> > > > > I'm fully aware what I'm proposing isn't awesome as it's not
> > > > > providing any real abstraction, but the problem(s) at hand also
> > > > > seem to defy abstraction, and in order to avoid a plethora of
> > > > > bespoke bindings I thought it was reasonable to define something
> > > > > generic.
> > > > >
> > > > > All-in-all I appreciate the suggestion, but assuming you agree with
> > > > > my reasoning above do you have thoughts on other alternatives?
> > > >
> > > > Seems the controls are more fixed than I first thought. All the data
> > > > you have here could simply be within a driver.
> >
> > Rob: A driver for what though? One unique to this particular mux? That feels overly specific when we can generalise the concept to cover a wider range of use-cases.
> 
> Not unique. Just instead of populating the structs you have in the
> driver from DT, define them in the driver and attach them to
> match->data ptr.

Okay, I'll prototype it.

> 
> > > > Help me understand what
> > > > functions are fixed (in the SoC) and which ones vary by board. Only
> > > > what's changing per board really needs to go into DT.
> >
> > I think this last sentence identifies a difference in our starting points, so I'd like to explore that. Blocks of functionality might move around inside the SoC as well, so don't we need a way to describe those functions appropriately?
> 
> Yes, if the blocks have well defined boundaries and functions. Blocks
> like a UART for example do. Various pieces dumped into system
> controllers generally don't IME.
> 
> > And from there describe how the SoC integrates the functions, and then describe how a board integrates the SoC? This all composes, and the problem at the end of the day comes down to what we want to view as a point of abstraction, right?
> 
> Yes. It's a judgement call as to how much we try to describe in DT. To
> use clocks again, a clock divider, mux, or gate all seem like well
> defined functions which could be (and were) described in DT, but we
> learned that doesn't really work. We're still converting platforms
> that did it that way...
> 
> > It seems ideal to me that the metadata about hardware features resides in the description of the relevant system (DT, for a function, a SoC or a board), otherwise don't we wind up with crazy, unfocused, monolithic drivers for things like system controllers? (There's MFD/syscon, but having used it previously I'm still grappling with the benefit over some of the weirdness it injects into devicetree - maybe I did it wrong.) Or alternatively, a generic driver that's choc full of platform-specific data covering the platforms that require it?
> 
> If that data is one set per SoC, then i'm not that concerned having
> platform-specific data in the driver. That doesn't mean the driver is
> not "generic". It's still not clear to me in this thread, how much of
> this is board specific, but given that you've placed all the data in
> an SoC dtsi file it seems to be all per SoC.

Right, the features we want to expose are part of the SoC, not the board it sits on. The distinction was that different boards (or even different software payloads on the same board) could use them in vastly different ways, though that mainly affects how they're treated inside the kernel and at the kernel/userspace interface rather than at the devicetree level.

Cheers,

Andrew
