From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 27 Aug 2013 22:41:56 -0700
Subject: [PATCH v3 0/1] ARM: signal: sigreturn_codes should be endian neutral
 to work in BE8
Message-ID: <1377668517-3722-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is third version of patch that fixes rt_sig* ltp failures
in case of big endian V7 kernel. It make sigreturn_codes snippets
endian neutral. In this version of the patch problem is fixed by
using separate .S file with snippets written with regular asm
mnemonic. With such change compiler/linker take care of all needed
byteswaps in case of BE8 mode.

This approach was suggested on the following thread:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191543.html

Changes were tested on V7 in both BE and LE modes

Changes from v2:
  Incorporated Dave's comments that he gave on
    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191879.html

  Added comment that explains why sigreturn_codes size is 7 words

  Note I could not implemented defensive snippet, that Dave suggested, in
  asm that asserts sigreturn_codes size in asm wrt one that declared in 
  C file. The issue is in gas handling movs instruction, please see above 
  thread for details. So we should rely on comment in the code to make
  sure that code maintained correctly further. Note it was not functional 
  piece anyway. I think it is OK to omit it.

Changes from v1:
  Use separate .S file rather than <asm/opcodes.h> instruction
  byteswaping macros

Victor Kamensky (1):
  ARM: signal: sigreturn_codes should be endian neutral to work in BE8

 arch/arm/kernel/Makefile          |  3 +-
 arch/arm/kernel/signal.c          | 24 +-------------
 arch/arm/kernel/sigreturn_codes.S | 69 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/kernel/sigreturn_codes.S

-- 
1.8.1.4
