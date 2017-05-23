From: panand@redhat.com (Pratyush Anand)
Date: Tue, 23 May 2017 10:32:07 +0530
Subject: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
Message-ID: <cover.1495514291.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
is around 13MB and initramfs is around 30MB. It takes more than 20 second
even when we have -O2 optimization enabled. However, if dcache is enabled
during purgatory execution then, it takes just a second in SHA
verification.

Therefore, these patches adds support for dcache enabling facility during
purgatory execution.

Changes since V2:
	- typo in name create_block_entry() fixed
	- moved shared definition between kexec and purgatory to a common
	  file.
	- MT_NORMAL as 0
	- PTRS_PER_*  and other calculation around pmd_index() etc have
	  been defined like in kernel
	- page table size has been kept for 5 tables, with comment about
	  expansion
	- Pass only virt address to create_block_entry() now
	- Addresses in kexec and purgatory domain have been defined as
	  host_addr_t and guest_addr_t respectively for clear code reading


Changes since V1:
	- Moved page table creation logic from purgatory to kexec code.
	- Only 4K page table is supported, with 48 bit VA and 2M block size
	- if platform supports a 4K page size, then D-cache is always
	  enabled now.
 

Pratyush Anand (2):
  kexec: arm64: create identity page table to be used in purgatory
  arm64: enable d-cache support during purgatory sha verification

 kexec/arch/arm64/kexec-arm64.c         | 119 +++++++++++++++
 kexec/arch/arm64/kexec-mmu.h           |  76 ++++++++++
 purgatory/arch/arm64/Makefile          |   1 +
 purgatory/arch/arm64/cache.S           | 264 +++++++++++++++++++++++++++++++++
 purgatory/arch/arm64/purgatory-arm64.c |   5 +
 5 files changed, 465 insertions(+)
 create mode 100644 kexec/arch/arm64/kexec-mmu.h
 create mode 100644 purgatory/arch/arm64/cache.S

-- 
2.9.3
