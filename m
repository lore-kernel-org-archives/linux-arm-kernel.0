From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 15 Aug 2013 16:53:12 +0100
Subject: [PATCH 3/3] ARM: kdgb: use <asm/opcodes.h> for data to be
 assembled as intruction
In-Reply-To: <1376498563-8146-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1376498563-8146-1-git-send-email-ben.dooks@codethink.co.uk>
 <1376498563-8146-4-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130815155312.GD4103@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 05:42:43PM +0100, Ben Dooks wrote:
> The arch_kgdb_breakpoint() function uses an inline assembly directive
> to assemble a specific instruction using .word. This means the linker
> will not treat is as an instruction, and therefore incorrectly swap
> the endian-ness if running BE8.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Cheers
---Dave

> ---
>  arch/arm/include/asm/kgdb.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
> index 48066ce..0a9d5dd 100644
> --- a/arch/arm/include/asm/kgdb.h
> +++ b/arch/arm/include/asm/kgdb.h
> @@ -11,6 +11,7 @@
>  #define __ARM_KGDB_H__
>  
>  #include <linux/ptrace.h>
> +#include <asm/opcodes.h>
>  
>  /*
>   * GDB assumes that we're a user process being debugged, so
> @@ -41,7 +42,7 @@
>  
>  static inline void arch_kgdb_breakpoint(void)
>  {
> -	asm(".word 0xe7ffdeff");
> +	asm(__inst_arm(0xe7ffdeff));

Actually, the #define could be used directly now:

	__inst_arm(KGDB_COMPILED_BREAK)

I don't know whether KGDB works with THUMB2_KERNEL or not... but this
patch shouldn't break anything that isn't broken already.

Nico and Deepak were involved at some point, maybe they have ideas about
this.  The code in question predates THUMB2_KERNEL and has not been
touched since, but because THUMB2_KERNEL implies !CPU_ENDIAN_BE32, the
first instruction of the asm will be 0xdeff, which is bkpt #0xff.

Other aspects look broken, though.

Maybe it would be wise to make HAVE_ARCH_KGDB conflict with
THUMB2_KERNEL for now.

Cheers
---Dave
