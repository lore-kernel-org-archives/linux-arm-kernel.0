From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 27 Aug 2017 13:30:59 +0200
Subject: [PATCH v2 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <20170827091301.wbuzxkh7opz4blrc@piout.net>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de>
 <20170827091301.wbuzxkh7opz4blrc@piout.net>
Message-ID: <d20fbc21-bd8f-c191-ed51-03487868e7b0@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

Am 27.08.2017 um 11:13 schrieb Alexandre Belloni:
> Not much to add, apart from the spinlock issue already spotted by Andrew.
> 
> On 27/08/2017 at 02:33:27 +0200, Andreas F?rber wrote:
>> +struct rtd119x_rtc {
>> +	void __iomem *base;
>> +	struct clk *clk;
>> +	struct rtc_device *rtcdev;
>> +	unsigned base_year;
> 
> checkpatch complains this should be made unsigned int

Ouch, I forgot to add my pre-commit hook in this tree and wasn't aware
of that rule yet. The RFC had it already. Fixed.

>> +	spinlock_t lock;
>> +};
>> +
>> +static inline int rtd119x_rtc_year_days(int year)
>> +{
>> +	return rtc_year_days(1, 12, year);
> 
> I'm not sure it is worth wrapping rtc_year_days
[snip]

Well, I found your rtc_year_days rather confusing and had to play with
the arguments until I got it working as expected, so I wanted an inline
function (or macro) as abstraction from my three callers.

Sadly the naming is rather confusing as I am looking for the number of
days 365..366, whereas your rtc_year_days is meant to return 0..365 and
I would just like to extract the 12th array element but need to counter
the -1 subtraction. rtc_year_days(31, 11, year) + 1 is not intuitive
either - reads like November (and ranges are not documented).

What about exporting a convenient rtc_days_in_year(year) from rtc-lib.c
accessing the table directly without rtc_year_days detour? Alternatively
an inline function in rtc.h to the same effect without the array?

Also despite is_leap_year() returning a bool || expression you keep
using it as array index or integer to add. That assumes true == 1,
whereas to my knowledge only false is guaranteed to be 0 and any
non-zero value means true. So I'd expect the code to be like this:

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index 1ae7da5cfc60..8983a408fc30 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -32,7 +32,7 @@ static const unsigned short rtc_ydays[2][13] = {
  */
 int rtc_month_days(unsigned int month, unsigned int year)
 {
-       return rtc_days_in_month[month] + (is_leap_year(year) && month
== 1);
+       return rtc_days_in_month[month] + ((is_leap_year(year) && month
== 1) ? 1 : 0);
 }
 EXPORT_SYMBOL(rtc_month_days);

@@ -41,7 +41,7 @@ EXPORT_SYMBOL(rtc_month_days);
  */
 int rtc_year_days(unsigned int day, unsigned int month, unsigned int year)
 {
-       return rtc_ydays[is_leap_year(year)][month] + day-1;
+       return rtc_ydays[is_leap_year(year) ? 1 : 0][month] + day-1;
 }
 EXPORT_SYMBOL(rtc_year_days);

@@ -69,7 +69,7 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
                - LEAPS_THRU_END_OF(1970 - 1);
        if (days < 0) {
                year -= 1;
-               days += 365 + is_leap_year(year);
+               days += 365 + (is_leap_year(year) ? 1 : 0);
        }
        tm->tm_year = year - 1900;
        tm->tm_yday = days + 1;

The above rtc_time64_to_tm() hunk could be converted to the proposed
rtc_days_in_year(). rtc-mcp795.c has another candidate.

By reusing rtc_year_days I elegantly avoided is_leap_year in my code,
but I could spell out 365 + (is_leap_year(year) ? 1 : 0) in my function
if preferred. I dislike duplicating expressions in code.

What do you think?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
