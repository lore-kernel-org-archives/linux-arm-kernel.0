From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 May 2013 12:31:23 +0100
Subject: [PATCH v2 0/4] Optimise cache-flushing system call
Message-ID: <1369395087-30972-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

This is a follow-on from the patches I originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/157810.html

but with some notable differences:

  - I've temporarily dropped the iovec system call while I try to work
    out a sane threshold value between flushing by line and nuking L1.

  - Added syscall restarting to address DoS issues raised by Catalin.

  - Added access_ok check now that vma searching code is removed.

  - Based on 3.10-rc2.

As per usual, all comments are welcome.

Cheers,

Will


Will Deacon (4):
  ARM: entry: allow ARM-private syscalls to be restarted
  ARM: cacheflush: split user cache-flushing into interruptible chunks
  ARM: cacheflush: don't round address range up to nearest page
  ARM: cacheflush: don't bother rounding to nearest vma

 arch/arm/include/asm/cacheflush.h  |  3 +-
 arch/arm/include/asm/thread_info.h | 11 +++++++
 arch/arm/kernel/entry-common.S     |  4 +--
 arch/arm/kernel/traps.c            | 64 +++++++++++++++++++++++++++++---------
 4 files changed, 63 insertions(+), 19 deletions(-)

-- 
1.8.2.2
