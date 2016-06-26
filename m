From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 26 Jun 2016 22:54:13 +0800
Subject: [PATCH v3 4/8] rtc: ac100: Add RTC driver for X-Powers AC100
In-Reply-To: <20160626003054.GW5809@piout.net>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-5-git-send-email-wens@csie.org>
 <20160626003054.GW5809@piout.net>
Message-ID: <CAGb2v661AUiAZpH2oFLVAqdy_sBGi_3Hg7oGCKO416L=P0zUSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 8:30 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> A few comments, mostly about style.
>
> On 20/06/2016 at 10:52:14 +0800, Chen-Yu Tsai wrote :
>> +struct ac100_rtc_dev {
>> +     struct rtc_device *rtc;
>> +     struct device *dev;
>> +     struct regmap *regmap;
>> +     struct mutex mutex;
>
> I don't think that mutex is needed. Instead, you can take rtc->ops_lock
> from the interrupt handler.

OK. I didn't think using the lock from the rtc device was a good idea.

>
>> +     int irq;
>> +     unsigned long alarm;
>> +};
>> +
>> +static int ac100_rtc_get_time(struct device *dev, struct rtc_time *rtc_tm)
>> +{
>> +     struct ac100_rtc_dev *chip = dev_get_drvdata(dev);
>> +     struct regmap *regmap = chip->regmap;
>> +     u16 reg[7];
>> +     int ret;
>> +
>> +     ret = regmap_bulk_read(regmap, AC100_RTC_SEC, reg, 7);
>> +     if (ret)
>> +             return ret;
>> +
>> +     rtc_tm->tm_sec  = bcd2bin(reg[0] & AC100_RTC_SEC_MASK);
>> +     rtc_tm->tm_min  = bcd2bin(reg[1] & AC100_RTC_MIN_MASK);
>> +     rtc_tm->tm_hour = bcd2bin(reg[2] & AC100_RTC_HOU_MASK);
>> +     rtc_tm->tm_wday = bcd2bin(reg[3] & AC100_RTC_WEE_MASK);
>> +     rtc_tm->tm_mday = bcd2bin(reg[4] & AC100_RTC_DAY_MASK);
>> +     rtc_tm->tm_mon  = bcd2bin(reg[5] & AC100_RTC_MON_MASK);
>> +     rtc_tm->tm_year = bcd2bin(reg[6] & AC100_RTC_YEA_MASK);
>> +
>> +     rtc_tm->tm_mon  -= 1;
>
> I would put the - 1 inline with the first tm_mon assignment.

OK

>
>> +
>> +     /*
>> +      * switch from (data_year->min)-relative offset to
>> +      * a (1900)-relative one
>> +      */
>> +     rtc_tm->tm_year += AC100_YEAR_OFF;
>
> Unless you feel the comment is absolutely necessary, I'd also put that
> with the first tm_year assignment.
>
> BTW, is that RTC aware that 0 is actually 1970? And so 2000 (30) is not
> a leap year but 2016 is? I'd say that this is not the case, seeing
> AC100_RTC_YEA_LEAP but it is worth checking.
>
> Is this bit (AC100_RTC_YEA_LEAP) updated by the rtc? IF that is not the
> case, the time will have to be set at least once between first of
> January and 28th of February of leap years else it will fail...

Unfortunately it is not. The datasheet explicitly said the RTC does not
update the leap year bit. So yes, the RTC will have to be updated at
least once a year...

>> +
>> +     return rtc_valid_tm(rtc_tm);
>> +}
>> +
>> +static int ac100_rtc_set_time(struct device *dev, struct rtc_time *rtc_tm)
>> +{
>> +     struct ac100_rtc_dev *chip = dev_get_drvdata(dev);
>> +     struct regmap *regmap = chip->regmap;
>> +     int year;
>> +     u16 reg[8];
>> +
>> +     /* our RTC has a limited year range... */
>> +     year = rtc_tm->tm_year + 1900;
>> +     if (year < AC100_YEAR_MIN || year > AC100_YEAR_MAX) {
>> +             dev_err(dev, "rtc only supports year in range %d - %d\n",
>> +                     AC100_YEAR_MIN, AC100_YEAR_MAX);
>> +             return -EINVAL;
>> +     }
>> +
>
> What about:
>
> year = rtc_tm->tm_year - AC100_YEAR_OFF
> if (year < 0 || year > (AC100_YEAR_MAX - 1900))
>
> It allows to reuse year for the reg[6] assignment. IT is a simple
> suggestion, maybe the compiler is smarter than I am ;).
>
>> +     /* correct offsets */
>> +     rtc_tm->tm_year -= AC100_YEAR_OFF;
>> +     rtc_tm->tm_mon += 1;
>> +
>
> Those could also got inline with their respective reg[] assignment

OK. I'll see if I can still fit everything in a single line, to keep
the nice table-like formatting.

>
>
>> +     /* convert to BCD */
>> +     reg[0] = bin2bcd(rtc_tm->tm_sec)  & AC100_RTC_SEC_MASK;
>> +     reg[1] = bin2bcd(rtc_tm->tm_min)  & AC100_RTC_MIN_MASK;
>> +     reg[2] = bin2bcd(rtc_tm->tm_hour) & AC100_RTC_HOU_MASK;
>> +     reg[3] = bin2bcd(rtc_tm->tm_wday) & AC100_RTC_WEE_MASK;
>> +     reg[4] = bin2bcd(rtc_tm->tm_mday) & AC100_RTC_DAY_MASK;
>> +     reg[5] = bin2bcd(rtc_tm->tm_mon)  & AC100_RTC_MON_MASK;
>> +     reg[6] = bin2bcd(rtc_tm->tm_year) & AC100_RTC_YEA_MASK;
>> +     /* trigger write */
>> +     reg[7] = AC100_RTC_UPD_TRIGGER;
>> +
>> +     /* Is it a leap year? */
>> +     if (is_leap_year(year))
>> +             reg[6] |= AC100_RTC_YEA_LEAP;
>> +
>> +     return regmap_bulk_write(regmap, AC100_RTC_SEC, reg, 8);
>> +}
>> +
>> +
>
> [...]
>
>> +     alrm_tm->tm_sec  = bcd2bin(reg[0] & AC100_ALM_SEC_MASK);
>> +     alrm_tm->tm_min  = bcd2bin(reg[1] & AC100_ALM_MIN_MASK);
>> +     alrm_tm->tm_hour = bcd2bin(reg[2] & AC100_ALM_HOU_MASK);
>> +     alrm_tm->tm_wday = bcd2bin(reg[3] & AC100_ALM_WEE_MASK);
>> +     alrm_tm->tm_mday = bcd2bin(reg[4] & AC100_ALM_DAY_MASK);
>> +     alrm_tm->tm_mon  = bcd2bin(reg[5] & AC100_ALM_MON_MASK);
>> +     alrm_tm->tm_year = bcd2bin(reg[6] & AC100_ALM_YEA_MASK);
>> +
>> +     alrm_tm->tm_mon  -= 1;
>> +
>> +     /*
>> +      * switch from (data_year->min)-relative offset to
>> +      * a (1900)-relative one
>> +      */
>> +     alrm_tm->tm_year += AC100_YEAR_OFF;
>> +
>
> Well, same comments as in ac100_rtc_get_time()
>
>
>> +out:
>> +     mutex_unlock(&chip->mutex);
>> +     return ret;
>> +}
>> +
>> +static int ac100_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +     struct ac100_rtc_dev *chip = dev_get_drvdata(dev);
>> +     struct regmap *regmap = chip->regmap;
>> +     struct rtc_time *alrm_tm = &alrm->time;
>> +     u16 reg[8];
>> +     int year;
>> +     int ret;
>> +
>> +     /* our alarm has a limited year range... */
>> +     year = alrm_tm->tm_year + 1900;
>> +     if (year < AC100_YEAR_MIN || year > AC100_YEAR_MAX) {
>> +             dev_err(dev, "alarm only supports year in range %d - %d\n",
>> +                     AC100_YEAR_MIN, AC100_YEAR_MAX);
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* correct offsets */
>> +     alrm_tm->tm_year -= AC100_YEAR_OFF;
>> +     alrm_tm->tm_mon += 1;
>> +
>
> Same comment as ac100_rtc_set_time()
>
>> +     /* convert to BCD */
>> +     reg[0] = (bin2bcd(alrm_tm->tm_sec)  & AC100_ALM_SEC_MASK) |
>> +                     AC100_ALM_ENABLE_FLAG;
>> +     reg[1] = (bin2bcd(alrm_tm->tm_min)  & AC100_ALM_MIN_MASK) |
>> +                     AC100_ALM_ENABLE_FLAG;
>> +     reg[2] = (bin2bcd(alrm_tm->tm_hour) & AC100_ALM_HOU_MASK) |
>> +                     AC100_ALM_ENABLE_FLAG;
>> +     /* Do not enable weekday alarm */
>> +     reg[3] = bin2bcd(alrm_tm->tm_wday) & AC100_ALM_WEE_MASK;
>> +     reg[4] = (bin2bcd(alrm_tm->tm_mday) & AC100_ALM_DAY_MASK) |
>> +                     AC100_ALM_ENABLE_FLAG;
>> +     reg[5] = (bin2bcd(alrm_tm->tm_mon)  & AC100_ALM_MON_MASK) |
>> +                     AC100_ALM_ENABLE_FLAG;
>> +     reg[6] = (bin2bcd(alrm_tm->tm_year) & AC100_ALM_YEA_MASK) |
>> +                     AC100_ALM_ENABLE_FLAG;
>> +     /* trigger write */
>> +     reg[7] = AC100_ALM_UPD_TRIGGER;
>> +
>> +     mutex_lock(&chip->mutex);
>> +
>> +     ret = regmap_bulk_write(regmap, AC100_ALM_SEC, reg, 8);
>> +     if (ret)
>> +             goto out;
>> +
>> +     ret = _ac100_rtc_alarm_irq_enable(chip, alrm->enabled);
>> +
>> +out:
>> +     mutex_unlock(&chip->mutex);
>> +     return ret;
>> +}
>> +

Thanks for the review!

ChenYu
