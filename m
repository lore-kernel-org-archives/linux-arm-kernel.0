From: carlo.caione@gmail.com (Carlo Caione)
Date: Sat, 16 Nov 2013 13:58:35 +0100
Subject: [PATCH v3 1/2] ARM: sun4i/sun7i: RTC driver
In-Reply-To: <20131116085140.GJ3538@lukather>
References: <1383172738-8206-1-git-send-email-carlo.caione@gmail.com>
 <20131106141357.GQ26440@lukather>
 <CAOQ7t2a=KdNb-4_E_PRP53yYPiNmKzRN69Urg8EZ=4JE-6-Mig@mail.gmail.com>
 <20131116085140.GJ3538@lukather>
Message-ID: <CAOQ7t2Zsb0Kstd-tvnSLdyNxAvNUdYL4r5twVBvtnYFL1DRCMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 9:51 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Carlo,
>
> On Fri, Nov 15, 2013 at 11:50:56PM +0100, Carlo Caione wrote:
>> >> +static int sunxi_rtc_settime(struct device *dev, struct rtc_time *rtc_tm)
>> >> +{
>> >> +     struct sunxi_rtc_dev *chip = dev_get_drvdata(dev);
>> >> +     u32 date = 0;
>> >> +     u32 time = 0;
>> >> +     int year;
>> >> +     int t;
>> >> +
>> >> +     year = rtc_tm->tm_year + 1900;
>> >
>> > So, that means that the A10 RTC starts a year 1900, and the A20 at
>> > year 2010? Why not just put those in your year_offset fieldd directly?
>>
>> 1900 is the offset of the parameter tm_year with respect to the current year.
>> year_offset is used to make tm_year fit inside the limited range of
>> the year field of the SUNXI_RTC_YMD register.
>
> Ok, so 1900 is the RTC's epoch, and tm_year is relative to that
> epoch. What I still don't get is why you're not defining it as such
> and use it directly the field your year_offset as such.

Because for A10 the year field is only 6 bit wide and it can hold only
64 years so I cannot use year_offset directly.
We have the RTC framework where everything is based on 1900 and the
date register that is only 6 bit wide. Without year_offset I would
cover only 64 years from 1900 to 1963.
I need year_offset to shift the base year from 1900 to 2010 such that
I can use those 6 bit to track years from 2010 to 2073.

> Moreover, you have some max values that imply that the RTC can't count
> over either 2100 or 2073, which is kind of weird, since, respectively,
> it starts at 1900 and 2010, and the year field is documented to be 8
> bits wide, I'd expect it to go up to 2155 and 2265.

For A10 the date register is documented to be 6 bit. For A20 it is 8
bit wide (here the "mask" field in the sunxi_rtc_data_year).
In the v4 I'm going to expand to 255 the year range for A20 and modify
the min year to make it starts also at 1900 (it as actually wrong
having a the min field set to 1970).
(BTW I just noticed that the indexes for sunxi_rtc_data_year are
swapped, one more fix in v4).

>> >> +
>> >> +     /*
>> >> +      * wait about 70us to make sure the the time is really written into
>> >> +      * target
>> >> +      */
>> >> +     usleep_range(70, 100);
>> >
>> > Isn't the write operation supposed to be done already?
>>
>> Yes, it is supposed to be, but this waiting was already present in the
>> original version of the driver by aw so I'll leave it in v4.
>
> I feel like we argue over this again and again.
>
> I'm sorry, but saying "allwinner did it that way so we should keep it"
> is a bad argument. Otherwise we would be using fex, and every other
> driver Allwinner reimplemented.
>
> That being said, either that sleep is needed, and then it should be
> needed everytime you write to the RTC, which is not the case iirc, and
> have a comment saying "I have no idea why, but this come from
> Allwinner and this is actually required", or you don't need it, and
> then you can just remove it.
>
> But having it some-times-but-not-some-other seems pretty weak to me.

Maxime, as you know documentation for AW's SoC is really weak. I can
only extrapolate information from the old drivers and the badly
written comments to the code.
In those drivers (in all the versions I have) this waiting is always
present with the same comment I have left in the driver. What I
imagined is that it is needed not always, but only when I write
SUNXI_LOSC_CTRL_RTC_HMS_ACC or SUNXI_LOSC_CTRL_RTC_YMD_ACC (again,
this is just a guess but in the comment there is an explicit reference
to "time").
I actually have no idea why and removing it in my tests doesn't affect
the RTC. So I had two possibilities: 1) leave it in the code because
somehow it seems important even though I don't know exactly why it is
(only) there or 2) leave it out knowing that it doesn't affect my
tests but it could in some particular case or configuration.
That said, I'm going to do some more tests without the usleep to see
if there is any problem otherwise I'll delete it in v4.

Thank you,

--
Carlo Caione
