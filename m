From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  3 Feb 2016 20:04:53 +0100
Subject: [PATCH v2 0/4] kallsyms: remove special handling for CONFIG_ARM
Message-ID: <1454526297-5269-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series applies on top of today's -next, and addresses an issue with
the new kallsyms code that is queued there, that enables base relative
kallsyms tables for all architectures (except IA-64)

Two issues have surfaced on ARM with the new kallsyms code:
a) CONFIG_HAVE_TCM creates a virtual region that is too far away for the
   relative kallsyms code to reach it;
b) CONFIG_XIP_KERNEL=y kernel symbols are not filtered against PAGE_OFFSET,
   as is the case for kernels that execute from RAM, resulting in symbols
   that are out of range.

Since the way kallsyms deals with XIP kernels on ARM leaves some room for
improvement regardless of the base relative changes, this series proposes
a fix that allows the special case to be removed from the kallsyms handling
entirely.

Changes since v1:
- new patch #4 (optional, RFC)
- added Nico's ack to #1 - #3
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

Patch #4 is included as an RFC, it removes the magic constant 0x1000 which is
the offset between the start of the .vectors section and the start of the
.stubs section.

Note that we may still need to remove ARM from the list of architectures that
support base relative kallsyms tables if we cannot fix issue a) above, but
removing this special case seemed like an obvious improvement to me. Note the
a) is a pathological case where VMSPLIT_1G, KALLSYMS_ALL and HAVE_TCM are all
set.

Ard Biesheuvel (4):
  ARM: move .vectors and .stubs sections back into the kernel VMA
  kallsyms: remove special lower address limit for CONFIG_ARM
  kallsyms: remove --page-offset command line option
  ARM: use single definition for vectors-to-stubs section offset

 arch/arm/kernel/entry-armv.S  | 20 ++++++++++-----
 arch/arm/kernel/traps.c       |  4 ++-
 arch/arm/kernel/vmlinux.lds.S | 22 +++++++++++-----
 scripts/kallsyms.c            | 27 ++++----------------
 scripts/link-vmlinux.sh       |  4 ---
 5 files changed, 37 insertions(+), 40 deletions(-)

-- 
2.5.0
