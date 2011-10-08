From: gilbertd@treblig.org (Dr. David Alan Gilbert)
Date: Sat, 8 Oct 2011 16:35:13 +0100
Subject: [PATCH] ARM: kprobes: work around build errors
In-Reply-To: <2056947.a9vGLIKRYk@wuerfel>
References: <2056947.a9vGLIKRYk@wuerfel>
Message-ID: <20111008153513.GA26609@gallifrey>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann (arnd at arndb.de) wrote:
> I got a few build errors for kprobes playing with randconfig on the
> latest kernel. While this patch manages to avoid these errors, I'm
> pretty sure that it is not the ideal solution.
> 
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
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
> index fc82de8..ba9c600 100644
> --- a/arch/arm/kernel/kprobes-test-arm.c
> +++ b/arch/arm/kernel/kprobes-test-arm.c

<snip>

> -#if __LINUX_ARM_ARCH__ >= 6
> +#if __LINUX_ARM_ARCH__ >= 7
>  	TEST_UNSUPPORTED("ldrex	r2, [sp]")
>  	TEST_UNSUPPORTED("strexd	r0, r2, r3, [sp]")
>  	TEST_UNSUPPORTED("ldrexd	r2, r3, [sp]")

The ldrexd and strexd are supported on one of the ARMv6 varients
(6k I think from memory) which makes stuff a bit more complicated.
(and I think the plain ldrex that's the first one in that set
works on older CPUs).

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
