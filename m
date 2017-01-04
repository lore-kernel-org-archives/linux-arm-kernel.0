From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  4 Jan 2017 17:55:24 +0900
Subject: [PATCH 0/3] linux/const.h: cleanups of macros such as UL(), _BITUL(),
 BIT() etc.
Message-ID: <1483520127-29316-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


ARM, arm64, unicore32 define UL() as a shorthand of _AC(..., UL).
In the future, more architectures may introduce it, so move
the definition to include/linux/const.h.

The _AC() is used for either (likely) UL or (unlikely) ULL.
Having UL(L) in a common place can avoid direct use of _AC().

The _AC() is defined under uapi directory, so it compels
underscore-prefixed macros even for unexported headers.

I see similar situation for _BITUL().  This is available in
both C and assembly.  However, it is defined in an uapi header,
so direct use of the underscore macro is needed even for unexported
headers.  The 3/3 makes BIT() available in assembly too, which will
be more suitable for use in unexported headers.



Masahiro Yamada (3):
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
