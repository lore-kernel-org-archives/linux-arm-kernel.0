From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Mar 2014 17:57:01 +0000
Subject: PL310 errata workarounds
In-Reply-To: <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314150110.GQ21483@n2100.arm.linux.org.uk>
 <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
Message-ID: <20140314175701.GR21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 11:02:17AM -0500, Rob Herring wrote:
> The obvious fix is to convert l2x0_flush_line to a function ptr which
> just further complicates the code.

I currently regard this code as unmaintainable, so right now I'm in the
process of completely rewriting it, going back to the specs and checking
what is required.  Sharing code between the L210, L220 and L310 looks
good from the point of view of keeping the line count down, but actually
they're quite different and have various different requirements.

Out of those, L220 is the odd one out: all operations are background
operations there, which means they have to be waited for.  Currently,
if you have one of these, and you build a multiplatform kernel which
includes PL310 support, you don't wait for any of these and you probably
see a lot of data corruption as a result.

PL210 and PL310 are very similar, but PL310 has all the nasty errata
against it.  Both of these have the nice behaviour that provided you
stick to the "atomic" operations (physical addressed operations, and
cache sync) and you don't need to do the errata workaround dances,
then you don't need the spinlocks... which means less contention on
a SMP system.

Besides, the L2 mess extends outside this file:

static int sirfsoc_pm_enter(suspend_state_t state)
{
...
                outer_flush_all();
                outer_disable();

So, outer_disable() is defined to disable the L2 cache in a way that
doesn't result in data loss to the system (which would crash it) so
why is there that outer_flush_all() call there...  *REMOVED*.

static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
{
...
        pen_release = cpu;
        flush_cache_all();
        outer_flush_all();

This is a very big hammer, and quite unnecessary - there's other
solutions to writing to "pen_release" and getting it visible which
are much more effective and don't require such a big hammer.  I've
committed a patch to remove this.

The last one is in the dcscb code, which seems to be a real unknown:

                /*
                 * This is a harmless no-op.  On platforms with a real
                 * outer cache this might either be needed or not,
                 * depending on where the outer cache sits.
                 */
                outer_flush_all();

hardly "harmless" and hardly a "no-op" either... this one I've left
but as I've no hope of running this code as no one seems willing to
assist me with getting Versatile Express running with anything but the
Cortex-A9 tile, I've a good mind to just delete the above.

The reason outer_flush_all() matters is that if we avoid the index/way
operations on the L2 cache, we can remove the locking on much of the L2
cache operations, which means less SMP contention on this stuff.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
