From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 12 Jul 2018 10:14:09 +1000
Subject: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc.
 BMC control fields
In-Reply-To: <20180711200450.GB17291@rob-hp-laptop>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
Message-ID: <2f479f747daa5cee15d250e3a6a4853e3dc1c4a0.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-07-11 at 14:04 -0600, Rob Herring wrote:
> On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
> > Baseboard Management Controllers (BMCs) are embedded SoCs that exist to
> > provide remote management of (primarily) server platforms. BMCs are
> > often tightly coupled to the platform in terms of behaviour and provide
> > many hardware features integral to booting and running the host system.
> > 
> > Some of these hardware features are simple, for example scratch
> > registers provided by the BMC that are exposed to both the host and the
> > BMC. In other cases there's a single bit switch to enable or disable
> > some of the provided functionality.
> > 
> > The documentation defines bindings for fields in registers that do not
> > integrate well into other driver models yet must be described to allow
> > the BMC kernel to assume control of these features.
> 
> So we'll get a new binding when that happens? That will break 
> compatibility.

What do you mean ? The binding provides a way to describe arbitrary
register fields and expose them to userspace. I'm not sure what you
mean by backward compatibility.

There is simply no way these things can be "abstracted" via some kind
of nice layered Linux subsystem of some sort. It's just a whole bunch
of knobs that control various things integral to the operation of the
host system. Andrew can provide a more precise list if you need to.

> 
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > 
> > Since RFC v1:
> > 
> > * Add a commit message
> > * Minor changes to documented labels
> > 
> >  .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++++++++
> >  MAINTAINERS                                   |   6 +
> >  2 files changed, 258 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > new file mode 100644
> > index 000000000000..2c869fcc7ef2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > @@ -0,0 +1,252 @@
> > +BMC Miscellaneous Control Interfaces
> > +====================================
> > +
> > +Baseboard Management Controllers (BMCs) often have an array of hardware
> > +features that need to be described but are awkward to sensibly expose.
> > +
> > +This bindings document provides a generic mechanism for describing such
> > +features, covering read-only (RO), read-modify-write (RMW) and
> > +write-1-set/write-1-clear (W1SC) semantics.
> 
> If we wanted a generic mechanism for single register bits/fields in DT, 
> we'd have one already. A node per register bit doesn't scale.

Register *field*. I think you are looking at this from the wrong angle.
This isn't about exposing 236821643 SoC registers in an embedded
product. This is about exposing a dozen or so tunables that don't
control the SoC from the perspective of the OS running on it, but
controls how various features of the SoC are exposed to the *host*
system. Examples could be which of the SoC internal PCIe devices
exposed to the host is enabled (the SoC can appear as a GPU, a BMC misc
device or both or neither, it can have a DMA controller or not,
etc...). Other examples are scratch registers that need to be set to
system specific values by userspace, which the BIOS of the host will
read to determine some configuration information. That sort of thing.

There isn't that many, scalability isn't a problem. Both the list of
registers of interest and what needs to go in them is very much
system/vendor specific. This is a way for the kernel to act as a
"conduit" that doesn't need to know the specifics of a given
system/vendor/BIOS combination.

Your response smells like yet another case of trying to apply one of
those general "blanket" rules to something where it's completely
unapplicable.

> Maybe this should be modelled using GPIO binding? There's a line there 
> too as whether the signals are "general purpose" or not.

GPIOs are binary values right ? These are arbitrary fields. We want
arbitrary fields. This is really needed Rob, otherwise we'll NEVER have
BMC support upstream. 

The other option will be a dozen random ad-hoc char-devs that would
have to be updated every time a new bit needs to be added or changed.

Ben.
