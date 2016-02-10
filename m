From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 10 Feb 2016 13:59:36 +0100
Subject: [PATCH v4] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <56B4E2FB.3050703@arm.com>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <56B4E2FB.3050703@arm.com>
Message-ID: <20160210125936.GD31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 05, 2016 at 05:59:23PM +0000, Andre Przywara wrote:
> Hi Maxime,
> 
> just found this while looking at your current git branch, so sorry for
> the late reply.
> 
> CC:ing DT people, since you touch both existing DTs(!) and the binding doc.
> 
> On 01/02/16 20:20, Maxime Ripard wrote:
> > Remove the fixed dividers from the PLL6 driver to be able to have a
> > reusable driver that can be used across several SoCs that share the same
> > controller, but don't have the same set of dividers for this clock, and to
> > also be reused multiple times in the same SoC, since we're droping the
> > clock name.
> > 
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> > 
> > Changes from v3:
> >   - Fixed the documentation
> >   - Added pll6d2 back
> > 
> > Changes from v2:
> >   - Rebased and converted over to the new factors refactoring. Fixed the
> >     retrieved rate
> > 
> >  Documentation/devicetree/bindings/clock/sunxi.txt |  2 +-
> >  arch/arm/boot/dts/sun6i-a31.dtsi                  | 36 +++++++++++-----------
> >  arch/arm/boot/dts/sun8i-a23-a33.dtsi              | 25 ++++++++++-----
> >  arch/arm/boot/dts/sun8i-a23.dtsi                  |  2 +-
> >  arch/arm/boot/dts/sun8i-a33.dtsi                  |  4 +--
> >  arch/arm/boot/dts/sun8i-h3.dtsi                   | 37 ++++++++++++++---------
> 
> So are you really breaking all those systems by changing the DT and the
> driver in an incompatible way?

Yes.

> Please correct me if this assessment is wrong, but to me it looks like
> any user out there is either stuck with 4.5 at best _or_ will only be
> able to run 4.6 and later (depending on which version of the DT she is
> using)? And no, switching DTs along with the kernel is _not_ an option.

It is. And it is one that every other ARM platform chose. And so did
every distribution.

> That is not how I understand DT.

I'm sorry for that. This has never been something we said was
happening.

> Also this totally ignores any other DT user (U-Boot, FreeBSD, you
> name it).

Which all have their own DT copies, with their own bindings, that we
(ie Linux) never agreed on.

By further extending that argument, you're currently looking at the DT
from Allwinner, do you want to support theirs as well?

> I actually appreciate this rework, it's more flexible now and looks
> better, but you really can't do this in a way to breaks compatibility
> with existing DTs.
> 
> Jean-Francois came up with another solution for the pll8 clock [1], so
> could this be considered at least?
> I think changing the H3 PLL8 clock from dummy to something real is a
> different story in terms of compatibility (since it never really worked
> before and this wouldn't change for any old-DT user).

So, one would have to update the DT anyway to benefit from these
changes? What's the point of maintaining DT stability if you add every
new release new stuff to the DT that users are going to want? Beside
adding untested, unmaintained, dead, and possibly broken code, that is.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160210/76711c11/attachment.sig>
