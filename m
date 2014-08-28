From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Aug 2014 19:17:28 +0100
Subject: [PATCH 11/14] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <CAMuHMdXTo+JN+eSgvU_HkMKcv3RS1Dr+D3VnHF8x+EdKiK8j1g@mail.gmail.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-3-git-send-email-ch.naveen@samsung.com>
 <20140828035639.GB4972@localhost>
 <20140828094846.GD14650@leverpostej>
 <CAOesGMjY8wfAcq2fLgs=ZWHdiWtFqxr+ncUKTje0SnXqO-CCgQ@mail.gmail.com>
 <20140828170306.GQ14650@leverpostej>
 <CAOesGMgYeFObKHA9znzBq9t2mLv8WWT1QaKugQ6yf7RgV09Qyg@mail.gmail.com>
 <20140828173931.GB18005@leverpostej>
 <CAMuHMdXTo+JN+eSgvU_HkMKcv3RS1Dr+D3VnHF8x+EdKiK8j1g@mail.gmail.com>
Message-ID: <20140828181728.GF18005@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 06:47:00PM +0100, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> On Thu, Aug 28, 2014 at 7:39 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> >> Ok. If address-cells is kept at 2 the unit address needs to be changed
> >> >> to "0,0". So one or the other has to be changed.
> >> >
> >> > I'm happy either way.
> >> >
> >> > I'm not sure the rest of the tree had "0," prefixes on all of the
> >> > unit-addresses for 64-bit addresses that were under 4GB, and I'm not
> >> > sure that existing dts consistently do that either.
> >> >
> >> > Do we want to enforce that for all 64-bit unit-addresses?
> >>
> >> Yeah, I believe that's the only valid format for a 2-address-cell unit address.
> >
> > Fair enough. I didn't spot this explicitly mentioned anywhere in ePAPR,
> > but the examples match.
> 
> I couldn't find much about how the unit-addresses should really look like.
> 
> Power_ePAPR_APPROVED_v1.1.pdf:
> "The unit-address component of the name is specific to the bus type on
> which the node sits. It consists
> of one or more ASCII characters from the set of characters in Table
> 2-1. The unit-address must
> match the first address specified in the reg property of the node. If
> the node has no reg property, the
> @ and unit-address must be omitted and the node-name alone
> differentiates the node from other nodes
> at the same level in the tree. The binding for a particular bus may
> specify additional, more specific
> requirements for the format of reg and the unit-address."
> 
> "Table 2.1" contains lot of characters, definitely not limited to hex numbers.
> Also nothing about (not) needing a "0x" prefix.

This is unfortunate. I guess this was assumed to be implied by way of
the examples. :/

> > I should probably re-jig that checkpatch test I had for unit-addresses.
> 
> It would be great if dtc started complaining about unit-addresses not
> matching the first reg property.

Agreed.

When I last tried I thought that required more complex parsing than
could be done with a regex.

That said, I'd forgotten that properties must come before child nodes,
so I though I had to at least balance '{' and '}' for children. I guess
all we need to do is find a line beginning with '\s*reg\s*=\s*<' before
the next '{' or '}'.

Maybe this will be easier than previously thought. :)

Mark.
