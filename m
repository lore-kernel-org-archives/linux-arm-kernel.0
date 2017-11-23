From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Nov 2017 16:25:32 +0000
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171123161040.GS31757@n2100.armlinux.org.uk>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123150439.GB18754@mellanox.com>
 <20171123153637.kbqcd2jsek4ybeic@piout.net>
 <20171123161040.GS31757@n2100.armlinux.org.uk>
Message-ID: <20171123162532.GA25597@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 04:10:40PM +0000, Russell King - ARM Linux wrote:
> Using my program instead:
> 
> root at clearfog21:~# ./test-rtc
> 
> Warning: NTP synchronisation is enabled, measurements may be affected
> 
> RTC is currently trimmed to -39112 ppb
> Takes average of 65127ns to read RTC
> Took 64411ns to read RTC on second change
> 
> RTC Time: 23-11-2017 15:52:50
> System Time was:     15:52:50.000

PS, my program works by:

- switching to SCHED_FIFO scheduling
- timing how long it takes to read the RTC 100 times.
- timing how long it takes to read the RTC for real across a change
  in the number of seconds.
    if this is different by more than 25us from the average, then
    the entire measurement cycle is restarted until we hit this target.
- reporting the RTC time and the compensated system time half-way
  through the ioctl() to read the RTC, based on the average time
  taken to read the RTC.

This has the advantage that it's indepdendent of the kernel's UIE
implementation and RTC interrupt latency, and so can be much more
accurate than 1/HZ.

Its measurements have sufficient accuracy (when printed to microsecond
resolution) to show the effect of the RTC's trimming corrections where
RTCs apply trimming pulses every minute rather than every second.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
