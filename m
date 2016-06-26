From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 27 Jun 2016 00:18:57 +0200
Subject: [PATCH] clk: rockchip: add flag CLK_SET_RATE_PARENT for
 dclk_vop0_div on RK3399
In-Reply-To: <CAD=FV=V5UvQGtYQ26gZ+U7+TygEWuqRoHhiH8SiQSK7GcvkF5w@mail.gmail.com>
References: <1465724928-14611-1-git-send-email-zhengxing@rock-chips.com>
 <2376423.L1zs1HaIGm@diego>
 <CAD=FV=V5UvQGtYQ26gZ+U7+TygEWuqRoHhiH8SiQSK7GcvkF5w@mail.gmail.com>
Message-ID: <3441187.YrMqoaIQDf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Juni 2016, 17:31:16 schrieb Doug Anderson:
> OK, so what do we do?  Personally I can't see us coming up with a
> one-size fits all approach, can you?  That means some type of
> configuration.  ...and, as seen by the assigned-clocks device tree
> binding, _some_ types of configuration is allowed in the device tree
> presuming it is well thought out and describing how the designers of
> the hardware "intended" it to be used.
> 
> So maybe:
> 
> i) Unless there's a counter example, I see no reason to let any clocks
> other than the VOP display clocks parent on the "dynamic" PLL.  If we
> later find a counter example then presumably we should add a device
> tree property on that board.  We could have code at boot time that
> goes through all clocks parented on "dynamic" PLL and reparents them
> (trying to keep the rate?), they disallows future muxing to the
> "dynamic" PLL.

Two problems:
- "disallowing future muxing to the pll" feels a bit far on the "policy"-
side on the policy<->hw-description scale, I still guess the kernel should 
be allowed to shoot itself in the foot :-)
- would probably include hacking up the clock parent-names, which won't work 
at runtime, as they are init params and get memcpy'd on clk creation.

But I guess this issue of depending clock maybe needing to adapt to a 
changed pll-rate here would be solvable with my rate-reassignment I still 
need to revisit.


> ii) It seems sane to me to add a device tree property to the board
> that will effectively enable CLK_SET_RATE_PARENT on one of the
> dclk_vop clocks and forcing it to the "dynamic" PLL (no
> auto-remuxing).  Maybe we would add something to the HDMI node, for
> instance, like "rockchip,intended-dclk-pll = <&...>".  Then somehow
> this would need to affect whichever VOP was assigned to HDMI.

Right now I see two issues:
- can the drm reassign vops at runtime [don't know enough about drm], but 
what would happen in such a case when hdmi jumps from one to the other vop.
- clock-flags [CLK_SET_RATE_PARENT and friends] are clk-init data, set when 
creating a clock, so there is no changing this at runtime - see above

I guess one option to handle this could be to not have anybody getting a 
real CLK_SET_RATE_PARENT to the vpll, but instead having the vops handle 
this special pll if necessary. Aka check if the requested rate is possible 
using the current sources (clk_round_rate on the dclk_vopX) and if not adapt 
the special pll to a suitable source rate and re-check.

And if there is no dclk-vpll, then simply skip that step and try to get the 
best rate possible.


> iii) If later someone can propose how to handle D) above, we can
> handle it then.  Until a solution is proposed those boards would work
> like today.

Having the "rockchip,dclk-pll = <&...>;" live in the display-subsystem node 
or so (=assigned to the global display-subsystem not one special vop) the 
available vops might even be able to work out between them who should get 
access to it depending on connected displays / modes?


Heiko
