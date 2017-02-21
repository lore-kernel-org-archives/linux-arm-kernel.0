From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Feb 2017 22:12:55 +0000
Subject: [PATCH v2 0/2] ARM/arm64: module-plt: split core and init PLT sections
Message-ID: <1487715177-30790-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a thinko on my part in both the ARM and the arm64 implementations
of module PLTs. What I failed to realise is that the core module sections and
the init sections are allocated independently, which means they could end up
further away from each other than the range of a branch instruction. This
implies that they cannot share a single array of PLT entries, and so this
series splits them into core and init PLT sections. To complicate matters
further, this also means that .init.text code may require PLT entries to branch
into the .text section of the same module.

For ARM, this is actually a revert of commit 35fa91eed817 ("ARM: kernel:
merge core and init PLTs") [although the patch in this series is not a
straight revert.] This means that the issue is a regression, and the patch
should probably go to -stable.

For arm64, the likelihood of this issue ever occurring is very small, due
to the 128 MB range of its branch instructions. Also, the arm64 version of
the code was never correct, so it is not a regression. But for correctness,
it is fixed in the same way as for ARM.

Build tested on ARM+arm64, and runtime tested on arm64.

v2: deal with init PLT entries referring to .text symbols of the same module
    fix warning in ARM code

Ard Biesheuvel (2):
  ARM: module: split core and init PLT sections
  arm64: module: split core and init PLT sections

 arch/arm/include/asm/module.h   |   9 +-
 arch/arm/kernel/module-plts.c   |  87 +++++++++++-----
 arch/arm/kernel/module.lds      |   1 +
 arch/arm64/include/asm/module.h |   9 +-
 arch/arm64/kernel/module-plts.c | 108 ++++++++++++--------
 arch/arm64/kernel/module.c      |   2 +-
 arch/arm64/kernel/module.lds    |   1 +
 7 files changed, 140 insertions(+), 77 deletions(-)

-- 
2.7.4
