From: saeed.bishara@gmail.com (saeed bishara)
Date: Sun, 15 May 2011 17:48:24 +0300
Subject: [PATCH 1/2] ARM: remove unneeded check of the
	cache_is_vipt_nonaliasing()
In-Reply-To: <1305225183-15521-1-git-send-email-saeed@marvell.com>
References: <1305225183-15521-1-git-send-email-saeed@marvell.com>
Message-ID: <BANLkTim=dmHg_vyfYN6m73z6SQXiVzM7vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 9:33 PM, Saeed Bishara <saeed@marvell.com> wrote:
>
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
> ?arch/arm/mm/flush.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 2b269c9..f1b7998 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -253,8 +253,8 @@ void __sync_icache_dcache(pte_t pteval)
>
> ? ? ? ?if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> ? ? ? ? ? ? ? ?__flush_dcache_page(mapping, page);
> - ? ? ? /* pte_exec() already checked above for non-aliasing VIPT cache */
> - ? ? ? if (cache_is_vipt_nonaliasing() || pte_exec(pteval))
> +
> + ? ? ? if (pte_exec(pteval))
> ? ? ? ? ? ? ? ?__flush_icache_all();
> ?}
> ?#endif
can you have I a look at this patch?
the __sync_icache_dcache() returns if (cache_is_vipt_nonaliasing() &&
!pte_exec(pteval)), so later, the if (cache_is_vipt_nonaliasing() ||
pte_exec(pteval)) should be equivalent to  if (pte_exec(pteval))

saeed
