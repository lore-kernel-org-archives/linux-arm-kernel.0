From: joe@perches.com (Joe Perches)
Date: Sun, 26 Oct 2014 23:46:11 -0700
Subject: [RFC V2] arm/arm64:add CONFIG_HAVE_ARCH_BITREVERSE to support
 rbit instruction
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
Message-ID: <1414392371.8884.2.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-10-27 at 14:37 +0800, Wang, Yalin wrote:
> this change add CONFIG_HAVE_ARCH_BITREVERSE config option,
> so that we can use arm/arm64 rbit instruction to do bitrev operation
> by hardware.
> 
> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> ---
>  arch/arm/Kconfig                |  1 +
>  arch/arm/include/asm/bitrev.h   | 21 +++++++++++++++++++++
>  arch/arm64/Kconfig              |  1 +
>  arch/arm64/include/asm/bitrev.h | 21 +++++++++++++++++++++
>  include/linux/bitrev.h          |  9 +++++++++
>  lib/Kconfig                     |  9 +++++++++
>  lib/bitrev.c                    |  2 ++
>  7 files changed, 64 insertions(+)
>  create mode 100644 arch/arm/include/asm/bitrev.h
>  create mode 100644 arch/arm64/include/asm/bitrev.h
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 89c4b5c..426cbcc 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -16,6 +16,7 @@ config ARM
>  	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select GENERIC_ALLOCATOR
>  	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
> +	select HAVE_ARCH_BITREVERSE if (CPU_V7M || CPU_V7)
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select GENERIC_IDLE_POLL_SETUP
>  	select GENERIC_IRQ_PROBE
> diff --git a/arch/arm/include/asm/bitrev.h b/arch/arm/include/asm/bitrev.h
> new file mode 100644
> index 0000000..0df5866
> --- /dev/null
> +++ b/arch/arm/include/asm/bitrev.h
> @@ -0,0 +1,21 @@
> +#ifndef __ASM_ARM_BITREV_H
> +#define __ASM_ARM_BITREV_H
> +
> +static inline __attribute_const__ u32 __arch_bitrev32(u32 x)
> +{
> +	__asm__ ("rbit %0, %1" : "=r" (x) : "r" (x));
> +	return x;
> +}
> +
> +static inline __attribute_const__ u16 __arch_bitrev16(u16 x)
> +{
> +	return __arch_bitrev32((u32)x) >> 16;
> +}
> +
> +static inline __attribute_const__ u8 __arch_bitrev8(u8 x)
> +{
> +	return __arch_bitrev32((u32)x) >> 24;
> +}
> +
> +#endif
> +
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 9532f8d..263c28c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -36,6 +36,7 @@ config ARM64
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_JUMP_LABEL
> +	select HAVE_ARCH_BITREVERSE
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_BPF_JIT
> diff --git a/arch/arm64/include/asm/bitrev.h b/arch/arm64/include/asm/bitrev.h
> new file mode 100644
> index 0000000..5d24c11
> --- /dev/null
> +++ b/arch/arm64/include/asm/bitrev.h
> @@ -0,0 +1,21 @@
> +#ifndef __ASM_ARM_BITREV_H
> +#define __ASM_ARM_BITREV_H
> +
> +static inline __attribute_const__ u32 __arch_bitrev32(u32 x)
> +{
> +	__asm__ ("rbit %w0, %w1" : "=r" (x) : "r" (x));
> +	return x;
> +}
> +
> +static inline __attribute_const__ u16 __arch_bitrev16(u16 x)
> +{
> +	return __arch_bitrev32((u32)x) >> 16;
> +}
> +
> +static inline __attribute_const__ u8 __arch_bitrev8(u8 x)
> +{
> +	return __arch_bitrev32((u32)x) >> 24;
> +}
> +
> +#endif
> +
> diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
> index 7ffe03f..ef5b2bb 100644
> --- a/include/linux/bitrev.h
> +++ b/include/linux/bitrev.h
> @@ -3,6 +3,14 @@
>  
>  #include <linux/types.h>
>  
> +#ifdef CONFIG_HAVE_ARCH_BITREVERSE
> +#include <asm/bitrev.h>
> +
> +#define bitrev32 __arch_bitrev32
> +#define bitrev16 __arch_bitrev16
> +#define bitrev8 __arch_bitrev8
> +
> +#else
>  extern u8 const byte_rev_table[256];

If this is done, the direct uses of byte_rev_table in
drivers/net/wireless/ath/carl9170/phy.c and
sound/usb/6fire/firmware.c should be converted too?
