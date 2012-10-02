From: david@gibson.dropbear.id.au (David Gibson)
Date: Tue, 2 Oct 2012 10:08:51 +1000
Subject: [PATCH 1/1] Fix segfault in DTC
In-Reply-To: <5069C7A5.8090409@wwwdotorg.org>
References: <50624393.30607@broadcom.com>
 <20120926003508.GB31993@truffula.fritz.box>
 <50632F78.4030709@broadcom.com> <5065D9C7.40906@wwwdotorg.org>
 <E1THfgr-0006Fg-KT@jdl.com> <5065F4FD.4010807@wwwdotorg.org>
 <20120929235342.GA23078@truffula.fritz.box>
 <50692B7A.8000405@wwwdotorg.org>
 <20121001064610.GA5323@truffula.fritz.box>
 <5069C7A5.8090409@wwwdotorg.org>
Message-ID: <20121002000851.GA29302@truffula.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 10:41:09AM -0600, Stephen Warren wrote:
> On 10/01/2012 12:46 AM, David Gibson wrote:
> > On Sun, Sep 30, 2012 at 11:34:50PM -0600, Stephen Warren wrote:
> >> On 09/29/2012 05:53 PM, David Gibson wrote:
> >>> On Fri, Sep 28, 2012 at 01:05:33PM -0600, Stephen Warren wrote:
> >>>> On 09/28/2012 12:53 PM, Jon Loeliger wrote:
> >>>>>>>
> >>>>>>> Yeah, seems like the kernel DTC is quite old.
> >>>>>>
> >>>>>> FYI, I'm working on a patch to the kernel to bring in the latest dtc.
> >>>>>
> >>>>> Awesome.  Thank you.
> >>>>>
> >>>>>> I've run a regression test vs. the old dtc in the kernel ...
> >>>>>
> >>>>> Which is the icky step.  Again, thank you.
> >>>>>
> >>>>>> ... and found that
> >>>>>> some of the PowerPC .dts files don't compile with the new dtc (but did
> >>>>>> with the old), all due to non-existent labels/paths being referenced.
> >>>>>> I'll try and track down whether this is a regression in dtc, or simply
> >>>>>> buggy .dts files that weren't noticed before.
> >>>>>
> >>>>> I think you should just smack the PowerPC guys. :-)
> >>>>
> >>>> For the record in this thread, it was a regression I introduced into dtc
> >>>> - the patch I just sent was for this.
> >>>
> >>> I would be nice to add a testcase for this regression into dtc.
> >>
> >> The issue here was caused by uninitialized memory, so it would, I think,
> >> be basically impossible to create a test-case that would be guaranteed
> >> to fail because of this; it'd depend on the internal details of the
> >> malloc library and how/when it re-used previously free()d memory blocks.
> > 
> > It doesn't have to be guaranteed to fail to be useful.  Plus, we
> > already have the infrastructure to run the tests under valgrind, which
> > would catch it.
> 
> I certainly disagree here; the absolute worst kind of test is one which
> gives different results each time it's run, or statically gives
> different results to different people. People will either ignore the
> test because it's flaky, or it'll end up blaming the wrong person due to
> some entirely unrelated and correct change just happening to tickle the
> test.

I'd agree 100% if the test could give false failures.  But in this
case it can only give false passes.  If the test fails there is a bug
*somewhere*, even if it's not actually in whatever changed last.  The
test framework actually has a "PASS (inconclusive)" result for exactly
this sort of case.

> If we were to force any such new test to always run under valgrind, then
> hopefully the test would always fail (assuming the test harness triggers
> failure if valgrind finds problems).

Aside: it's supposed to;  if it doesn't, that's a bug.  You can try it
easily enough with "make checkm".

> That might be reasonable. However,
> if we do this, then I think instead we should just always force the
> entire existing test suite to run under valgrind; no new test should be
> needed for valgrind to detect this failure (since there was a
> read-before-write problem any time a label was used in the existing
> code, it just didn't always cause a user-visible issue).

Hrm.  I don't want to run the whole testsuite under valgrind by
default for a couple of reasons.  First, it's much, much slower, and
second you need to have valgrind installed.  Both these would
discourage people from running the testsuite so frequently, and even
without valgrind it's very, very useful.

I guess we could make the new one a "valgrind only" test, that's we
only bother to execute when the valgrind options are enabled.

> Another alternative might be to LD_PRELOAD a test malloc library with a
> known allocation pattern. That would allow a new test for this case to
> always fail. However, the allocation pattern of this test malloc library
> would have to be carefully tied to the allocation pattern of dtc itself
> when processing the new test's .dts file, and that could easily and
> legitimately change due to unrelated implementation details of dtc
> changing, thus making the maintenance of the test malloc library
> painful. So, I don't think this is the way to go.

Hrm.  A malloc() with a "known buggy" allocation pattern would be
impractical, I agree.  But it occurred to me that a much simpler
malloc() wrapper which filled each allocated block with garbage
(non-zero) data before returning it would be sufficient in this case.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
