From: karlp@tweak.net.au (Karl Palsson)
Date: Wed, 29 Oct 2014 15:05:36 +0000
Subject: [PATCH v2] ARM: dts: rockchip: use internal pull-up resistors on
 I2C busses
In-Reply-To: <5450FAF3.2010208@neo-technologies.fr>
References: <1414492597-13566-1-git-send-email-julien.chauveau@neo-technologies.fr>
 <2234299.BSD6RSf1dG@diego>
 <20141029134415.GA3499@palmtree.beeroclock.net>
 <32904940.RFLKbTnBmv@xq-nb> <5450FAF3.2010208@neo-technologies.fr>
Message-ID: <20141029150536.GA3876@palmtree.beeroclock.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


However, and possibly out of line, but should we consider submitting a patch to remove the
pullups by default for exynos that Doug hinted at?  

Cheers,
Karl P


On Wed, Oct 29, 2014 at 03:34:27PM +0100, NEO-Technologies / Julien CHAUVEAU wrote:
> Hi everyone,
> 
> Okay, I understand your opinion. So let's drop my patch in this case.
> 
> Thank you for your comments.
> 
> Julien
> 
> 
> Le 29/10/2014 15:02, Max Schwarz a ?crit :
> >Hi,
> >
> >I'll agree with Karl and Doug. If you (as a board vendor/maintainer/etc) want
> >to use I2C, it's *your* responsibility to provide the pullup resistors by
> >either including pullup resistors on the board or by enabling the internal
> >ones.
> >Either way, you should think a moment about the consequences (frequency/trace
> >length limitations), which is why I'm also against the pullup-by-default
> >behavior.
> >
> >Also, it's much harder to diagnose effects like Doug is describing (slightly
> >out-of-spec due to internal + external pulls) than the effects you are seeing
> >without any pullups. With your i2cdetect results my first thought would have
> >been "are there pullups on the bus?".
> >
> >Cheers,
> >   Max
> >
> >Am Mittwoch, 29. Oktober 2014, 13:44:15 schrieb Karl Palsson:
> >>I'd be more inclined to have pulls disabled by default, it's more standard
> >>with what smaller micros do, but I've no experience with these bigger
> >>cortex-a parts.  It's also the "least surprise" path.  If you want to try
> >>and use the onboard pullups, you can specify that in your board file, but
> >>for people deliberately selecting pullups for their timing and load
> >>expectations, being required to take an extra step to turn off something
> >>seems unexpected.
> >>
> >>If you _want_ to be able to probe an i2c bus for devices added aftermarket,
> >>on a board that didn't get i2c pull ups because no devices were planned,
> >>and you want to turn on the internal pullups for that, I think that's
> >>something you need to do yourself, not making it a hard default in the SoC
> >>dtsi file.
> >>
> >>so, if it's off by default, you get this
> >>                                          dtsi   dts
> >>Board1, i2c periphs, designed pullups => off     -
> >>board2, no peripsh, pulls in case     => off     -
> >>board3, no periphs, forgot pulls, pray=> off    on
> >>
> >>If you turn it on by default, sure, it causes no harm in most cases, but
> >>you're no longer getting the values you expect, without having to turn off
> >>things that are not default anyway.
> >>
> >>Sincerely,
> >>Karl Palsson
> >>
> >>On Wed, Oct 29, 2014 at 02:17:23PM +0100, Heiko St?bner wrote:
> >>>Hi Addy, Max, Wolfram,
> >>>
> >>>after Doug's explanation of disfavour [0] and Julien's subsequent response
> >>>I'm not sure which direction to go. So if possible I'd like to collect
> >>>some more opinions of people knowing a lot more about i2c internals than
> >>>myself :-) .
> >>>
> >>>
> >>>Thanks
> >>>Heiko
> >>>
> >>>
> >>>[0] http://lists.infradead.org/pipermail/linux-rockchip/2014-October/000934.html
> 
