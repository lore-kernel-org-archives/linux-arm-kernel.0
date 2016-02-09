From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  9 Feb 2016 16:13:45 +0100
Subject: [PATCH v4 0/3] kallsyms: remove special handling for CONFIG_ARM
Message-ID: <1455030828-6416-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kallsyms symbol address table generation contains a workaround for
CONFIG_ARM to address an issue with perf when it sees symbols whose
addresses are close to 0x0. The workaround is only enabled if XIP_KERNEL=n,
not because the issue itself only exists in that case, but because the
chosen workaround cannot deal with [_stext,_etext] living below PAGE_OFFSET.

So let's fix this properly, by emitting the stubs symbols at a more reasonable
offset, which is more likely to be the actual location of the vectors and stubs
sections at runtime, and will prevent the symbols from being mistaken for
userland symbols by perf.

Changes since v3:
- rebased onto -next, which contains a patch that moves the XIP handling to a
  separate linker script (patch #1)
  
Changes since v2:
- Move back to the original arrangement, where .stubs follows .vectors, and both
  are emitted outside of the ordinary kernel VMA space
- Move .vectors and .stubs sections to VMA 0xffff0000/0xffff1000, respectively.
  As Russell pointed out, this is the most reasonable value, since modern CPUs
  actually execute the vectors and stubs from there, and it fixes the kallsyms
  perf issue all the same.
- Rebased onto latest -next, which contains related ARM patch 8514/1, and
  updated kallsyms base relative patches (queued via akpm's tree)

Changes since v1:
- added Nico's ack
- use PROVIDE() for vector_fiq_offset since vector_fiq itself is not always
  defined
- put __stubs_start/_end inside the section definition so that the value of the
  start symbol equals the start of the section after alignment (fixes an issue
  on XIP spotted by Chris)

Patch #1 moves the .stubs and .vectors section back into the kernel VMA, while
preserving the guaranteed virtual offset of 4 KB. This results in all symbols
that kallsyms sees to be in a reasonable interval.

Patch #2 removes the special case for CONFIG_ARM && !CONFIG_XIP_KERNEL in the
invocation of scripts/kallsyms

Patch #3 removes the now unused --page-offset command line argument handling
from scripts/kallsyms.c

Ard Biesheuvel (3):
  ARM: move .vectors and .stubs sections back into the kernel VMA
  kallsyms: remove special lower address limit for CONFIG_ARM
  kallsyms: remove --page-offset command line option

 arch/arm/kernel/entry-armv.S      | 3 +--
 arch/arm/kernel/vmlinux-xip.lds.S | 6 ++++--
 arch/arm/kernel/vmlinux.lds.S     | 6 ++++--
 scripts/kallsyms.c                | 8 --------
 scripts/link-vmlinux.sh           | 4 ----
 5 files changed, 9 insertions(+), 18 deletions(-)

-- 
2.5.0
