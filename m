From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Nov 2017 16:10:40 +0000
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171123153637.kbqcd2jsek4ybeic@piout.net>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123150439.GB18754@mellanox.com>
 <20171123153637.kbqcd2jsek4ybeic@piout.net>
Message-ID: <20171123161040.GS31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 04:36:37PM +0100, Alexandre Belloni wrote:
> On 23/11/2017 at 08:04:39 -0700, Jason Gunthorpe wrote:
> > On Thu, Nov 23, 2017 at 10:54:56AM +0100, Alexandre Belloni wrote:
> > You can't really measure the offset without doing a time set, many
> > embedded RTCs do not hook up interrupts, etc.
> 
> If you don't hook up the interrupt, then all you did is completely
> pointless because you will never be able to read the correct time from
> the RTC, you'll have up to a 1s offset.

That is incorrect.  The kernel provides emulation for the update
interrupt - it polls the RTC every 1/HZ checking it for a change
in seconds.

So, you end up with up to a 1/HZ offset where no interrupt is
present.

Please don't base your assumptions on the output of hwclock(8) -
the output of that which comes after the timezone specifier is
not documented in the man page, and appears on the face of it to
be rather random:

root at clearfog21:~# hwclock -r --noadjfile --utc
Thu 23 Nov 2017 15:52:35 GMT  -0.547531 seconds
root at clearfog21:~# hwclock -r --noadjfile --utc
Thu 23 Nov 2017 15:52:37 GMT  -0.399859 seconds
root at clearfog21:~# hwclock -r --noadjfile --utc
Thu 23 Nov 2017 15:52:38 GMT  -0.275654 seconds

Using my program instead:

root at clearfog21:~# ./test-rtc

Warning: NTP synchronisation is enabled, measurements may be affected

RTC is currently trimmed to -39112 ppb
Takes average of 65127ns to read RTC
Took 64411ns to read RTC on second change

RTC Time: 23-11-2017 15:52:50
System Time was:     15:52:50.000

root at clearfog21:~# ./test-rtc

Warning: NTP synchronisation is enabled, measurements may be affected

RTC is currently trimmed to -39112 ppb
Takes average of 64560ns to read RTC
Took 63884ns to read RTC on second change

RTC Time: 23-11-2017 15:53:14
System Time was:     15:53:14.000
root at clearfog21:~# ./test-rtc

Warning: NTP synchronisation is enabled, measurements may be affected

RTC is currently trimmed to -39112 ppb
Takes average of 64467ns to read RTC
Took 74642ns to read RTC on second change

RTC Time: 23-11-2017 15:53:17
System Time was:     15:53:17.000

root at clearfog21:~#

So, the RTC is closely synchronised with the system time, and is
certainly not variable as hwclock(8) _appears_ to suggest.  So the
figure it comes out with after printing the time is _not_ the
difference betwen system time and RTC time.

It seems to be the negative amount of time from an arbitary point
after hwclock() starts execution to the point just after waiting
for the update interrupt:

root at clearfog21:~# strace -tt -T hwclock -r --noadjfile --utc --debug
15:58:32.411876 execve("/sbin/hwclock", ["hwclock", "-r", "--noadjfile", "--utc", "--debug"], [/* 16 vars */]) = 0 <0.000834>
...
15:58:32.425566 gettimeofday({1511452712, 425707}, NULL) = 0 <0.000134>
...
15:58:32.436914 write(1, "Waiting for clock tick...\n", 26Waiting for clock tick...
) = 26 <0.000233>
15:58:32.437303 ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) = 0 <0.000391>
15:58:32.437859 select(4, [3], NULL, NULL, {10, 0}) = 1 (in [3], left {9, 438030}) <0.562095>
15:58:33.002175 ioctl(3, PHN_NOT_OH or RTC_UIE_OFF, 0) = 0 <0.000186>
15:58:33.002592 write(1, "...got clock tick\n", 18...got clock tick
) = 18 <0.000314>
15:58:33.003217 gettimeofday({1511452713, 3378}, NULL) = 0 <0.000159>
...
15:58:33.009146 write(1, "Thu 23 Nov 2017 15:58:33 GMT  -0"..., 48Thu 23 Nov 2017 15:58:33 GMT  -0.577671 seconds

1511452713.003378 - 1511452712.425707 = 0.577671s - the figure printed
by hwclock(8) after the time.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
