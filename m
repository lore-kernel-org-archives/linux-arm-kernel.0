From: kmcmarti@redhat.com (Kyle McMartin)
Date: Sat, 10 Jan 2015 10:22:59 -0500
Subject: Linux 3.19-rc3
In-Reply-To: <54B09CA3.1060501@redhat.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <54AE7D53.2020305@redhat.com> <20150109121348.GD12942@leverpostej>
 <CAPvkgC23LHhs7Tw4rdAPFooimonji8R7kEAbWYRKPJwouwUzBA@mail.gmail.com>
 <54AFE53A.4020004@redhat.com> <20150109175702.GA27787@leverpostej>
 <54B01FF0.3020900@arm.com> <20150109194333.GA23028@arm.com>
 <54B09CA3.1060501@redhat.com>
Message-ID: <20150110152259.GP18580@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 04:29:39AM +0100, Laszlo Ersek wrote:
> I've bisected this issue to
> 

Awesome, this was on my list of list of suspicious commits to check
before my ARM64 box decided not to come back from reboot on Friday. :)

Thanks for bisecting!

cheers,
--Kyle

> > f045bbb9fa1bf6f507ad4de12d4e3471d8f672f1 is the first bad commit
> > commit f045bbb9fa1bf6f507ad4de12d4e3471d8f672f1
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Wed Dec 17 11:59:04 2014 -0800
> >
> >     mmu_gather: fix over-eager tlb_flush_mmu_free() calling
> >
> >     Dave Hansen reports that commit fb7332a9fedf ("mmu_gather: move minimal
> >     range calculations into generic code") caused a performance problem:
> >
> >       "tlb_finish_mmu() goes up about 9x in the profiles (~0.4%->3.6%) and
> >        tlb_flush_mmu_free() takes about 3.1% of CPU time with the patch
> >        applied, but does not show up at all on the commit before"
> >
> >     and the reason is that Will moved the test for whether we need to flush
> >     from tlb_flush_mmu() into tlb_flush_mmu_tlbonly().  But that meant that
> >     tlb_flush_mmu_free() basically lost that check.
> >
> >     Move it back into tlb_flush_mmu() where it belongs, so that it covers
> >     both tlb_flush_mmu_tlbonly() _and_ tlb_flush_mmu_free().
> >
> >     Reported-and-tested-by: Dave Hansen <dave@sr71.net>
> >     Acked-by: Will Deacon <will.deacon@arm.com>
> >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> >
