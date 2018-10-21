From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 21 Oct 2018 23:27:37 +0200
Subject: [PATCH 01/15] power: supply: olpc_battery: correct the
 temperature units
In-Reply-To: <CAHp75VenECSZWR3RVh=t35Os93t-MzEH_YzPgT=qQWL-SwjgFQ@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-2-lkundrak@v3.sk>
 <CAHp75VenECSZWR3RVh=t35Os93t-MzEH_YzPgT=qQWL-SwjgFQ@mail.gmail.com>
Message-ID: <20181021212737.v546ychvlnkxxvrp@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 19, 2018 at 04:00:32PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > According to [1] and [2], the temperature values are in tenths of degree
> > Celsius. Exposing the Celsius value makes the battery appear on fire:
> >
> >   $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
> >   ...
> >       temperature:         236.9 degrees C
> >
> > Tested on OLPC XO-1 and OLPC XO-1.75 laptops.
> 
> It's interesting that the very author of that code is not included in
> so-o long Cc list :)
> Cc: David.
> 
> David, do you remember if and how you had tested temperature report of
> the battery on OLPC? I guess this kind of error would be appear immediately.

It depends on the way of testing. It's not so obvious when you just
do a `cat /sys/class/power_supply/.../temperature`, since you just
get the raw integer.

> OTOH it might be that power framework had changed requirements (which
> would be noticeable change).

As far as I know, power-supply has always used 1/10 ?C. People tend
to get units wrong all the time though (i.e. mV instead of uV). I'm
not surprised, that this sneaked into the kernel.

> If the latter is true, this patch misses Fixes tag. Actually in any
> case it misses it.

Yes, this should probably have Fixes: fb972873a767 ("[BATTERY] One Laptop
Per Child power/battery driver").

-- Sebastian

> > [1] include/linux/power_supply.h
> > [2] Documentation/power/power_supply_class.txt
> >
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/power/supply/olpc_battery.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> > index 6da79ae14860..5a97e42a3547 100644
> > --- a/drivers/power/supply/olpc_battery.c
> > +++ b/drivers/power/supply/olpc_battery.c
> > @@ -428,14 +428,14 @@ static int olpc_bat_get_property(struct power_supply *psy,
> >                 if (ret)
> >                         return ret;
> >
> > -               val->intval = (s16)be16_to_cpu(ec_word) * 100 / 256;
> > +               val->intval = (s16)be16_to_cpu(ec_word) * 10 / 256;
> >                 break;
> >         case POWER_SUPPLY_PROP_TEMP_AMBIENT:
> >                 ret = olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
> >                 if (ret)
> >                         return ret;
> >
> > -               val->intval = (int)be16_to_cpu(ec_word) * 100 / 256;
> > +               val->intval = (int)be16_to_cpu(ec_word) * 10 / 256;
> >                 break;
> >         case POWER_SUPPLY_PROP_CHARGE_COUNTER:
> >                 ret = olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
> > --
> > 2.19.0
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181021/a9461f46/attachment-0001.sig>
