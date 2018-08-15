From: yaojun8558363@gmail.com (Jun Yao)
Date: Wed, 15 Aug 2018 18:26:06 +0800
Subject: [PATCH v3 3/5] arm64/mm: Create initial page tables in init_pg_dir
In-Reply-To: <41a18121-c91d-f9ec-87c3-8dba7931b517@arm.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-4-yaojun8558363@gmail.com>
 <3977afaa-63ae-e390-7660-4d25146140b8@arm.com>
 <41a18121-c91d-f9ec-87c3-8dba7931b517@arm.com>
Message-ID: <20180815102606.GA2274@toy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Fri, Jul 06, 2018 at 03:41:07PM +0100, James Morse wrote:
> I missed one: head.S has a call to kasan_early_init() before start_kernel(),
> this goes messing with the page tables, and calls pgd_offset_k(), which pulls in
> swapper_pg_dir. This one is enabled by CONFIG_KASAN.
> 
> Something like that same hunk [0] in kasan_early_init() fixes it. This is still
> within arch/arm64, so I still think we should get away without some #ifdeffery
> to override the core-code's initial setup of swapper_pg_dir...

I'm sorry to reply you so late, I missed this email before.

In order to ensure that pgd_offset_k() works properly, I update
init_mm.pgd by introducing set_init_mm_pgd(). And its implementation is
like this:

>diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>index 65f86271f02b..e4f0868b4cfd 100644
>--- a/arch/arm64/mm/mmu.c
>+++ b/arch/arm64/mm/mmu.c
>@@ -623,6 +623,19 @@ static void __init map_kernel(pgd_t *pgdp)
>        kasan_copy_shadow(pgdp);
> }
>
>+void __init set_init_mm_pgd(pgd_t *pgd)
>+{
>+       pgd_t **addr = &(init_mm.pgd);
>+
>+       asm volatile("str %x0, [%1]\n"
>+                   : : "r" (pgd), "r" (addr) : "memory");
>+}
> /*
>  * paging_init() sets up the page tables, initialises the zone memory
>  * maps and sets up the zero page.

The purpose of using assembly is to prevent KASAN instrumentation, as
KASAN has not been initialized when this function is called:

>diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>index c3e4b1886cde..ede2e964592b 100644
>--- a/arch/arm64/kernel/head.S
>+++ b/arch/arm64/kernel/head.S
>@@ -439,6 +438,9 @@ __primary_switched:
>        bl      __pi_memset
>        dsb     ishst                           // Make zero page visible to PTW
>
>+       adrp    x0, init_pg_dir
>+       bl      set_init_mm_pgd
>+
> #ifdef CONFIG_KASAN
>        bl      kasan_early_init
> #endif

What do you think?
