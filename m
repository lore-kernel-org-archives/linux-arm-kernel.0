From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 7 Jul 2014 11:28:53 +1000
Subject: linux-next: manual merge of the mvebu tree with the arm tree
Message-ID: <20140707112853.7f5a9323@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
arch/arm/mach-mvebu/headsmp-a9.S between commit 8a3a9dd50dd9 ("ARM:
convert all "mov.* pc, reg" to "bx reg" for ARMv6+") from the arm tree
and commit 0e2be4c1121a ("ARM: mvebu: fix SMP boot for Armada 38x and
Armada 375 Z1 in big endian") from the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-mvebu/headsmp-a9.S
index 7c91ddb6f1f7,da5bb292b91c..000000000000
--- a/arch/arm/mach-mvebu/headsmp-a9.S
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@@ -14,8 -14,9 +14,10 @@@
  
  #include <linux/linkage.h>
  #include <linux/init.h>
 +#include <asm/assembler.h>
  
+ #include <asm/assembler.h>
+ 
  	__CPUINIT
  #define CPU_RESUME_ADDR_REG 0xf10182d4
  
@@@ -23,9 -24,13 +25,13 @@@
  .global armada_375_smp_cpu1_enable_code_end
  
  armada_375_smp_cpu1_enable_code_start:
- 	ldr     r0, [pc, #4]
+ ARM_BE8(setend	be)
+ 	adr     r0, 1f
+ 	ldr	r0, [r0]
  	ldr     r1, [r0]
+ ARM_BE8(rev	r1, r1)
 -	mov     pc, r1
 +	ret     r1
+ 1:
  	.word   CPU_RESUME_ADDR_REG
  armada_375_smp_cpu1_enable_code_end:
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140707/c8ce4ffb/attachment.sig>
