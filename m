From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Apr 2017 09:02:09 +0200
Subject: [PATCH 1/3] clk: sunxi-ng: Add clk notifier to gate then ungate
 PLL clocks
In-Reply-To: <20170413021354.3258-2-wens@csie.org>
References: <20170413021354.3258-1-wens@csie.org>
 <20170413021354.3258-2-wens@csie.org>
Message-ID: <20170413070209.kjpv27fqc4o4znqs@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Thu, Apr 13, 2017 at 10:13:52AM +0800, Chen-Yu Tsai wrote:
> In common PLL designs, changes to the dividers take effect almost
> immediately, while changes to the multipliers (implemented as
> dividers in the feedback loop) take a few cycles to work into
> the feedback loop for the PLL to stablize.
> 
> Sometimes when the PLL clock rate is changed, the decrease in the
> divider is too much for the decrease in the multiplier to catch up.
> The PLL clock rate will spike, and in some cases, might lock up
> completely. This is especially the case if the divider changed is
> the pre-divider, which affects the reference frequency.
> 
> This patch introduces a clk notifier callback that will gate and
> then ungate a clk after a rate change, effectively resetting it,
> so it continues to work, despite any possible lockups. Care must
> be taken to reparent any consumers to other temporary clocks during
> the rate change, and that this notifier callback must be the first
> to be registered.
> 
> This is intended to fix occasional lockups with cpufreq on newer
> Allwinner SoCs, such as the A33 and the H3. Previously it was
> thought that reparenting the cpu clock away from the PLL while
> it stabilized was enough, as this worked quite well on the A31.
> 
> On the A33, hangs have been observed after cpufreq was recently
> introduced. With the H3, a more thorough test [1] showed that
> reparenting alone isn't enough. The system still locks up unless
> the dividers are limited to 1.
> 
> A hunch was if the PLL was stuck in some unknown state, perhaps
> gating then ungating it would bring it back to normal. Tests
> done by Icenowy Zheng using Ondrej's test firmware shows this
> to be a valid solution.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg552501.html
> 
> Reported-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Icenowy Zheng <icenowy@aosc.io>
> Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Thanks for looking into this, and coming up with a clean solution, and
a great commit log.

However, I wondering, isn't that notifier just a re-implementation of
CLK_SET_RATE_GATE?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170413/076adcef/attachment.sig>
