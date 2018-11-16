From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Nov 2018 11:22:44 +0100
Subject: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
In-Reply-To: <20181116064748.6c7shn3am4wejrnj@pengutronix.de>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <20181114124752.GI2620@ulmo>
 <20181116064748.6c7shn3am4wejrnj@pengutronix.de>
Message-ID: <20181116102244.GB14769@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 07:47:48AM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Nov 14, 2018 at 01:47:52PM +0100, Thierry Reding wrote:
> > On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
> > > The flag 'has_clks' and related checks are superfluous as the CCF
> > > subsystem does this for you.
> > 
> > Both of these mechanisms aren't equivalent. While CCF can deal with
> > optional clocks, what the has_clks flag actually means is that the
> > device doesn't need a clock (or doesn't have a clock input) on the
> > devices where it is cleared.
> > 
> > So I'd actually be in favor of keeping the has_clks property because it
> > serves as an additional sanity check. For example if you run this driver
> > on an SoC that "has clocks" but if you don't list them in DT, then after
> > this patch the driver will happily continue without clocks, even though
> > it may break completely without those clocks. I've seen SoCs respond to
> > disabled clocks for a hardware block in different ways, in many cases an
> > access to any of the registers will completely hang the CPU. In other
> > cases it may just crash in some other way or give you some sort of
> > machine exception. None of those are good, and make the tiny bit of
> > additional code required to support the has_clks flag very attractive.
> > 
> > But that's just my opinion. If you prefer to throw away that safety
> > barrier, be my guest. But if you do, please move this functionality into
> > the clock framework first and then make the driver use it.
> 
> The usual policy is: If the things specified in the dt are
> wrong or incomplete, it's ok to fail however you like. So from a
> correctness POV I think the change is fine.

Erm... that's pretty much what I said. It doesn't necessarily mean that
it's the right thing to do, though. If we know that clocks are required
and we don't find them in DT, it's better to complain and let the user
know exactly what is wrong rather than just let it crash and have them
track down the bug without additional information.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/a8092c6b/attachment.sig>
