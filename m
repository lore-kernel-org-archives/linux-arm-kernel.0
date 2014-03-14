From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Mar 2014 20:32:42 +0000
Subject: PL310 errata workarounds
In-Reply-To: <CAL_JsqL02dw7B+GEL4921f_7m=RRUokW0n64TxSJnMWN3MMfrQ@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314150110.GQ21483@n2100.arm.linux.org.uk>
 <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
 <20140314175701.GR21483@n2100.arm.linux.org.uk>
 <CAL_JsqL02dw7B+GEL4921f_7m=RRUokW0n64TxSJnMWN3MMfrQ@mail.gmail.com>
Message-ID: <20140314203242.GS21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 02:14:06PM -0500, Rob Herring wrote:
> On Fri, Mar 14, 2014 at 12:57 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Mar 14, 2014 at 11:02:17AM -0500, Rob Herring wrote:
> >> The obvious fix is to convert l2x0_flush_line to a function ptr which
> >> just further complicates the code.
> >
> > Out of those, L220 is the odd one out: all operations are background
> > operations there, which means they have to be waited for.  Currently,
> > if you have one of these, and you build a multiplatform kernel which
> > includes PL310 support, you don't wait for any of these and you probably
> > see a lot of data corruption as a result.
> 
> Oops. I guess there are not many users as the L220 was primarily used
> with the 1176 (and 11MP?) IIRC. I guess one of the primary 1176 based
> platforms currently used is RPi, but it appears the BCM2835 doesn't
> have an L2 (other than some custom L2 for the GPU).

I guess not as there hasn't been any reports about breakage there.

> > PL210 and PL310 are very similar, but PL310 has all the nasty errata
> > against it.  Both of these have the nice behaviour that provided you
> > stick to the "atomic" operations (physical addressed operations, and
> > cache sync) and you don't need to do the errata workaround dances,
> > then you don't need the spinlocks... which means less contention on
> > a SMP system.
> 
> I would definitely like to see removing the spinlock. readl/writel can
> be a hotspot because of this if you have them in any critical path.
> 
> Really, if you are flushing such large buffers that you need the
> optimization, you should fix how the buffers are mapped rather than
> optimizing the flush.

Exactly.

> >
> > Besides, the L2 mess extends outside this file:
> >
> > static int sirfsoc_pm_enter(suspend_state_t state)
> > {
> > ...
> >                 outer_flush_all();
> >                 outer_disable();
> >
> > So, outer_disable() is defined to disable the L2 cache in a way that
> > doesn't result in data loss to the system (which would crash it) so
> > why is there that outer_flush_all() call there...  *REMOVED*.
> 
> Isn't l2x0_disable racy in SMP? What happens to a write between the
> flush and the disable? If it is only usable when running single core,
> then we can remove the spinlock there. I don't think any of the custom
> disable functions like highbank take the lock.

Yes it is - which is why it should only ever be called as part of
turning the L2 cache off, which is only done when we're sure that we
have complete control over the system and we're single threaded.  So
yes, you're right that the spinlocks aren't needed there.

I've got most of it done now, but there's a few stumbling blocks: the
Aurora and Broadcom caches in there need to have their addiction to
the old ARM code removed.

Broadcom appears to be L2C-310, but it would be useful to know which
revision this is based upon (and therefore which errata we carry are
applicable to it.)  This makes a big difference because we now end up
with different function pointers for the two errata I mentioned (each
errata currently affect two different functions and don't overlap on
native ARM implementations.)

Aurora is completely opaque as to which ARM L2C it's based upon, and
this is quite a blocker for killing the old code.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
