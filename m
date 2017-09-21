From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Sep 2017 23:45:41 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170921220510.GA11395@obsidianresearch.com>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
 <20170921075907.GR20805@n2100.armlinux.org.uk>
 <20170921093218.GS20805@n2100.armlinux.org.uk>
 <20170921220510.GA11395@obsidianresearch.com>
Message-ID: <20170921224541.GC20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 04:05:10PM -0600, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2017 at 10:32:19AM +0100, Russell King - ARM Linux
> wrote:
> 
> I've combined several of your messages together into this reply...

Sorry about that, I'm currently ill and sleep deprived, so it's been
a struggle to pick up on everything together.

> So with v2 of this patch, the driver would specify positive 1s, and
> then the set will be called when tv_nsec == 0, but the tv_sec will
> be +1.
> 
> Similarly the existing case of 0.5s offset will work more like
> before, where it will be called with tv_nsec == .5s and the tv_sec
> will be +1 - before I think this happened reliably 'by accident' due
> to the rounding.

It seems to mean (from reading the code) that I'd need to specify
-470ms for the PCF8523, if I'm understand what you're saying and
the code correctly.

I should point out, however, that I'm running a modified version
of your previous patch with 470ms specified - I added a debug
printk() for the failure cases, and I seem to be getting quite a
number:

[  416.966909] rtc_tv_nsec_ok: fail: ts=1506001533.510194975
[  427.974142] rtc_tv_nsec_ok: fail: ts=1506001544.518073728
[  768.946856] rtc_tv_nsec_ok: fail: ts=1506001885.510091123
[  779.954207] rtc_tv_nsec_ok: fail: ts=1506001896.518068045
...
[31391.230806] rtc_tv_nsec_ok: fail: ts=1506032509.510048412
[31402.238221] rtc_tv_nsec_ok: fail: ts=1506032520.518080991

176 so far in that window, which equates to an average failure rate
of one failure every 3m5s.  This is on a kernel with:

CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_HZ=250

>From what I can see, we have failures that are 11s apart and 340s
apart.  If we assume that we had a successful write at 1506001555s,
then that means we only waited 329s before we next tried to set the
RTC, not the 11 minutes that we should have.  Not sure yet what's
going on there, but it seems to suggest that we're struggling to
set the RTC, taking multiple attempts to achieve it.

Also... don't we want to move the call to rtc_set_ntp_time() from out
of the "if (abs(now.tv_nsec - (NSEC_PER_SEC / 2)) <= tick_nsec * 5) {"
check, otherwise how could it be called except at about .5s?

I'm actually not sure if we are ending up setting the time - my test
program reports:

RTC Time: 21-09-2017 22:40:45
System Time was:     22:40:44.997

so the RTC has drifted off by 3ms wrt system time, and that suggests
it hasn't been set.  It's difficult to know.  Given that tick_nsec is
likely to be 4ms (I've not checked) it would suggest that we're never
successfully setting the RTC - since either the test in ntp.c fails
or the test in systohc.c fails.  Both can't succeed given these
constraints.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
