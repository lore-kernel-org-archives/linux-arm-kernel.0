From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 3 Jul 2017 03:21:16 +0000
Subject: [PATCH 4/9] clk: imx: add pllv4 support
In-Reply-To: <20170701003642.GS22780@codeaurora.org>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-5-git-send-email-aisheng.dong@nxp.com>
 <20170620015917.GO4493@codeaurora.org>
 <20170620093143.GD6805@b29396-OptiPlex-7040>
 <20170701003642.GS22780@codeaurora.org>
Message-ID: <AM3PR04MB306EEF6F5F442465B258E3C80D60@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at codeaurora.org]
> Sent: Saturday, July 01, 2017 8:37 AM
> To: Dong Aisheng
> Cc: A.s. Dong; linux-clk at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; mturquette at baylibre.com;
> shawnguo at kernel.org; Anson Huang; Jacky Bai
> Subject: Re: [PATCH 4/9] clk: imx: add pllv4 support
> 
> On 06/20, Dong Aisheng wrote:
> > On Mon, Jun 19, 2017 at 06:59:17PM -0700, Stephen Boyd wrote:
> > > On 05/15, Dong Aisheng wrote:
> > > > +
> > > > +	if (clk_pllv4_is_enabled(hw)) {
> > > > +		WARN(1, "clk_pllv4: can't change rate when pll is
> enabled");
> > > > +		return -EINVAL;
> > >
> > > Sad, CLK_SET_RATE_GATE isn't working for you I suppose?
> > >
> >
> > CLK_SET_RATE_GATE can't work in early stage before running
> clk_disable_unused.
> > At that point, the clock tree state is still not consistent with HW.
> > e.g. prepare/enable count is still zero but it's actually enabled due
> > to reset state or bootloader.
> >
> > The code here is adding a double check in case user sets rate in early
> stage.
> >
> > However, probably it could also be moved into clock core as it's not
> > platform dependant behavior?
> >
> 
> Ok. It would be good to fix the core framework to synchronize the
> prepared/enabled state at registration time so we don't need this check
> in the driver.
> 

I will prepare a core fix later and remove these checks first.

Regards
Dong Aisheng

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
