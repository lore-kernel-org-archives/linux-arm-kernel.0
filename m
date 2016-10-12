From: labbott@redhat.com (Laura Abbott)
Date: Wed, 12 Oct 2016 15:31:58 -0700
Subject: [PATCHv2 0/4] WX checking for arm64
Message-ID: <1476311522-15381-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v2 of the implementation to check for writable and executable pages on
arm64.

Major changes since v1:
- I realized my concerns about initialization and registration were unfounded
  so registration to register page tables with debugfs is simplified.
- New patch to remove max_addr since it was pointed out it was unused.
- Rebased to include changes for the EFI page tables as well.
- Checking is now only done on the init_mm page tables. It was mentioned that
  we should check the hyp page tables as well but that can be follow on work.
- Checking for UXN per suggestion from Mark Rutland.

Laura Abbott (4):
  arm64: dump: Make ptdump debugfs a separate option
  arm64: dump: Make the page table dumping seq_file optional
  arm64: dump: Remove max_addr
  arm64: dump: Add checking for writable and exectuable pages

 arch/arm64/Kconfig.debug           | 34 ++++++++++++++-
 arch/arm64/include/asm/ptdump.h    | 22 +++++++---
 arch/arm64/mm/Makefile             |  3 +-
 arch/arm64/mm/dump.c               | 89 ++++++++++++++++++++++++++------------
 arch/arm64/mm/mmu.c                |  2 +
 arch/arm64/mm/ptdump_debugfs.c     | 31 +++++++++++++
 drivers/firmware/efi/arm-runtime.c |  5 +--
 7 files changed, 147 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/mm/ptdump_debugfs.c

-- 
2.7.4
