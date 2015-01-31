From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 31 Jan 2015 19:49:15 +0000
Subject: [PATCH resend 0/4] module loading for large kernels and Thumb-2
Message-ID: <1422733759-27236-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I sent these patches to the list a while ago (end of November) and the
first 2 were acked by Nico and put in rmk's patch system as 

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8219/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8220/1

Patch #1 and #2 implement a module PLT to help prevent module loading
errors with big kernels and/or modules.

Patch #3 is arguably a bug fix, although I don't think the issue it fixes
has been observed in the wild.

Patch #4 implements Thumb -> ARM interworking function calls, mainly
for modules like accelerated crypto that are built around an assembler
implementation which requires additional work to be built in Thumb-2
mode. (e.g., the SHA-1 and SHA-512 modules currently cannot be built
in Thumb-2 mode for this exact reason, although I think the code works
fine when adding .syntax unified etc)

Ard Biesheuvel (4): 
  ARM: handle interworking and out-of-range relocations separately
  ARM: allow modules outside of bl range
  ARM: Thumb-2: infer function annotation for external ksyms
  ARM: add partial interworking support to Thumb-2 kernel

 arch/arm/Kconfig              |  17 +++-
 arch/arm/Makefile             |   4 +
 arch/arm/include/asm/module.h |  12 ++-
 arch/arm/kernel/Makefile      |   1 +
 arch/arm/kernel/module-plts.c | 182 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/module.c      | 101 +++++++++++++++++++----
 arch/arm/kernel/module.lds    |   4 +
 7 files changed, 305 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/kernel/module-plts.c
 create mode 100644 arch/arm/kernel/module.lds

-- 
1.8.3.2
