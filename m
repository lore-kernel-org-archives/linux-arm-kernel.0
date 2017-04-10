From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 11 Apr 2017 01:35:01 +0400
Subject: [RFC PATCH 0/3] arm64: queued spinlocks and rw-locks
Message-ID: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch of Jan Glauber enables queued spinlocks on arm64. I rebased it on
latest kernel sources, and added a couple of fixes to headers to apply it 
smoothly.

Though, locktourture test shows significant performance degradation in the
acquisition of rw-lock for read on qemu:

                          Before           After
spin_lock-torture:      38957034        37076367         -4.83
rw_lock-torture W:       5369471        18971957        253.33
rw_lock-torture R:       6413179         3668160        -42.80

I'm  not much experienced in locking, and so wonder how it's possible that
simple switching to generic queued rw-lock causes so significant performance
degradation, while in theory it should improve it. Even more, on x86 there
are no such problems probably.

I also think that patches 1 and 2 are correct and useful, and should be applied
anyway.

Any comments appreciated.

Yury.

Jan Glauber (1):
  arm64/locking: qspinlocks and qrwlocks support

Yury Norov (2):
  kernel/locking: #include <asm/spinlock.h> in qrwlock.c
  asm-generic: don't #include <linux/atomic.h> in qspinlock_types.h

 arch/arm64/Kconfig                      |  2 ++
 arch/arm64/include/asm/qrwlock.h        |  7 +++++++
 arch/arm64/include/asm/qspinlock.h      | 20 ++++++++++++++++++++
 arch/arm64/include/asm/spinlock.h       | 12 ++++++++++++
 arch/arm64/include/asm/spinlock_types.h | 14 +++++++++++---
 include/asm-generic/qspinlock.h         |  1 +
 include/asm-generic/qspinlock_types.h   |  8 --------
 kernel/locking/qrwlock.c                |  1 +
 8 files changed, 54 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/qrwlock.h
 create mode 100644 arch/arm64/include/asm/qspinlock.h

-- 
2.7.4
