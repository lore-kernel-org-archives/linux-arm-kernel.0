From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Fri, 27 Jun 2014 11:00:23 -0500
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <20140627085125.GA7088@hal>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <20140627085125.GA7088@hal>
Message-ID: <53AD9517.4060400@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 03:51 AM, Jan Glauber wrote:
> On Sun, Jun 22, 2014 at 10:11:49PM -0500, Nathan Lynch wrote:
>> Provide fast userspace implementations of gettimeofday and
>> clock_gettime on systems that implement the generic timers extension
>> defined in ARMv7.  This follows the example of arm64 in conception but
>> significantly differs in some aspects of the implementation (C vs
>> assembly, mainly).
> 
> Hi Nathan,
> 
> applying your patches I get the following compile error under Ubuntu 12.04:
> 
>   CC      arch/arm/kernel/vdso.o
>   LDS     arch/arm/kernel/vdso/vdso.lds
>   CC      arch/arm/kernel/vdso/vgettimeofday.o
>   AS      arch/arm/kernel/vdso/datapage.o
>   VDSOL   arch/arm/kernel/vdso/vdso.so.raw
>   HOSTCC  arch/arm/kernel/vdso/vdsomunge
> arch/arm/kernel/vdso/vdsomunge.c: In function ?main?:
> arch/arm/kernel/vdso/vdsomunge.c:152:16: error: ?EF_ARM_ABI_FLOAT_HARD? undeclared (first use in this function)
> arch/arm/kernel/vdso/vdsomunge.c:152:16: note: each undeclared identifier is reported only once for each function it appears in
> arch/arm/kernel/vdso/vdsomunge.c:156:34: error: ?EF_ARM_ABI_FLOAT_SOFT? undeclared (first use in this function)
> make[2]: *** [arch/arm/kernel/vdso/vdsomunge] Error 1
> make[1]: *** [arch/arm/kernel/vdso] Error 2
> make: *** [arch/arm/kernel] Error 2
> 
> Looks like the libc dev is too old (EF_ARM_ABI_FLOAT_* not in /usr/include/elf.h).
> On a more recent Ubuntu it compiles fine. Not sure how to solve this, maybe disable
> vdso if the libc is too old?

We should just define some of the needed ELF constants in the tool if
the host <elf.h> lacks them.  EF_ARM_ABI_FLOAT_HARD/SOFT were added in
2012, EF_ARM_EABI_VER5 in 2009... everything else the tool uses has been
there for twelve years or more.

Thanks for the report -- please try the below?


diff --git a/arch/arm/kernel/vdso/vdsomunge.c
b/arch/arm/kernel/vdso/vdsomunge.c
index 823b84d142bc..b586ef699fb8 100644
--- a/arch/arm/kernel/vdso/vdsomunge.c
+++ b/arch/arm/kernel/vdso/vdsomunge.c
@@ -67,6 +67,21 @@
 #define HOST_ORDER ELFDATA2MSB
 #endif

+/* Some of the ELF constants we'd like to use were added to <elf.h>
+ * relatively recently.
+ */
+#ifndef EF_ARM_EABI_VER5
+#define EF_ARM_EABI_VER5 0x05000000
+#endif
+
+#ifndef EF_ARM_ABI_FLOAT_SOFT
+#define EF_ARM_ABI_FLOAT_SOFT 0x200
+#endif
+
+#ifndef EF_ARM_ABI_FLOAT_HARD
+#define EF_ARM_ABI_FLOAT_HARD 0x400
+#endif
+
 static const char *outfile;

 static void cleanup(void)
