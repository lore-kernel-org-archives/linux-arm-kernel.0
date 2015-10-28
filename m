From: avanbrunt@nvidia.com (Alex Van Brunt)
Date: Wed, 28 Oct 2015 14:43:54 -0700
Subject: [PATCH 0/3] Revert arm64 cache geometry
Message-ID: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset reverts three patches that attempt to query the CPU for cache
geometry and then make use of that information. Those patches rely on the
NumSets and LineSize fields of CCSIDR to determine the cache geometry. However,
the architectural documentation for these registers forbids such use:

	The parameters NumSets, Associativity, and LineSize in these registers
	define the architecturally visible parameters that are required for the
	cache maintenance by Set/Way instructions. They are not guaranteed to
	represent the actual microarchitectural features of a design. You cannot
	make any inference about the actual sizes of caches based on these
	parameters.

It is not just theoretical. For example, the Denver CPU will report one set and
one way in CCSIDR even though the actual microarchitectural implementation has
many sets and many ways.

I have two suggestions for how to get the cache geometry on an ARMv8 processor:
  1. Specify the information in the device tree. The purpose of the deivce tree
     is to specify information that software cannot query at run-time. Becuase
     the architecture does not have an architectural way to query the cache
     geometry this may be a good fit.
  2. Add a function pointer to cpu_table that gives a implementation specific
     way to query the cache geometry. For an A57, for example, the function
     could read the CCSIDR register because it happens to report the
     microarchitectural geometry. The Denver CPU has implementation defined
     registers that can be used to determine the microarchitectural geometry.
     However, the implementation for the default "AArch64 Processor", must
     return an error.

The only place that the cache geometry is used is to determine if there can be
aliasing for a VIPT (virtually-indexed, physically-tagged) instruction cache.
The code assumes that there is no need to flush the entire instruction cache
if the size of a cache set is less than or equal to a page size. However, the
architectural definition of VIPT says "The only architecturally-guaranteed way
to invalidate all aliases of a physical address from a VIPT instruction cache
is to invalidate the entire instruction cache." Not only are the parameters not
guaranteed to be correct, it is explicitly not legal to ignore aliasing even if
the parameters were correct.

Alex Van Brunt (3):
  Revert "arm64: kernel: add support for cpu cache information"
  Revert "arm64: don't flag non-aliasing VIPT I-caches as aliasing"
  Revert "arm64: add helper functions to read I-cache attributes"

 arch/arm64/include/asm/cachetype.h |  37 -----------
 arch/arm64/kernel/Makefile         |   2 +-
 arch/arm64/kernel/cacheinfo.c      | 128 -------------------------------------
 arch/arm64/kernel/cpuinfo.c        |  16 +----
 4 files changed, 3 insertions(+), 180 deletions(-)
 delete mode 100644 arch/arm64/kernel/cacheinfo.c

-- 
2.1.4
