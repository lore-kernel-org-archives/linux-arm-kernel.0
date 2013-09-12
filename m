From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 11 Sep 2013 22:42:36 -0700
Subject: [PATCH] ARM: signal: sigreturn_codes fix build breakage for old arch
Message-ID: <1378964557-24520-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben, Dave, Russell,

This is addtion to previously posted patch 'ARM: signal: sigreturn_codes 
should be endian neutral'
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/195176.html

Ben, who graciously agreed to include my above V3 version of patch into his
BE series, reported that above patch breaks build of some old architectures.

I believe I am able to reproduce the issue using rpc_defconfig. Build
fails with messages like these (full gcc invocation could be found
below in Apendix 1):

arch/arm/kernel/sigreturn_codes.S: Assembler messages:
arch/arm/kernel/sigreturn_codes.S:46: Error: selected processor does not support THUMB opcodes
arch/arm/kernel/sigreturn_codes.S:47: Error: selected processor does not support Thumb mode `movs r7,#((0x900000+119)-0x900000)'
<snip>

When I proposed first version of the patch using asm/opcodes.h
macros 

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191543.html

we discussed that it is better to use separate assembler file with
right asm mnemonics and let toolchain to do right thing - byte 
swapping instructions depending on endianity. It was highlighted
the assumption is that we have sufficiently thumb-capable tools.
In sigreturn_codes.S I explicitly used asm '.thumb' directive. 
However I failed to realize that even toolchain is thumb-capable it 
depends on -march=XXX gcc command line option whether gas takes
.thumb opcodes or not. For architectures below v6, non t variants
(like -march=armv3 used by rpc_defconfig) it fails to compile .S file
with .thumb directive in it. Please see below Apendix 2 for
small examples.

To fix the issue I considered several options. I created fix patch 
with my preferred choice, which follows this cover letter, but I
am looking for other folks feedback and opinions and/or maybe
suggestions for other better ways to address it.


Switch arch with explicity .arch asm directive
----------------------------------------------

The idea of this approach is to switch arm architecture
explicitly with '.arch' asm directive inside of sigreturn_codes.S 
if arch that set by Makefile is too low

Diff will look like this:

diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
index c888c43..3c5d0f2 100644
--- a/arch/arm/kernel/sigreturn_codes.S
+++ b/arch/arm/kernel/sigreturn_codes.S
@@ -30,6 +30,17 @@
  * snippets.
  */
 
+#if __LINUX_ARM_ARCH__ <= 4
+	/*
+	 * Note we manually set minimally required arch that supports
+	 * required thumb opcodes for early arch versions. It is OK
+	 * for this file to be used in combination with other
+	 * lower arch variants, since these code snippets are only
+	 * used as input data.
+	 */
+	.arch armv4t
+#endif
+
 	.section .rodata
 	.global sigreturn_codes
 	.type	sigreturn_codes, #object

Note with this approach if modern abi is used and explicit '.arch armv4t'
is used, gas generate "File Attributes" that contain 'Tag_CPU_name: "4T"'
and 'Tag_CPU_arch: v4T' tag records. I would like not to have mismatch
with other object file so '.arch armv4t' usage is conditional - only for
old arch values. Note for rpc_defconfig test case old '-mabi=apcs-gnu'
option is used, and in this case no "File Attributes" is generated. Although
mixing .o file with different Tag_CPU_arch tags may not be big issue as long
as valuea are compatible. I do see in CONFIG_ARCH_MULTIPLATFORM case .o files
with 'Tag_CPU_arch: v6K' are mixed with object files with 'Tag_CPU_arch: v7'.

This is my preferred approach. Complete proposed diff follows this
cover letter.


Conditional compilation based on __LINUX_ARM_ARCH__ value
---------------------------------------------------------

Use '#if __LINUX_ARM_ARCH__ >= 6' condition around .thumb
asm sequences, if not, fallback to constructing opcode manually
as original sigretun_codes did. Code will look something like
this:

+#if __LINUX_ARM_ARCH__ >= 5
 	.thumb
 	movs	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
 	swi	#0
+#else
+	/*
+	 * gas will not take .thumb opcodes for older arch,
+	 * construct them manually
+	 */
+	.long (0xdf00 << 16 | 0x2700 | (__NR_rt_sigreturn - __NR_SYSCALL_BASE))
+#endif

this approach is safe bet but manually generated opcodes seems to
be step backward


Use asm/opcodes.h macros
------------------------

With this approach we can abandon use of separate .S file and use 
macros from <asm/opcodes.h>. Effectively it will back out my v3 
version of patch and apply v1 version as I posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191543.html


Any other suggestions?
----------------------


Testing
-------

I tested LE and BE pandaboard in Linaro tree and BE patch series. Original 
LTP ./rt_sigactionNN tests have been run.

Tested build of rpc_defconfig which has CONFIG_CPU_32v3 and exhibited build
problem. Beyond that I struggle to find old machine that would fail to build.

Also I looked at

kirkwood_defconfig there was no issue with original patch, it is
CONFIG_CPU_32v5 which implies -march=armv5te or -march=armv4t, both OK with
.thumb

integrator_defconfig there was no issue with original patch, it is 
CONFIG_CPU_32v4t which implies -march=armv4t, which is OK with .thumb

ixp4xx_defconfig there was no issue with original patch, it is CONFIG_CPU_32v5
and it is in CONFIG_CPU_BIG_ENDIAN=y (BE32). This is compiled with
-march=armv5te. sigreturn_codes look OK. Before original patch thumb instrs
were swapped.

Any other suggestions for old boards configs to test?


Apendix 1 full failed compile line
----------------------------------

arm-linux-gnueabihf-gcc -Wp,-MD,arch/arm/kernel/.sigreturn_codes.o.d  \
-nostdinc -isystem /run/media/kamensky/wd/linaro/gcc-linaro-arm-linux-gnueabihf-4.7-2013.01-20130125_linux/bin/../lib/gcc/arm-linux-gnueabihf/4.7.3/include \
-I/run/media/kamensky/wd/linaro/linux-linaro-core-tracking/091013/linux-linaro-tracking-be/arch/arm/include -Iarch/arm/include/generated \
-Iinclude -I/run/media/kamensky/wd/linaro/linux-linaro-core-tracking/091013/linux-linaro-tracking-be/arch/arm/include/uapi -Iarch/arm/include/generated/uapi \
-I/run/media/kamensky/wd/linaro/linux-linaro-core-tracking/091013/linux-linaro-tracking-be/include/uapi -Iinclude/generated/uapi -include \
/run/media/kamensky/wd/linaro/linux-linaro-core-tracking/091013/linux-linaro-tracking-be/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian \
-Iarch/arm/mach-rpc/include  -D__ASSEMBLY__ -mabi=apcs-gnu -mno-thumb-interwork -marm -D__LINUX_ARM_ARCH__=3 -march=armv3 -mtune=strongarm110 \
-include asm/unified.h -msoft-float -gdwarf-2 -c -o arch/arm/kernel/sigreturn_codes.o arch/arm/kernel/sigreturn_codes.S
arch/arm/kernel/sigreturn_codes.S: Assembler messages:
arch/arm/kernel/sigreturn_codes.S:46: Error: selected processor does not support THUMB opcodes
arch/arm/kernel/sigreturn_codes.S:47: Error: selected processor does not support Thumb mode `movs r7,#((0x900000+119)-0x900000)'
<snip>

Apendix 2 -march and .thumb simple test case
--------------------------------------------

[kamensky at kamensky-w530 linux-linaro-tracking-be]$ cat t.S
sigreturn_codes:
	.thumb
	movs	r7, #157

[kamensky at kamensky-w530 linux-linaro-tracking-be]$ arm-linux-gnueabihf-gcc -nostdinc -mlittle-endian -mno-thumb-interwork -mabi=apcs-gnu -marm -march=armv3 -msoft-float -c -o t.o t.S
t.S: Assembler messages:
t.S:2: Error: selected processor does not support THUMB opcodes
t.S:3: Error: selected processor does not support Thumb mode `movs r7,#157'
[kamensky at kamensky-w530 linux-linaro-tracking-be]$ arm-linux-gnueabihf-gcc -nostdinc -mlittle-endian -mno-thumb-interwork -mabi=apcs-gnu -marm -march=armv5 -msoft-float -c -o t.o t.S
t.S: Assembler messages:
t.S:2: Error: selected processor does not support THUMB opcodes
t.S:3: Error: selected processor does not support Thumb mode `movs r7,#157'
[kamensky at kamensky-w530 linux-linaro-tracking-be]$ arm-linux-gnueabihf-gcc -nostdinc -mlittle-endian -mno-thumb-interwork -mabi=apcs-gnu -marm -march=armv6 -msoft-float -c -o t.o t.S
[kamensky at kamensky-w530 linux-linaro-tracking-be]$ arm-linux-gnueabihf-gcc -nostdinc -mlittle-endian -mno-thumb-interwork -mabi=apcs-gnu -march=armv7 -msoft-float -c -o t.o t.S

Thanks,
Victor

Victor Kamensky (1):
  ARM: signal: sigreturn_codes fix build breakage for old arch

 arch/arm/kernel/sigreturn_codes.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
1.8.1.4
