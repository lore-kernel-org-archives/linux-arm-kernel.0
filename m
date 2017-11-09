From: philip@cog.systems (Philip Derrin)
Date: Thu,  9 Nov 2017 11:41:42 +1100
Subject: [PATCH 0/2] STRICT_KERNEL_RWX weakened on ARM by CONFIG_ARM_LPAE=y
Message-ID: <20171109004144.2246-1-philip@cog.systems>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series fixes a bug which makes CONFIG_STRICT_KERNEL_RWX ineffective
when CONFIG_ARM_LPAE is enabled. Specifically, the kernel text and rodata are
mapped writeable. This has been the case since DEBUG_RODATA for ARM was first
merged in 3.19.

The cause was an incorrect conflict resolution in 1e3479225acb ("ARM: 8275/1:
mm: fix PMD_SECT_RDONLY undeclared compile error") between the commit that
implemented DEBUG_RODATA, 80d6b0c2eed2 ("ARM: mm: allow text and rodata
sections to be read-only"), and another that moved the LPAE read-only bit into
a software bit, ded947798469 ("ARM: 8109/1: mm: Modify pte_write and pmd_write
logic for LPAE").

The incorrect mappings were not apparent in the debugfs kernel_page_tables
dump because that was checking only the software RO bit, not the hardware RO
bit.

Regards,
Philip


Philip Derrin (2):
  ARM: mm: make STRICT_KERNEL_RWX effective for LPAE
  ARM: mm: dump: check hardware RO bit for LPAE

 arch/arm/mm/dump.c | 4 ++--
 arch/arm/mm/init.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.15.0
