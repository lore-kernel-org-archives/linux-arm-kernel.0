From: jean.pihet@linaro.org (Jean Pihet)
Date: Mon, 20 Jan 2014 22:21:59 +0100
Subject: [RFC PATCH 0/3] Add support for dwarf compat mode unwinding
Message-ID: <1390252922-25889-1-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case of unwinding the debug info from a binary that has a different
address size than the current native platform, it is needed to record
it in the address space struct, in order to correctly parse the debug
info later. This mode is known as compat mode.

This is the case when e.g. profiling an ARMv7 binary that runs on an
ARMv8 (aka AARCH64) platform.

Depending on the target binary address size, loading and parsing of the
dwarf debug info and unwinding of the recorded stack frame must be
performed accordingly.

Tested dwarf local unwinding on ARMv8 (aka AARCH64) with ARMv7 and
ARMv8 binaries; and natively on X86_64.

Note:
- this series is an RFC, although tested OK on ARMv7, ARMv8 and x86_64,
- only local unwinding has been tested,
- retrieval of the next ip and frame pointer is performed using a
  native read followed by a cast to the desired target address size.


Jean Pihet (3):
  Add support for different binary target address sizes
  Dwarf: load and parse the debug info of different target address
    sizes
  Dwarf: unwind the recorded stack frame of different target address
    sizes

 include/libunwind_i.h              |   7 ++
 include/tdep-aarch64/libunwind_i.h |   1 +
 include/tdep-arm/libunwind_i.h     |   1 +
 include/tdep-hppa/libunwind_i.h    |   1 +
 include/tdep-ia64/libunwind_i.h    |   1 +
 include/tdep-mips/libunwind_i.h    |   1 +
 include/tdep-ppc32/libunwind_i.h   |   1 +
 include/tdep-ppc64/libunwind_i.h   |   1 +
 include/tdep-sh/libunwind_i.h      |   1 +
 include/tdep-x86/libunwind_i.h     |   1 +
 include/tdep-x86_64/libunwind_i.h  |   1 +
 src/dwarf/Gfde.c                   |  25 +++--
 src/dwarf/Gfind_proc_info-lsb.c    | 194 +++++++++++++++++++++++++++++--------
 src/dwarf/Gparser.c                |  27 ++++++
 14 files changed, 214 insertions(+), 49 deletions(-)

-- 
1.7.11.7
