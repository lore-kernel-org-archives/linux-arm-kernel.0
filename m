From: stefan@agner.ch (Stefan Agner)
Date: Wed, 21 Mar 2018 00:02:01 +0100
Subject: [PATCH 0/5] ARM: clang support
Message-ID: <20180320230206.25289-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes some remaining issues when building the ARM
architecture using LLVM/clang.  The patchset requires the following
kbuild change:
https://lkml.org/lkml/2018/3/19/1756

With that patch and this patchset applied and I can successfully
build the multi_v7_defconfig with 4.16-rc5 using clang 5.0.1.

So far I mainly tested with ARMv7 architectures. A brief test with
ARMv6 enabled (multi platform configuraiton) failed with an error
from the assembler:
/tmp/empty-96a4d6.s: Assembler messages:
/tmp/empty-96a4d6.s:4: Error: unknown cpu `arm1176j-s'

It seems that clang emits a non-existig cpu name:
https://reviews.llvm.org/D18086

Stefan Agner (5):
  bus: arm-cci: use asm unreachable
  efi/libstub/arm: add support for building with clang
  ARM: trusted_foundations: do not use naked function
  ARM: drop no-thumb-interwork in EABI mode
  ARM: add support for building ARM kernel with clang

 arch/arm/Makefile                       |  4 ++--
 arch/arm/boot/compressed/Makefile       |  2 +-
 arch/arm/firmware/trusted_foundations.c | 12 +++++++-----
 drivers/bus/arm-cci.c                   |  3 +--
 drivers/firmware/efi/libstub/Makefile   |  3 ++-
 5 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.16.2
