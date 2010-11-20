From: kmpark@infradead.org (Kyungmin Park)
Date: Sat, 20 Nov 2010 12:02:47 +0900
Subject: [PATCH] ARM: Fix spinlock bad magic on disabling nonboot cpu
In-Reply-To: <1290219413-21026-1-git-send-email-ccross@android.com>
References: <1290219413-21026-1-git-send-email-ccross@android.com>
Message-ID: <AANLkTi=d2xL_ZDhQtTE9Vt8SQkHGSM5oespHGT4m6Fav@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I wonder why this patch is not merged previous rc cycles.

it's already reported by Mr. Ham (a month or more ago) and get some
acked for merge.

To Rusell, Catalin,
How to include or commit the latest kernel?

Thank you,
Kyungmin Park

On Sat, Nov 20, 2010 at 11:16 AM, Colin Cross <ccross@android.com> wrote:
> The init_mm.context.id_lock spinlock is not initialized, which
> causes a spinlock bad magic warning when nonboot cpus are disabled,
> either through hotplug or during suspend.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
> ?arch/arm/include/asm/mmu.h | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
> index 68870c7..1556f6a 100644
> --- a/arch/arm/include/asm/mmu.h
> +++ b/arch/arm/include/asm/mmu.h
> @@ -13,6 +13,8 @@ typedef struct {
>
> ?#ifdef CONFIG_CPU_HAS_ASID
> ?#define ASID(mm) ? ? ? ((mm)->context.id & 255)
> +#define INIT_MM_CONTEXT(name) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? ?.context.id_lock = __SPIN_LOCK_UNLOCKED(name.context.id_lock),
> ?#else
> ?#define ASID(mm) ? ? ? (0)
> ?#endif
> --
> 1.7.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>
