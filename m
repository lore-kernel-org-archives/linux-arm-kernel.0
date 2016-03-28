From: yh.huang@mediatek.com (YH Huang)
Date: Mon, 28 Mar 2016 10:32:10 +0800
Subject: [PATCH] sbs-battery: fix power status when battery is dry
In-Reply-To: <CAGS+omDhFP+_shCqEWasLDsHf-ab0-OWJJ-gZZkgihAgrZwBHA@mail.gmail.com>
References: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
 <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
 <1458801832.16645.7.camel@mtksdaap41>
 <CAGS+omDhFP+_shCqEWasLDsHf-ab0-OWJJ-gZZkgihAgrZwBHA@mail.gmail.com>
Message-ID: <1459132330.16645.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-03-25 at 11:06 +0800, Daniel Kurtz wrote:
> On Thu, Mar 24, 2016 at 2:43 PM, YH Huang <yh.huang@mediatek.com> wrote:
> >
> > Hi Daniel,
> >
> > On Thu, 2016-03-24 at 12:01 +0800, Daniel Kurtz wrote:
> > > Hi YH,
> > >
> > > On Wed, Mar 23, 2016 at 5:53 PM, YH Huang <yh.huang@mediatek.com> wrote:
> > > > When the battery is dry and BATTERY_FULL_DISCHARGED is set,
> > > > we should check BATTERY_DISCHARGING to decide the power status.
> > > > If BATTERY_DISCHARGING is set, the power status is not charging.
> > > > Or the power status should be charging.
> > > >
> > > > Signed-off-by: YH Huang <yh.huang@mediatek.com>
> > > > ---
> > > >  drivers/power/sbs-battery.c |   22 ++++++++++++----------
> > > >  1 file changed, 12 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
> > > > index d6226d6..d86db0e 100644
> > > > --- a/drivers/power/sbs-battery.c
> > > > +++ b/drivers/power/sbs-battery.c
> > > > @@ -382,11 +382,12 @@ static int sbs_get_battery_property(struct i2c_client *client,
> > > >
> > > >                 if (ret & BATTERY_FULL_CHARGED)
> > > >                         val->intval = POWER_SUPPLY_STATUS_FULL;
> > > > -               else if (ret & BATTERY_FULL_DISCHARGED)
> > > > -                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > > > -               else if (ret & BATTERY_DISCHARGING)
> > > > -                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > > > -               else
> > > > +               else if (ret & BATTERY_DISCHARGING) {
> > > > +                       if (ret & BATTERY_FULL_DISCHARGED)
> > > > +                               val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > > > +                       else
> > > > +                               val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > > > +               } else
> > >
> > >
> > > I think (BATTERY_DISCHARGING && BATTERY_FULL_DISCHARGED) is still
> > > POWER_SUPPLY_STATUS_DISCHARGING.
> > > So, let's just report what the battery says and do:
> > >
> > >                else if (ret & BATTERY_DISCHARGING)
> > >                                val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > >
> > So we just ignore the special situation (BATTERY_DISCHARGING &&
> > BATTERY_FULL_DISCHARGED).
> > Isn't POWER_SUPPLY_STATUS_NOT_CHARGING a useful information?
> 
> The battery is discharging.  The fact that it is also reporting that
> it is already "discharged" just seems premature.   I would expect to
> only see NOT_CHARGING if completely discharged *and* not discharging.

I check the "Smart Battery Data Specification Revision 1.1".
And there are some words about FULLY_DISCHARGED.
"Discharge should be stopped soon."
"This status bit may be set prior to the
?TERMINATE_DISCHARGE_ALARM? as an early or first level warning of end of
battery charge."
It looks like the FULLY_DISCHARGED status is used to announce the
warning of battery charge and it is still discharging if there is no one
takes care of it.
