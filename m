From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 24 Feb 2014 15:33:23 +0000
Subject: [RFC PATCH 0/2] Introduce pte_isset for arm and arm64
Message-ID: <1393256005-2206-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Long descriptors on ARM and all ptes on ARM64 are 64 bits. Some pte
attribute test functions such as pte_dirty return the bitwise-and of a
flag with the pte value. If the flag to be tested resides in the
upper 32 bits of the pte, then we run into the danger of the result
being dropped if downcast.

For example:
	gather_stats(page, md, pte_dirty(*pte), 1);
where pte_dirty(*pte) is downcast to an int.

Under ARM with LPAE, functions such as huge_pte_write also perform a
downcast to unsigned long (which is 32 bits). 

This series introduces a new macro pte_isset which performs the bitwise
and, then performs a double logical invert to ensure predictable
downcasting.

The reasoning behind a new macro was that it creates an obvious
pattern which can be followed by future changes to the pte functions.
Rather than target specific pte functions, I opted to wrap all of them
with this macro for the sake of simplicity (also the flags may move in
future).

I was toying with using (bool), but decided that the !! looked slightly
better. Under testing (with an Arndale and the Fast Model on 3.14-rc4)
both strategies worked as expected.

My compilers, gcc 4.7.3 for arm and aarch64, both optimised cases such
as "if(pte_dirty(blah))" to a simple single bit test.

Any feedback on this would be very welcome, as both my PTE_WRITE patch
for ARM, and PTE_SPECIAL introduction patch for ARM (needed for
fast_gup on ARM and ARM64) depend on this.

Thanks,
-- 
Steve

Steve Capper (2):
  arm: mm: Introduce pte_isset(pte,flag)
  arm64: Introduce pte_isset(pte,flag)

 arch/arm/include/asm/pgtable.h   | 12 +++++++-----
 arch/arm64/include/asm/pgtable.h | 13 +++++++------
 2 files changed, 14 insertions(+), 11 deletions(-)

-- 
1.8.1.4
