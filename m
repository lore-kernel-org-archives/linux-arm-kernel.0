From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 13 Apr 2011 10:56:35 +0100
Subject: [PATCH v4 REPOST 0/2] ARM: ptrace: migrate to regsets and enable VFP
	coredumps
Message-ID: <1302688597-2969-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Final call for comments on this series.
* 
* The relevant gdb/bfd changes have been implemented by Ulrich
* Weigand and posted upstream, here:
* http://comments.gmane.org/gmane.comp.gnu.binutils/53050


The VFP register state is currently missing from coredumps.

Rather than adding extra arch-specific code to handle this,
migrating to use the regsets framework and implementing a regset
for the VFP registers allows this state to be dumped automatically,
as well as simplifying some aspects of the ptrace implementation.

Dumping of other extension state could also be built
straightforwardly on the same framework, though I don't attempt
to implement that here.

In principle, we should be able to enable the generic
PTRAGE_GETREGSET/PTRAGE_SETREGSET calls too, but strangely
these are #ifdef'd on CONFIG_HAVE_ARCH_TRACEHOOK (which we don't
currently have).  CORE_DUMP_USE_REGSET might be more appropriate.
I'll raise this question separately on lkml.

v2: Move the new note definition to the customary global
    include/linux/elf.h

v3: Explicitly ensure the size of the VFP state dump is 0x104
    bytes, instead just relying on sizeof(struct user_vfp) which
    is larger due to trailing padding.  This avoids transferring
    too much data in the net PTRACE_GET/SETVFPREGS calls, as well
    as matching the coredump contents to the old ptrace payload.

v4: Correct the definition of ARM_VFPREGS_SIZE: there are 32
    *8*-byte registers, not 32 4-byte registers.

    Thanks to Will for spotting that one quickly...
   
Dave Martin (2):
  ARM: ELF: Define new core note type for VFP registers
  ARM: ptrace: Migrate to regsets framework

 arch/arm/include/asm/elf.h    |    1 +
 arch/arm/include/asm/ptrace.h |    6 +
 arch/arm/kernel/ptrace.c      |  348 ++++++++++++++++++++++++++++-------------
 include/linux/elf.h           |    1 +
 4 files changed, 247 insertions(+), 109 deletions(-)
