From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  6 Jun 2013 17:03:00 +0200
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
Message-ID: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is a partial repost of the patches I proposed a couple of weeks ago to add
support for VFP/NEON in kernel mode.

This time, I have included two use cases that I have been using, XOR and RAID-6
checksumming. The former gets a 60% performance boost on the NEON, the latter
over 400%.


ARM: add support for kernel mode NEON

Adds kernel_neon_begin/end (renamed from kernel_vfp_begin/end in the previous
version to de-emphasize the VFP part as VFP code that needs software assistance
is not supported currently)
Introduces <asm/neon.h> and the Kconfig symbol KERNEL_MODE_NEON. This has been
aligned with Catalin for arm64, so any NEON code that does not use assembly but
intrinsics or the GCC vectorizer (such as my examples) can potentially be shared
between arm and arm64 archs.


ARM: move VFP init to an earlier boot stage

This is needed so the NEON is enabled when the XOR and RAID-6 algo boot time
benchmarks are run.


ARM: be strict about FP exceptions in kernel mode

This adds a check to vfp_support_entry() to flag unsupported uses of the
NEON/VFP in kernel mode. FP exceptions (bounces) are flagged as a BUG(), this is
because of their potentially intermittent nature. Exceptions caused by the fact
that kernel_neon_begin has not been called are just routed through the undef
handler.


ARM: crypto: add NEON accelerated XOR implementation

This is the xor_blocks() implementation built with -ftree-vectorize, 60% faster
than optimized ARM code. It calls in_interrupt() to check whether the NEON
flavor can be used: this should really not be necessary, but due to xor_blocks's
quite generic nature, there is no telling how exactly people may be using it in
the real world.


lib/raid6: add ARM-NEON accelerated syndrome calculation

This is a port of the RAID-6 checksumming code in altivec.uc ported to use NEON
intrinsics. It is about 4x faster than the sequential code. As this code does
not live under arch/arm, I will send this patch separately to the appropriate 
list if/when the prerequisite patches from this series have been accepted.

-- 
Ard.


 arch/arm/Kconfig            |  7 ++++
 arch/arm/include/asm/neon.h | 36 ++++++++++++++++++++
 arch/arm/include/asm/xor.h  | 73 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/lib/Makefile       |  6 ++++
 arch/arm/lib/xor-neon.c     | 42 ++++++++++++++++++++++++
 arch/arm/vfp/vfphw.S        |  5 +++
 arch/arm/vfp/vfpmodule.c    | 56 ++++++++++++++++++++++++++++++-
 include/linux/raid/pq.h     |  5 +++
 lib/raid6/.gitignore        |  1 +
 lib/raid6/Makefile          | 31 ++++++++++++++++++
 lib/raid6/algos.c           |  6 ++++
 lib/raid6/neon.c            | 58 ++++++++++++++++++++++++++++++++
 lib/raid6/neon.uc           | 80 +++++++++++++++++++++++++++++++++++++++++++++
 lib/raid6/test/Makefile     | 19 ++++++++++-
 14 files changed, 423 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/neon.h
 create mode 100644 arch/arm/lib/xor-neon.c
 create mode 100644 lib/raid6/neon.c
 create mode 100644 lib/raid6/neon.uc

-- 
1.8.1.2
