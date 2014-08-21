From: balbi@ti.com (Felipe Balbi)
Date: Thu, 21 Aug 2014 16:11:00 -0500
Subject: Build failure with v3.17-rc1
Message-ID: <20140821211100.GS11146@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

When running my randconfig build tests, I noticed that I had a build
failure at arch/arm/kernel/patch.c

KCONFIG_SEED=0x26B77624
arch/arm/kernel/patch.c: In function ?__patch_text?:
arch/arm/kernel/patch.c:35:4: error: implicit declaration of function ?__opcode_to_mem_thumb32? [-Werror=implicit-function-declaration]
    insn = __opcode_to_mem_thumb32(insn);
    ^
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/kernel/patch.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/arm/kernel] Error 2
make: *** Waiting for unfinished jobs....

Looking at the definition of __opcode_to_mem_thumb32 it's easy to see
that it's not defined when ! CONFIG_CPU_ENDIAN_BE8 and that's exactly
what I have in my generated defconfig (attached).

Would below patch be the correct fix for this ?

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index e796c59..d74eb26 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -111,6 +111,7 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 
 #define __opcode_to_mem_arm(x) ___opcode_identity32(x)
 #define __opcode_to_mem_thumb16(x) ___opcode_identity16(x)
+#define __opcode_to_mem_thumb32(x) ___opcode_identity32(x)
 #define ___asm_opcode_to_mem_arm(x) ___asm_opcode_identity32(x)
 #define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_identity16(x)
 #ifndef CONFIG_CPU_ENDIAN_BE32

if it is, I can send it as a formal patch and/or add it to your patch
tracking system. Otherwise, let me know what would be the best fix and
I'll either fix or build-test a patch from you, whatever works best.

cheers

-- 
balbi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/4db0ee21/attachment.sig>
