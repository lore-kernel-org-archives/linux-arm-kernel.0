From: rbthomas@pobox.com (Rick Thomas)
Date: Tue, 12 May 2015 21:54:32 -0700
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure drivers
 for both Cubox i4pro real time clocks
In-Reply-To: <1431421889.8263.97.camel@debian.org>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
 <1428710930.29665.17.camel@decadent.org.uk>
 <20150429085705.GG12732@n2100.arm.linux.org.uk>
 <1430582464.15640.186.camel@hellion.org.uk>
 <20150502161226.GS12732@n2100.arm.linux.org.uk>
 <1430583695.15640.190.camel@hellion.org.uk>
 <1430899272.15640.237.camel@debian.org>
 <64A51823-C50B-48D5-8180-CBC44F691CCB@pobox.com>
 <1430908023.2660.203.camel@debian.org>
 <1250B1D0-EBAA-404C-B0F2-686DE9E4D156@pobox.com>
 <47E9FE80-96C8-4D91-B161-53A61A8A5FCB@pobox.com>
 <1431421889.8263.97.camel@debian.org>
Message-ID: <8113BF2D-D7DC-4215-942A-9B00CC7832A9@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 12, 2015, at 2:11 AM, Ian Campbell <ijc@debian.org> wrote:

> On Tue, 2015-05-12 at 01:33 -0700, Rick Thomas wrote:
>> On May 6, 2015, at 3:35 AM, Rick Thomas <rbthomas@pobox.com> wrote:
>> 
>>> 
>>> On May 6, 2015, at 3:27 AM, Ian Campbell <ijc@debian.org> wrote:
>>> 
>>>> It would be preferable to test the thing in Sid before the upload to
>>>> jessie-proposed-updates
>>> 
>>> I?ll keep an eye out for it.
>>> 
>>> But I don?t have one of the cubox models without the battery-backed
>>> RTC, so I won?t be able to test that case.   Is there anyone out there
>>> in debian-arm land with an appropriate test box?
>>> 
>>> Enjoy!
>>> Rick

It arrived this morning.  I?ve got two RTC entries now in /dev.  But I?m a bit confused?

Looking at the boot log with journalctl (see attachment), it appears that the snvs RTC (i.e. the one without a battery backup) is being found first, and the _kernel_ is setting system time from it ? ignoring /etc/init.d/hwclock.sh completely.

The pcf8523 RTC (the one with battery backup) is being discovered later, and is not being used to set the system time at all.

This is exactly the opposite of the behavior I was hoping for.

Well? I thought I was prepared for that by planning to use parameters in /etc/default/hwclock to tell it which RTC to use when shutting-down or booting-up.  But it appears that those parameters are being ignored.

Looking in /lib/systemd/system/hwclock-save.service (the systemd equivalent of /etc/init.d/hwclock), I find ?ExecStart=/sbin/hwclock -D ?systohc? which is interesting because (1) it invokes a ?-D? option which is not documented in ?man hwclock?, (2) it ignores the /etc/default parameters, and (3) it?s only being done on shutdown/halt/reboot; there?s no corresponding service that gets run at boot time?  Is the RTC driver itself supposed to be doing that, so there?s no need for sysvinit or systemd to worry about it???  The ?setting system clock? log entry would seem to substantiate that.

So what to do now?

Any constructive suggestions will appreciated.

Rick

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ClockBootLog.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/a7ce649c/attachment-0001.txt>
