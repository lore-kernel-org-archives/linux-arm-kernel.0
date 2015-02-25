From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Feb 2015 16:58:35 +0100
Subject: [RFC PATCH] arm: asm/cmpxchg.h: Add support half-word xchg()
In-Reply-To: <1424878581-11701-1-git-send-email-bobby.prani@gmail.com>
References: <1424878581-11701-1-git-send-email-bobby.prani@gmail.com>
Message-ID: <3465519.0ga9zC7F7b@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 February 2015 10:36:20 Pranith Kumar wrote:
> This patch adds support for a half-word xchg() for ARM using ldrexh/strexh
> instructions. It also fixes an asm comment  for __cmpxchg2.
> 
> Currently using a half-word xchg() results in the following splat on an ARMv7
> machine.
> 
> [   45.833303] xchg: bad data size: pc 0xbe806020, ptr 0xeb18deee, size 2
> [   45.833324] ------------[ cut here ]------------
> [   45.837939] kernel BUG at /dvs/git/dirty/git-master_linux/kernel/arch/arm/kernel/traps.c:727!
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

Unfortunately, the BUG message seems incomplete, can you reproduce this
with CONFIG_DEBUG_BUGVERBOSE enabled?

>  arch/arm/include/asm/cmpxchg.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> index abb2c37..9505cca 100644
> --- a/arch/arm/include/asm/cmpxchg.h
> +++ b/arch/arm/include/asm/cmpxchg.h
> @@ -50,6 +50,16 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>  			: "r" (x), "r" (ptr)
>  			: "memory", "cc");
>  		break;
> +	case 2:
> +		asm volatile("@	__xchg2\n"
> +		"1:	ldrexh	%0, [%3]\n"
> +		"	strexh	%1, %2, [%3]\n"
> +		"	teq	%1, #0\n"
> +		"	bne	1b"
> +			: "=&r" (ret), "=&r" (tmp)
> +			: "r" (x), "r" (ptr)
> +			: "memory", "cc");
> +		break;
>  	case 4:
>  		asm volatile("@	__xchg4\n"
>  		"1:	ldrex	%0, [%3]\n"

Does this work on all ARMv6 or just ARMv6k?

	Arnd
