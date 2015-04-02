From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Apr 2015 15:13:36 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <551AD902.9090401@arm.com>
References: <20150316195255.GM8656@n2100.arm.linux.org.uk>
 <550818A6.9020205@arm.com>
 <20150317153657.GY8656@n2100.arm.linux.org.uk>
 <55084D99.7050004@arm.com>
 <20150317161748.GZ8656@n2100.arm.linux.org.uk>
 <20150330140333.GJ24899@n2100.arm.linux.org.uk>
 <55196228.5050805@arm.com>
 <20150330150552.GK24899@n2100.arm.linux.org.uk>
 <55196E31.80803@arm.com> <551AD902.9090401@arm.com>
Message-ID: <20150402141336.GI24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 06:27:30PM +0100, Sudeep Holla wrote:
> Not sure on that as v3.18 with DT seems to be working fine and passed
> overnight reboot testing.

Okay, that suggests there's something post v3.18 which is causing this,
rather than it being a DT vs non-DT thing.

An extra data point which I've just found (by enabling attempts to do
hibernation on various test platforms) is that the Versatile Express
appears to be incapable of taking a CPU offline.

This crashes the entire system with sometimes random results.  Sometimes
it'll appear that a spinlock has been left owned by CPU#1 which is
offline.  Sometimes it'll silently hang.  Sometimes it'll start slowly
dumping kernel messages from the start of the kernel's ring buffer (!),
eg:

PM: freeze of devices complete after 29.342 msecs
PM: late freeze of devices complete after 6.398 msecs
PM: noirq freeze of devices complete after 5.493 msecs
Disabling non-boot CPUs ...
__cpu_disable(1)
__cpu_die(1)
handle_IPI(0)
Booting Linux on physical CPU 0x0

So far, it's not managed to take a CPU successfully offline and know that
it has.  If I disable the calls to cpu_enter_lowpower() and
cpu_leave_lowpower(), then it appears to work.

This leads me to wonder whether flush_cache_louis() works... which led me
in turn to ARM_ERRATA_643719, which is disabled in my builds.  However,
the CA9 tile has a r0p1 CA9, which allegedly suffers from this errata.

The really interesting thing is that I've never had that errata enabled
for Versatile Express - even going back to 3.14 times (I have a working
3.14 config file which clearly shows that it was disabled.)  So, I'm
wondering if we've relaxed the cache flushing in such a way that we now
expose the ineffectual flush_cache_louis() bug.

There aren't that many flush_cache_louis() calls in the kernel.  We do
have this:

commit bca7a5a04933700a8bde4ea5798119607a8b0436
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Thu Apr 18 18:15:44 2013 +0100

    ARM: cpu hotplug: remove majority of cache flushing from platforms

in conjuction with:

commit 51acdfd1fa38a2bf1003255be9f105c19fbc0176
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Thu Apr 18 18:05:29 2013 +0100

    ARM: smp: flush L1 cache in cpu_die()

which changed the flush_cache_all() to a flush_cache_louis() in the
hot unplug path.  We also have this:

commit e40678559fdf3f56ce9a349365fbf39e1f63ecc0
Author: Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Thu Nov 8 19:46:07 2012 +0100

    ARM: 7573/1: idmap: use flush_cache_louis() and flush TLBs only when necessary

which added the flush_cache_louis() for the idmap tables, but prior to
that, I don't see how we were ensuring that the page tables were visible.

I haven't tested going back to a tag latency of 1 1 1 yet.  Can you
confirm whether you have this errata enabled for your tests?

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
