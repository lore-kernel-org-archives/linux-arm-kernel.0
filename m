From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 Jun 2017 17:36:42 -0700
Subject: [PATCH 4/9] clk: imx: add pllv4 support
In-Reply-To: <20170620093143.GD6805@b29396-OptiPlex-7040>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-5-git-send-email-aisheng.dong@nxp.com>
 <20170620015917.GO4493@codeaurora.org>
 <20170620093143.GD6805@b29396-OptiPlex-7040>
Message-ID: <20170701003642.GS22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20, Dong Aisheng wrote:
> On Mon, Jun 19, 2017 at 06:59:17PM -0700, Stephen Boyd wrote:
> > On 05/15, Dong Aisheng wrote:
> > > +
> > > +	if (clk_pllv4_is_enabled(hw)) {
> > > +		WARN(1, "clk_pllv4: can't change rate when pll is enabled");
> > > +		return -EINVAL;
> > 
> > Sad, CLK_SET_RATE_GATE isn't working for you I suppose?
> > 
> 
> CLK_SET_RATE_GATE can't work in early stage before running clk_disable_unused.
> At that point, the clock tree state is still not consistent with HW.
> e.g. prepare/enable count is still zero but it's actually enabled due to
> reset state or bootloader.
> 
> The code here is adding a double check in case user sets rate in early stage.
> 
> However, probably it could also be moved into clock core as it's not platform
> dependant behavior?
> 

Ok. It would be good to fix the core framework to synchronize the
prepared/enabled state at registration time so we don't need this
check in the driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
