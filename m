From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 22 Feb 2018 21:15:10 +0900
Subject: [PATCH v3 0/5] linux/const.h: cleanups of macros such as UL(),
 _BITUL(), BIT() etc.
Message-ID: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


ARM, ARM64, UniCore32 define UL() as a shorthand of _AC(..., UL).
More architectures may introduce it in the future.

UL() is arch-agnostic, and useful. So let's move it to
include/linux/const.h

Currently, <asm/memory.h> must be included to use UL().
It pulls in more bloats just for defining some bit macros.

I posted V2 one year ago.

The previous posts are:
https://patchwork.kernel.org/patch/9498273/
https://patchwork.kernel.org/patch/9498275/
https://patchwork.kernel.org/patch/9498269/
https://patchwork.kernel.org/patch/9498271/

At that time, what blocked this series was a comment from
David Howells:
  You need to be very careful doing this.  Some userspace stuff
  depends on the guard macro names on the kernel header files.

(https://patchwork.kernel.org/patch/9498275/)

Looking at the code closer, I noticed this is not a problem.

See the following line.
https://github.com/torvalds/linux/blob/v4.16-rc2/scripts/headers_install.sh#L40

scripts/headers_install.sh rips off _UAPI prefix from guard macro names.

I ran "make headers_install" and confirmed the result is what I expect.

So, we can prefix the include guard of include/uapi/linux/const.h,
and add a new include/linux/const.h.



Masahiro Yamada (5):
  linux/const.h: prefix include guard of uapi/linux/const.h with _UAPI
  m68k: rename UL() to TO_UL()
  linux/const.h: move UL() macro to include/linux/const.h
  linux/const.h: refactor _BITUL and _BITULL a bit
  linux/const.h: move BIT(_ULL) to linux/const.h for use in assembly

 arch/arm/include/asm/memory.h       |  6 ------
 arch/arm64/include/asm/memory.h     |  6 ------
 arch/m68k/mm/init.c                 |  6 +++---
 arch/unicore32/include/asm/memory.h |  6 ------
 include/linux/bitops.h              |  3 +--
 include/linux/const.h               | 12 ++++++++++++
 include/uapi/linux/const.h          | 13 ++++++++-----
 7 files changed, 24 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/const.h

-- 
2.7.4
