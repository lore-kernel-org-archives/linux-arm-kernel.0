From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 12:00:32 +0100
Subject: [PATCH 1/2] ARM: remove unneeded check of the
	cache_is_vipt_nonaliasing()
In-Reply-To: <BANLkTimFst-+LEuN9cDpAtRiF4aDOipAKA@mail.gmail.com>
References: <1305225183-15521-1-git-send-email-saeed@marvell.com>
	<BANLkTim=dmHg_vyfYN6m73z6SQXiVzM7vg@mail.gmail.com>
	<BANLkTikUphZ4azqK50YBZa4uTyU4EystLA@mail.gmail.com>
	<BANLkTikWJzdYOrk4=gte8zOHDVioGAOhhg@mail.gmail.com>
	<BANLkTimFst-+LEuN9cDpAtRiF4aDOipAKA@mail.gmail.com>
Message-ID: <20110516110032.GO30539@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 09:38:00AM +0100, Catalin Marinas wrote:
> On 16 May 2011 08:39, saeed bishara <saeed.bishara@gmail.com> wrote:
> >>>> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> >>>> ---
> >>>> ?arch/arm/mm/flush.c | ? ?4 ++--
> >>>> ?1 files changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> >>>> index 2b269c9..f1b7998 100644
> >>>> --- a/arch/arm/mm/flush.c
> >>>> +++ b/arch/arm/mm/flush.c
> >>>> @@ -253,8 +253,8 @@ void __sync_icache_dcache(pte_t pteval)
> >>>>
> >>>> ? ? ? ?if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> >>>> ? ? ? ? ? ? ? ?__flush_dcache_page(mapping, page);
> >>>> - ? ? ? /* pte_exec() already checked above for non-aliasing VIPT cache */
> >>>> - ? ? ? if (cache_is_vipt_nonaliasing() || pte_exec(pteval))
> >>>> +
> >>>> + ? ? ? if (pte_exec(pteval))
> >>>> ? ? ? ? ? ? ? ?__flush_icache_all();
> >>>> ?}
> >>>> ?#endif
> >>> can you have I a look at this patch?
> >>> the __sync_icache_dcache() returns if (cache_is_vipt_nonaliasing() &&
> >>> !pte_exec(pteval)), so later, the if (cache_is_vipt_nonaliasing() ||
> >>> pte_exec(pteval)) should be equivalent to ?if (pte_exec(pteval))
> >>
> >> Your patch looks fine - when cache_is_vipt_nonaliasing(), we always
> >> have pte_exec() true at the end of this function, so no need for the
> >> additional check.
> >>
> >> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > thanks, can you please merge it to your tree.
> 
> I could but it may be better for you to just upload it to Russell's
> patch system (I'm not planning to send any pull requests to Russell,
> apart from LPAE).

It may also be a good idea to put some description into the commit comment
so people know why the change is being made.  Eg, the fact you had to
explain why in a follow up message before you got a response suggests that
omitting it meant that people had to read the code to work out why the
patch was being proposed.
