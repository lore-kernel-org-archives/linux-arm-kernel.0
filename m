From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 14 Jun 2016 16:31:25 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <551D7EAB.1000200@arm.com>
References: <20150316195255.GM8656@n2100.arm.linux.org.uk>
 <550818A6.9020205@arm.com> <20150317153657.GY8656@n2100.arm.linux.org.uk>
 <55084D99.7050004@arm.com> <20150317161748.GZ8656@n2100.arm.linux.org.uk>
 <20150330140333.GJ24899@n2100.arm.linux.org.uk> <55196228.5050805@arm.com>
 <20150330150552.GK24899@n2100.arm.linux.org.uk> <55196E31.80803@arm.com>
 <551AD902.9090401@arm.com> <20150402141336.GI24899@n2100.arm.linux.org.uk>
 <551D7EAB.1000200@arm.com>
Message-ID: <1465918285.2840.41.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep

Over the past several days I think I've been unknowingly reproducing
many of the steps in this old discussion thread [1] about A9 Versatile
Express boot failures. It's only when I found myself looking at the L2
cache timings that I got a vague recollection and dug out this old
thread again. Was there any resolution to the issue? As far as I can
work out, the A9x4 CoreTile stopped working around Linux 3.18 (the
problem isn't 100% reproducible so it's difficult to tell).

Using "arm,tag-latency = <2 2 1>" as Russell seemed to indicate [2]
fixed things for him, also works for me. So should we update mainline
device-tree with that?

Alternatively, we could assume nobody cares about A9 as presumably Linux
has been unbootable for a year without anyone raising the issue. (The
only reason I'm looking at it is I may be making U-Boot changes for
vexpress and I wanted to test them).

But if we are going to just ignore things, I think it would be good to
delete the A9 dts, or the L2 cache entry, so other people in the future
don't waste days trying to track down the problem.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330860.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/342005.html

-- 
Tixy


n Thu, 2015-04-02 at 18:38 +0100, Sudeep Holla wrote:
> 
> On 02/04/15 15:13, Russell King - ARM Linux wrote:
> > On Tue, Mar 31, 2015 at 06:27:30PM +0100, Sudeep Holla wrote:
> >> Not sure on that as v3.18 with DT seems to be working fine and passed
> >> overnight reboot testing.
> >
> > Okay, that suggests there's something post v3.18 which is causing this,
> > rather than it being a DT vs non-DT thing.
> >
> 
> Correct. Just to be 100% sure I reverted that non-DT removal commit on
> both v3.19-rc1 and v4.0-rc6 and was able to reproduce issue without DT.
> 
> > An extra data point which I've just found (by enabling attempts to do
> > hibernation on various test platforms) is that the Versatile Express
> > appears to be incapable of taking a CPU offline.
> >
> > This crashes the entire system with sometimes random results.  Sometimes
> > it'll appear that a spinlock has been left owned by CPU#1 which is
> > offline.  Sometimes it'll silently hang.  Sometimes it'll start slowly
> > dumping kernel messages from the start of the kernel's ring buffer (!),
> > eg:
> >
> > PM: freeze of devices complete after 29.342 msecs
> > PM: late freeze of devices complete after 6.398 msecs
> > PM: noirq freeze of devices complete after 5.493 msecs
> > Disabling non-boot CPUs ...
> > __cpu_disable(1)
> > __cpu_die(1)
> > handle_IPI(0)
> > Booting Linux on physical CPU 0x0
> >
> > So far, it's not managed to take a CPU successfully offline and know that
> > it has.  If I disable the calls to cpu_enter_lowpower() and
> > cpu_leave_lowpower(), then it appears to work.
> >
> > This leads me to wonder whether flush_cache_louis() works... which led me
> > in turn to ARM_ERRATA_643719, which is disabled in my builds.  However,
> > the CA9 tile has a r0p1 CA9, which allegedly suffers from this errata.
> >
> 
> Yes I observed that and tested for this issue enabling it. It's doesn't
> affect and I still hit the issue.
> 
> [...]
> >
> > I haven't tested going back to a tag latency of 1 1 1 yet.  Can you
> > confirm whether you have this errata enabled for your tests?
> >
> I have now gone back to <1 1 1> latency to debug the issue as it's
> easier to reproduce with that latencies.
> 
> After I failed terribly to bisect between v3.18..v3.19-c1, as it depends
> a lot on the config you choose(a lot of changes introduced as it's merge
> window), I started looking at the code where we hit this issue since
> it's always in __radix_tree_lookup in lib/radix-tree.c while
> accessing the slots to see if it provides any more details.
> 
> Regards,
> Sudeep
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
