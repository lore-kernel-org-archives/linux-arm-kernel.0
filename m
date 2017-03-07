From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Mar 2017 15:58:34 +0100
Subject: [PATCH 4/5] clk: sunxi-ng: Add driver for A83T CCU
In-Reply-To: <20170303235639.GW25384@codeaurora.org>
References: <20170214033526.16977-1-wens@csie.org>
 <20170214033526.16977-5-wens@csie.org>
 <20170214095819.utsftcvti5zdmlmi@lukather>
 <CAGb2v66PxbhUdqSwFc5iFN2wDVQbOsibDkckXpFsxXW1WJNe3w@mail.gmail.com>
 <20170215094954.h3wyaxlqkeb342yu@lukather>
 <20170301191705.GS25384@codeaurora.org>
 <20170303095333.hgxoli2h7clailvo@lukather>
 <20170303235639.GW25384@codeaurora.org>
Message-ID: <20170307145834.kalpo76jbwll6z5s@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Mar 03, 2017 at 03:56:39PM -0800, Stephen Boyd wrote:
> On 03/03, Maxime Ripard wrote:
> > On Wed, Mar 01, 2017 at 11:17:05AM -0800, Stephen Boyd wrote:
> > 
> > > Can someone explain what the issue is? Could something like
> > > clk_get_phase() + clk_get_rate() tell us if we're in one mode
> > > vs. the other?
> > 
> > So we have two modes of operation for that clock, old vs new (I know,
> > I didn't pick the names).
> > 
> > The old mode is what we support right now. It has a combination of a
> > linear multiplier and divider, plus some phase controls.
> > 
> > The new mode however disables the phase controls and adds post-divider
> > of 2 on the rate.
> > 
> > We cannot really rely on the rate itself, since there's a huge overlap
> > between the rates we can obtain in the old and new modes. Same thing
> > for the phase, having a 0 deg phase is achieved both in the old and
> > new modes.
> > 
> > To make things worse, the new mode is only available on one out of
> > three MMC controllers (and associated clocks), and that MMC controller
> > needs to set a bit as well to switch to the new mode if needed. So we
> > definitely needs some synchronisation there, and also to be able to
> > retrieve if the mode switching is available, and if we're already
> > using that mode.
> > 
> > Mike agreed that the easiest way forward was to use a custom function.
> 
> Ok. Is there any need to change the mode dynamically at runtime?
> Or could it be decided once at clk driver probe time/boot time
> and detected via set_phase() failing when we're in the new mode?

One thing I forgot to mention is that we also still have to support
the old DTs that use our old clock drivers, that will probably never
get to see this new mode. So the first thing we need is being able to
tell whether that mode is supported and if it's already enabled.

And if it's supported, and not enabled, enable it, both in the clock
and MMC drivers.

> At least, it sounds like set_phase() should bail out there
> because it doesn't exist, although it could be argued that
> setting the phase to something it already is set to is valid and
> shouldn't return an error.

Yep, once the new mode is set (disregarding how we do it), we should
prevent any clk_set_phase != 0. We'll also need to adjust the reported
clock rate.

> I'm not saying I'm opposed to the custom function, just thinking
> of alternatives if MMC maintainers don't agree with the custom
> function.

Ok, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170307/3c5f8057/attachment.sig>
