From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 28 Mar 2016 18:05:49 +0800
Subject: [PATCH] sbs-battery: fix power status when battery is dry
In-Reply-To: <1459132330.16645.14.camel@mtksdaap41>
References: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
 <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
 <1458801832.16645.7.camel@mtksdaap41>
 <CAGS+omDhFP+_shCqEWasLDsHf-ab0-OWJJ-gZZkgihAgrZwBHA@mail.gmail.com>
 <1459132330.16645.14.camel@mtksdaap41>
Message-ID: <CAGS+omBVStB3mfXtDHdbsOK+y2UesGYtZBtYm=ctcpBfm88VEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Rhyland Klein who original wrote this code...

On Mon, Mar 28, 2016 at 10:32 AM, YH Huang <yh.huang@mediatek.com> wrote:
>
> On Fri, 2016-03-25 at 11:06 +0800, Daniel Kurtz wrote:
> > On Thu, Mar 24, 2016 at 2:43 PM, YH Huang <yh.huang@mediatek.com> wrote:
> > >
> > > Hi Daniel,
> > >
> > > On Thu, 2016-03-24 at 12:01 +0800, Daniel Kurtz wrote:
> > > > Hi YH,
> > > >
> > > > On Wed, Mar 23, 2016 at 5:53 PM, YH Huang <yh.huang@mediatek.com> wrote:
> > > > > When the battery is dry and BATTERY_FULL_DISCHARGED is set,
> > > > > we should check BATTERY_DISCHARGING to decide the power status.
> > > > > If BATTERY_DISCHARGING is set, the power status is not charging.
> > > > > Or the power status should be charging.
> > > > >
> > > > > Signed-off-by: YH Huang <yh.huang@mediatek.com>
> > > > > ---
> > > > >  drivers/power/sbs-battery.c |   22 ++++++++++++----------
> > > > >  1 file changed, 12 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
> > > > > index d6226d6..d86db0e 100644
> > > > > --- a/drivers/power/sbs-battery.c
> > > > > +++ b/drivers/power/sbs-battery.c
> > > > > @@ -382,11 +382,12 @@ static int sbs_get_battery_property(struct i2c_client *client,
> > > > >
> > > > >                 if (ret & BATTERY_FULL_CHARGED)
> > > > >                         val->intval = POWER_SUPPLY_STATUS_FULL;
> > > > > -               else if (ret & BATTERY_FULL_DISCHARGED)
> > > > > -                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > > > > -               else if (ret & BATTERY_DISCHARGING)
> > > > > -                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > > > > -               else
> > > > > +               else if (ret & BATTERY_DISCHARGING) {
> > > > > +                       if (ret & BATTERY_FULL_DISCHARGED)
> > > > > +                               val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > > > > +                       else
> > > > > +                               val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > > > > +               } else
> > > >
> > > >
> > > > I think (BATTERY_DISCHARGING && BATTERY_FULL_DISCHARGED) is still
> > > > POWER_SUPPLY_STATUS_DISCHARGING.
> > > > So, let's just report what the battery says and do:
> > > >
> > > >                else if (ret & BATTERY_DISCHARGING)
> > > >                                val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > > >
> > > So we just ignore the special situation (BATTERY_DISCHARGING &&
> > > BATTERY_FULL_DISCHARGED).
> > > Isn't POWER_SUPPLY_STATUS_NOT_CHARGING a useful information?
> >
> > The battery is discharging.  The fact that it is also reporting that
> > it is already "discharged" just seems premature.   I would expect to
> > only see NOT_CHARGING if completely discharged *and* not discharging.
>
> I check the "Smart Battery Data Specification Revision 1.1".
> And there are some words about FULLY_DISCHARGED.
> "Discharge should be stopped soon."
> "This status bit may be set prior to the
> ?TERMINATE_DISCHARGE_ALARM? as an early or first level warning of end of
> battery charge."
> It looks like the FULLY_DISCHARGED status is used to announce the
> warning of battery charge and it is still discharging if there is no one
> takes care of it.

Sure, it is in the sbs spec.  That is why the battery is setting that bit.
The problem isn't with what the battery is doing, the issue here is in
how the kernel is interpreting it, and what it is choosing to expose
to user space.
It looks like the current property interface is not able to accurately
report the full status of the battery: "discharging & nearly empty".
Instead, IMHO, the closest it can report is that it is still
discharging (== POWER_SUPPLY_STATUS_DISCHARGING), and use some other
mechanism to report how much charge is actually left.
Re-using "POWER_SUPPLY_STATUS_NOT_CHARGING" to report "discharging &
nearly empty" seems arbitrary, wrong and unnecessary.

Of course, this bit of code is very old, as it was added in the
original TI BQ20Z75 gas gauge patch:

commit d3ab61ecbab2b8950108b3541bc9eda515d605e0
Author: Rhyland Klein <rklein@nvidia.com>
Date:   Tue Sep 21 15:33:55 2010 -0700
    bq20z75: Add support for more power supply properties

So, it would be nice if an sbs battery expert could chime in here,
since I don't really know what I am talking about, I am just
interpreting #define names.

-Dan
