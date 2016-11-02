From: labbott@redhat.com (Laura Abbott)
Date: Wed,  2 Nov 2016 15:00:48 -0600
Subject: [PATCHv2 0/6] CONFIG_DEBUG_VIRTUAL for arm64
Message-ID: <20161102210054.16621-1-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v2 of the series to add CONFIG_DEBUG_VIRTUAL support from arm64. This
has been split out into a number of patches:

Patch #1 Adds ARCH_HAS_DEBUG_VIRTUAL to avoid the need for adding arch
dependencies for DEBUG_VIRTUAL. This touches arch/x86/Kconfig

Patch #2 Cleans up cma to not rely on __pa_nodebug and have an #ifdef inline
in the function.

Patch #3 Adjust some macros in arm64 memory.h to be under __ASSEMBLY__
protection

Patch #4 Adds a cast for virt_to_pfn since __virt_to_phys for DEBUG_VIRTUAL no
longer has a cast.

Patch #5 Switches to using __pa_symbol for _end to avoid erroneously triggering
a bounds error with the debugging.

Patch #6 is the actual implementation of DEBUG_VIRTUAL. The biggest change from
the RFCv1 is the addition of __phys_addr_symbol. This is to handle several
places where the physical address of _end is needed. x86 avoids this problem by
doing its bounds check based on the entire possible image space which is well
beyond where _end would end up.

There are a few dependencies outside of arm64, so I don't know if
it will be easier for this to eventually go through arm64 or the mm tree.

Thanks,
Laura




Laura Abbott (6):
  lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
  mm/cma: Cleanup highmem check
  arm64: Move some macros under #ifndef __ASSEMBLY__
  arm64: Add cast for virt_to_pfn
  arm64: Use __pa_symbol for _end
  arm64: Add support for CONFIG_DEBUG_VIRTUAL

 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/memory.h | 50 ++++++++++++++++++++++++-----------------
 arch/arm64/mm/Makefile          |  2 ++
 arch/arm64/mm/init.c            |  4 ++--
 arch/arm64/mm/physaddr.c        | 34 ++++++++++++++++++++++++++++
 arch/x86/Kconfig                |  1 +
 lib/Kconfig.debug               |  5 ++++-
 mm/cma.c                        | 15 +++++--------
 8 files changed, 79 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm64/mm/physaddr.c

-- 
2.10.1
