From: yaojun8558363@gmail.com (Jun Yao)
Date: Tue, 17 Jul 2018 17:56:02 +0800
Subject: [PATCH v4 0/6] arm64/mm: Move {idmap_pg_dir,swapper_pg_dir} to
Message-ID: <20180717095608.11008-1-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 4 changes:
	1. Rename INIT_DIR to INIT_PG_TABLES and move it outside the
	   '.init.data' section[1].
	2. Move the 'count' calculation to clear_pages()[1].
	3. Rearrange register in __enable_mmu() and pass ttbr1 through
	   the x1 register[2].
	4. Add commit message to explain why we can make swapper_pg_dir
	   smaller[3].
	5. Rewrite in_swapper_pgdir() and use pgd_set_fixmap() to
	   populate swapper_pg_dir. At the same time, add a spin lock to
	   avoid race conditions[4].
	6. Move {idmap_pg_dir,tramp_pg_dir,reserved_ttbr0,swapper_pg_dir}
	   to the KERNEL_PG_TABLES macro. And put this macro after
	   NOTES[4].

v3: https://www.spinics.net/lists/arm-kernel/msg662537.html
v2: https://patchwork.kernel.org/patch/10485641/
v1: https://patchwork.kernel.org/patch/10476595/

[1] https://lkml.org/lkml/2018/7/6/238
[2] https://lkml.org/lkml/2018/7/6/239
[3] https://lkml.org/lkml/2018/7/6/243
[4] https://lkml.org/lkml/2018/7/11/782

Jun Yao (6):
  arm64/mm: Introduce init_pg_dir
  arm64/mm: Make __enable_mmu() take the ttbr1 page as an argument
  arm64/mm: Create initial page tables in init_pg_dir
  arm64/mm: Make swapper_pg_dir smaller
  arm64/mm: Populate swapper_pg_dir by fixmap
  arm64/mm: Move {idmap_pg_dir, swapper_pg_dir} to .rodata section

 arch/arm64/include/asm/assembler.h | 29 +++++++++++++
 arch/arm64/include/asm/pgtable.h   | 66 ++++++++++++++++++++++++++----
 arch/arm64/kernel/head.S           | 45 ++++++++++++--------
 arch/arm64/kernel/setup.c          |  1 +
 arch/arm64/kernel/sleep.S          |  1 +
 arch/arm64/kernel/vmlinux.lds.S    | 47 ++++++++++++++-------
 arch/arm64/mm/mmu.c                | 34 +++------------
 7 files changed, 154 insertions(+), 69 deletions(-)

-- 
2.17.1
