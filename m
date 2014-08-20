From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 20 Aug 2014 16:11:43 +0100
Subject: [PATCH 0/6] RCU get_user_pages_fast and __get_user_pages_fast
In-Reply-To: <CALdTtns6+MRb=Z7i0ncq_c2u7QZWo1mUxD824bvNF==q-_+BiQ@mail.gmail.com>
References: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
 <CALdTtns6+MRb=Z7i0ncq_c2u7QZWo1mUxD824bvNF==q-_+BiQ@mail.gmail.com>
Message-ID: <20140820151142.GA26217@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 08:56:09AM -0600, Dann Frazier wrote:
> On Wed, Jun 25, 2014 at 9:40 AM, Steve Capper <steve.capper@linaro.org> wrote:
> > Hello,
> > This series implements general forms of get_user_pages_fast and
> > __get_user_pages_fast and activates them for arm and arm64.
> >
> > These are required for Transparent HugePages to function correctly, as
> > a futex on a THP tail will otherwise result in an infinite loop (due to
> > the core implementation of __get_user_pages_fast always returning 0).
> >
> > This series may also be beneficial for direct-IO heavy workloads and
> > certain KVM workloads.
> >
> > The main changes since RFC V5 are:
> >  * Rebased against 3.16-rc1.
> >  * pmd_present no longer tested for by gup_huge_pmd and gup_huge_pud,
> >    because the entry must be present for these leaf functions to be
> >    called.
> >  * Rather than assume puds can be re-cast as pmds, a separate
> >    function pud_write is instead used by the core gup.
> >  * ARM activation logic changed, now it will only activate
> >    RCU_TABLE_FREE and RCU_GUP when running with LPAE.
> >
> > The main changes since RFC V4 are:
> >  * corrected the arm64 logic so it now correctly rcu-frees page
> >    table backing pages.
> >  * rcu free logic relaxed for pre-ARMv7 ARM as we need an IPI to
> >    invalidate TLBs anyway.
> >  * rebased to 3.15-rc3 (some minor changes were needed to allow it to merge).
> >  * dropped Catalin's mmu_gather patch as that's been merged already.
> >
> > This series has been tested with LTP and some custom futex tests that
> > exacerbate the futex on THP tail case. Also debug counters were
> > temporarily employed to ensure that the RCU_TABLE_FREE logic was
> > behaving as expected.
> >
> > I would really appreciate any testers or comments (especially on the
> > validity or otherwise of the core fast_gup implementation).
> 
> I have a test case that can reliably hit the THP issue on arm64, which
> hits it on both 3.16 and 3.17-rc1. I do a "juju bootstrap local" w/
> THP disabled at boot. Then I reboot with THP enabled. At this point
> you'll see jujud spin at 200% CPU. gccgo binaries seem to have a nack
> for hitting it.
> 
> I validated that your patches resolve this issue on 3.16, so:
> 
> Tested-by: dann frazier <dann.frazier@canonical.com>

Thanks Dann!

> 
> I haven't done the same for 3.17-rc1 because they no longer apply
> cleanly, but I'm happy to test future submissions w/ hopefully a
> shorter feedback loop (please add me to the CC). btw, should we
> consider something like this until your patches go in?

I am about to post the following series, I will CC you:
git://git.linaro.org/people/steve.capper/linux.git fast_gup/3.17-rc1
(I've just been giving it a workout on 3.17-rc1).

I would much prefer for the RCU fast_gup to go into 3.18 rather than
BROKEN for THP. I am not sure what to do about earlier versions.

Cheers,
-- 
Steve
