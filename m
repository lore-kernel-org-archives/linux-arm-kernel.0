From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 03 Aug 2012 12:01:51 -0600
Subject: [PATCH] ARM: tegra: fix U16 divider range check
In-Reply-To: <1343170214-28262-1-git-send-email-swarren@wwwdotorg.org>
References: <1343170214-28262-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <501C120F.60404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2012 04:50 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> A U16 divider can divide a clock by 1..64K. However, the range-check
> in clk_div16_get_divider() limited the range to 1..256. Fix this. NVIDIA's
> downstream kernels already have the fixed range-check.
> 
> In practice this is a problem on Whistler's I2C bus, which uses a bus
> clock rate of 100KHz (rather than the more common 400KHz on Tegra boards),
> which requires a HW module clock of 8*100KHz. The parent clock is 216MHz,
> leading to a desired divider of 270. Prior to conversion to the common
> clock framework, this range error was somehow ignored/irrelevant and
> caused no problems. However, the common clock framework evidently has
> more rigorous error-checking, so this failure causes the I2C bus to fail
> to operate correctly.

Applied to for-3.7/common-clk.
