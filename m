From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jun 2010 15:04:44 +0100
Subject: [PATCH 0/4] Fix atomic operations so that atomic64_test passes on ARM
	[V2]
Message-ID: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 2 of the patches originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/018742.html

There are quite a few changes, mainly because I now understand the compiler
bug I was hitting previously.

A recently introduced Kernel feature is the atomic64_test on boot.
ARM fails these tests because the compiler is not correctly informed about
updates occuring to memory and is at liberty to constant-fold atomic64_t
variables.

This patch series fixes some problems with the current atomic64 operations,
adds the correct memory constraints to all of the atomic operations and finally
enables all of the atomic64 tests for ARM. I had to speak with the GCC guys at
ARM to get the memory constraints right in patch 3/4. The problem with the "m"
constraint likely affects other parts of the Kernel, for example, kprobes-decode
seems to have multiple uses of an "m" operand within a single block of inline
asm.

Cc: Nigel Stephens <nigel.stephens@arm.com>
Cc: Nicolas Pitre <nico@fluxnic.net>

Will Deacon (4):
  ARM: atomic ops: fix register constraints for atomic64_add_unless
  ARM: atomic ops: reduce critical region in atomic64_cmpxchg
  ARM: atomic ops: add memory constraints to inline asm
  ARM: atomic64_test: add ARM as supported architecture

 arch/arm/include/asm/atomic.h |  132 ++++++++++++++++++++--------------------
 lib/atomic64_test.c           |    2 +-
 2 files changed, 67 insertions(+), 67 deletions(-)
