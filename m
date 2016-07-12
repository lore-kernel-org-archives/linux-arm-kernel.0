From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 12 Jul 2016 09:09:38 +0800
Subject: [PATCH v2 18/22] usb: chipidea: msm: Add reset controller for
 PHY POR bit
In-Reply-To: <CAJOFmgxHQPTm-aq3-e_8SGe2kw8R6TAQKDp2Jn8DXfMykcSS8w@mail.gmail.com>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-19-stephen.boyd@linaro.org>
 <20160711053228.GB31647@shlinux2>
 <CAJOFmgxHQPTm-aq3-e_8SGe2kw8R6TAQKDp2Jn8DXfMykcSS8w@mail.gmail.com>
Message-ID: <20160712010938.GL31647@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 03:07:24PM -0700, Stephen Boyd wrote:
> On 10 July 2016 at 22:32, Peter Chen <hzpeterchen@gmail.com> wrote:
> > On Thu, Jul 07, 2016 at 03:21:09PM -0700, Stephen Boyd wrote:
> >> @@ -40,11 +43,38 @@ struct ci_hdrc_msm {
> >>       struct clk *iface_clk;
> >>       struct clk *fs_clk;
> >>       struct ci_hdrc_platform_data pdata;
> >> +     struct reset_controller_dev rcdev;
> >>       bool secondary_phy;
> >>       bool hsic;
> >>       void __iomem *base;
> >>  };
> >>
> >> +static int
> >> +ci_hdrc_msm_por_reset(struct reset_controller_dev *r, unsigned long id)
> >> +{
> >> +     struct ci_hdrc_msm *ci_msm = container_of(r, struct ci_hdrc_msm, rcdev);
> >> +     void __iomem *addr = ci_msm->base;
> >> +     u32 val;
> >> +
> >> +     if (id)
> >> +             addr += HS_PHY_SEC_CTRL;
> >> +     else
> >> +             addr += HS_PHY_CTRL;
> >> +
> >> +     val = readl_relaxed(addr);
> >> +     val |= HS_PHY_POR_ASSERT;
> >> +     writel(val, addr);
> >> +     udelay(12);
> >
> > Does this delay is reference manual defines or experienced value?
> > Do you need to comment it?
> >
> 
> 10us comes from the manual but we add two more from experience. I can
> add a comment to that effect similar to the one above udelay(12) in
> phy-msm-usb.c?

Yes, you can move that comments from there.

-- 

Best Regards,
Peter Chen
