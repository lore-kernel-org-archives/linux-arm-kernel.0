From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Jun 2017 16:46:01 +0100
Subject: [RFC PATCH 0/2] ARM: Fix unparseable signal frame with CONFIG_IWMMXT
Message-ID: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
  ARM: signal: Remove unparseable iwmmxt_sigframe from uc_regspace[]

 arch/arm/include/asm/ucontext.h | 20 ----------------
 arch/arm/kernel/signal.c        | 52 +++++++++++++++++++++++++++--------------
 2 files changed, 35 insertions(+), 37 deletions(-)

-- 
2.1.4
