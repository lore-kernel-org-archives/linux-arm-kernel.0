From: Dave.Martin@arm.com (Dave Martin)
Date: Fri,  9 Sep 2016 15:15:41 +0100
Subject: [RFC PATCH 0/5] arm64: Signal context expansion
Message-ID: <1473430576-20792-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for supporting the ARM Scalable Vector Extension in the
Linux kernel, it is necessary to be able to save more data in the signal
frame than can be accommodated in the existing arm64 signal frame
structure.


To minimise ABI impact the current structures are retained as-is, and a
new extra_context record is defined, which (if present) declares some
additional space beyond the standard arm64 signal frame.

This new record can be added in sigframe.__reserved[] if there is a
need to allocate extra space beyond the standard signal frame.  The
extra block of memory referenced by extra_context can then be parsed in
the same way as sigcontext.__reserved[].  Old code should just ignore
the whole thing as an unrecognised record.  To maintain backward
compatibility, signal context records defined today are always placed
directly in __reserved[], never in the block referenced by
extra_context.

This series also does some refactoring in order to make it easier to add
records to the signal frame in the future, using the new expansion
mechanism.  The extra_context mechanism is hidden behind a simple
allocator that grows and signal frame only as needed.


Note: this series makes rt_sigreturn somewhat stricter about parsing the
signal frame than previously: violators will be SEGV'd.  This should
only be an ABI break for software that was doing something wrong in the
first place, but I'm open to suggestions if people have concerns about
it.


Dave Martin (5):
  arm64: signal: Refactor sigcontext parsing in rt_sigreturn
  arm64: signal: factor frame layout and population into separate passes
  arm64: signal: factor out signal frame record allocation
  arm64: signal: Allocate extra sigcontext space as needed
  arm64: signal: Parse extra_context during sigreturn

 arch/arm64/include/uapi/asm/sigcontext.h |  27 +++
 arch/arm64/kernel/signal.c               | 355 ++++++++++++++++++++++++++++---
 2 files changed, 350 insertions(+), 32 deletions(-)

-- 
2.1.4
