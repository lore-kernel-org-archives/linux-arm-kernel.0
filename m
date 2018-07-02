From: yaojun8558363@gmail.com (Jun Yao)
Date: Mon,  2 Jul 2018 19:16:54 +0800
Subject: [PATCH v3 0/5] Move {idmap_pg_dir,swapper_pg_dir} to .rodata
Message-ID: <20180702111659.25570-1-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 3 changes:
	As James Morse suggested[1], we split the old patch into 5
	patches:

	1. Introduce init_pg_dir.
	2. Make __enable_mmu() take the ttbr1 page as an argument.
	3. Create initial page tables in init_pg_dir and then create final
	   page tables in swapper_pg_dir directly.
	4. Make swapper_pg_dir smaller.
	5. Move {idmap_pg_dir, swapper_pg_dir} to .rodata section.

	At the same time, fix bugs mentioned in [1] and [2].

Special thanks to James Morse and Suzuki K Poulose. Without their help, I
couldn't write these patches.

v2: https://patchwork.kernel.org/patch/10485641/
v1: https://patchwork.kernel.org/patch/10476595/

[1] https://patchwork.kernel.org/patch/10485641/
[2] https://patchwork.kernel.org/patch/10485643/

Jun Yao (5):
  arm64/mm: Introduce init_pg_dir
  arm64/mm: Make __enable_mmu() take the ttbr1 page as an argument
  arm64/mm: Create initial page tables in init_pg_dir
  arm64/mm: Make swapper_pg_dir smaller
  arm64/mm: Move {idmap_pg_dir, swapper_pg_dir} to .rodata section

 arch/arm64/include/asm/assembler.h | 23 ++++++++++++++
 arch/arm64/include/asm/pgalloc.h   | 48 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable.h   | 17 ++++++-----
 arch/arm64/kernel/head.S           | 31 ++++++++++++++-----
 arch/arm64/kernel/setup.c          |  1 +
 arch/arm64/kernel/sleep.S          |  1 +
 arch/arm64/kernel/vmlinux.lds.S    | 29 ++++++++++++------
 arch/arm64/mm/mmu.c                | 32 +++-----------------
 8 files changed, 129 insertions(+), 53 deletions(-)

-- 
2.17.1
