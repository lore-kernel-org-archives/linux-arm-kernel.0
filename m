From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 11 Dec 2016 18:26:39 +0530
Subject: [Question] New mmap64 syscall?
In-Reply-To: <20161210092130.GA19309@xo-6d-61-c0.localdomain>
Message-ID: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the draft of sys_mmap64() support in the kernel. For 64-bit
kernels everything is simple. For 32-bit kernels we have a problem.
pgoff_t is declared as unsigned long, and should be turned to 
unsigned long long. It affects the number of structures and interfaces.
Last patch does the change. It should be wide-tested on 32-bit kernels
whith I didn't do. Arm64 kernel is working with this patchset, and I don't
expect difficulties there.

Yury Norov (3):
  mm: move argument checkers of mmap_pgoff() to separated routine
  sys_mmap64()
  mm: turn page offset types to 64-bit

 fs/btrfs/extent_io.c              |  2 +-
 fs/ext2/dir.c                     |  4 +--
 include/linux/mm.h                |  9 +++---
 include/linux/radix-tree.h        |  8 ++---
 include/linux/syscalls.h          |  3 ++
 include/linux/types.h             |  2 +-
 include/uapi/asm-generic/unistd.h |  4 ++-
 lib/radix-tree.c                  |  8 ++---
 mm/debug.c                        |  2 +-
 mm/internal.h                     |  2 +-
 mm/memory.c                       |  4 +--
 mm/mmap.c                         | 66 ++++++++++++++++++++++++++++++++-------
 mm/readahead.c                    |  4 +--
 mm/util.c                         |  3 +-
 14 files changed, 85 insertions(+), 36 deletions(-)

-- 
2.7.4
