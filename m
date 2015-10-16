From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Oct 2015 11:37:29 +0100
Subject: [PATCH] ARM: SWP emulation: Restore original *data when failed
In-Reply-To: <5620ACB8.20908@arm.com>
References: <1444791077-26020-1-git-send-email-shengjiu.wang@freescale.com>
 <20151015082417.GX32532@n2100.arm.linux.org.uk>
 <20151015083629.GA32630@shlinux2>
 <20151015085700.GY32532@n2100.arm.linux.org.uk>
 <561F6F3B.6030607@arm.com> <20151015130247.GB29301@arm.com>
 <561FA948.5080505@arm.com> <5620ACB8.20908@arm.com>
Message-ID: <20151016103729.GA6613@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 08:52:24AM +0100, Vladimir Murzin wrote:
> > On 15/10/15 14:02, Will Deacon wrote:
> >> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> >> index bcee7abac68e..6039d1eb5912 100644
> >> --- a/arch/arm64/kernel/armv8_deprecated.c
> >> +++ b/arch/arm64/kernel/armv8_deprecated.c
> >> @@ -284,12 +284,12 @@ static void register_insn_emulation_sysctl(struct ctl_table *table)
> >>  	__asm__ __volatile__(					\
> >>  	ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,	\
> >>  		    CONFIG_ARM64_PAN)				\
> >> -	"	mov		%w2, %w1\n"			\
> >> -	"0:	ldxr"B"		%w1, [%3]\n"			\
> >> -	"1:	stxr"B"		%w0, %w2, [%3]\n"		\
> >> +	"0:	ldxr"B"		%w2, [%3]\n"			\
> >> +	"1:	stxr"B"		%w0, %w1, [%3]\n"		\
> >>  	"	cbz		%w0, 2f\n"			\
> >>  	"	mov		%w0, %w4\n"			\
> >>  	"2:\n"							\
> >> +	"	mov		%w1, %w2\n"			\
> >>  	"	.pushsection	 .fixup,\"ax\"\n"		\
> >>  	"	.align		2\n"				\
> >>  	"3:	mov		%w0, %w5\n"			\
> 
> On the second thought looks like we still update *data in case stxr
> fails (or I need more coffee).

I'm on the second cup and I see the same problem. Even if stxr fails, we
fall back through "mov %w1, %w2", so *data is always updated with the
loaded value. Maybe something like below on top of Will's patch:

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 6039d1eb5912..3fab37b3bc95 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -286,10 +286,10 @@ static void register_insn_emulation_sysctl(struct ctl_table *table)
 		    CONFIG_ARM64_PAN)				\
 	"0:	ldxr"B"		%w2, [%3]\n"			\
 	"1:	stxr"B"		%w0, %w1, [%3]\n"		\
-	"	cbz		%w0, 2f\n"			\
-	"	mov		%w0, %w4\n"			\
+	"	cmp		%w0, #0\n"			\
+	"	csel		%w0, %w4, wzr, ne\n"		\
+	"	csel		%w1, %w2, %w1, eq\n"		\
 	"2:\n"							\
-	"	mov		%w1, %w2\n"			\
 	"	.pushsection	 .fixup,\"ax\"\n"		\
 	"	.align		2\n"				\
 	"3:	mov		%w0, %w5\n"			\
@@ -303,7 +303,7 @@ static void register_insn_emulation_sysctl(struct ctl_table *table)
 	ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,	\
 		CONFIG_ARM64_PAN)				\
 	: "=&r" (res), "+r" (data), "=&r" (temp)		\
-	: "r" (addr), "i" (-EAGAIN), "i" (-EFAULT)		\
+	: "r" (addr), "r" (-EAGAIN), "i" (-EFAULT)		\
 	: "memory")
 
 #define __user_swp_asm(data, addr, res, temp) \
@@ -342,7 +342,7 @@ static void set_segfault(struct pt_regs *regs, unsigned long addr)
 static int emulate_swpX(unsigned int address, unsigned int *data,
 			unsigned int type)
 {
-	unsigned int res = 0;
+	unsigned int res;
 
 	if ((type != TYPE_SWPB) && (address & 0x3)) {
 		/* SWP to unaligned address not permitted */


Since Will is away for a week, I'll wait until he's back to push this
patch.

-- 
Catalin
