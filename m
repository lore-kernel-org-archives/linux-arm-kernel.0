From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Oct 2017 14:05:05 +0100
Subject: [PATCH] arm64: Fix flush_icache_range prototype
In-Reply-To: <20171023125414.10758-1-marc.zyngier@arm.com>
References: <20171023125414.10758-1-marc.zyngier@arm.com>
Message-ID: <20171023130504.GF31263@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 01:54:14PM +0100, Marc Zyngier wrote:
> flush_icache_range can return -EFAULT, and yet its prototype
> has void as a return type. Fix it by aligning it to that of
> __flush_cache_user_range.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/cacheflush.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 76d1cc85d5b1..377fa6b5d67f 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -65,7 +65,7 @@
>   *		- kaddr  - page address
>   *		- size   - region size
>   */
> -extern void flush_icache_range(unsigned long start, unsigned long end);
> +extern long flush_icache_range(unsigned long start, unsigned long end);

Oh blimey, I hadn't realised that. However, this is used in the core code,
which expects a void return type and I'd like to avoid the risk of compiler
warnings complaining that the returned value is not used. I don't think
there's a problem with leaving this as void, since the PCS already says
that x0 is caller saved and this is out-of-line asm.

It just means that we silently handle userspace addresses, rather than
trigger a panic in the absence of software-PAN.

Will
