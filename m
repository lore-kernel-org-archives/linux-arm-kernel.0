From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:35:54 +0100
Subject: [RESEND PATCH 0/4] Fix PROT_NONE page permissions when
 !CPU_USE_DOMAINS
Message-ID: <1350488158-3399-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a respin of the patches originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/121661.html

the only difference being that these are based on top of -rc1. I intended
to change the definition of pte_present_user to avoid the additional check,
but it turns out that GCC is generating terrible code regardless of what I
try:


#define pte_present_user(pte)  (pte_present(pte) && (pte_val(pte) & L_PTE_USER))

  c0010990:       e3a02043        mov     r2, #67 ; 0x43
  c0010994:       e3a03000        mov     r3, #0
  c0010998:       e0000002        and     r0, r0, r2
  c001099c:       e0011003        and     r1, r1, r3
  c00109a0:       e3510000        cmp     r1, #0
  c00109a4:       03500040        cmpeq   r0, #64 ; 0x40
  c00109a8:       93a00000        movls   r0, #0
  c00109ac:       83a00001        movhi   r0, #1
  c00109b0:       e12fff1e        bx      lr


#define pte_present_user(pte)  \
		((pte_val(pte) & (L_PTE_PRESENT | L_PTE_USER)) > L_PTE_USER)

  c0010990:       e3a02003        mov     r2, #3
  c0010994:       e3a03000        mov     r3, #0
  c0010998:       e0022000        and     r2, r2, r0
  c001099c:       e0033001        and     r3, r3, r1
  c00109a0:       e192c003        orrs    ip, r2, r3
  c00109a4:       17e00350        ubfxne  r0, r0, #6, #1
  c00109a8:       03a00000        moveq   r0, #0
  c00109ac:       e12fff1e        bx      lr


After some investigation, it looks like this is related to having 64-bit
ptes (LPAE) [I've reported this to the GCC guys], so I reverted to
classic MMU and we get the same number of instructions there for either
case:

  c0010950:       e3003101        movw    r3, #257        ; 0x101
  c0010954:       e0000003        and     r0, r0, r3
  c0010958:       e0503003        subs    r3, r0, r3
  c001095c:       e2730000        rsbs    r0, r3, #0
  c0010960:       e0b00003        adcs    r0, r0, r3
  c0010964:       e12fff1e        bx      lr

vs

  c0010950:       e3003101        movw    r3, #257        ; 0x101
  c0010954:       e0003003        and     r3, r0, r3
  c0010958:       e3530c01        cmp     r3, #256        ; 0x100
  c001095c:       93a00000        movls   r0, #0
  c0010960:       83a00001        movhi   r0, #1
  c0010964:       e12fff1e        bx      lr

so I've opted to leave it as I have currently implemented it.

Comments welcome,

Will


Will Deacon (4):
  ARM: mm: use pteval_t to represent page protection values
  ARM: mm: don't use the access flag permissions mechanism for classic
    MMU
  ARM: mm: introduce L_PTE_VALID for page table entries
  ARM: mm: introduce present, faulting entries for PAGE_NONE

 arch/arm/include/asm/pgtable-2level.h |    2 ++
 arch/arm/include/asm/pgtable-3level.h |    4 +++-
 arch/arm/include/asm/pgtable.h        |   10 ++++------
 arch/arm/mm/mmu.c                     |    2 +-
 arch/arm/mm/proc-macros.S             |    4 ++++
 arch/arm/mm/proc-v7-2level.S          |   10 +++++++---
 arch/arm/mm/proc-v7-3level.S          |    5 ++++-
 7 files changed, 25 insertions(+), 12 deletions(-)

-- 
1.7.4.1
