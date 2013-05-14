From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 14 May 2013 12:06:41 -0700
Subject: [PATCH] clk: ux500: clk-sysctrl: handle clocks with no parents
In-Reply-To: <20130503090305.GA17733@balto.lan>
References: <1367325906-23045-1-git-send-email-fabio.baltieri@linaro.org>
 <CAPDyKFpZ+-6b3kPyNacPQ33=Ssdjs=fvFxkr4iSUT_hm1YzVTg@mail.gmail.com>
 <CAPDyKFq6iQ21QosEH_WqGCetXfaO1uecvK7+WzjZJDkK8r3SxA@mail.gmail.com>
 <20130503090305.GA17733@balto.lan>
Message-ID: <20130514190641.10068.14584@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Fabio Baltieri (2013-05-03 02:03:05)
> On Fri, May 03, 2013 at 10:54:09AM +0200, Ulf Hansson wrote:
> > On 3 May 2013 10:51, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On 30 April 2013 14:45, Fabio Baltieri <fabio.baltieri@linaro.org> wrote:
> > >> Fix clk_reg_sysctrl() to set main clock registers of new struct
> > >> clk_sysctrl even if the registered clock has no parents.
> > >>
> > >> This fixes an issue where "ulpclk" was registered with all clk->reg_*
> > >> fields uninitialized, causing a -EINVAL error from clk_prepare().
> > >>
> > >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > >> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> > >> ---
> > >>  drivers/clk/ux500/clk-sysctrl.c | 8 +++++++-
> > >>  1 file changed, 7 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
> > >> index bc7e9bd..e364c9d 100644
> > >> --- a/drivers/clk/ux500/clk-sysctrl.c
> > >> +++ b/drivers/clk/ux500/clk-sysctrl.c
> > >> @@ -145,7 +145,13 @@ static struct clk *clk_reg_sysctrl(struct device *dev,
> > >>                 return ERR_PTR(-ENOMEM);
> > >>         }
> > >>
> > >> -       for (i = 0; i < num_parents; i++) {
> > >> +       /* set main clock registers */
> > >> +       clk->reg_sel[0] = reg_sel[0];
> > >> +       clk->reg_bits[0] = reg_bits[0];
> > >> +       clk->reg_mask[0] = reg_mask[0];
> > >> +
> > >> +       /* handle clocks with more than one parent */
> > >> +       for (i = 1; i < num_parents; i++) {
> > >>                 clk->reg_sel[i] = reg_sel[i];
> > >>                 clk->reg_bits[i] = reg_bits[i];
> > >>                 clk->reg_mask[i] = reg_mask[i];
> > >> --
> > >> 1.8.2
> > >>
> > >
> > > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > This is bugfix, should go "stable" as well?
> > 
> > Stable means 3.10 rcs, since the abx500 clk tree was added for 3.10.
> 
> Thanks!  Yes, it would be great if this could be queued up for an -rc.
> 

Taken into clk-fixes.

Thanks!
Mike

> Fabio
> 
> -- 
> Fabio Baltieri
