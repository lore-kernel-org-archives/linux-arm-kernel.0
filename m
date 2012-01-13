From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 12 Jan 2012 18:11:02 -0600
Subject: [RFC] ARM: imx: Add imx6q thermal
In-Reply-To: <20120112093618.GB5446@pengutronix.de>
References: <1326266285-11656-1-git-send-email-rob.lee@linaro.org>
 <20120112093618.GB5446@pengutronix.de>
Message-ID: <CAMXH7KGesA7yhKg3c9sazqen+OtX_vgrMjCwzAeHYsKcgp4xbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha, comments below.  Thanks.

On Thu, Jan 12, 2012 at 3:36 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Jan 11, 2012 at 01:18:05AM -0600, Robert Lee wrote:
>> Add thermal support for i.MX6Q. ?Uses recently submitted common
>> cpu_cooling functionality shown here:
>>
>> http://www.spinics.net/lists/linux-pm/msg26500.html
>>
>> Have some todo items but basic implementation is done and I'd like to
>> get any helpful feedback on it.
>
> Generally shouldn't this be a regular driver?
>

After considering your comment, there is a small window of up to 17
microsecond immediately following the msleep(1) call where if the
system suspended completely in 17 microseconds, an internal oscillator
needed by the sensor could get powered off in a very low power suspend
mode, and I'd guess this could distort the temperature, although the
designers say it won't cause any problem in the system.  While hitting
that race condition that seems highly unlikely, it's still better not
to have that race condition so creating and registering a
platfrom_driver structure would give a suspend and resume hook to
allow this to be handled correctly.  It seems wasteful to create this
structure just for the suspend and resume callbacks but I'm not
knowledgeable on a lightweight method to use instead.  The suspend
notifier PM_POST_SUSPEND doesn't seem to guarantee it will get called
before the work queue thread continues (at least on SMP systems).  If
there was one default registered device that in turn had its own list
of suspend and resume callbacks from those who registered to it, this
might work.  But I'm sure there is some reason why that is a bad idea
to set up such a mechanism.

Besides handling of suspend and resume, are there other reasons why
this should be a driver?

>
>> +
>> +/* register define of anatop */
>> +#define HW_ANADIG_ANA_MISC0 ?(0x00000150)
>> +#define HW_ANADIG_ANA_MISC0_SET ? ? ?(0x00000154)
>> +#define HW_ANADIG_ANA_MISC0_CLR ? ? ?(0x00000158)
>> +#define HW_ANADIG_ANA_MISC0_TOG ? ? ?(0x0000015c)
>
> unnecessary braces. Please remove.

Ok.

>
>> +
>> +#if IMX6Q_THERMAL_DEBUG
>> + ? ? pr_info("Temperature is %lu C\n", *temp);
>> +#endif
>
> Please don't add your own debug defines which then issue
> messages with pr_info. Use pr_debug in the first place.

Ok.

>
> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
