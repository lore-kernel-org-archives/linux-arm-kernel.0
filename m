From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 01 Aug 2010 13:15:13 +0200
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
In-Reply-To: <201008010253.28319.marek.vasut@gmail.com> (Marek Vasut's message
	of "Sun\, 1 Aug 2010 02\:53\:28 +0200")
References: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
	<201008010213.24191.marek.vasut@gmail.com> <87iq3vyx7d.fsf@free.fr>
	<201008010253.28319.marek.vasut@gmail.com>
Message-ID: <87eieiziri.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> Dne Ne 1. srpna 2010 02:48:38 Robert Jarzmik napsal(a):
>> Marek Vasut <marek.vasut@gmail.com> writes:
>> > Dne So 31. ?ervence 2010 23:07:06 Robert Jarzmik napsal(a):
>> >> Marek Vasut <marek.vasut@gmail.com> writes:
>> >> > Dne So 31. ?ervence 2010 17:38:06 Robert Jarzmik napsal(a):
>> >> >> Marek Vasut <marek.vasut@gmail.com> writes:
>> >> >> > The wakealarm capability was incorrectly set after the RTC was
>> >> >> > registered, which resulted into the sysfs node not being created.
>> >> >> 
>> >> >> On my platform, without this patch:
>> >> >> > cat /sys/devices/platform/pxa-rtc/power/wakeup
>> >> >> > enabled
>> >> >> 
>> >> >> The sysfs node is created. What's the issue you're having ?
>> >> > 
>> >> > It's not created for me without this patch (and if you read the code,
>> >> > it is impossible to be created without this patch).
>> 
>> Are we talking about the same /sys/devices/platform/pxa-rtc/power/wakeup ?
>> Aren't you looking for /sys/class/rtc/rtc0/power/wakeup ?
>
> I'm looking for /sys/class/rtc/rtc0/wakealarm

Okay, I understand better, you're looking for the class driver wakup sysfs
entry, and not the driver sysfs wakeup entry.

So when you said "It's not created for me without this patch", you meant the
class driver's sysfs entry, not the one I mentioned I presume ?

Anyway, to straighten things up :
 - for an rtc driver, device_init_wakeup() has to be called before
 rtc_driver_register()
 - if that's not the case, /sys/class/rtc/rtc0/wakealarm won't be created
 - if that's the case, if the driver called device_init_wakeup(x, 1), the rtc
 registering will override the value with device_init_wakeup(x, 0)

I don't think changing the current behaviour, ie. having by default the rtc
driver *not* wake up from suspend is a good thing. As I see now your real
problem, I would request you leave the existing "device_init_wakeup(x, 1)" *and*
you add yours to make the class driver happy.

Cheers.

--
Robert
