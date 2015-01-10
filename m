From: lersek@redhat.com (Laszlo Ersek)
Date: Sat, 10 Jan 2015 20:47:03 +0100
Subject: Linux 3.19-rc3
In-Reply-To: <20150110133742.GA6999@arm.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <54AE7D53.2020305@redhat.com> <20150109121348.GD12942@leverpostej>
 <CAPvkgC23LHhs7Tw4rdAPFooimonji8R7kEAbWYRKPJwouwUzBA@mail.gmail.com>
 <54AFE53A.4020004@redhat.com> <20150109175702.GA27787@leverpostej>
 <54B01FF0.3020900@arm.com> <20150109194333.GA23028@arm.com>
 <54B09CA3.1060501@redhat.com>
 <CA+55aFw3aGeiWOiKxQaC23VVX_Q9B0cDeZc37vVfK+SJVjGwFw@mail.gmail.com>
 <20150110133742.GA6999@arm.com>
Message-ID: <54B181B7.5080503@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/15 14:37, Will Deacon wrote:

> My hunch is that when a task exits and sets fullmm, end is zero and so the
> old need_flush cases no longer run.

(Disclaimer: I'm completely unfamiliar with this code.)

If you have the following call chain in mind:

  exit_mmap()
    tlb_gather_mmu()

then I think that (fullmm != 0) precludes (end == 0).

I grepped the tree for "fullmm", and only tlb_gather_mmu() seems to set
it. There are several instances of that function, but each sets fullmm to:

	/* Is it from 0 to ~0? */
	tlb->fullmm     = !(start | (end+1));

So, a nonzero fullmm seems to imply (end == ~0UL).

(And sure enough, exit_mmap() passes it ((unsigned long)-1) as "end").

> With my original patch, we skipped the
> TLB invalidation (since the task is exiting and we will invalidate the TLB
> for that ASID before the ASID is reallocated) but still did the freeing.
> With the current code, we skip the freeing too, which causes us to leak
> pages on exit.

Yes, the new check prevents

  tlb_flush_mmu()
    tlb_flush_mmu_free()  <--- this
      free_pages_and_swap_cache()

> I guess we can either check need_flush as well as end, or we could set both
> start == end == some_nonzero_value in __tlb_adjust_range when need_flush is
> set. Unfortunately, I'm away from my h/w right now, so it's not easy to test
> this.

If you have a patch that applies and builds, I'm glad to test it. I got
a few hours now and I'll have some tomorrow as well. (On Monday I guess
you'll have access to your hardware again.)

Thanks!
Laszlo
