From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Apr 2013 15:24:06 +0100
Subject: [PATCH] Report double word access atomicity on LPAE enabled
 targets through AUXV
In-Reply-To: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
References: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
Message-ID: <20130408142406.GL17995@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 08:34:28AM -0400, Vladimir Danushevsky wrote:
> From: Vladimir Danushevsky <vladidan@oracle.com>

Please don't obfuscate your email address like that - git won't parse it.

> Hi All,

We don't include such salutations in the commit message.

> One of the indirect LPAE features in a single-copy atomicity of LDRD/STRD
> instructions. This information is useful for some dynamic code generating
> applications (e.g. JIT compilers) to produce a more efficient access
> mechanism to atomic/volatile operands.
> 
> The feature is part of the design scheme therefore it's not related to the
> platform configuration i.e. whether CONFIG_ARM_LPAE is enabled or not.
> 
> The patch exposes that information through hwcap entry of an Auxiliary
> Vector.

I think we're heading towards running out of hwcap bits to represent all
these different features.  Not there yet, but after this we only have 11
spare bits.

Maybe we need to switch to a more x86-centric method where we report this
stuff in /proc/cpuinfo, and userspace parses this information out.  If
glibc already has code in there for x86, maybe we can reuse that?

> Signed-off-by: Vladimir Danushevsky <vladidan@oracle.com>

Again, don't obfuscate.

> ---

diffstat?

> 
> --- linux-3.8.4_vanilla/arch/arm/include/uapi/asm/hwcap.h       2013-03-20 16:11:19.000000000 -0400
> 
> +++ linux-3.8.4/arch/arm/include/uapi/asm/hwcap.h       2013-03-26 16:32:18.266043699 -0400

This double-line spacing makes this patch impossible to apply.

> +        /* check LPAE presence */ 

If it's worth a comment, it's worth making it a good comment.
> 
> +        if (((read_cpuid_ext(CPUID_EXT_MMFR3) >> 28) & 0xf) > 0)
> 
> +          elf_hwcap |= HWCAP_ATOMICD;

We use tabs for indentation, not two spaces.  Also, on the face of it
ATOMICD isn't obvious what it means.  Maybe HWCAP_LDRDSTRD would be
better - it's only one character longer and truely reflects what you're
trying to report - the presence of these two instructions.
