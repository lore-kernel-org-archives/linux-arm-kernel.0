From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 12 Feb 2014 11:50:05 +0000
Subject: [PATCH 0/3] arm64: Use pte manipulation functions for THP
In-Reply-To: <20140212102112.GE13441@mudshark.cambridge.arm.com>
References: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
 <20140212094338.GA11325@linaro.org>
 <20140212100736.GA13441@mudshark.cambridge.arm.com>
 <20140212101602.GD29702@arm.com>
 <20140212102112.GE13441@mudshark.cambridge.arm.com>
Message-ID: <20140212115004.GA14527@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 10:21:12AM +0000, Will Deacon wrote:
> On Wed, Feb 12, 2014 at 10:16:02AM +0000, Catalin Marinas wrote:
> > On Wed, Feb 12, 2014 at 10:07:37AM +0000, Will Deacon wrote:
> > > On Wed, Feb 12, 2014 at 09:43:39AM +0000, Steve Capper wrote:
> > > > On Thu, Feb 06, 2014 at 02:16:08PM +0000, Steve Capper wrote:
> > > > > This series replaces the Transparent HugePage pmd manipulation
> > > > > functions with calls to the standard pte functions. This allows the THP
> > > > > code to take advantage of the new PTE_WRITE logic, and provides better
> > > > > parity with the HugeTLB code (which already uses the pte functions).
> > > > > 
> > > > > Testing was done on the Fast Model with LTP THP tests, and the 3.14-rc1
> > > > > kernel was used.
> > > > 
> > > > Does this series look reasonable?
> > > 
> > > I was waiting for the corresponding arch/arm/ changes.
> > 
> > The arch/arm/ code doesn't have the PTE_WRITE changes. It's a bit more
> > work here because of the classic MMU (but I hope Steve will get there ;).
> 
> Indeed, but I'm wary of divergence in the mm code between the two
> architectures and I'd much rather we try to keep them in sync, rather than
> improve/bug fix in one before porting the whole lot over.

I do think we need the same behaviour for 3-level code on ARM and for
ARM64.

The PTE_WRITE changes for ARM64 allow one to distinguish between
writable clean ptes and read only ptes which fixes a very subtle
problem with huge pages (and maybe some other problems). This problem
is still present in the ARM 3-level code.

The ARM 2-level code stores a separate linux/hardware pte and it is
possible to distinguish between writable clean ptes and read only ptes.

For ARM, I would like to split out some of the pte logic and page
permissions from pgtable.h into pgtable-[23]level.h. Then introduce
PTE_WRITE for the 3-level code on ARM.
 
Russell,
I have noticed the following for ARM:
 36bb94b ARM: pgtable: provide RDONLY page table bit rather than WRITE bit
Are you happy for me to re-introduce PTE_WRITE for the 3-level code
only, and keep L_PTE_RDONLY for the 2-level code?

Thanks,
-- 
Steve
