From: james.morse@arm.com (James Morse)
Date: Tue, 9 Oct 2018 14:25:17 +0100
Subject: [PATCH] arm64: mm: Use #ifdef for the __PAGETABLE_P?D_FOLDED
 defines
In-Reply-To: <CAMuHMdUFzHUJk7dT9CqF1uCg3bPr-Mh6LWTj6RpdcXLPRQkFEw@mail.gmail.com>
References: <20181005134916.12937-1-james.morse@arm.com>
 <CAMuHMdUFzHUJk7dT9CqF1uCg3bPr-Mh6LWTj6RpdcXLPRQkFEw@mail.gmail.com>
Message-ID: <5eeebac5-b296-219d-f768-f81eaeec5498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert!

On 09/10/2018 13:37, Geert Uytterhoeven wrote:
> On Fri, Oct 5, 2018 at 3:55 PM James Morse <james.morse@arm.com> wrote:
>> __is_defined(__PAGETABLE_P?D_FOLDED) doesn't quite work as intended
>> as these symbols are internal to asm-generic and aren't defined in the
>> way kconfig expects. This makes them always evaluate to false.
>> Switch to #ifdef.

> This is now e9ed821be48600ea ("arm64: mm: Use #ifdef for the
> __PAGETABLE_P?D_FOLDED defines") in arm64/for-next/core.
> 
> If CONFIG_DEBUG_VIRTUAL=y, it prints a few times during boot on
> several R-Car Gen3 platforms:

Aha, I didn't test this with debug-virtual ... and the new __pa() to setup the
fixmap for swapper is what is causing this:

>From arch/arm64/mm/mmu.c:
| void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
| {
| 	pgd_t *fixmap_pgdp;
|
|	spin_lock(&swapper_pgdir_lock);
|	fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
|	WRITE_ONCE(*fixmap_pgdp, pgd);

This patch is just exposing the problem on your configuration, its commit
2330b7ca78350efcb ("arm64/mm: use fixmap to modify swapper_pg_dir") that missed
this.

We always know pgdp here will point within swapper_pg_dir, so I think its fair
to switch this to the __pa_symbol() version. This fixes it for me:
--------------------------%<--------------------------
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6f0e2edcc114..6deb836a102a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -74,7 +74,7 @@ void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
        pgd_t *fixmap_pgdp;

        spin_lock(&swapper_pgdir_lock);
-       fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
+       fixmap_pgdp = pgd_set_fixmap(__pa_symbol(pgdp));
        WRITE_ONCE(*fixmap_pgdp, pgd);
        /*
         * We need dsb(ishst) here to ensure the page-table-walker sees
--------------------------%<--------------------------

(which I will post shortly).

Passing not-a-symbol-name to __pa_symbol() doesn't look nice, but lm_alias()
would do this too. Manually calculating the offset in swapper_pg_dir is some
logic that is already wrapped up in pgd_set_fixmap().


Thanks!

James
