From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Mon, 25 May 2015 01:00:31 +0900
Subject: [RFC PATCH 0/2] vmalloc based thread_info allocator
Message-ID: <1432483231-23061-1-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 kernel tries to get physically contiguous 16KB for thread_info
when creating a process. The allocation is sometimes failed on low
memory platforms due to memory fragmentation, not a lack of free memory.

The first approach is to improve memory compaction logic, but the work should
consider a lot of different factors and scenarios. Instead, Sungjinn Chung
suggests a vmalloc based thread_info allocator which can address the issue
by memory fragmentation without touching any internal memory management codes.

The patches implement the idea as allocating the memory from vmalloc space
instead of 1:1 mapping area. The idea is accompanied by another observation:
vmalloc space is large enough to handle allocation request on ARM64 kernel.
It is ~240GB under a combination of 39-bit VA and 4KB page.

If a 64-bit kernel with low system memory is not an unusual option on other
architectures, the idea could be expaneded into them.

All works are based on the following branch:
https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core

Any feedback or comment very welcome!

Thanks in advance!

Jungseok Lee (2):
  kernel/fork.c: add a function to calculate page address from
    thread_info
  arm64: Implement vmalloc based thread_info allocator

 arch/arm64/Kconfig                   | 12 ++++++++++++
 arch/arm64/include/asm/thread_info.h |  9 +++++++++
 arch/arm64/kernel/process.c          |  7 +++++++
 kernel/fork.c                        |  7 ++++++-
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
1.9.1
