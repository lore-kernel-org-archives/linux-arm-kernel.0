From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Aug 2016 10:07:21 +0100
Subject: [PATCH] [bugfix] replace unnessary ldax with common ldr
In-Reply-To: <1472538931-145463-1-git-send-email-liguozhu@hisilicon.com>
References: <1472538931-145463-1-git-send-email-liguozhu@hisilicon.com>
Message-ID: <20160830090721.GC5163@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 02:35:31PM +0800, Kenneth Lee wrote:
> (add comment for the previous mail, sorry for the duplication)
> 
> There is no store_ex pairing with this load_ex. It is not necessary and
> gave wrong hint to the cache system.
> 
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> ---
>  arch/arm64/include/asm/spinlock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
> index c85e96d..3334c4f 100644
> --- a/arch/arm64/include/asm/spinlock.h
> +++ b/arch/arm64/include/asm/spinlock.h
> @@ -63,7 +63,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>  	 */
>  "	sevl\n"
>  "2:	wfe\n"
> -"	ldaxrh	%w2, %4\n"
> +"	ldrh	%w2, %4\n"
>  "	eor	%w1, %w2, %w0, lsr #16\n"
>  "	cbnz	%w1, 2b\n"
>  	/* We got the lock. Critical section starts here. */

This is needed because the arch_spin_unlock() code only uses an STLR
without an explicit SEV (like we have on AArch32). An event is
automatically generated when the exclusive monitor is cleared by STLR.
But without setting it with a load exclusive in arch_spin_lock() (even
though it does not acquire the lock), there won't be anything to clear,
hence no event to be generated. In this case, the WFE would wait
indefinitely.

-- 
Catalin
