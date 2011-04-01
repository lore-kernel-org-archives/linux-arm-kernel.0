From: dave.martin@linaro.org (Dave Martin)
Date: Fri,  1 Apr 2011 17:21:26 +0100
Subject: [PATCH 0/2] ARM: ptrace: migrate to regsets and enable VFP coredumps
Message-ID: <1301674888-16842-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Dave Martin (2):
  ARM: ELF: Define new core note type for VFP registers
  ARM: ptrace: Migrate to regsets framework

 arch/arm/include/asm/elf.h |    3 +
 arch/arm/kernel/ptrace.c   |  348 ++++++++++++++++++++++++++++++--------------
 2 files changed, 242 insertions(+), 109 deletions(-)
