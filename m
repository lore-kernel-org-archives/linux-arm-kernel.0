From: will.deacon@arm.com (Will Deacon)
Date: Mon,  5 Feb 2018 15:34:15 +0000
Subject: [PATCH 0/9] Mitigations against spectre-v1 in the arm64 Linux kernel
Message-ID: <1517844864-15887-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series implements some mitigations against spectre-v1 for arm64. It
broadly follows the work that has been done for x86, by implementing:

  * A back-end version of array_index_mask_nospec() to suppress any
    compiler optimisations that could introduce unwanted speculative
    paths

  * Masking of the syscall number to restrict speculation through the
    syscall table

  * Masking of __user pointers prior to deference in uaccess routines

The latter introduces complications in access_ok and set_fs which are
also handled in this series.

Cheers,

Will

--->8

Robin Murphy (3):
  arm64: Implement array_index_mask_nospec()
  arm64: Make USER_DS an inclusive limit
  arm64: Use pointer masking to limit uaccess speculation

Will Deacon (6):
  arm64: barrier: Add CSDB macros to control data-value prediction
  arm64: entry: Ensure branch through syscall table is bounded under
    speculation
  arm64: uaccess: Prevent speculative use of the current addr_limit
  arm64: uaccess: Don't bother eliding access_ok checks in
    __{get,put}_user
  arm64: uaccess: Mask __user pointers for __arch_{clear,copy_*}_user
  arm64: futex: Mask __user pointers prior to dereference

 arch/arm64/include/asm/assembler.h |  18 +++++
 arch/arm64/include/asm/barrier.h   |  22 ++++++
 arch/arm64/include/asm/futex.h     |   9 ++-
 arch/arm64/include/asm/processor.h |   3 +
 arch/arm64/include/asm/uaccess.h   | 155 +++++++++++++++++++++++++------------
 arch/arm64/kernel/arm64ksyms.c     |   4 +-
 arch/arm64/kernel/entry.S          |   6 +-
 arch/arm64/lib/clear_user.S        |   6 +-
 arch/arm64/lib/copy_in_user.S      |   5 +-
 arch/arm64/mm/fault.c              |   4 +-
 10 files changed, 170 insertions(+), 62 deletions(-)

-- 
2.1.4
