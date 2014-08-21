From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Aug 2014 23:33:24 +0100
Subject: Build failure with v3.17-rc1
In-Reply-To: <20140821211100.GS11146@saruman.home>
References: <20140821211100.GS11146@saruman.home>
Message-ID: <20140821223324.GM30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 04:11:00PM -0500, Felipe Balbi wrote:
> Hi Russell,
> 
> When running my randconfig build tests, I noticed that I had a build
> failure at arch/arm/kernel/patch.c
> 
> KCONFIG_SEED=0x26B77624
> arch/arm/kernel/patch.c: In function ?__patch_text?:
> arch/arm/kernel/patch.c:35:4: error: implicit declaration of function ?__opcode_to_mem_thumb32? [-Werror=implicit-function-declaration]
>     insn = __opcode_to_mem_thumb32(insn);
>     ^
> cc1: some warnings being treated as errors
> make[1]: *** [arch/arm/kernel/patch.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/arm/kernel] Error 2
> make: *** Waiting for unfinished jobs....
> 
> Looking at the definition of __opcode_to_mem_thumb32 it's easy to see
> that it's not defined when ! CONFIG_CPU_ENDIAN_BE8 and that's exactly
> what I have in my generated defconfig (attached).
> 
> Would below patch be the correct fix for this ?

I think you should read a bit more of the file first.  In the ifdef which
starts in the context of your patch:

#ifndef CONFIG_CPU_ENDIAN_BE32
/*
 * On BE32 systems, using 32-bit accesses to store Thumb instructions will not
 * work in all cases, due to alignment constraints.  For now, a correct
 * version is not provided for BE32.
 */
#define __opcode_to_mem_thumb32(x) ___opcode_swahw32(x)
#define ___asm_opcode_to_mem_thumb32(x) ___asm_opcode_swahw32(x)
#endif

The contents of the ifdef cover the !BE32 case.  It doesn't cover the BE32
case, and the BE32 case is what is being referred to in the comment.

It seems that it is intentionally not provided because it's currently
broken, and has been broken for about the last two years.

Further information can be found by looking in the git history, which
brings up commit ID 57b9da32addd.  This commit text implies the need
for __opcode_to_mem_thumb32() is an error.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
