From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Jul 2015 16:49:41 +0100
Subject: [PATCH v3 4/5] arm64: add KASAN support
In-Reply-To: <1437561037-31995-5-git-send-email-a.ryabinin@samsung.com>
References: <1437561037-31995-1-git-send-email-a.ryabinin@samsung.com>
 <1437561037-31995-5-git-send-email-a.ryabinin@samsung.com>
Message-ID: <20150722154941.GE16627@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 01:30:36PM +0300, Andrey Ryabinin wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 318175f..61ebb7c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -46,6 +46,7 @@ config ARM64
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_BITREVERSE
>  	select HAVE_ARCH_JUMP_LABEL
> +	select HAVE_ARCH_KASAN if SPARSEMEM_VMEMMAP
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_TRACEHOOK
> @@ -122,6 +123,22 @@ config GENERIC_CSUM
>  config GENERIC_CALIBRATE_DELAY
>  	def_bool y
>  
> +config KASAN_SHADOW_OFFSET
> +	hex
> +	depends on KASAN
> +	default 0xdfff200000000000 if ARM64_VA_BITS_48
> +	default 0xdffffc8000000000 if ARM64_VA_BITS_42
> +	default 0xdfffff9000000000 if ARM64_VA_BITS_39
> +	help
> +	  This value used to address to corresponding shadow address

"This value is used to map an address to the corresponding shadow
address..." (unless you meant something else but the above doesn't read
well).

> +	  by the following formula:
> +	      shadow_addr = (address >> 3) + KASAN_SHADOW_OFFSET;
> +
> +	  (1 << 61) shadow addresses - [KASAN_SHADOW_OFFSET,KASAN_SHADOW_END]
> +	  cover all 64-bits of virtual addresses. So KASAN_SHADOW_OFFSET
> +	  should satisfy the following equation:
> +	      KASAN_SHADOW_OFFSET = KASAN_SHADOW_END - (1ULL << 61)

I think we should generate KASAN_SHADOW_OFFSET in the Makefile directly
using some awk snippet/script (we are going to get a 47-bit VA as well
with 16KB page configuration):

---------8<-----------------
#!/bin/awk -f

BEGIN {
	# 32-bit arithmetics
	va_bits = ARGV[1] - 32
	va_start = and(0xffffffff, lshift(0xffffffff, va_bits))
	shadow_end = va_start + lshift(1, va_bits - 3)
	shadow_offset = shadow_end - lshift(1, 64 - 3 - 32)
	printf("0x%x00000000\n", shadow_offset)
}
-------8<-----------------


Otherwise the code looks fine.

-- 
Catalin
