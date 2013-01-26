From: kyungsik.lee@lge.com (Kyungsik Lee)
Date: Sat, 26 Jan 2013 14:50:43 +0900
Subject: =?UTF-8?q?=5BRFC=20PATCH=200/4=5D=20Add=20support=20for=20LZ4-compressed=20kernels?=
Message-ID: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is for supporting LZ4 compressed kernel and initial ramdisk on
the x86 and ARM architectures.

According to http://code.google.com/p/lz4/, LZ4 is a very fast lossless
compression algorithm and also features an extremely fast decoder.

Kernel Decompression APIs are based on implementation by Yann Collet
(http://code.google.com/p/lz4/source/checkout).
De/compression Tools are also provided from the site above.

The initial test result on ARM(v7) based board shows that the size of kernel
with LZ4 compressed is 8% bigger than LZO compressed  but the decompressing
speed is faster(especially under the enabled unaligned memory access).

Test: 3.4 based kernel built with many modules
Uncompressed kernel size: 13MB
lzo: 6.3MB, 301ms
lz4: 6.8MB, 251ms(167ms, with enabled unaligned memory access)

It seems that it?s worth trying LZ4 compressed kernel image or ramdisk 
for making the kernel boot more faster.

Thanks,
Kyungsik


Kyungsik Lee (4):
  decompressors: add lz4 decompressor module
  lib: add support for LZ4-compressed kernels
  arm: add support for LZ4-compressed kernels
  x86: add support for LZ4-compressed kernels

 arch/arm/Kconfig                      |   1 +
 arch/arm/boot/compressed/.gitignore   |   1 +
 arch/arm/boot/compressed/Makefile     |   3 +-
 arch/arm/boot/compressed/decompress.c |   4 +
 arch/arm/boot/compressed/piggy.lz4.S  |   6 +
 arch/x86/Kconfig                      |   1 +
 arch/x86/boot/compressed/Makefile     |   5 +-
 arch/x86/boot/compressed/misc.c       |   4 +
 include/linux/decompress/unlz4.h      |  10 ++
 include/linux/lz4.h                   |  62 +++++++++++
 init/Kconfig                          |  13 ++-
 lib/Kconfig                           |   7 ++
 lib/Makefile                          |   2 +
 lib/decompress.c                      |   5 +
 lib/decompress_unlz4.c                | 199 ++++++++++++++++++++++++++++++++++
 lib/lz4/Makefile                      |   1 +
 lib/lz4/lz4_decompress.c              | 199 ++++++++++++++++++++++++++++++++++
 lib/lz4/lz4defs.h                     | 129 ++++++++++++++++++++++
 scripts/Makefile.lib                  |   5 +
 usr/Kconfig                           |   9 ++
 20 files changed, 663 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/compressed/piggy.lz4.S
 create mode 100644 include/linux/decompress/unlz4.h
 create mode 100644 include/linux/lz4.h
 create mode 100644 lib/decompress_unlz4.c
 create mode 100644 lib/lz4/Makefile
 create mode 100644 lib/lz4/lz4_decompress.c
 create mode 100644 lib/lz4/lz4defs.h

-- 
1.8.0.3
