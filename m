From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 16 Nov 2013 09:51:40 +0100
Subject: [PATCH v3 1/2] ARM: sun4i/sun7i: RTC driver
In-Reply-To: <CAOQ7t2a=KdNb-4_E_PRP53yYPiNmKzRN69Urg8EZ=4JE-6-Mig@mail.gmail.com>
References: <1383172738-8206-1-git-send-email-carlo.caione@gmail.com>
 <20131106141357.GQ26440@lukather>
 <CAOQ7t2a=KdNb-4_E_PRP53yYPiNmKzRN69Urg8EZ=4JE-6-Mig@mail.gmail.com>
Message-ID: <20131116085140.GJ3538@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

On Fri, Nov 15, 2013 at 11:50:56PM +0100, Carlo Caione wrote:
> >> +static int sunxi_rtc_settime(struct device *dev, struct rtc_time *rtc_tm)
> >> +{
> >> +     struct sunxi_rtc_dev *chip = dev_get_drvdata(dev);
> >> +     u32 date = 0;
> >> +     u32 time = 0;
> >> +     int year;
> >> +     int t;
> >> +
> >> +     year = rtc_tm->tm_year + 1900;
> >
> > So, that means that the A10 RTC starts a year 1900, and the A20 at
> > year 2010? Why not just put those in your year_offset field directly?
> 
> 1900 is the offset of the parameter tm_year with respect to the current year.
> year_offset is used to make tm_year fit inside the limited range of
> the year field of the SUNXI_RTC_YMD register.

Ok, so 1900 is the RTC's epoch, and tm_year is relative to that
epoch. What I still don't get is why you're not defining it as such
and use it directly the field your year_offset as such.

Moreover, you have some max values that imply that the RTC can't count
over either 2100 or 2073, which is kind of weird, since, respectively,
it starts at 1900 and 2010, and the year field is documented to be 8
bits wide, I'd expect it to go up to 2155 and 2265.

> >> +
> >> +     /*
> >> +      * wait about 70us to make sure the the time is really written into
> >> +      * target
> >> +      */
> >> +     usleep_range(70, 100);
> >
> > Isn't the write operation supposed to be done already?
> 
> Yes, it is supposed to be, but this waiting was already present in the
> original version of the driver by aw so I'll leave it in v4.

I feel like we argue over this again and again.

I'm sorry, but saying "allwinner did it that way so we should keep it"
is a bad argument. Otherwise we would be using fex, and every other
driver Allwinner reimplemented.

That being said, either that sleep is needed, and then it should be
needed everytime you write to the RTC, which is not the case iirc, and
have a comment saying "I have no idea why, but this come from
Allwinner and this is actually required", or you don't need it, and
then you can just remove it.

But having it some-times-but-not-some-other seems pretty weak to me.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/6468848d/attachment.sig>
