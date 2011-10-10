From: tixy@yxit.co.uk (Tixy)
Date: Mon, 10 Oct 2011 08:05:39 +0100
Subject: [PATCH] ARM: kprobes: work around build errors
In-Reply-To: <2056947.a9vGLIKRYk@wuerfel>
References: <2056947.a9vGLIKRYk@wuerfel>
Message-ID: <1318230339.2238.51.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-10-08 at 17:07 +0200, Arnd Bergmann wrote:
> I got a few build errors for kprobes playing with randconfig on the
> latest kernel. While this patch manages to avoid these errors, I'm
> pretty sure that it is not the ideal solution.

It's the practical solution and what I did in other places of the code.
I didn't think it was worth the effort to introduce runtime CPU
detection to the test framework, especially as the kprobes
implementation which is tested in these situations is itself not
dependent on CPU version. (Though if we're heading for a 'single zImage'
then I may have to rethink this at some point.)

> The errors I got in arm are while building for ARMv6 with
> the arm-linux-gnueabihf-gcc-4.6 provided by Linaro, which
> results in these messages:
> 
> /tmp/ccGpftnj.s: Assembler messages:
> /tmp/ccGpftnj.s:22066: Error: selected processor does not support ARM mode `mls r0,r1,r2,r3'
> /tmp/ccGpftnj.s:22099: Error: selected processor does not support ARM mode `mlshi r7,r8,r9,r10'
> /tmp/ccGpftnj.s:22128: Error: selected processor does not support ARM mode `mls lr,r1,r2,r13'
> /tmp/ccGpftnj.s:23781: Error: selected processor does not support ARM mode `strexd r0,r2,r3,[sp]'
> /tmp/ccGpftnj.s:23802: Error: selected processor does not support ARM mode `ldrexd r2,r3,[sp]'
> /tmp/ccGpftnj.s:23823: Error: selected processor does not support ARM mode `strexb r0,r2,[sp]'
> /tmp/ccGpftnj.s:23844: Error: selected processor does not support ARM mode `ldrexb r2,[sp]'
> /tmp/ccGpftnj.s:23865: Error: selected processor does not support ARM mode `strexh r0,r2,[sp]'
> /tmp/ccGpftnj.s:23886: Error: selected processor does not support ARM mode `ldrexh r2,[sp]'
> /tmp/ccGpftnj.s:25836: Warning: base register written back, and overlaps second transfer register
> 
> The errors for the thumb variant are using the same tool
> chain, but obviously in v7 thumb2 mode. The error I got
> is
> 
> /tmp/cczp95OW.s:18721: Error: offset out of range
> 
> Reducing the amount of padding in the "TEST_BF_X("bpl.w 2f",0x1000)"
> test case resolves this, and I experimentally found 0xe20 to be the
> maximum value in this location, but that is different if I change the
> surrounding code. This one is much harder to reproduce and I can
> provide the configuration file I used if that helps.

The padding value of 0x1000 was deliberately chosen as it forces a
different instruction encoding to be used. This encoding was introduced
in ARMv6T2 so the test case should instead be made conditional on
__LINUX_ARM_ARCH__ >= 7.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
> index fc82de8..ba9c600 100644
> --- a/arch/arm/kernel/kprobes-test-arm.c
> +++ b/arch/arm/kernel/kprobes-test-arm.c
> @@ -367,9 +367,11 @@ void kprobe_arm_test_cases(void)
>  	TEST_UNSUPPORTED(".word 0xe0500090 @ undef")
>  	TEST_UNSUPPORTED(".word 0xe05fff9f @ undef")
>  
> +#if __LINUX_ARM_ARCH__ >= 7
>  	TEST_RRR(  "mls		r0, r",1, VAL1,", r",2, VAL2,", r",3,  VAL3,"")
>  	TEST_RRR(  "mlshi	r7, r",8, VAL3,", r",9, VAL1,", r",10, VAL2,"")
>  	TEST_RR(   "mls		lr, r",1, VAL2,", r",2, VAL3,", r13")
> +#endif
>  	TEST_UNSUPPORTED(".word 0xe06f3291 @ mls pc, r1, r2, r3")
>  	TEST_UNSUPPORTED(".word 0xe060329f @ mls r0, pc, r2, r3")
>  	TEST_UNSUPPORTED(".word 0xe0603f91 @ mls r0, r1, pc, r3")
> @@ -447,7 +449,7 @@ void kprobe_arm_test_cases(void)
>  	TEST_UNSUPPORTED(".word	0xe1500090") /* Unallocated space */
>  	TEST_UNSUPPORTED(".word	0xe1600090") /* Unallocated space */
>  	TEST_UNSUPPORTED(".word	0xe1700090") /* Unallocated space */
> -#if __LINUX_ARM_ARCH__ >= 6
> +#if __LINUX_ARM_ARCH__ >= 7
>  	TEST_UNSUPPORTED("ldrex	r2, [sp]")
>  	TEST_UNSUPPORTED("strexd	r0, r2, r3, [sp]")
>  	TEST_UNSUPPORTED("ldrexd	r2, r3, [sp]")

As Dave Gilbert pointed out, the "ldrex	r2, [sp]" is legal on ARMv6 so
this would be better as...

#if __LINUX_ARM_ARCH__ >= 6
  	TEST_UNSUPPORTED("ldrex	r2, [sp]")
#endif
#if __LINUX_ARM_ARCH__ >= 7
  	TEST_UNSUPPORTED("strexd	r0, r2, r3, [sp]")
  	TEST_UNSUPPORTED("ldrexd	r2, r3, [sp]")

With the changes I suggested: Acked-by: Jon Medhurst <tixy@yxit.co.uk>

Thanks for your randconfig fixes. As you can probably tell, I only
tested the code on v5 and v7 hardware as that was what I had, but I
could still have compile tested it for v6.

-- 
Tixy
