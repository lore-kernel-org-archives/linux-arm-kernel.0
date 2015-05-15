From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 15 May 2015 20:04:16 +0200
Subject: [PATCH v2 1/2] rtc: add rtc-lpc24xx driver
In-Reply-To: <20150515175330.GL23600@jcartwri.amer.corp.natinst.com>
References: <1431696306-19093-1-git-send-email-manabian@gmail.com>
 <1431696306-19093-2-git-send-email-manabian@gmail.com>
 <20150515152312.GG23600@jcartwri.amer.corp.natinst.com>
 <CAGhQ9VxpN-dSgWS0tJMeik7o_DsRdRo=Mf=Ap1L3j988abcHfQ@mail.gmail.com>
 <20150515175330.GL23600@jcartwri.amer.corp.natinst.com>
Message-ID: <CAGhQ9VygfAvRmFCd5uiZpADpqtfyJgSJDbh1W4LcXE-YqNXmOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2015 at 19:53, Josh Cartwright <joshc@ni.com> wrote:
> On Fri, May 15, 2015 at 06:31:53PM +0200, Joachim Eastwood wrote:
>> On 15 May 2015 at 17:23, Josh Cartwright <joshc@ni.com> wrote:
>> > Hello again,
>> >
>> > On Fri, May 15, 2015 at 03:25:05PM +0200, Joachim Eastwood wrote:
>> >> Add driver for the RTC found on NXP LPC24xx/178x/18xx/43xx devices.
>> >> The RTC provides calendar and clock functionality together with
>> >> periodic tick and alarm interrupt support.
>> >>
>> >> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> >> ---
> [..]
>> >> +static int lpc24xx_rtc_read_time(struct device *dev, struct rtc_time *tm)
>> >> +{
>> >> +     struct lpc24xx_rtc *rtc = dev_get_drvdata(dev);
>> >> +     u32 ct0, ct1, ct2;
>> >> +
>> >> +     ct0 = rtc_readl(rtc, LPC24XX_CTIME0);
>> >> +     ct1 = rtc_readl(rtc, LPC24XX_CTIME1);
>> >> +     ct2 = rtc_readl(rtc, LPC24XX_CTIME2);
>> >> +
>> >> +     tm->tm_sec  = CT0_SECS(ct0);
>> >> +     tm->tm_min  = CT0_MINS(ct0);
>> >> +     tm->tm_hour = CT0_HOURS(ct0);
>> >> +     tm->tm_wday = CT0_DOW(ct0);
>> >> +     tm->tm_mon  = CT1_MONTH(ct1);
>> >> +     tm->tm_mday = CT1_DOM(ct1);
>> >> +     tm->tm_year = CT1_YEAR(ct1);
>> >> +     tm->tm_yday = CT2_DOY(ct2);
>> >> +
>> >> +     if (rtc_valid_tm(tm) < 0) {
>> >> +             dev_warn(dev, "retrieved date and time is invalid\n");
>> >> +             rtc_time64_to_tm(0, tm);
>> >> +             lpc24xx_rtc_set_time(dev, tm);
>> >> +     }
>> >> +
>> >> +     return 0;
>> >
>> > Forcing the read time to be the epoch on failure seems like a pretty
>> > poor way to handle errors, in my opinion.
>>
>> When the device doesn't have battery the CTIME registers contains an
>> invalid value. So if you don't set them to something valid you will
>> get a warning each time you try to read the RTC. To "fix" that problem
>> I set the time at epoch which make the CTIME registers to contain a
>> valid value. Since the value is already useless I think setting it to
>> epoch is an improvement in this case.
>
> I see.  I think doing this setting in your read_time callback is the
> wrong place to do this check.  I'm thinking a better place for it would
> be in your driver's probe().

That is a good idea. I'll move the check to probe instead.

>> I guess it deserves a comment in the driver.
>
> Yes, I agree.

I'll add it in the next version.


regards,
Joachim Eastwood
