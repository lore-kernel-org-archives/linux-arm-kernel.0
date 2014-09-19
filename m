From: joe@perches.com (Joe Perches)
Date: Fri, 19 Sep 2014 07:39:21 -0700
Subject: [PATCH v10 5/6] rtc: max77686: Use ffs() to calculate tm_wday
In-Reply-To: <1411122377-10426-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1411122377-10426-1-git-send-email-javier.martinez@collabora.co.uk>
 <1411122377-10426-6-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1411137561.24444.5.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-19 at 12:26 +0200, Javier Martinez Canillas wrote:
> The function max77686_rtc_calculate_wday() is used to
> calculate the day of the week to be filled in struct
> rtc_time but that function only calculates the number
> of bits shifted. So the ffs() function can be used to
> find the first bit set instead of a special function.

This isn't the same logic.  Perhaps you want fls.

> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
[]
> -static inline int max77686_rtc_calculate_wday(u8 shifted)
> -{
> -	int counter = -1;
> -	while (shifted) {
> -		shifted >>= 1;
> -		counter++;
> -	}
> -	return counter;
> -}
> -
>  static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
>  				   int rtc_24hr_mode)
>  {
> @@ -93,7 +83,7 @@ static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
>  			tm->tm_hour += 12;
>  	}
>  
> -	tm->tm_wday = max77686_rtc_calculate_wday(data[RTC_WEEKDAY] & 0x7f);
> +	tm->tm_wday = ffs(data[RTC_WEEKDAY] & 0x7f) - 1;
