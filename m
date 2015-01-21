From: edubezval@gmail.com (Eduardo Valentin)
Date: Wed, 21 Jan 2015 01:15:01 -0400
Subject: [PATCH v2] thermal: rockchip: make temperature reporting much
 more accurate
In-Reply-To: <CAGS+omDiajqKxYFqdBXTeax+eeE-TD1WJ+C5odCbZBg6FELXDA@mail.gmail.com>
References: <1421625349-14101-1-git-send-email-wxt@rock-chips.com>
 <1421625349-14101-2-git-send-email-wxt@rock-chips.com>
 <CAGS+omDiajqKxYFqdBXTeax+eeE-TD1WJ+C5odCbZBg6FELXDA@mail.gmail.com>
Message-ID: <20150121051459.GA13468@developer.hsd1.ca.comcast.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 12:23:49PM +0800, Daniel Kurtz wrote:
> Hi Caesar,
> 
> Some drive-by review comments inline...
> 
> On Mon, Jan 19, 2015 at 7:55 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> > In general, the kernel should report temperature readings exactly as
> > reported by the hardware. The cpu / gpu thermal driver works in 5 degree
> > increments,but we ought to do more accurate. The temperature will do
> > linear interpolation between the entries in the table.
> >
> > Test= $md5sum /dev/zero &
> > $while true; do grep "" /sys/class/thermal/thermal_zone[1-2]/temp;
> > sleep .5; done
> >
> > e.g. We can get the result as follows:
> >     /sys/class/thermal/thermal_zone1/temp:39994
> >     /sys/class/thermal/thermal_zone2/temp:39086
> >     /sys/class/thermal/thermal_zone1/temp:39994
> >     /sys/class/thermal/thermal_zone2/temp:39540
> >     /sys/class/thermal/thermal_zone1/temp:39540
> >     /sys/class/thermal/thermal_zone2/temp:39540
> >     /sys/class/thermal/thermal_zone1/temp:39540
> >     /sys/class/thermal/thermal_zone2/temp:39994
> >
> > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > ---
> >
> > Changes in v2:
> > Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> >  drivers/thermal/rockchip_thermal.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> > index 1bcddfc..a7ae23a 100644
> > --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -193,19 +193,18 @@ static u32 rk_tsadcv2_temp_to_code(long temp)
> >
> >  static long rk_tsadcv2_code_to_temp(u32 code)
> >  {
> > -       int high, low, mid;
> > -
> > -       low = 0;
> > -       high = ARRAY_SIZE(v2_code_table) - 1;
> > -       mid = (high + low) / 2;
> > +       unsigned int low = 0;
> > +       unsigned int high = ARRAY_SIZE(v2_code_table) - 1;
> > +       unsigned int mid = (low + high) / 2;
> > +       unsigned int scale;
> >
> >         if (code > v2_code_table[low].code || code < v2_code_table[high].code)
> >                 return 125000; /* No code available, return max temperature */
> 
> I think if the temp sensor reading was invalid we should return an
> error code rather than just silently returning "max temp".
> Returning an error here could then be propagated up by its only
> caller, the ->get_temp() callback.
> 

Agreed here.

> Note: 'code < v2_code_table[high].code' is always false, since code is
> unsigned, and the last entry is 0.
> 
> Also, the check above doesn't reject "code == 0xfff".
> Even worse, I believe in that case the below algorithm will eventually
> set mid=0 and access v2_code_table[-1].code.
> 

yeah, if that can happen, then it must be fixed.


> >
> >         while (low <= high) {
> > -               if (code >= v2_code_table[mid].code && code <
> > -                   v2_code_table[mid - 1].code)
> > -                       return v2_code_table[mid].temp;
> > +               if (code >= v2_code_table[mid].code &&
> > +                   code < v2_code_table[mid - 1].code)
> > +                       break;
> >                 else if (code < v2_code_table[mid].code)
> >                         low = mid + 1;
> >                 else
> > @@ -213,7 +212,16 @@ static long rk_tsadcv2_code_to_temp(u32 code)
> >                 mid = (low + high) / 2;
> >         }
> >
> > -       return 125000;
> > +       /*
> > +        * The 5C granularity provided by the table is too much. Let's
> > +        * assume that the relationship between sensor readings and
> > +        * temperature between 2 table entries is linear and extrapolate
> 
> I think this is "interpolate", not "extrapolate".


in this case yes, agreed too.

> 
> > +        * to produce less granular result.
> > +        */
> > +       scale = (v2_code_table[mid].temp - v2_code_table[mid - 1].temp) /
> > +               (v2_code_table[mid - 1].code - v2_code_table[mid].code);
> > +       return v2_code_table[mid - 1].temp +
> > +                       (v2_code_table[mid - 1].code - code) * scale;
> 
> Assuming the product fits in an unsigned long (and it will, since code
> is only 12-bits), it is more precise to multiply first and then
> divide, something like this:
> 
>    num = v2_code_table[mid].temp - v2_code_table[mid - 1].temp;
>    num *= v2_code_table[mid - 1].code - code;
>    denom = v2_code_table[mid - 1].code - v2_code_table[mid].code;
>    return v2_code_table[mid - 1].temp + (num / denom);
> 
> -Daniel
> 
> >  }
> >
> >  /**
> > --
> > 1.9.1
> >
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/3a18fb13/attachment.sig>
