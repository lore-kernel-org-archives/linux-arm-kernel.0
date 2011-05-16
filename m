From: saeed@marvell.com (Saeed Bishara)
Date: Mon, 16 May 2011 14:10:12 +0300
Subject: [PATCH 1/2] ARM: remove unneeded check of the
	cache_is_vipt_nonaliasing()
In-Reply-To: <20110516110032.GO30539@n2100.arm.linux.org.uk>
References: <1305225183-15521-1-git-send-email-saeed@marvell.com>
	<BANLkTim=dmHg_vyfYN6m73z6SQXiVzM7vg@mail.gmail.com>
	<BANLkTikUphZ4azqK50YBZa4uTyU4EystLA@mail.gmail.com>
	<BANLkTikWJzdYOrk4=gte8zOHDVioGAOhhg@mail.gmail.com>
	<BANLkTimFst-+LEuN9cDpAtRiF4aDOipAKA@mail.gmail.com>
	<20110516110032.GO30539@n2100.arm.linux.org.uk>
Message-ID: <FCBE654890C0334289D0AD3AF4EF009F01162C9200E2@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> >>> can you have I a look at this patch?
>> >>> the __sync_icache_dcache() returns if 
>(cache_is_vipt_nonaliasing() &&
>> >>> !pte_exec(pteval)), so later, the if 
>(cache_is_vipt_nonaliasing() ||
>> >>> pte_exec(pteval)) should be equivalent to ?if (pte_exec(pteval))
>> >>
>> >> Your patch looks fine - when cache_is_vipt_nonaliasing(), 
>we always
>> >> have pte_exec() true at the end of this function, so no 
>need for the
>> >> additional check.
>> >>
>> >> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> >
>> > thanks, can you please merge it to your tree.
>> 
>> I could but it may be better for you to just upload it to Russell's
>> patch system (I'm not planning to send any pull requests to Russell,
>> apart from LPAE).
>
>It may also be a good idea to put some description into the 
>commit comment
>so people know why the change is being made.  Eg, the fact you had to
>explain why in a follow up message before you got a response 
>suggests that
>omitting it meant that people had to read the code to work out why the
>patch was being proposed.
Ok what about this (added Catalin's explanation):
commit 1ae2a4434959b5c6b234fa5f6eb5ad9a8e0fba0c
Author: Saeed Bishara <saeed@marvell.com>
Date:   Thu May 12 19:45:25 2011 +0300

    ARM: remove unneeded check of the cache_is_vipt_nonaliasing()

    when cache_is_vipt_nonaliasing(), we always have pte_exec() true at
    the end of this function, so no need for the additional check.

    Acked-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 2b269c9..f1b7998 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -253,8 +253,8 @@ void __sync_icache_dcache(pte_t pteval)

        if (!test_and_set_bit(PG_dcache_clean, &page->flags))
                __flush_dcache_page(mapping, page);
-       /* pte_exec() already checked above for non-aliasing VIPT cache */
-       if (cache_is_vipt_nonaliasing() || pte_exec(pteval))
+
+       if (pte_exec(pteval))
                __flush_icache_all();
 }
 #endif
>
