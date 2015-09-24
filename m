From: drew.richardson@arm.com (Drew Richardson)
Date: Thu, 24 Sep 2015 10:31:23 -0700
Subject: [PATCH] arm: perf: Add event descriptions
In-Reply-To: <20150817214035.GA25775@dreric01-gentoo.localdomain>
References: <20150804001522.GA13214@dreric01-gentoo.localdomain>
 <20150817205809.GA16506@dreric01-gentoo.localdomain>
 <20150826165148.GF30466@arm.com>
 <20150817214035.GA25775@dreric01-gentoo.localdomain>
Message-ID: <20150924173122.GA32516@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 10:40:35PM +0100, Drew Richardson wrote:
> On Wed, Aug 26, 2015 at 05:51:49PM +0100, Will Deacon wrote:
> > On Mon, Aug 17, 2015 at 09:58:09PM +0100, Drew Richardson wrote:
> > > On Tue, Aug 04, 2015 at 01:15:23AM +0100, Drew Richardson wrote:
> > > > Add additional information about hardware events to make counters self
> > > > describing. This makes the hardware PMUs easier to use as perf list
> > > > contains the possible events instead of users having to refer to
> > > > documentation like the ARM TRMs. This could also allow tools like
> > > > oprofile to support PMUs without requiring an update.
> > > > 
> > > > Signed-off-by: Drew Richardson <drew.richardson@arm.com>
> > > > ---
> > > >  arch/arm/kernel/perf_event.c    |   1 +
> > > >  arch/arm/kernel/perf_event_v7.c | 617 ++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 618 insertions(+)
> > > 
> > > Any concerns with merging this?
> > 
> > We should revisit this after the merge window (since the ARM perf code is
> > moving out to drivers/)
> 
> Not a problem
> 
> > but I do have reservations about putting all these
> > strings into the kernel. Why can't we put this into something like libpfm
> > instead?
> > 
> > Will
> > 
> 
> My intent is to make it easier for people to use hardware counters on
> ARM, particularly with new CPUs. Currently, the developer of the tool
> needs to extract the event information from the ARM TRMs, add it to
> their tool and make a new release. This work is done by multiple
> tools, for example for the Cortex-A15:
> 
> http://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/events/arm_cortex_a15_events.h
> http://sourceforge.net/p/oprofile/oprofile/ci/master/tree/events/arm/armv7-ca15/events
> https://github.com/ARM-software/gator/blob/master/daemon/events-Cortex-A15.xml
> 
> There are likely more tools, these are the ones I could easily
> find. Note that the new ARM Cortex-A72 isn't supported by most of
> them. And the perf command line tool doesn't have any of this.
> 
> Once the tool supports the new CPUs events the user needs to make sure
> they're running a recent version of the tool that contains these
> events for their new ARM CPU. Technically the user could add the event
> information themselves and upstream the change, but not all users will
> do this.
> 
> So my suggestion to solve the problem is that the kernel can have the
> list of events as proposed in the patch. This is already done for some
> PMUs like arm-ccn and arm-cci. If the tool doesn't support the
> particular CPU, they can fall back to the event list provided by the
> kernel. There will be some information missing like user-friendly
> descriptions of the events, but it's hopefully enough that users can
> do what they need to do and update their tool at a later time.
> 
> I'd be glad to wrap this all in a config option so users can disable
> it to reduce bloat. Perhaps there is some other central location
> outside the kernel that could store this information?
> 
> Thanks,
> 
> Drew

Will,

Have you had a chance to review this again? I also noticed that my x86
machines have something similar, although not as few events as I'm
proposing to add.

$ ls /sys/bus/event_source/devices/cpu/events/
cycles-ct  el-capacity  el-start    tx-abort     tx-conflict
cycles-t   el-commit    mem-loads   tx-capacity  tx-start
el-abort   el-conflict  mem-stores  tx-commit

Thanks,

Drew
