From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Sep 2017 13:24:20 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170922095713.GD20805@n2100.armlinux.org.uk>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
 <20170921075907.GR20805@n2100.armlinux.org.uk>
 <20170921093218.GS20805@n2100.armlinux.org.uk>
 <20170921220510.GA11395@obsidianresearch.com>
 <20170921224541.GC20805@n2100.armlinux.org.uk>
 <20170921232040.GA15130@obsidianresearch.com>
 <20170922095713.GD20805@n2100.armlinux.org.uk>
Message-ID: <20170922122419.GH20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 22, 2017 at 10:57:13AM +0100, Russell King - ARM Linux wrote:
> Maybe the solution here is to split two forms of ntp RTC synchronisation
> so:
> - If you enable CONFIG_GENERIC_CMOS_UPDATE, then you get the
>   update_persistent_clock*() methods called.
> - If you enable CONFIG_RTC_SYSTOHC, rtc_set_ntp_time() gets called.
> - If you enable both, then both get called at their appropriate times.
> 
> This would certainly simplify sync_cmos_clock().

I've just tried that out, and it doesn't work very well (not wrapping
the kernel messages):

[   18.827144] sync_rtc_clock: adjust=1506081346.710933001 target=470000000 next=1506081357.470000000 now=1506081346.710953334 delta=10.759046666 jiffies=2690
[   29.662077] sync_rtc_clock: adjust=1506081357.546474534 target=470000000 next=1506081368.470000000 now=1506081357.546487201 delta=10.923512799 jiffies=2731
[   40.671669] sync_rtc_clock: adjust=1506081368.556684059 target=470000000 next=1506081379.470000000 now=1506081368.556696727 delta=10.913303273 jiffies=2729
[   51.675016] sync_rtc_clock: adjust=1506081379.560649235 target=470000000 next=1506081390.470000000 now=1506081379.560662236 delta=10.909337764 jiffies=2728
[   62.682385] sync_rtc_clock: adjust=1506081390.568637970 target=470000000 next=1506081401.470000000 now=1506081390.568648637 delta=10.901351363 jiffies=2726
[   73.689831] sync_rtc_clock: adjust=1506081401.576696708 target=470000000 next=1506081412.470000000 now=1506081401.576708376 delta=10.893291624 jiffies=2724
[   84.697233] sync_rtc_clock: adjust=1506081412.584695110 target=470000000 next=1506081423.470000000 now=1506081412.584723778 delta=10.885276222 jiffies=2722
[   95.704624] sync_rtc_clock: adjust=1506081423.592724847 target=470000000 next=1506081434.470000000 now=1506081423.592736847 delta=10.877263153 jiffies=2720
[  106.711941] sync_rtc_clock: adjust=1506081434.600651911 target=470000000 next=1506081445.470000000 now=1506081434.600665579 delta=10.869334421 jiffies=2718
[  117.719334] sync_rtc_clock: adjust=1506081445.608659647 target=470000000 next=1506081456.470000000 now=1506081445.608673981 delta=10.861326019 jiffies=2716
[  128.726723] sync_rtc_clock: adjust=1506081456.616661715 target=470000000 next=1506081467.470000000 now=1506081456.616676049 delta=10.853323951 jiffies=2714
[  139.734103] sync_rtc_clock: adjust=1506081467.624659450 target=470000000 next=1506081478.470000000 now=1506081467.624672451 delta=10.845327549 jiffies=2712
[  150.741489] sync_rtc_clock: adjust=1506081478.632661185 target=470000000 next=1506081489.470000000 now=1506081478.632673519 delta=10.837326481 jiffies=2710
[  161.748870] sync_rtc_clock: adjust=1506081489.640655587 target=470000000 next=1506081500.470000000 now=1506081489.640668254 delta=10.829331746 jiffies=2708
[  172.756352] sync_rtc_clock: adjust=1506081500.648758661 target=470000000 next=1506081511.470000000 now=1506081500.648772995 delta=10.821227005 jiffies=2706
[  183.763642] sync_rtc_clock: adjust=1506081511.656658057 target=470000000 next=1506081522.470000000 now=1506081511.656671391 delta=10.813328609 jiffies=2704
[  194.771043] sync_rtc_clock: adjust=1506081522.664678127 target=470000000 next=1506081533.470000000 now=1506081522.664689794 delta=10.805310206 jiffies=2702
[  205.778402] sync_rtc_clock: adjust=1506081533.672649194 target=470000000 next=1506081544.470000000 now=1506081533.672662528 delta=10.797337472 jiffies=2700
[  216.785780] sync_rtc_clock: adjust=1506081544.680643928 target=470000000 next=1506081555.470000000 now=1506081544.680656929 delta=10.789343071 jiffies=2698
[  227.792447] sync_rtc_clock: adjust=1506081555.688650369 target=470000000 next=1506081566.470000000 now=1506081555.688664037 delta=10.781335963 jiffies=2696
[  238.798968] sync_rtc_clock: adjust=1506081566.696674887 target=470000000 next=1506081577.470000000 now=1506081566.696687889 delta=10.773312111 jiffies=2694
[  249.805483] sync_rtc_clock: adjust=1506081577.704652923 target=470000000 next=1506081588.470000000 now=1506081577.704666259 delta=10.765333741 jiffies=2692
[  260.812078] sync_rtc_clock: adjust=1506081588.712679979 target=470000000 next=1506081599.470000000 now=1506081588.712693647 delta=10.757306353 jiffies=2690
[  271.818656] sync_rtc_clock: adjust=1506081599.720654429 target=470000000 next=1506081610.470000000 now=1506081599.720668431 delta=10.749331569 jiffies=2688
[  282.825311] sync_rtc_clock: adjust=1506081610.728677710 target=470000000 next=1506081621.470000000 now=1506081610.728690045 delta=10.741309955 jiffies=2686
[  293.575979] sync_rtc_clock: adjust=1506081621.480653995 target=470000000 next=1506081632.470000000 now=1506081621.480666996 delta=10.989333004 jiffies=2748
[  304.582667] sync_rtc_clock: adjust=1506081632.488651088 target=470000000 next=1506081643.470000000 now=1506081632.488663756 delta=10.981336244 jiffies=2746
[  315.589372] sync_rtc_clock: adjust=1506081643.496641761 target=470000000 next=1506081654.470000000 now=1506081643.496653429 delta=10.973346571 jiffies=2744

As previous mentioned, this has HZ=250, so one jiffy is about 4ms.  What
this shows is that we're failing every single time to hit the desired
window - the closest we got in the 5 minutes of uptime to 470ms was
480653995ns.

The comments in linux/workqueue.h refer to a gmane link -
http://thread.gmane.org/gmane.linux.kernel/1480396 but this seems to be
dead - "Archived At Nothing found - bye".  Looks like using gmane URLs
in kernel code is not a good idea, they don't seem to be persistent!

It's interesting to watch what's happening there - despite reducing the
number of jiffies each time, we still seem to be woken later and later
each time, with an approximate increase of 8ms or two jiffies each time.
Eg:

[  293.575979] sync_rtc_clock: adjust=1506081621.480653995 target=470000000
 next=1506081632.470000000 now=1506081621.480666996 delta=10.989333004
 jiffies=2748
[  304.582667] sync_rtc_clock: adjust=1506081632.488651088 target=470000000
 next=1506081643.470000000 now=1506081632.488663756 delta=10.981336244
 jiffies=2746
[  315.589372] sync_rtc_clock: adjust=1506081643.496641761 target=470000000
 next=1506081654.470000000 now=1506081643.496653429 delta=10.973346571
 jiffies=2744

If we do the math, then:

 2748 jiffies is 10.992s, which is 10.989333004 rounded up to a jiffy.
 10.992 + 1506081621.480666996 gives 1506081632.472666996, but we're
 next called at 1506081632.488651088, which is almost 4 jiffies later
 than requested.

 2746 jiffies is 10.984s, which is 10.981336244 rounded up to a jiffy.
 10.984 + 1506081632.488663756 gives 1506081643.472663756, but we're
 next called at 1506081643.496641761, which is almost 6 jiffies later
 than requested.

I'm not sure where those extra jiffies are coming from... but maybe
using the power efficient wq is not the best for accuracy?

Also notice that the target time seems to always be about 2.6ms late.
based on the requested jiffies, which in itself would mean we miss
the 1ms window in the systohc.c code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
