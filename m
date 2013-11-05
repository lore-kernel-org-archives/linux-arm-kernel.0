From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon,  4 Nov 2013 18:16:02 -0800
Subject: [PATCH 0/3] follow up fixes for V7 big endian changes
Message-ID: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've tested a bit more big endian images from rmk/for-next
which has Ben's big endian series merged. I've run into several
issues while testing Pandaboard and Arndale. All three issues 
have fairly simple fix once detected.

Here is short explanation/note for each fix 

1) ARM: __fixup_smp read of SCU config should do byteswap in BE case
[1] introduced SCU read in __fixup_smp function in case of A9 cpu. 
Such read need byteswap in case of BE.

2) ARM: mm: fix __phys_to_virt to work with 64 bit phys_addr_t in BE case
[2] changed type of __phys_to_virt from 'unsigned long' to 'phys_addr_t' 
but that causes problem with inline assembler in __phys_to_virt function
that expects 'r' operand but gets 64 bit value. It is very similar to 
ASID issue [3]. Small test cases that illustrate inline asm and 64 bit
operand issue could be found in [4].

3) ARM: fix mov to mvn conversion in case of 64 bit phys_addr_t and BE
Conflict resolution between [5] and [6] was not entirely correct for 
the case when 'mov' instruction has to be converted into 'mvn'
instruction. I missed it in my previos testing because the issue manifests 
itself only if CONFIG_ARCH_PHYS_ADDR_T_64BIT is enabled, which was not,
and I saw this issue only when I got to Arndale testing. In proposed
patch I've fixed  this issue trying to push spirit of [6] and do it in
most optimized way. However personally, I think code could be much
readable if we just add instruction byteswap under ARM_BE8 after
read, and before write with common patch logic in between. After all, in
THUMB2 case few lines above code just do that. Please let me know if
folks like this idea better I can respin this fix.

Tests: boots and runs

TC2: LE/BE Thumb2/Non-Thumb2 (no LPAE, no ARCH_PHYS_ADDR_T_64BIT)
Pandaboard: LE/BE multiarch (non-thumb2)
Arndale: LE/BE Thumb2/Non-Thumb2 (with LPAE, with ARCH_PHYS_ADDR_T_64BIT,
no KVM, no MMC_DW_IDMAC)

For testing Arndale and Pandaboard BE BSP changes were used on top of
these patches.

References:

[1] bc41b8724f24b9a27d1dcc6c974b8f686b38d554 
ARM: 7846/1: Update SMP_ON_UP code to detect A9MPCore with 1 CPU devices

[2] ca5a45c06cd4764fb8510740f7fc550d9a0208d4 
ARM: mm: use phys_addr_t appropriately in p2v and v2p conversions

[3] a1af3474487cc3b8731b990dceac6b6aad7f3ed8
ARM: tlb: ASID macro should give 32bit result for BE correct operation

[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/202584.html

[5] f52bb722547f43caeaecbcc62db9f3c3b80ead9b
ARM: mm: Correct virt_to_phys patching for 64 bit physical addresses

[6] 2f9bf9beddb1649485b47302a5aba9761cbc9084
ARM: fixup_pv_table bug when CPU_ENDIAN_BE8

Victor Kamensky (3):
  ARM: __fixup_smp read of SCU config should do byteswap in BE case
  ARM: mm: fix __phys_to_virt to work with 64 bit phys_addr_t in BE case
  ARM: fix mov to mvn conversion in case of 64 bit phys_addr_t and BE

 arch/arm/include/asm/memory.h | 8 +++++++-
 arch/arm/kernel/head.S        | 7 ++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
1.8.1.4
