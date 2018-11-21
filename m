From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 21 Nov 2018 14:17:31 +0100
Subject: [PATCH v2 0/2] bpf: permit JIT allocations to be served outside the
 module region
Message-ID: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64, modules are allocated from a 128 MB window which is close to
the core kernel, so that relative direct branches are guaranteed to be
in range (except in some KASLR configurations). Also, module_alloc()
is in charge of allocating KASAN shadow memory when running with KASAN
enabled.

This means that the way BPF reuses module_alloc()/module_memfree() is
undesirable on arm64 (and potentially other architectures as well),
and so this series refactors BPF's use of those functions to permit
architectures to change this behavior.

Patch #1 breaks out the module_alloc() and module_memfree() calls into
__weak functions so they can be overridden.

Patch #4 implements the new alloc/free overrides for arm64

Changes since v1:
- Drop misguided attempt to 'fix' and refactor the free path. Instead,
  just add another __weak wrapper for the invocation of module_memfree()

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>

Cc: Jessica Yu <jeyu@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: netdev at vger.kernel.org

Ard Biesheuvel (2):
  bpf: add __weak hook for allocating executable memory
  arm64/bpf: don't allocate BPF JIT programs in module memory

 arch/arm64/net/bpf_jit_comp.c | 10 ++++++++++
 kernel/bpf/core.c             | 14 ++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.17.1
