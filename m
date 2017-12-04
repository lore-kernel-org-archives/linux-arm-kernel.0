From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 04 Dec 2017 08:46:18 +0100
Subject: [PATCH 0/4] Move DP phy switch to PHY driver
In-Reply-To: <8042d73f-c1de-da41-9066-2377de1f521c@rock-chips.com>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
 <1941891.vosvJnn3h1@phil>
 <8042d73f-c1de-da41-9066-2377de1f521c@rock-chips.com>
Message-ID: <4091462.xo23GTqF41@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Am Montag, 4. Dezember 2017, 10:47:08 CET schrieb Chris Zhong:
> On 2017?12?02? 05:58, Heiko Stuebner wrote:
> > Am Freitag, 1. Dezember 2017, 13:42:46 CET schrieb Doug Anderson:
> >> Hi,
> >> 
> >> On Wed, Nov 29, 2017 at 6:27 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> >>> Hi Doug
> >>> 
> >>> Thank you for mentioning this patch.
> >>> 
> >>> I think the focus of the discussion is: can we put the grf control bit
> >>> to
> >>> dts.
> >>> 
> >>> The RK3399 has 2 Type-C phy, but only one DP controller, this
> >>> "uphy_dp_sel"
> >>> 
> >>> can help to switch these 2 phy. So I think this bit can be considered as
> >>> a
> >>> part of
> >>> 
> >>> Type-C phy, these 2 phy have different bits, just similar to other bits
> >>> (such as "pipe-status").
> >>> 
> >>> Put them to DTS file might be a accepted practice.
> >> 
> >> I guess the first step would be finding the person to make a decision.
> >> Is that Heiko?  Olof?  Kishon?  Rob?.  As I see it there are a few
> >> options:
> >> 
> >> 1. Land this series as-is.  This makes the new bit work just like all
> >> the other ones next to it.  If anyone happens to try to use an old
> >> device tree on a new kernel they'll break.  Seems rather unlikely
> >> given that the whole type C PHY is not really fully functional
> >> upstream, but technically this is a no-no from a device tree
> >> perspective.
> >> 
> >> 2. Change the series to make this property optional.  If it's not
> >> there then the code behaves like it always did.  This would address
> >> the "compatibility" problem but likely wouldn't actually help any real
> >> people, and it would be extra work.
> >> 
> >> 3. Redo the driver to deprecate all the old offsets / bits and just
> >> put the table in the driver, keyed off the compatible string and base
> >> address if the IO memory.
> >> 
> >> 
> >> I can't make this decision.  It's up to those folks who would be
> >> landing the patch and I'd be happy with any of them.  What I'm less
> >> happy with, however, is the indecision preventing forward progress.
> >> We should pick one of the above things and land it.  My own personal
> >> bias is #1: just land the series.  No real people will be hurt and
> >> it's just adding another property that matches the ones next to it.
> > 
> > I'd second that #1 . That whole type-c phy thingy never fully worked in
> > the past (some for the never used dp output), so personally I don't have
> > issues with going that route.
> > 
> >>  From a long term perspective (AKA how I'd write the next driver like
> >> 
> >> this) I personally lean towards to "tables in the driver, not in the
> >> device tree" but quite honestly I'm happy to take whatever direction
> >> the maintainers give.
> > 
> > It looks like we're in agreement here :-) . GRF stuff should not leak into
> > the devicetree, as it causes endless headaches later. But I guess we'll
> > need to live with the ones that happened so far.
> 
> So, the first step is: move all the private property of tcphy to
> drivers/phy/rockchip/phy-rockchip-typec.c.
> Second step: new a member: uphy-dp-sel.
> In my mind, we should have discussed these properties before, and then I
> moved them all into DTS.

Actually, I was agreeing with Doug, that we probably don't need to rework the 
type-c phy driver. As most properties for it are in the devicetree right now
we'll need to support them for backwards-compatiblity anyway.

And yes, there probably was discussion over dts vs. driver-table when the
type-c driver was introduced, but I either missed it or wasn't firm enough
back then ;-) .

Hence the "we'll need to live with it" for the type-c phy, but should not
do similar things in future drivers.


Heiko
