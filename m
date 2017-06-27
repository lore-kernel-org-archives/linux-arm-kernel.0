From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 27 Jun 2017 18:04:05 +0100
Subject: [RFC PATCH v2 0/2] ARM: Fix unparseable signal frame with
 CONFIG_IWMMXT
Message-ID: <1498583067-14178-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since RFC v1:

 * Emit a dummy block instead of omitting ixmmxt_sigframe.
   A new magic, DUMMY_MAGIC, is defined for this purpose.

 * Optionally consume the dummy block on sigreturn, but don't maintain
   it in case some userspace is crafting its own sigframes.

Limited manual testing, but not tested on iWMMXt hardware so far.


Original blurb:

In kernels with CONFIG_IWMMXT=y running on non-iWMMXt hardware, the
signal frame can be left partially uninitialised in such a way
that userspace cannot parse uc_regspace[] safely.  In particular,
this means that the VFP registers cannot be located reliably in the
signal frame when a multi_v7_defconfig kernel is run on the
majority of platforms.

I don't know whether any userspace has implemented any sort of
workaround for this, but the ABI by itself is insufficient anyway.

This series attempts to omit the spurious iWMMXt record when
appropriate.

Not extensively tested, and the ABI impact is unknown for now.

Dave Martin (2):
  ARM: iwmmxt: Add missing __user annotations to sigframe accessors
  ARM: signal: Fix unparseable iwmmxt_sigframe in uc_regspace[]

 arch/arm/include/asm/ucontext.h |  6 ++++
 arch/arm/kernel/signal.c        | 79 +++++++++++++++++++++++++++++++----------
 2 files changed, 67 insertions(+), 18 deletions(-)

-- 
2.1.4
