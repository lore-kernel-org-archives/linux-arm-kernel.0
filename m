From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 24 Jul 2013 15:48:08 +0100
Subject: [PATCH 02/14] ARM: asm: Add ARM_BE8() assembly helper
In-Reply-To: <20130724142825.GK11072@mudshark.cambridge.arm.com>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-3-git-send-email-ben.dooks@codethink.co.uk>
 <20130724142825.GK11072@mudshark.cambridge.arm.com>
Message-ID: <51EFE928.2070907@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/13 15:28, Will Deacon wrote:
> On Wed, Jul 24, 2013 at 11:27:50AM +0100, Ben Dooks wrote:
>> Add ARM_BE8() helper to wrap any code conditional on being
>> compile when CONFIG_ARM_ENDIAN_BE8 is selected and convert
>> existing places where this is to use it.
>>
>> Acked-by: Nicolas Pitre<nico@linaro.org>
>> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
>
> Reviewed-by: Will Deacon<will.deacon@arm.com>
>
> We could probably add a similar ARM_LE helper to clean up the
> __LITTLE_ENDIAN definitions in arch/arm/net/bpf_jit_32.c too.
>
> Will

I did however realise we need to fix the instruction storage
so changed _emit to fix this as follows:

     ARM: net: fix arm instruction endian-ness in bpf_jit_32.c

     Use <asm/opcodes.h> to correctly transform instruction byte ordering
     into in-memory ordering.

     Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 1a643ee..95b43b6 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -19,6 +19,7 @@
  #include <linux/if_vlan.h>
  #include <asm/cacheflush.h>
  #include <asm/hwcap.h>
+#include <asm/opcodes.h>

  #include "bpf_jit_32.h"

@@ -113,8 +114,11 @@ static u32 jit_udiv(u32 dividend, u32 divisor)

  static inline void _emit(int cond, u32 inst, struct jit_ctx *ctx)
  {
+       inst |= (cond << 28);
+       inst = __opcode_to_mem_arm(inst);
+
         if (ctx->target != NULL)
-               ctx->target[ctx->idx] = inst | (cond << 28);
+               ctx->target[ctx->idx] = inst;

         ctx->idx++;
  }

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
