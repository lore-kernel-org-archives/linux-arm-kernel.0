From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 06 Jan 2014 15:45:28 +0000
Subject: [PATCH 1/2] ARM: dcache: select DCACHE_WORD_ACCESS for big-endian
 CPUs
In-Reply-To: <1387282577-2753-1-git-send-email-will.deacon@arm.com>
References: <1387282577-2753-1-git-send-email-will.deacon@arm.com>
Message-ID: <52CACF98.6010300@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/13 12:16, Will Deacon wrote:
> With commit 11ec50caedb5 ("word-at-a-time: provide generic big-endian
> zero_bytemask implementation"), the asm-generic word-at-a-time code now
> provides a zero_bytemask implementation, allowing us to make use of
> DCACHE_WORD_ACCESS on big-endian CPUs, providing our
> load_unaligned_zeropad function is endianness-clean.
>
> This patch reworks the load_unaligned_zeropad fixup code to work for
> both big- and little-endian CPUs, then removes the !CPU_BIG_ENDIAN check
> when selecting DCACHE_WORD_ACCESS.


> @@ -73,7 +77,11 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>   	"	bic	%2, %2, #0x3\n"
>   	"	ldr	%0, [%2]\n"
>   	"	lsl	%1, %1, #0x3\n"
> +#ifndef __ARMEB__
>   	"	lsr	%0, %0, %1\n"
> +#else
> +	"	lsl	%0, %0, %1\n"
> +#endif

IIRC we have ARM_BE() and ARM_LE() helpers for this


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
