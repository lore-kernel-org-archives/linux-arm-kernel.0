From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Sep 2016 11:47:45 +0200
Subject: [PATCH v4 4/8] dts: sun8i-h3: move uart1 pinmux/peripheral
 assocation to DSTI
In-Reply-To: <20160908095108.GA14915@carbon.kippendief.biz>
References: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
 <1473235141-12768-5-git-send-email-jorik@kippendief.biz>
 <20160908062317.GD8913@lukather>
 <20160908080213.GA32547@carbon.kippendief.biz>
 <20160908090153.GL8913@lukather>
 <20160908095108.GA14915@carbon.kippendief.biz>
Message-ID: <20160912094745.GH9449@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 11:51:09AM +0200, Jorik Jonker wrote:
> >>- put rts/cts in seperate pinmux sets for uart1 (2,3: see below)
> >>- associate rx/tx for uart1-3 in H3 DTSI (this is the only option)
> >
> >I'm still a bit skeptical about this. This wouldn't be in any way
> >consistant. I prefer to have something consistant and a bit duplicated
> >over something without any duplication but that confuses everyone
> >about what should be placed where.
> >
> >>- associate UART1 rts/cts as pinctrl-1 in sun8i-h3-bananapi-m2-plus
> >> (to prevent breakage for existing users)
> >
> >You can also set it in pinctrl-0.
> 
> OK, sounds reasonable, but also a bit contradictive. One the one hand you
> prefer consistency (so, let uart2-3 follow uart1 and include rts/cts in
> them)

Hmm, I never said that, quite the opposite actually. Any board might
use either just RX/TX, or RX/TX and RTS/CTS. I don't see why we should
enable RTS/CTS on any board by default.

> , on the other hand the common case over the rare (so split off
> rts/cts). What should I do with uarts2-3 and should I do that to
> uart1 too?

You do the exact same thing in both cases.

My point was that you could just do:

pinctrl-0 = <&uart0_pins_a>, <&uart0_rts_cts_pins_a>;
pinctrl-names = "default";

instead of

pinctrl-0 = <&uart0_pins_a>;
pinctrl-1 = <&uart0_rts_cts_pins_a>;
pinctrl-names = "default", "default";

Since they are the exact same pin state.

> Moreover, Chen-Yu prefers to drop _a and @0 when they are redundant, which
> does not appear to be the convention, looking at existing sun*dsti. What's
> your opinion on this?

AFAIK, he wanted to remove them when they're not relevant (ie, only
one pin state possible).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160912/2eaa8fe0/attachment.sig>
