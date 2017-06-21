From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Jun 2017 15:55:37 +0100
Subject: [PATCH 0/3] arm64: Coredump fixes
Message-ID: <1498057010-12028-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a few bugs affecting coredumps on arm64, namely:

 * VFP regs missing for compat
 * dumped FPSIMD/VFP regs and user RW TLS reg may be stale

It appears that these bugs were all introduced in the original arm64
ptrace implementation in v3.6: 478fcb2cdb23 ("arm64: Debugging
support").

Judging by the amount of noise people have(n't) been making about these,
they're not likely to be critical for anyone, but the patches apply back
to v4.9 without conflicts so it may be worth Cc-ing stable for those.
I've not done that yet to avoid the patches being pulled prematurely.

I have simple backports back to v3.6 if anyone cares, but I won't post
them unless someone shouts -- they may just cause unnecessary churn.

Basic testing has been done, on v4.12-rc* only, with a simple userspace
test and manual parsing of the resulting coredumps.  Other revisions
have only been build-tested.

I haven't checked for similar bugs in arch/arm.  Casual inspection
suggests that the required flushing is already in place there.

Dave Martin (3):
  arm64: compat: Fix VFP register dumping in coredumps
  arm64: ptrace: Flush FPSIMD regs back to thread_struct before reading
  arm64: ptrace: Flush user-RW TLS reg to thread_struct before reading

 arch/arm64/include/asm/processor.h |  3 +++
 arch/arm64/kernel/process.c        |  8 ++++++--
 arch/arm64/kernel/ptrace.c         | 22 ++++++++++++++++++----
 3 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.1.4
