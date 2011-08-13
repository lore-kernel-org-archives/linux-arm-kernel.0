From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 13 Aug 2011 15:14:30 +0100
Subject: [PATCH] Fix non-LPAE boot regression.
In-Reply-To: <1313240299-24712-1-git-send-email-anarsoul@gmail.com>
References: <201108131556.27301.anarsoul@gmail.com>
	<1313240299-24712-1-git-send-email-anarsoul@gmail.com>
Message-ID: <CAHkRjk4p1kqwKGiW_XRFU0aap98QkvRGRs0hwsBR4CcfM5RKqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, 13 August 2011, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> It was introduced by ?407f8b4cb07cbc5c1c7cc386f231224e2524ccea
> ARM: LPAE: MMU setup for the 3-level page table format
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> ?arch/arm/kernel/head.S | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 0bdafc4..5add5f5 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -206,7 +206,7 @@ __create_page_tables:
> ?1: ? ? orr ? ? r3, r7, r5, lsl #SECTION_SHIFT ?@ flags + kernel base
>  ? ? ? ?str ? ? r3, [r4, r5, lsl #PMD_ORDER] ? ?@ identity mapping
>  ? ? ? ?cmp ? ? r5, r6
> - ? ? ? addlo ? r5, r5, #SECTION_SHIFT >> 20 ? ?@ next section
> + ? ? ? addlo ? r5, r5, #1 ? ? ? ? ? ? ? ? ? ? ?@ next section
>  ? ? ? ?blo ? ? 1b

Thanks for this. The original code was indeed broken but I think the
fix should be to use SECTION_SIZE instead of SHIFT. I'll have a look
on Monday.

-- 
Catalin
