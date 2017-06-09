From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 09 Jun 2017 22:22:52 +0930
Subject: [PATCH] arm: aspeed: Add Aspeed board file with clocksource
 devicetree fixup
In-Reply-To: <CAK8P3a23XpDQhnM=j8FBS8NGck2ZfaAotVo191NEOttP2GDCYA@mail.gmail.com>
References: <CAK8P3a0EaqwmAMRWn--29e4Kt6zJA9kHL2dpj=7Uabn5hANxOA@mail.gmail.com>
 <20170609073037.21871-1-andrew@aj.id.au>
 <CAK8P3a23XpDQhnM=j8FBS8NGck2ZfaAotVo191NEOttP2GDCYA@mail.gmail.com>
Message-ID: <1497012772.23335.12.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-06-09 at 11:19 +0200, Arnd Bergmann wrote:
> > On Fri, Jun 9, 2017 at 9:30 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > Add the clock-names property in init_timer() to work-around Aspeed
> > devicetrees from times prior to merging the Moxart/Aspeed and Faraday
> > drivers.
> > 
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > Well, here's an implementation I knocked up. It's a fair chunk of code for
> > marginal benefit. Joel is against it.
> > 
> > At least it's something to debate.
> > 
> > Tested under QEMU for both AST2400 and AST2500 SoCs.
> 
> Right, I think having the one-line fixup in the driver makes way more sense
> here, and that is what we usually do, but we could do this if Daniel has good
> reasons to keep the driver free of backwards-compatibility support.

Yeah, choosing between the two with no further information I'd prefer
adding support to the driver.

> 
> It also depends a bit on how common the old binding version already
> is, and if anyone is shipping systems with that.

So the fttmr010 bindings describe the clocks and clock-names properties
as optional (a little confusingly, "Optionally required properties"). 
I guess keeping in mind the bindings describe the hardware and not the
driver this might be reasonable, but the driver fails init if they're
not present. arch/arm/boot/dts/moxart.dtsi doesn't specify clock-names
either so I would have thought systems based on it would also fail.
However, Linus' fttmr010 series has Tested-by tags from Jonas, so maybe
I've missed something.

Regardless, if it's the case that Moxa systems now fail to init the
clocksource then the Aspeed-specific init_time() solution is even less
attractive. moxart.dtsi dates back to December 2013 ("448e7edefa92 ARM:
moxart: add MOXA ART SoC device tree files").

The old binding is less of a problem for Aspeed systems as we don't yet
have a clk driver upstream. Joel only recently added fixed-clock nodes
in 4.12 so Aspeed systems could boot without DTS modifications.

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/908ac828/attachment.sig>
