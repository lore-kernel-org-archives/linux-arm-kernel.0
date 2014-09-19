From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 19 Sep 2014 21:27:07 +0200
Subject: [PATCH v10 5/6] rtc: max77686: Use ffs() to calculate tm_wday
In-Reply-To: <1411137561.24444.5.camel@joe-AO725>
References: <1411122377-10426-1-git-send-email-javier.martinez@collabora.co.uk>	
 <1411122377-10426-6-git-send-email-javier.martinez@collabora.co.uk>
 <1411137561.24444.5.camel@joe-AO725>
Message-ID: <541C838B.7070207@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joe,

On 09/19/2014 04:39 PM, Joe Perches wrote:
> On Fri, 2014-09-19 at 12:26 +0200, Javier Martinez Canillas wrote:
>> The function max77686_rtc_calculate_wday() is used to
>> calculate the day of the week to be filled in struct
>> rtc_time but that function only calculates the number
>> of bits shifted. So the ffs() function can be used to
>> find the first bit set instead of a special function.
> 
> This isn't the same logic.  Perhaps you want fls.
>

Right, the removed function has the same logic than fls() - 1 but the value
stored in data[RTC_WEEKDAY] is:

data[RTC_WEEKDAY] = 1 << tm->tm_wday;

so for this particular case, it doesn't matter since ffs() == fls() always.

>> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> []
>> -static inline int max77686_rtc_calculate_wday(u8 shifted)
>> -{
>> -	int counter = -1;
>> -	while (shifted) {
>> -		shifted >>= 1;
>> -		counter++;
>> -	}
>> -	return counter;
>> -}
>> -
>>  static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
>>  				   int rtc_24hr_mode)
>>  {
>> @@ -93,7 +83,7 @@ static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
>>  			tm->tm_hour += 12;
>>  	}
>>  
>> -	tm->tm_wday = max77686_rtc_calculate_wday(data[RTC_WEEKDAY] & 0x7f);
>> +	tm->tm_wday = ffs(data[RTC_WEEKDAY] & 0x7f) - 1;

I did wonder which function to use and the question is when you want to know
the number of shifted bits, do you look for the first or the last bit set?

Of course is the same for powers of two but I did a naive search to have an
usage count:

$ git grep "shift = ffs(" | wc -l
39
$ git grep "shift = fls(" | wc -l
17

so it seems that ffs() is twice more popular than fls() for this case so I
decided to use ffs() but I don't have a strong opinion tbh.

Best regards,
Javier
