From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 22 Jan 2015 12:01:46 +0800
Subject: [PATCH v3] thermal: rockchip: make temperature reporting much
 more accurate
In-Reply-To: <1421861370-19422-2-git-send-email-wxt@rock-chips.com>
References: <1421861370-19422-1-git-send-email-wxt@rock-chips.com>
 <1421861370-19422-2-git-send-email-wxt@rock-chips.com>
Message-ID: <CAGS+omAi+F1_1-8wmDMf9oUq6GCjXu8N4kyeNmKRWv8m3eaCrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 1:29 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> In general, the kernel should report temperature readings exactly as
> reported by the hardware. The cpu / gpu thermal driver works in 5 degree
> increments,but we ought to do more accurate. The temperature will do
> linear interpolation between the entries in the table.
>
> Test= $md5sum /dev/zero &
> $while true; do grep "" /sys/class/thermal/thermal_zone[1-2]/temp;
> sleep .5; done
>
> e.g. We can get the result as follows:
>     /sys/class/thermal/thermal_zone1/temp:39994
>     /sys/class/thermal/thermal_zone2/temp:39086
>     /sys/class/thermal/thermal_zone1/temp:39994
>     /sys/class/thermal/thermal_zone2/temp:39540
>     /sys/class/thermal/thermal_zone1/temp:39540
>     /sys/class/thermal/thermal_zone2/temp:39540
>     /sys/class/thermal/thermal_zone1/temp:39540
>     /sys/class/thermal/thermal_zone2/temp:39994
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> ---
>
> Changes in v3:
> Suggested-by Daniel Kurtz,
> the check doesn't reject "code == 0xfff"
> Fixed in rk_tsadcv2_code_to_temp(u32 code)
>
> Changes in v2:
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
>  drivers/thermal/rockchip_thermal.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 1bcddfc..ce18007 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -193,19 +193,22 @@ static u32 rk_tsadcv2_temp_to_code(long temp)
>
>  static long rk_tsadcv2_code_to_temp(u32 code)
>  {
> -       int high, low, mid;
> -
> -       low = 0;
> -       high = ARRAY_SIZE(v2_code_table) - 1;
> -       mid = (high + low) / 2;
> +       unsigned int low = 0;
> +       unsigned int high = ARRAY_SIZE(v2_code_table) - 1;
> +       unsigned int mid = (low + high) / 2;
> +       unsigned int num;
> +       unsigned long denom;
>
> +       /* No code available, return callback */
>         if (code > v2_code_table[low].code || code < v2_code_table[high].code)
> -               return 125000; /* No code available, return max temperature */
> +               return rk_tsadcv2_code_to_temp(code);

Isn't this an infinite recursion?

>
>         while (low <= high) {
> -               if (code >= v2_code_table[mid].code && code <
> -                   v2_code_table[mid - 1].code)
> -                       return v2_code_table[mid].temp;
> +               if (code >= v2_code_table[mid].code &&
> +                   code < v2_code_table[mid - 1].code)
> +                       break;
> +               else if (code == TSADCV2_DATA_MASK)
> +                       break;
>                 else if (code < v2_code_table[mid].code)
>                         low = mid + 1;
>                 else
> @@ -213,7 +216,16 @@ static long rk_tsadcv2_code_to_temp(u32 code)
>                 mid = (low + high) / 2;
>         }
>
> -       return 125000;
> +       /*
> +        * The 5C granularity provided by the table is too much. Let's
> +        * assume that the relationship between sensor readings and
> +        * temperature between 2 table entries is linear and interpolate
> +        * to produce less granular result.
> +        */
> +       num = v2_code_table[mid].temp - v2_code_table[mid - 1].temp;
> +       num *= v2_code_table[mid - 1].code - code;
> +       denom = v2_code_table[mid - 1].code - v2_code_table[mid].code;
> +       return v2_code_table[mid - 1].temp + (num / denom);
>  }
>
>  /**
> --
> 1.9.1
>
>
