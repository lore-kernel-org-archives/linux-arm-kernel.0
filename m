From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Sep 2017 19:23:24 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170922182424.GA21945@obsidianresearch.com>
References: <20170920224522.GB20974@obsidianresearch.com>
 <20170921075907.GR20805@n2100.armlinux.org.uk>
 <20170921093218.GS20805@n2100.armlinux.org.uk>
 <20170921220510.GA11395@obsidianresearch.com>
 <20170921224541.GC20805@n2100.armlinux.org.uk>
 <20170921232040.GA15130@obsidianresearch.com>
 <20170922095713.GD20805@n2100.armlinux.org.uk>
 <20170922164850.GA13235@obsidianresearch.com>
 <20170922172022.GJ20805@n2100.armlinux.org.uk>
 <20170922182424.GA21945@obsidianresearch.com>
Message-ID: <20170923182324.GK20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 22, 2017 at 12:24:24PM -0600, Jason Gunthorpe wrote:
> For reference, here is the revised patch

Thanks.  I'm running with this patch, and moved on to a different
machine (clearfog, Armada 388) with some of my other tweaks in
place (like debug printks).

It doesn't seem to manage to set the RTC:

[  164.508327] sched_sync_hw_clock: adjust=0.504426705 now=1506185035.504429664 next=0.995570336 target=500000000 fail=1
[  165.532499] sched_sync_hw_clock: adjust=0.528428314 now=1506185036.528431353 next=0.971568647 target=500000000 fail=1
[  166.524666] sched_sync_hw_clock: adjust=0.520430346 now=1506185037.520433426 next=0.979566574 target=500000000 fail=1
[  167.516828] sched_sync_hw_clock: adjust=0.512428087 now=1506185038.512431646 next=0.987568354 target=500000000 fail=1
[  168.508991] sched_sync_hw_clock: adjust=0.504429462 now=1506185039.504432861 next=0.995567139 target=500000000 fail=1
[  169.533162] sched_sync_hw_clock: adjust=0.528433808 now=1506185040.528437087 next=0.971562913 target=500000000 fail=1
[  170.525319] sched_sync_hw_clock: adjust=0.520430693 now=1506185041.520433773 next=0.979566227 target=500000000 fail=1
[  171.517485] sched_sync_hw_clock: adjust=0.512431067 now=1506185042.512436146 next=0.987563854 target=500000000 fail=1
[  172.509639] sched_sync_hw_clock: adjust=0.504428078 now=1506185043.504432197 next=0.995567803 target=500000000 fail=1
[  173.533807] sched_sync_hw_clock: adjust=0.528431790 now=1506185044.528435910 next=0.971564090 target=500000000 fail=1

Notice the weidness of "adjust" which is the "now" argument to
sched_sync_hw_clock() (now= is the getnstimeofday64() value inside
the function.)

> +#if defined(CONFIG_RTC_SYSTOHC)
> +static void sync_rtc_clock(void)
> +{
> +	unsigned long target_nsec;
> +	struct timespec64 adjust, now;
> +	int rc;
> +
> +	getnstimeofday64(&now);
> +
> +	now = adjust;

This should be:
	adjust = now;

With that fixed, things start behaving:

[ 1610.640275] sched_sync_hw_clock: adjust=1506186910.320475949 now=1506186910.320481069 next=0.179518931 target=500000000 fail=1
[ 1610.824271] sched_sync_hw_clock: adjust=1506186910.504470719 now=1506186910.504489040 next=659.995510960 target=500000000 fail=0

and:

# ./test-rtc
Takes average of 64364ns to read RTC
Took 63923ns to read RTC on second change
RTC Time: 23-09-2017 17:15:32
System Time was:     17:15:31.505
# perl -e 'print gmtime( 1506186910.504470719)."\n";'
Sat Sep 23 17:15:10 2017

The update to the clock looks like it took 19us, so nice and quick.  We
were about 504ms past the second, which is reflected in the read-back.
Setting the offset to zero gives:

[ 2283.310136] sched_sync_hw_clock: adjust=1506187583.024478934 now=1506187583.024484335 next=0.975515665 target=0 fail=1
[ 2284.302088] sched_sync_hw_clock: adjust=1506187584.016471005 now=1506187584.016490006 next=659.983509994 target=0 fail=0

and:

RTC Time: 23-09-2017 17:26:28
System Time was:     17:26:28.017

So we're getting it almost right - except for the sloppyness of the
workqueue being run (which is mostly dependent on the sloppiness of
the timer.)

[ 2954.059895] sched_sync_hw_clock: adjust=1506188253.808470501 now=1506188253.808475661 next=0.191524339 target=0 fail=1
[ 2954.255898] sched_sync_hw_clock: adjust=1506188254.004471056 now=1506188254.004490017 next=659.995509983 target=0 fail=0
[ 3625.769764] sched_sync_hw_clock: adjust=1506188925.552468680 now=1506188925.552473640 next=0.447526360 target=0 fail=1
[ 3626.249738] sched_sync_hw_clock: adjust=1506188926.032470718 now=1506188926.032474358 next=0.967525642 target=0 fail=1
[ 3627.241688] sched_sync_hw_clock: adjust=1506188927.024472221 now=1506188927.024475501 next=0.975524499 target=0 fail=1
[ 3628.233656] sched_sync_hw_clock: adjust=1506188928.016475925 now=1506188928.016493206 next=659.983506794 target=0 fail=0
[ 4297.479450] sched_sync_hw_clock: adjust=1506189597.296468095 now=1506189597.296473256 next=0.703526744 target=0 fail=1
[ 4298.215411] sched_sync_hw_clock: adjust=1506189598.032469007 now=1506189598.032472527 next=0.967527473 target=0 fail=1
[ 4299.207366] sched_sync_hw_clock: adjust=1506189599.024475501 now=1506189599.024478982 next=0.975521018 target=0 fail=1
[ 4300.199324] sched_sync_hw_clock: adjust=1506189600.016469555 now=1506189600.016487676 next=659.983512324 target=0 fail=0
[ 4969.189207] sched_sync_hw_clock: adjust=1506190269.040474937 now=1506190269.040479897 next=0.959520103 target=0 fail=1
[ 4970.181150] sched_sync_hw_clock: adjust=1506190270.032471016 now=1506190270.032474976 next=0.967525024 target=0 fail=1
[ 4971.173104] sched_sync_hw_clock: adjust=1506190271.024476656 now=1506190271.024480136 next=0.975519864 target=0 fail=1
[ 4972.165063] sched_sync_hw_clock: adjust=1506190272.016471455 now=1506190272.016489416 next=659.983510584 target=0 fail=0

It looks like we struggle to hit that window, even though it's +/-
5 ticks (@250Hz, that's still 20ms, and we can see from the above
we're twice that.)

So, I think the old timers are just too sloppy in modern kernels.
If we want to do this, we need to use a hrtimer to trigger a
workqueue - in other words, open-coding a hrtimer-delayed workqueue.
That's something I've already tried, and it seems to work a lot
better.  I'll adapt it to your current patch.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
