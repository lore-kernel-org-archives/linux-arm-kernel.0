From: natechancellor@gmail.com (Nathan Chancellor)
Date: Tue, 22 May 2018 14:59:35 -0700
Subject: [PATCH] arm64: vdso32: Use full path to Clang instead of relying on
 PATH
Message-ID: <20180522215935.12029-1-natechancellor@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, in order to build the compat VDSO with Clang, this format
has to be used:

  PATH=${BIN_FOLDER}:${PATH} make CC=clang

Prior to the addition of this file, this format would also be
acceptable:

  make CC=${BIN_FOLDER}/clang

This is because the vdso32 Makefile uses cc-name instead of CC. After
this path, CC will still evaluate to clang for the first case as
expected but now the second case will use the specified Clang, rather
than the host's copy, which may not be compatible as shown below.

/usr/bin/as: unrecognized option '-mfloat-abi=soft'
clang-6.0: error: assembler command failed with exit code 1

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Hi everyone,

I noticed this issue when building the Pixel 2's kernel. Since this
is a supplement to https://patchwork.kernel.org/patch/10186671/, I
was instructed by Mark to push it here. I could not find a public git
tree for this patch, I am not sure if it has been applied or not so I
couldn't add a fixes tag. If there are any other issues, please let me
know!

Nathan

 arch/arm64/kernel/vdso32/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 6d44d972e89d..837e877a326b 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -5,7 +5,7 @@
 # A mix between the arm64 and arm vDSO Makefiles.
 
 ifeq ($(cc-name),clang)
-  CC_ARM32 := $(cc-name) $(CLANG_TARGET_ARM32) -no-integrated-as
+  CC_ARM32 := $(CC) $(CLANG_TARGET_ARM32) -no-integrated-as
 else
   CC_ARM32 := $(CROSS_COMPILE_ARM32)$(cc-name)
 endif
-- 
2.17.0
