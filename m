From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 11 Jun 2014 13:22:57 -0700
Subject: [RFC 0/5] Two-phase seccomp and an x86_64 fast path
Message-ID: <cover.1402517933.git.luto@amacapital.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On my VM, getpid takes about 70ns.  Before this patchset, adding a
single-instruction always-accept seccomp filter added about 134ns of
overhead to getpid.  With this patchset, the overhead is down to about
13ns.

I'd really appreciate careful review from all relevant arch
maintainers for patch 1.

This is an RFC for now.  I'll submit a non-RFC version after the merge
window ends.

Andy Lutomirski (5):
  seccomp,x86,arm,mips,s390: Remove nr parameter from secure_computing
  x86_64,entry: Treat regs->ax the same in fastpath and slowpath
    syscalls
  seccomp: Refactor the filter callback and the API
  seccomp: Allow arch code to provide seccomp_data
  x86,seccomp: Add a seccomp fastpath

 arch/arm/kernel/ptrace.c       |   7 +-
 arch/mips/kernel/ptrace.c      |   2 +-
 arch/s390/kernel/ptrace.c      |   2 +-
 arch/x86/include/asm/calling.h |   6 +-
 arch/x86/kernel/entry_64.S     |  52 ++++++++-
 arch/x86/kernel/ptrace.c       |   2 +-
 arch/x86/kernel/vsyscall_64.c  |   2 +-
 include/linux/seccomp.h        |  25 +++--
 kernel/seccomp.c               | 244 +++++++++++++++++++++++++++--------------
 9 files changed, 241 insertions(+), 101 deletions(-)

-- 
1.9.3
