From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Apr 2017 11:27:49 +0200
Subject: [PATCH 1/3] clk: sunxi-ng: Add clk notifier to gate then ungate
 PLL clocks
In-Reply-To: <CAGb2v64z9+FyozKf=O4ASFrEgZoeGJVBSNR6NsnyP4dHgYZqfw@mail.gmail.com>
References: <20170413021354.3258-1-wens@csie.org>
 <20170413021354.3258-2-wens@csie.org>
 <20170413070209.kjpv27fqc4o4znqs@lukather>
 <CAGb2v64z9+FyozKf=O4ASFrEgZoeGJVBSNR6NsnyP4dHgYZqfw@mail.gmail.com>
Message-ID: <20170413092749.h5iyqqnuvy4odxwv@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 03:35:30PM +0800, Chen-Yu Tsai wrote:
> On Thu, Apr 13, 2017 at 3:02 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi Chen-Yu,
> >
> > On Thu, Apr 13, 2017 at 10:13:52AM +0800, Chen-Yu Tsai wrote:
> >> In common PLL designs, changes to the dividers take effect almost
> >> immediately, while changes to the multipliers (implemented as
> >> dividers in the feedback loop) take a few cycles to work into
> >> the feedback loop for the PLL to stablize.
> >>
> >> Sometimes when the PLL clock rate is changed, the decrease in the
> >> divider is too much for the decrease in the multiplier to catch up.
> >> The PLL clock rate will spike, and in some cases, might lock up
> >> completely. This is especially the case if the divider changed is
> >> the pre-divider, which affects the reference frequency.
> >>
> >> This patch introduces a clk notifier callback that will gate and
> >> then ungate a clk after a rate change, effectively resetting it,
> >> so it continues to work, despite any possible lockups. Care must
> >> be taken to reparent any consumers to other temporary clocks during
> >> the rate change, and that this notifier callback must be the first
> >> to be registered.
> >>
> >> This is intended to fix occasional lockups with cpufreq on newer
> >> Allwinner SoCs, such as the A33 and the H3. Previously it was
> >> thought that reparenting the cpu clock away from the PLL while
> >> it stabilized was enough, as this worked quite well on the A31.
> >>
> >> On the A33, hangs have been observed after cpufreq was recently
> >> introduced. With the H3, a more thorough test [1] showed that
> >> reparenting alone isn't enough. The system still locks up unless
> >> the dividers are limited to 1.
> >>
> >> A hunch was if the PLL was stuck in some unknown state, perhaps
> >> gating then ungating it would bring it back to normal. Tests
> >> done by Icenowy Zheng using Ondrej's test firmware shows this
> >> to be a valid solution.
> >>
> >> [1] http://www.spinics.net/lists/arm-kernel/msg552501.html
> >>
> >> Reported-by: Ondrej Jirman <megous@megous.com>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> Tested-by: Icenowy Zheng <icenowy@aosc.io>
> >> Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> >
> > Thanks for looking into this, and coming up with a clean solution, and
> > a great commit log.
> >
> > However, I wondering, isn't that notifier just a re-implementation of
> > CLK_SET_RATE_GATE?
> 
> They are not the same. AFAIK, CLK_SET_RATE_GATE tells the clk framework
> that this clk's rate cannot be changed if it is enabled (which means
> some one is using it). However the clk framework does nothing to
> actually handle it. It just returns an error. Any consumers are
> responsible for gating the clock before making changes. This is a nice
> thing to have, as it can prevent unintended changes to dot clocks or
> audio clocks used with active output streams. We could consider setting
> this for the audio and video PLLs.

Ah, you're right. I merged the two first patches and will send them
for 4.11.

> Here we are dealing with the CPU PLL, which, for practical reasons,
> is always enabled as far as the clk framework is concerned. The
> reason being the OPPs are never low enough for the CPU clock to
> use any other parent. To have it disabled, we would have to kick
> consumers (the CPU clock in this case) to use other clocks, so it's
> safe, remember which ones we kicked, and then bring them back once
> everything is done.
> 
> AFAIK, we, samsung, rockchip, meson, do the temporary reparenting
> using clk_notifiers to access the mux registers directly. As far
> as the clk framework is concerned, nothing has changed.
> 
> I'm not saying it's not possible to support this in the core, but
> the core already has to do a lot of bookkeeping and recalculation
> when anything changes. Adding something transient into the process
> isn't helping. And the reparenting might temporarily violate any
> downstream requirements.
> 
> For now, I think clk notifiers is the easier solution for these
> one off requirements that are pretty much contained in a small
> part of the system.

However, the third one is less urgent, since we don't have H3 cpufreq
support yet, so we won't hit that case, and I'd like to have first a
common function that register the notifiers since the order really
matters, we don't want to have someone getting it wrong.

Since this is 4.13 material, there's no rush on that one though.

Thanks again!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170413/2f3b1b71/attachment-0001.sig>
