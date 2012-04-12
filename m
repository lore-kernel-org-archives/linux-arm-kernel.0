From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Apr 2012 11:30:48 +0800
Subject: [PATCH 25/40] ARM: imx: add common clock support for clk busy
In-Reply-To: <4F8603E9.1080607@codeaurora.org>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-26-git-send-email-s.hauer@pengutronix.de>
 <4F848301.4080607@codeaurora.org>
 <20120411065305.GH3852@pengutronix.de>
 <4F8603E9.1080607@codeaurora.org>
Message-ID: <20120412033040.GF2445@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 03:21:29PM -0700, Stephen Boyd wrote:
> On 04/10/12 23:53, Sascha Hauer wrote:
> > On Tue, Apr 10, 2012 at 11:59:13AM -0700, Stephen Boyd wrote:
> >> On 04/10/12 06:45, Sascha Hauer wrote:
> >>> +static int clk_busy_wait(void __iomem *reg, u8 shift)
> >>> +{
> >>> +	unsigned long timeout = jiffies + msecs_to_jiffies(10);
> >>> +
> >>> +	while (readl_relaxed(reg) & (1 << shift))
> >>> +		if (time_after(jiffies, timeout))
> >>> +			return -ETIMEDOUT;
> >>> +
> >>> +	return 0;
> >>> +}
> >> MSM also has a bit to poll to see if a clock is enabled or not, similar
> >> to this rate switch complete bit. Would it make sense to have another
> >> few clock ops like wait_for_enable(), wait_for_rate(),
> >> wait_for_disable()? Then you should be able to copy the basic divider
> >> ops and assign the wait ops and avoid the wrappers.
> > I think this won't work. What arguments would your wait_for_* functions
> > take?
> 
> I assume the same as what all the other ops take.
> 
> wait_for_disable(struct clk_hw *hw)
> wait_for_enable(struct clk_hw *hw)
> wait_for_rate(struct clk_hw *hw)
> 
> Do you see the need for anything else?
> 
I guess Sascha is asking what arguments the particular clk registration
function need to take for implementing those wait_for_* ops.

For clk_gate example, besides the existing parameters that
clk_register_gate already takes, it needs to take more, probably
reg_busy, bit_busy, timeout at least.  And we need the same for
clk_divider and clk_mux.  (Yes, I have clks that need to wait for
busy when changing divider and parent.)

Having basic clks support that will definitely reduce the clock driver
code, but it will make the long parameter list of basic clks even
longer.  I do not know which way we should go.

-- 
Regards,
Shawn
