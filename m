From: nschichan@freebox.fr (Nicolas Schichan)
Date: Wed, 29 Apr 2015 15:37:33 +0200
Subject: [PATCH 0/4] Seccomp filter JIT support on ARM.
Message-ID: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

The following patches allow the use of the existing JIT code under
arch/arm for seccomp filters.

The first patch makes bpf_migrate_filter() available so that seccomp
code can use it.

The second patch invokes the classic BPF JIT code and if this fails
reverts to the internal BPF. The open coded double call to
bpf_convert_filter() and bpf_prog_select_runtime() is replaced by
bpf_migrate_filter()

The third patch adds support for loads from the seccomp_data structure in
the ARM BPF JIT code.

The fourth and final patch fixes a bug in the emit_udiv() function
when used to convert a BPF_ALU | BPF_DIV | BPF_K instruction in the
ARM BPF JIT code.

Regards,

Nicolas Schichan (4):
  net: filter: make bpf_migrate_filter available outside of
    net/core/filter.c
  seccomp: rework seccomp_prepare_filter().
  ARM: net: add JIT support for loads from struct seccomp_data.
  ARM: net fix emit_udiv() for BPF_ALU | BPF_DIV | BPF_K intruction.

 arch/arm/net/bpf_jit_32.c | 14 ++++++++++++--
 include/linux/filter.h    |  1 +
 kernel/seccomp.c          | 47 ++++++++++++++++++++---------------------------
 net/core/filter.c         |  2 +-
 4 files changed, 34 insertions(+), 30 deletions(-)

-- 
1.9.1
