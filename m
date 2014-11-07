From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 7 Nov 2014 15:04:11 -0800
Subject: [PATCH 03/21] thermal: of: Extend of-thermal.c to provide number
 of non critical trip points
In-Reply-To: <20141107110551.5316836f@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-4-git-send-email-l.majewski@samsung.com>
 <20141107014152.GD10180@developer>
 <20141107110551.5316836f@amdc2363>
Message-ID: <CAKdAkRRnWu3fCdviQyByCAjCDqUX-3_CWhKpYH65YnqmXH1b4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Fri, Nov 7, 2014 at 2:05 AM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Eduardo,
>
>> On Thu, Oct 09, 2014 at 06:38:39PM +0200, Lukasz Majewski wrote:
>> > This patch extends the of-thermal.c to provide information about
>> > number of available non critical (i.e. non HW) trip points in the
>> > system.
>> >
>> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>> > ---
>> >  drivers/thermal/of-thermal.c   | 12 ++++++++++++
>> >  drivers/thermal/thermal_core.h |  5 +++++
>> >  2 files changed, 17 insertions(+)
>> >
>> > diff --git a/drivers/thermal/of-thermal.c
>> > b/drivers/thermal/of-thermal.c index 23c8d6c..cd74e64 100644
>> > --- a/drivers/thermal/of-thermal.c
>> > +++ b/drivers/thermal/of-thermal.c
>> > @@ -128,6 +128,18 @@ int of_thermal_is_trip_en(struct
>> > thermal_zone_device *tz, int trip) return 1;
>> >  }
>> >
>> > +int of_thermal_get_non_crit_ntrips(struct thermal_zone_device *tz)
>> > +{
>> > +   struct __thermal_zone *data = tz->devdata;
>> > +   int i;
>> > +
>> > +   for (i = 0; i < data->ntrips; i++)
>> > +           if (data->trips[i].type != THERMAL_TRIP_CRITICAL)
>> > +                   continue;
>> > +
>> > +   return --i;
>> > +}
>> > +
>>
>>
>>
>> I am not against this addition. But looks like we start to spread some
>> specific APIs that may not be used to other drivers.
>
> Why do you think that this is a specific API? In the thermal OF we can
> define trip point as "active", "passive", "hot" and "critical".
>
> With the first three we can handle them and properly react. For the last
> one SoC's PMU will power down the board.
>
> Do you know if any board (e.g. from TI) is NOT supposed to shut down
> when "critical" temperature is passed?
>
> The real problem here is the accessibility to __thermal_trip and
> __thermal_bind arrays.
>
> Use case:
> In the Exynos driver we do need to initialize TMU registers with
> threshold temperatures.

Is this indeed plural or you want to program the next trip point as your
alarm temperature? If so, there was another patch floating around adding
set_trips() callback that would get passed in the low and high trip points for
the current temperature reading and you can use that data to program
alarms. Rockchip thermal driver uses it.

https://lkml.org/lkml/2014/6/27/76

Thanks.

-- 
Dmitry
