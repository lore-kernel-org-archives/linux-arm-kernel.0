From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 10:38:36 -0800
Subject: [PATCH] clk: divider: fix incorrect usage of container_of
In-Reply-To: <20171221163054.13600-1-jbrunet@baylibre.com>
References: <20171221163054.13600-1-jbrunet@baylibre.com>
Message-ID: <20171221183836.GL7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21, Jerome Brunet wrote:
> divider_recalc_rate() is an helper function used by clock divider of
> different types, so the structure containing the 'hw' pointer is not
> always a 'struct clk_divider'
> 
> At the following line:
> > div = _get_div(table, val, flags, divider->width);
> 
> in several cases, the value of 'divider->width' is garbage as the actual
> structure behind this memory is not a 'struct clk_divider'
> 
> Fortunately, this width value is used by _get_val() only when
> CLK_DIVIDER_MAX_AT_ZERO flag is set. This has never been the case so
> far when the structure is not a 'struct clk_divider'. This is probably
> why we did not notice this bug before
> 
> Fixes: afe76c8fd030 ("clk: allow a clk divider with max divisor when zero")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> Hi Stephen, Mike,
> 
> In addition to clock, this patch also touch the rtc and drm directories.
> As it is changing the API of the helper function, I have this fix in a
> single commit to avoid breaking bisect.
> 
> Please let me know if you prefer to do differently.
> 

Looks good. Thanks for catching this before it became a real
problem. It would be good to get acks from DRM and RTC
maintainers.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
