From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 18 Jul 2018 08:58:18 +0930
Subject: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
In-Reply-To: <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
 <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
Message-ID: <1531870098.3337969.1444201888.2476205D@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jul 2018, at 14:26, Benjamin Herrenschmidt wrote:
> On Mon, 2018-07-16 at 07:55 -0600, Rob Herring wrote:
> > If that data is one set per SoC, then i'm not that concerned having
> > platform-specific data in the driver. That doesn't mean the driver is
> > not "generic". It's still not clear to me in this thread, how much of
> > this is board specific, but given that you've placed all the data in
> > an SoC dtsi file it seems to be all per SoC.
> 
> So Rob, I think that's precisely where the disconnect is.
> 
> I think we all (well hopefully) agree that those few tunables don't fit
> in any existing subystem and aren't likely to ever do (famous last
> words...).
> 
> Where we disagree is we want to make this parametrized via the DT, and
> you want us to hard wire the list in some kind of SoC driver for a
> given SoC family/version.
> 
> The reason I think hard wiring the list in the driver is not a great
> solution is that that list in itself is prone to variations, possibly
> fairly often, between boards, vendors, versions of boards, etc...
> 
> We can't know for sure every SoC tunable (out of the gazillions in
> those chips) are going to be needed for a given system. We know which
> ones we do use for ours, and that's a couple of handfuls, but it could
> be that Dell need a slightly different set, and so might Yadro, or so
> might our next board revision for that matter.
> 
> Now, updating the device-tree in the board flash with whatever vendor
> specific information is needed is a LOT easier than getting the kernel
> driver constantly updated. The device-tree after all is there to
> reflect among other things system specific ways in which the SoC is
> wired and configured. This is rather close...

Not sure this helps, but I feel that the proposal pretty closely matches what's described in Documentation/devicetree/bindings/mfd/mfd.txt. It's intended that nodes using the bindings I'm proposing are children of a 'compatible = "syscon", "simple-mfd"' node (this is the case with the features we're hoping to describe for our SoC). I should explicitly call that out.

But to go on, "simple-mfd" is effectively an alias of "simple-bus", which means its intended to match child node compatibles to drivers provided by the kernel. If we shouldn't be describing minor features of a SoC in the devicetree, doesn't this invalidate the case for simple-mfd? What is the *correct* use of simple-mfd? When is it not used to expose minor features in set of "miscellaneous system registers"? Why doesn't this proposed case fit?

Cheers,

Andrew
