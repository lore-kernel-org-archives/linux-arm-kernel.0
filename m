From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 19 Jul 2018 11:58:22 +0930
Subject: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
In-Reply-To: <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
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
Message-ID: <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I agree
> > that not using /dev/mem is a good thing, but there are several ways
> > you could do that independent of any DT binding.
> 
> Such as ? The only other option is to have one or more kernel drivers
> that have built-in the precise and complete list of those tunables that
> need to be exposed.
> 
> It's not impossible, but I worry that it's not going to scale terribly
> well, and that vendors will constantly "fork" that driver to add
> different things to that list.

Picking on that last point, "different things" doesn't necessarily mean "different fields in the SoC" (though it may). We could just need to use different initial values for the fields already described. So taking that into account, the field descriptions could vary wildly from platform to platform - where "platform" here is the combination of the BMC, its host system, and the host system's required configuration - not just referring to the BMC in isolation.  That in turn may cause a fork of the driver (changes that are incompatible with other platforms), or not scale terribly well as Ben suggests.

The initial value concept can help reduce the impact on userspace as userpace may no-longer need to care about it, so I think it's a desirable property. With respect to devicetree, the field definitions will stay in the SoC dtsi, but the initial values would be described on a per-platform basis in the dts.

> 
> I might be wrong here, so I'd like for Eugene (Dell) and Alexander
> (Yadro) to chime in, but experience with BMCs has shown that we
> regularily , as we add a feature or rewrite something, need to find
> another new magic SoC tunable the HW manufacturer hid somewhere that
> will make our stuff work.
> 
> > > Now, updating the device-tree in the board flash with whatever vendor
> > > specific information is needed is a LOT easier than getting the kernel
> > > driver constantly updated. The device-tree after all is there to
> > > reflect among other things system specific ways in which the SoC is
> > > wired and configured. This is rather close...
> > 
> > Sadly, updating my kernel is easier than updating my PC firmware
> > (though packaged firmware on my current laptop changes that). I can
> > assure you that ARM boards are generally much worse in that regard.
> > BTW, you may want to pay attention to EBBR[1][2]. Not sure how much
> > you care for BMCs, but there may be some interest.
> 
> You are conflating your host kernel and your BMC here. The BMC kernel
> is part of the "firmware", as is its DTS and the BMC userspace.
> 
> (Again this isn't the host DTS, this is the BMC DTS).
> 
> They get all updated together. My point isn't about the ease or
> difficulty for a *user* to udpate their BMC, in that case the solutions
> above are equivalent.
> 
> The point is from a system vendor perspective. A system vendor using
> OpenBMC will *customize* their BMC build in various ways. Typically
> they *will* have a custom DT since this is what represents their
> specific system and they will have some specific userspace bits.
> 
> However, we are trying very hard for them *not* to fork the kernel, and
> if possible move OpenBMC towards a fully upstream kernel (still working
> on getting all the SoC drivers cleaned up and pushed up but it's moving
> in the right direction).
> 
> So from a vendor perspective, such as us IBM, we *alread* have custom
> DTs and customized userspace, that's part of the normal flow of
> deploying a BMC.
> 
> However, we are trying *NOT* to have a custom kernel (and we don't, at
> the moment there is an OpenBMC kernel accross vendors, though it's not
> *yet* fully upstream).
> 
> So if the solution proposed is prone to requiring frequent changes to a
> kernel driver, that solution makes the above a lot more difficult and
> will encourage vendors to keep forking kernels.
> 
> This is what we are trying to avoid.

Well described. Thanks Ben.

Andrew
