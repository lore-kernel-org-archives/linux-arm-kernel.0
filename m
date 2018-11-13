From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Nov 2018 15:39:20 -0800
Subject: [PATCH 0/3] arm64: use subsections instead of function calls for
 LL/SC fallbacks
Message-ID: <20181113233923.20098-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactor the LL/SC atomics code so we can emit the LL/SC fallbacks for the
LSE atomics as subsections that get instantiated at each call site rather
than as out of line functions that get called from inline asm (without the
awareness of the compiler)

This should allow slightly better LSE code, and removes stack spilling and
potential PLT indirection for the LL/SC fallbacks.

Ard Biesheuvel (3):
  arm64/atomics: refactor LL/SC base asm templates
  arm64/atomics: use subsections for out of line LL/SC alternatives
  arm64/atomics: remove out of line LL/SC alternatives

 arch/arm64/include/asm/atomic_ll_sc.h | 190 ++++---
 arch/arm64/include/asm/atomic_lse.h   | 558 ++++++++++----------
 arch/arm64/include/asm/lse.h          |  13 -
 arch/arm64/lib/Makefile               |  19 -
 arch/arm64/lib/atomic_ll_sc.c         |   3 -
 5 files changed, 372 insertions(+), 411 deletions(-)
 delete mode 100644 arch/arm64/lib/atomic_ll_sc.c

-- 
2.17.1
