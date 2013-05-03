From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 3 May 2013 12:22:29 +0100
Subject: [PATCH 2/4] mfd: ab8500-gpadc: Suppress 'ignoring
 regulator_enable() return value' warning
In-Reply-To: <20130503110424.GG24153@gmail.com>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
 <1367509690-24022-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdaf75sQduyfw58PFmC1ZyNDMxpwAf0OSyRLPP6vFc+wBQ@mail.gmail.com>
 <20130503110424.GG24153@gmail.com>
Message-ID: <20130503112229.GI24153@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 May 2013, Lee Jones wrote:

> On Fri, 03 May 2013, Linus Walleij wrote:
> 
> > On Thu, May 2, 2013 at 5:48 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > > drivers/mfd/ab8500-gpadc.c: In function ?ab8500_gpadc_resume?:
> > > drivers/mfd/ab8500-gpadc.c:911:18: warning: ignoring return value of
> > >         ?regulator_enable?, declared with attribute warn_unused_result
> > >         [-Wunused-result]
> > >
> > > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/mfd/ab8500-gpadc.c |    5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
> > > index 5e65b28..7278e53 100644
> > > --- a/drivers/mfd/ab8500-gpadc.c
> > > +++ b/drivers/mfd/ab8500-gpadc.c
> > > @@ -907,8 +907,11 @@ static int ab8500_gpadc_suspend(struct device *dev)
> > >  static int ab8500_gpadc_resume(struct device *dev)
> > >  {
> > >         struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
> > > +       int ret;
> > >
> > > -       regulator_enable(gpadc->regu);
> > > +       ret = regulator_enable(gpadc->regu);
> > > +       if (ret < 0)
> > > +               return ret;
> > >
> > >         pm_runtime_mark_last_busy(gpadc->dev);
> > >         pm_runtime_put_autosuspend(gpadc->dev);
> > 
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> As it has your Ack, I'm going to add an error print as per Srinidhi's
> suggestion, test it again and apply this to my MFD tree.

Slight change of plan, as I've changed the semantics.

Would you be kind enough to see v2?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
