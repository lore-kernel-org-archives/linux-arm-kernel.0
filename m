From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 17 Sep 2014 16:02:43 +0300
Subject: [PATCH] ARM: OMAP2+: clock: allow omap2_dpll_round_rate() to
 round to next-lowest rate
In-Reply-To: <alpine.DEB.2.02.1407231043230.32419@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407231043230.32419@utopia.booyaka.com>
Message-ID: <54198673.3090002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/07/14 13:44, Paul Walmsley wrote:
> 
> Change the behavior of omap2_dpll_round_rate() to round to either the
> exact rate requested, or the next lowest rate that the clock is able to
> provide.
> 
> This is not an ideal fix, but is intended to provide a relatively safe
> way for drivers to set PLL rates, until a better solution can be
> implemented.
> 
> For the time being, omap3_noncore_dpll_set_rate() is still allowed to
> set its rate to something other than what the caller requested; but will
> warn when this occurs.
> 
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/clkt_dpll.c | 28 +++++++++++++++++++++-------
>  arch/arm/mach-omap2/dpll3xxx.c  | 12 ++++++++++--
>  2 files changed, 31 insertions(+), 9 deletions(-)

This patch improved things quite a bit, but we still have problems. I
noticed that on AM43xx:

clk_round_rate(dss_fclk, 199990846) = 199967213
clk_set_rate(dss_fclk, 199967213) -> 199966387

So similar to the issue that 7e50e7e176634e8cc0335778915be75df41043dc fixed.

Above you say that "omap3_noncore_dpll_set_rate() is still allowed to
set its rate to something other than what the caller requested; but will
warn when this occurs.", but I see no warning printed.

I didn't find out where the error comes from, but I (again) noticed the
two issues we have:

- The omap dpll code has no maximum values, so omap2_dpll_round_rate()
goes on to return ~4GHz rates as valid, which I believe it can't do.

- clk-divider.c driver doesn't handle errors from __clk_round_rate(). At
least omap2_dpll_round_rate() returns ~0 on error.

Any ideas where that round/set issue might come from?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140917/c3a21e5a/attachment.sig>
