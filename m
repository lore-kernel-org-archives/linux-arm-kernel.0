From: kyungsik.lee@lge.com (Kyungsik Lee)
Date: Tue,  5 Mar 2013 20:47:31 +0900
Subject: [PATCH v3 -next 0/5] Add support for LZ4-compressed kernel
Message-ID: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the third version. In this version, Some codes are fixed
and more description and note are added. I would like to thank David Sterba
for his review.

The Last patch[5/5] of the patch set is for making x86 and arm default to
LZ4-compressed for testing the LZ4 code in the linux-next.
It was requested by Andrew Morton in the patch set v2.

Currently, A preliminary version of LZ4 de/compression tool is supported.
However, It is expected that we will have a tool with more features
once its format is finished.

LZ4 compression tool is available at
http://code.google.com/p/lz4/source/checkout.

Thanks,
Kyungsik


Change log: v2
- Clean up code
- Enable unaligned access for ARM v6 and above with
  CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
- Add lz4_decompress() for faster decompression with
  uncompressed output size
- Use lz4_decompress() for LZ4-compressed kernel during
  boot-process
- Apply -Os to decompress.o to improve decompress
  performance during boot-up process
Change log: v3
- Prevent double evaluation by using an inline function
- Add LZ4 description and note for uncompressed chunk size issue
- Fix indentation error


Kyungsik Lee (5):
  decompressor: Add LZ4 decompressor module
  lib: Add support for LZ4-compressed kernel
  arm: Add support for LZ4-compressed kernel
  x86: Add support for LZ4-compressed kernel
  Kconfig: Make x86 and arm kernels default to the LZ4-compressed

 arch/arm/Kconfig                      |   1 +
 arch/arm/boot/compressed/.gitignore   |   1 +
 arch/arm/boot/compressed/Makefile     |   6 +-
 arch/arm/boot/compressed/decompress.c |   4 +
 arch/arm/boot/compressed/piggy.lz4.S  |   6 +
 arch/x86/Kconfig                      |   1 +
 arch/x86/boot/compressed/Makefile     |   5 +-
 arch/x86/boot/compressed/misc.c       |   4 +
 include/linux/decompress/unlz4.h      |  10 ++
 include/linux/lz4.h                   |  51 ++++++
 init/Kconfig                          |  19 +-
 lib/Kconfig                           |   7 +
 lib/Makefile                          |   2 +
 lib/decompress.c                      |   5 +
 lib/decompress_unlz4.c                | 187 +++++++++++++++++++
 lib/lz4/Makefile                      |   1 +
 lib/lz4/lz4_decompress.c              | 326 ++++++++++++++++++++++++++++++++++
 lib/lz4/lz4defs.h                     |  94 ++++++++++
 scripts/Makefile.lib                  |   5 +
 usr/Kconfig                           |   9 +
 20 files changed, 740 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/compressed/piggy.lz4.S
 create mode 100644 include/linux/decompress/unlz4.h
 create mode 100644 include/linux/lz4.h
 create mode 100644 lib/decompress_unlz4.c
 create mode 100644 lib/lz4/Makefile
 create mode 100644 lib/lz4/lz4_decompress.c
 create mode 100644 lib/lz4/lz4defs.h

-- 
1.8.1.1
