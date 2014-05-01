From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 1 May 2014 10:52:47 +0100
Subject: [RFC PATCH V4 6/7] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <20140501073402.GA30358@linaro.org>
References: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
 <1396018892-6773-7-git-send-email-steve.capper@linaro.org>
 <20140430152047.GF31220@arm.com> <20140430153317.GG31220@arm.com>
 <20140430153824.GA7166@linaro.org> <20140430172114.GI31220@arm.com>
 <20140501073402.GA30358@linaro.org>
Message-ID: <20140501095246.GB22316@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 08:34:03AM +0100, Steve Capper wrote:
> On Wed, Apr 30, 2014 at 06:21:14PM +0100, Catalin Marinas wrote:
> > Both powerpc and sparc use tlb_remove_table() via their __pte_free_tlb()
> > etc. which implies an IPI for synchronisation if mm_users > 1. For
> > gup_fast we may not need it since we use the RCU for protection. Am I
> > missing anything?
> 
> So my understanding is:
> 
> tlb_remove_table will just immediately free any pages where there's a
> single user as there's no need to consider a gup walking.

Does gup_fast walking increment the mm_users? Or is it a requirement of
the calling code? I can't seem to find where this happens.

> For the case of multiple users we have an mmu_table_batch structure
> that holds references to pages that should be freed at a later point.

Yes.

> This batch is contained on a page that is allocated on the fly. If, for
> any reason, we can't allocate the batch container we fallback to a slow
> path which is to issue an IPI (via tlb_remove_table_one). This IPI will
> block on the gup walker. We need this fallback behaviour on ARM/ARM64.

That's my main point: this batch page allocation on the fly for table
pages happens in tlb_remove_table(). With your patch for arm64
HAVE_RCU_TABLE_FREE, I can comment out tlb_remove_table() and it
compiles just fine because you don't call it from functions like
__pte_free_tlb() (as powerpc and sparc do). The __tlb_remove_page() that
we currently use doesn't give us any RCU protection here.

-- 
Catalin
