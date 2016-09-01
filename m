From: liguozhu@hisilicon.com (Liguozhu (Kenneth))
Date: Thu, 1 Sep 2016 03:44:11 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBbYnVnZml4XSByZXBsYWNlIHVubmVzc2FyeSBsZGF4?=
 =?gb2312?Q?_with_common_ldr?=
In-Reply-To: <20160830090721.GC5163@e104818-lin.cambridge.arm.com>
References: <1472538931-145463-1-git-send-email-liguozhu@hisilicon.com>
 <20160830090721.GC5163@e104818-lin.cambridge.arm.com>
Message-ID: <161EFA05D917D0419F95C4CAEEF86C10B0615519@SZXEMA504-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the clarification. 

Add a comment there will be nice:)


-Kenneth Lee (Hisilicon)


-----????-----
???: Catalin Marinas [mailto:catalin.marinas at arm.com] 
????: 2016?8?30? 17:07
???: Liguozhu (Kenneth)
??: Will Deacon; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
??: Re: [PATCH] [bugfix] replace unnessary ldax with common ldr

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
