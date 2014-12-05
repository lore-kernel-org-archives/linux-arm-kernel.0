From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 5 Dec 2014 16:23:47 +0000
Subject: [PATCH] arm: mm: dump: don't skip final region
In-Reply-To: <1417782016-11825-1-git-send-email-mark.rutland@arm.com>
References: <1417782016-11825-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAPvkgC1oOU_3D03ZV-uZqTW_DX8J74oGEKQZTTi2YrC+oSqJyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2014 at 12:20, Mark Rutland <mark.rutland@arm.com> wrote:
> If the final page table entry we walk is a valid mapping, the page table
> dumping code will not log the region this entry is part of, as the final
> note_page call in walk_pgd will trigger an early return. Luckily this
> isn't seen on contemporary systems as they typically don't have enough
> RAM to extend the linear mapping right to the end of the address space.
>
> In note_page, we log a region when we reach its end (i.e. we hit an
> entry immediately afterwards which has different prot bits or is
> invalid). The final entry has no subsequent entry, so we will not log
> this immediately. We try to cater for this with a subsequent call to
> note_page in ptdump_show, but this returns early as 0 is less than
> USER_PGTABLES_CEILING, and hence we will skip a valid mapping if it
> spans to the final entry we note.
>
> Luckily, the final note_page call has level == 0, while all prior calls
> have a non-zero level, so if we also check level we will both skip user
> entries and handle the final note_page call correctly. Due to the way
> addr is constructed in the walk_* functions, it can never be less than
> LOWEST_ADDR when walking the page tables, so it is not necessary to
> avoid dereferencing invalid table addresses. The existing checks for
> st->current_prot and st->marker[1].start_address are sufficient to
> ensure we will not print and/or dereference garbage when trying to log
> information.

Do you mean USER_PGTABLES_CEILING instead of LOWEST_ADDR?

>
> This patch adds the aformentioned check for level, ensuring we log all
> regions in the kernel mappings, including those which span right to the
> end of the address space.
>

One comment above, then:
Acked-by: Steve Capper <steve.capper@linaro.org>

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Steve Capper <steve.capper@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/mm/dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I found this via inspection, rather than being hit by the problem described
> above, but it seemed worthwhile to fix this up (otherwise the final note_page
> call is pointless).
>
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> index 5942493..f459c0d 100644
> --- a/arch/arm/mm/dump.c
> +++ b/arch/arm/mm/dump.c
> @@ -220,7 +220,7 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level, u
>         static const char units[] = "KMGTPE";
>         u64 prot = val & pg_level[level].mask;
>
> -       if (addr < USER_PGTABLES_CEILING)
> +       if (level && addr < USER_PGTABLES_CEILING)
>                 return;
>
>         if (!st->level) {
> --
> 1.9.1
>
