From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Wed,  3 May 2017 16:37:44 +0100
Subject: [PATCH v2 0/4] arm64: improve tagged pointer handling
Message-ID: <1493825868-30872-1-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some patches to fix a few issues related to tagged pointer
handling.

Tagged pointers from userspace can end up in the kernel in a number of
ways. I most likely have not found all of them, but they include at
least the following:

 - Passing tagged pointers in system call arguments. This would be a
   userspace bug, as documented in tagged-pointers.txt.

 - Through FAR_EL1 when we take a data abort or watchpoint exception.
   Watchpoint handling is currently broken if we get a tagged pointer,
   patch #2 in this series fixes it. We already do the right thing for
   data aborts but patch #3 tries to improve on it a little.

 - Reading a tagged pointer from a GPR when trapping and emulating
   instructions, e.g. cache maintenance or uprobes. Patch #1 fixes the
   cache maintenance case.

 - The user stack pointer, frame pointer (x29), frame records, and link
   register (x30) can contain tagged pointers. Patch #4 documents that
   some kernel features do not currently work with tagged pointers in
   the first three of these.

 - A tagged pointer can end up in the PC on an illegal exception return
   (see D4.1.4 ARMARM A.k_iss10775), and from there in ELR on exception
   entry. As I understand it, this can only be caused by a bad eret at
   EL1 or a bad debug state exit by an external debugger, so only by a
   bug in Linux/firmware or the external debugger. So I don't think we
   need to handle this.

Note that the above applies to Linux only. I have spoken to Marc Zyngier
about KVM, and so far he hasn't found any problems there.

Thanks,
Kristina

v2:
 - Patch #3: changed clear_address_tag macro arguments, swapped bic and
   tst


Kristina Martsenko (4):
  arm64: traps: fix userspace cache maintenance emulation on a tagged
    pointer
  arm64: hw_breakpoint: fix watchpoint matching for tagged pointers
  arm64: entry: improve data abort handling of tagged pointers
  arm64: documentation: document tagged pointer stack constraints

 Documentation/arm64/tagged-pointers.txt | 62 +++++++++++++++++++++++++--------
 arch/arm64/include/asm/asm-uaccess.h    |  9 +++++
 arch/arm64/include/asm/uaccess.h        |  6 ++--
 arch/arm64/kernel/entry.S               |  5 +--
 arch/arm64/kernel/hw_breakpoint.c       |  3 ++
 arch/arm64/kernel/traps.c               |  4 +--
 6 files changed, 67 insertions(+), 22 deletions(-)

-- 
2.1.4
