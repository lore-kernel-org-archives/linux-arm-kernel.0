From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Nov 2011 16:43:55 +0000
Subject: [PATCH 2/4] ARM: suspend: use idmap_pgd instead of suspend_pgd
In-Reply-To: <1321462094-6647-3-git-send-email-will.deacon@arm.com>
References: <1321462094-6647-1-git-send-email-will.deacon@arm.com>
 <1321462094-6647-3-git-send-email-will.deacon@arm.com>
Message-ID: <CAHkRjk7Dfi8Rdnh6rr2=4wY7p4vBG5etKZJd=WshCra1_H8Jfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2011 16:48, Will Deacon <will.deacon@arm.com> wrote:
> The ARM CPU suspend code requires cpu_resume_mmu to be identity mapped
> in order to re-enable the MMU when coming out of suspend. Currently,
> this is accomplished by maintaining a suspend_pgd with the relevant
> mapping put in place at init time.
>
> This patch replaces the use of suspend_pgd with the new idmap_pgd.
> cpu_resume_mmu is placed in the .idmap.text section so that it is
> included in the identity map.
>
> Tested-by: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
...
> diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
> index 93a22d2..8880f94 100644
> --- a/arch/arm/kernel/suspend.c
> +++ b/arch/arm/kernel/suspend.c
> @@ -6,7 +6,7 @@
> ?#include <asm/suspend.h>
> ?#include <asm/tlbflush.h>
>
> -static pgd_t *suspend_pgd;
> +extern pgd_t *idmap_pgd;

We should move the extern declaration to pgtable.h where we have the
identity_mapping_*() function prototypes (we may need this in the
future for other things).

Otherwise,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
