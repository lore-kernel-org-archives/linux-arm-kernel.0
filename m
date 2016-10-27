From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu, 27 Oct 2016 17:06:00 +0100
Subject: [PATCH v3] drivers: psci: PSCI checker module
In-Reply-To: <20161027145446.GJ3716@linux.vnet.ibm.com>
References: <20161025154535.GA3107@red-moon>
 <20161025183436.GF3716@linux.vnet.ibm.com> <20161026131752.GA15478@red-moon>
 <20161026151858.GQ3716@linux.vnet.ibm.com> <20161026171006.GA16248@red-moon>
 <20161026172252.GV3716@linux.vnet.ibm.com> <20161026173534.GC16248@red-moon>
 <20161026181148.GW3716@linux.vnet.ibm.com> <20161027091306.GA16603@red-moon>
 <a3fd021e-1fae-08e3-994b-87efcf11b164@arm.com>
 <20161027145446.GJ3716@linux.vnet.ibm.com>
Message-ID: <9cf15020-5116-5082-d3d3-fba80fe2de70@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/10/16 15:54, Paul E. McKenney wrote:
> On Thu, Oct 27, 2016 at 01:51:57PM +0100, Kevin Brodsky wrote:
> > On 27/10/16 10:13, Lorenzo Pieralisi wrote:
> >> On Wed, Oct 26, 2016 at 11:11:48AM -0700, Paul E. McKenney wrote:
> >>> On Wed, Oct 26, 2016 at 06:35:34PM +0100, Lorenzo Pieralisi wrote:
> >>>> On Wed, Oct 26, 2016 at 10:22:52AM -0700, Paul E. McKenney wrote:
> >>>>> On Wed, Oct 26, 2016 at 06:10:06PM +0100, Lorenzo Pieralisi wrote:
> >>> [ . . . ]
> >>>
> >>>>>> Thanks a lot for your feedback, thoughts appreciated.
> >>>>> Let me ask the question more directly.
> >>>>>
> >>>>> Why on earth are we trying to run these tests concurrently?
> >>>> We must prevent that, no question about that, that's why I started
> >>>> this discussion. It is not fine to enable this checker and the
> >>>> RCU/LOCK torture hotplug tests at the same time.
> >>>>
> >>>>> After all, if we just run one at a time in isolation, there is no
> >>>>> problem.
> >>>> Fine by me, it was to understand if the current assumptions we made
> >>>> are correct and they are definitely not. If we enable the PSCI checker
> >>>> we must disable the torture rcu/lock hotplug tests either statically or
> >>>> dynamically.
> >>> What rcutorture, locktorture, and rcuperf do is to invoke
> >>> torture_init_begin(), which returns false if one of these tests
> >>> is already running.
> >>>
> >>> Perhaps we should extract this torture-test-exclusion and require
> >>> than conflicting torture tests invoke it?
> >> Yes if it can be extracted as a check (but it should also prevent the
> >> torture tests from running and vice versa), either that or Kconfig
> >> dependency (which we could do as a first step, waiting to add the
> >> required interface to the torture test code ?).
> >>
> >> Thanks !
> >> Lorenzo
> >
> > That sounds like a reasonable idea, but then that would mean that the PSCI checker
> > would have to wait until the torture test is finished if it is already running (and
> > the other way around).
> >
> > I wasn't aware that torture tests were hotplugging CPUs. I think that the most
> > sensible thing to do right now is to make CONFIG_PSCI_CHECKER depend on
> > !CONFIG_TORTURE_TEST (or maybe specifically !CONFIG_RCU_TORTURE_TEST &&
> > !CONFIG_LOCK_TORTURE_TEST). We can try to make them work together afterwards, but for
> > the sake of getting this patch merged in a reasonable amount of time, I think we
> > should just exclude the conflicting tests at the build level in this patch. I'll also
> > update the comment accordingly.
>
> I suggest !CONFIG_TORTURE_TEST, given that there are a couple of other
> tests in the offing.
>
>                             Thanx, Paul

Fair enough. If that's fine with Lorenzo, I'll add the dependency and post v4.

Thanks,
Kevin
