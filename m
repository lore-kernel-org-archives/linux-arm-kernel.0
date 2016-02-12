From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 12 Feb 2016 10:06:46 -0600
Subject: [PATCH 0/2] flag contiguous PTEs in linear mapping
Message-ID: <1455293208-6763-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a rebase of the previous contiguous ptes in linear map patches
on top of Mark Rutland's fixmap changes. Those changes appear to be sufficient
to allow this patch set to boot on JunoR2, seattle and the xgene/m400. I've
also done basic testing with RODATA turned on. In all cases with ACPI systems.

This patch also adds the ability to align 64k kernels on the 2M CONT boundary
which helps to assure that a number of the sections are completely mapped with
CONT bits. There remain a number of holes due to smaller remapping operations
that don't really affect the page protection states. That can be worked around
in a number of cases if the code gets smart enough to detect that the break
doesn't result in an actual change in permissions. Some of these are visible
in the included example where its not initially obvious why a contigious 2M
region isn't marked as such until digging into it.

With 64k pages, and section alignment enabled the kernel looks like:
---[ Kernel Mapping ]---
0xfffffe0000000000-0xfffffe0000200000           2M     RW NX SHD AF    CON     UXN MEM/NORMAL
0xfffffe0000200000-0xfffffe0001200000          16M     ro x  SHD AF    CON     UXN MEM/NORMAL
0xfffffe0001200000-0xfffffe0001400000           2M     RW NX SHD AF    CON     UXN MEM/NORMAL
0xfffffe0001400000-0xfffffe0001600000           2M     RW NX SHD AF            UXN MEM/NORMAL
0xfffffe0001600000-0xfffffe0002600000          16M     RW NX SHD AF    CON     UXN MEM/NORMAL
0xfffffe0002600000-0xfffffe0002800000           2M     RW NX SHD AF            UXN MEM/NORMAL
0xfffffe0002800000-0xfffffe0020000000         472M     RW NX SHD AF    CON     UXN MEM/NORMAL
0xfffffe0020000000-0xfffffe0060000000           1G     RW NX SHD AF        BLK UXN MEM/NORMAL
0xfffffe00600f0000-0xfffffe0060200000        1088K     RW NX SHD AF            UXN MEM/NORMAL
0xfffffe0060200000-0xfffffe0076400000         354M     RW NX SHD AF    CON     UXN MEM/NORMAL
0xfffffe0076400000-0xfffffe0076600000           2M     RW NX SHD AF            UXN MEM/NORMAL
0xfffffe0076600000-0xfffffe0078e00000          40M     RW NX SHD AF    CON     UXN MEM/NORMAL
0xfffffe00793b0000-0xfffffe0079400000         320K     RW NX SHD AF            UXN MEM/NORMAL
0xfffffe0079400000-0xfffffe007e200000          78M     RW NX SHD AF    CON     UXN MEM/NORMAL
0xfffffe007e200000-0xfffffe007e3d0000        1856K     RW NX SHD AF            UXN MEM/NORMAL
0xfffffe007e420000-0xfffffe007e600000        1920K     RW NX SHD AF            UXN MEM/NORMAL
0xfffffe007e600000-0xfffffe007f000000          10M     RW NX SHD AF    CON     UXN MEM/NORMAL
0xfffffe0800000000-0xfffffe0980000000           6G     RW NX SHD AF        BLK UXN MEM/NORMAL

With 4k pages
---[ Kernel Mapping ]---
0xffffffc000000000-0xffffffc000200000           2M     RW NX SHD AF        BLK UXN MEM/NORMAL
0xffffffc000200000-0xffffffc001200000          16M     ro x  SHD AF        BLK UXN MEM/NORMAL
0xffffffc001200000-0xffffffc001400000           2M     RW NX SHD AF        BLK UXN MEM/NORMAL
0xffffffc001400000-0xffffffc0015c0000        1792K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc0015c0000-0xffffffc0015d0000          64K     RW NX SHD AF            UXN MEM/NORMAL
0xffffffc0015d0000-0xffffffc001600000         192K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc001600000-0xffffffc002600000          16M     RW NX SHD AF        BLK UXN MEM/NORMAL
0xffffffc002600000-0xffffffc002620000         128K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc002620000-0xffffffc002630000          64K     RW NX SHD AF            UXN MEM/NORMAL
0xffffffc002630000-0xffffffc002800000        1856K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc002800000-0xffffffc060000000        1496M     RW NX SHD AF        BLK UXN MEM/NORMAL
0xffffffc0600f0000-0xffffffc060200000        1088K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc060200000-0xffffffc076400000         354M     RW NX SHD AF        BLK UXN MEM/NORMAL
0xffffffc076400000-0xffffffc076590000        1600K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc076590000-0xffffffc076595000          20K     RW NX SHD AF            UXN MEM/NORMAL
0xffffffc076596000-0xffffffc0765a0000          40K     RW NX SHD AF            UXN MEM/NORMAL
0xffffffc0765a0000-0xffffffc076600000         384K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc076600000-0xffffffc078e00000          40M     RW NX SHD AF        BLK UXN MEM/NORMAL
0xffffffc0793b0000-0xffffffc079400000         320K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc079400000-0xffffffc07e200000          78M     RW NX SHD AF        BLK UXN MEM/NORMAL
0xffffffc07e200000-0xffffffc07e3d0000        1856K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc07e420000-0xffffffc07e600000        1920K     RW NX SHD AF    CON     UXN MEM/NORMAL
0xffffffc07e600000-0xffffffc07f000000          10M     RW NX SHD AF        BLK UXN MEM/NORMAL
0xffffffc800000000-0xffffffc980000000           6G     RW NX SHD AF        BLK UXN MEM/NORMAL

Jeremy Linton (2):
  arm64: mm: Enable CONT_SIZE aligned sections for 64k page kernels.
  arm64: Mark kernel page ranges contiguous

 arch/arm64/Kconfig.debug        | 12 ++++----
 arch/arm64/kernel/vmlinux.lds.S | 11 +++----
 arch/arm64/mm/mmu.c             | 64 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 70 insertions(+), 17 deletions(-)

-- 
2.4.3
