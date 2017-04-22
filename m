From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Apr 2017 19:14:12 -0700
Subject: [PATCH V2] clk: hi6220: Add the hi655x's pmic clock
In-Reply-To: <20170419194737.GB2523@mai>
References: <1491683412-12237-1-git-send-email-daniel.lezcano@linaro.org>
 <20170412150245.GK7065@codeaurora.org> <20170416205713.GW2078@mai>
 <20170419160005.GS7065@codeaurora.org> <20170419194737.GB2523@mai>
Message-ID: <20170422021412.GE7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19, Daniel Lezcano wrote:
> On Wed, Apr 19, 2017 at 09:00:05AM -0700, Stephen Boyd wrote:
> > On 04/16, Daniel Lezcano wrote:
> > > On Wed, Apr 12, 2017 at 08:02:45AM -0700, Stephen Boyd wrote:
> > > > On 04/08, Daniel Lezcano wrote:
> 
> [ ... ]
> 
> > > > > +	ret = clk_hw_register_clkdev(&hi655x_clk->clk_hw, clk_name, NULL);
> > > > 
> > > > Missed this last time. Do you use this clkdev lookup? The name is
> > > > usually supposed to be based on what the device is expecting,
> > > > instead of clk_name, and we would want some device name for the
> > > > third argument here.
> > > 
> > > I'm not sure to get your comment. Are you saying the clk_name should be the
> > > third argument?
> > > 
> > > 
> > 
> > Sorry, no. I meant that con_id is typically something like "core"
> > or "ahb" or something like that, and dev_id is something like
> > "a456002.pmic_device" or whatever dev_name(pmic_dev) would return for
> > the consuming device. That way when we call clk_get(dev, "core")
> > it will find the lookup with "core" and "a456002.pmic_device" to
> > match up the clk lookup.
> > 
> > If anything, the clk_name should just go into the con_id for now,
> > and then it will need to be a globally unique identifier for the
> > clk. But that is going against how clkdev is supposed to be used.
> > Hence the question if you even need to use it. If not, just don't
> > add it. I can fix up v3 of this patch to put clk_name back at
> > con_id if you like. No need to resend.
> 
> Ok, I'm not very used with the CCF, so perhaps clk_name is not needed at all. I
> gave a try with the following combination:
> 
>  - con_id = NULL, dev_id = clk_name
>  - con_id = clk_name, dev_id = NULL
>  - con_id = NULL, dev_id = NULL
> 
> All worked.
> 
> And finally I removed the clk_hw_register_clkdev() call and it worked also.
> 
> So I'm not sure about this function.
> 

If you've removed it and it still works, then it means you're
using DT and you don't need clkdev at all. That's the of_clk
provider thing that you're using. So I'll go remove this clkdev
lookup because it's not used. If someone needs it they can add it
later.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
