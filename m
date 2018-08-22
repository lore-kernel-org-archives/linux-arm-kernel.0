From: yaojun8558363@gmail.com (Jun Yao)
Date: Wed, 22 Aug 2018 17:54:26 +0800
Subject: [RESEND PATCH v4 0/6] arm64/mm: Move swapper_pg_dir to rodata
Message-ID: <20180822095432.12125-1-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The set_init_mm_pgd() is reimplemented using assembly in order to
avoid being instrumented by kasan.

Test following configs with CONFIG_RANDOMIZE_BASE/UNMAP_KERNEL_AT_EL0/
CONFIG_ARM64_SW_TTBR0_PAN/CONFIG_KASAN_OUTLINE enabled on qemu:

	1. CONFIG_ARM64_4K_PAGES/CONFIG_ARM64_VA_BITS_48
	2. CONFIG_ARM64_4K_PAGES/CONFIG_ARM64_VA_BITS_39
	3. CONFIG_ARM64_64K_PAGES/CONFIG_ARM64_VA_BITS_48
	4. CONFIG_ARM64_64K_PAGES/CONFIG_ARM64_VA_BITS_42

Jun Yao (6):
  arm64/mm: Introduce the init_pg_dir.
  arm64/mm: Pass ttbr1 as a parameter to __enable_mmu().
  arm64/mm: Create the initial page table in the init_pg_dir.
  arm64/mm: Create the final page table directly in swapper_pg_dir.
  arm64/mm: Populate the swapper_pg_dir by fixmap.
  arm64/mm: Move {idmap_pg_dir .. swapper_pg_dir} to rodata section.

 arch/arm64/include/asm/assembler.h | 29 +++++++++++++
 arch/arm64/include/asm/pgtable.h   | 66 ++++++++++++++++++++++++++----
 arch/arm64/kernel/head.S           | 48 ++++++++++++++--------
 arch/arm64/kernel/sleep.S          |  1 +
 arch/arm64/kernel/vmlinux.lds.S    | 47 ++++++++++++++-------
 arch/arm64/mm/mmu.c                | 45 ++++++++------------
 6 files changed, 168 insertions(+), 68 deletions(-)

-- 
2.17.1
