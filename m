From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 17 Jun 2010 17:28:14 +0800
Subject: [PATCH 04/10] arm/zImage: fix comments for cache_on, cache_off
	and cache_clean_flush
In-Reply-To: <1276165636-20150-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100610102427.GC31057@pengutronix.de>
	<1276165636-20150-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTimZeF_tZ6lApQRbRFdPYugb1JbnT8bGfpiOlm3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> This adds missing registers to the list of corrupted registers and
> removes a wrong comment about r9 on entry
>
> While at it the formatting of the comment to cache_off is changed to
> resemble the other two.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> ?arch/arm/boot/compressed/head.S | ? 11 ++++++-----
> ?1 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 4058294..f8a210b 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -339,9 +339,8 @@ params: ? ? ? ? ? ? ldr ? ? r0, =params_phys
> ?* ?r4 = kernel execution address
> ?* ?r7 = architecture number
> ?* ?r8 = atags pointer
> - * ?r9 = run-time address of "start" ?(???)

OK. r9 is actually loaded with CPUID at the very first of call_cache_fn,
so I seriously doubt its usage on entrance.

> ?* On exit,
> - * ?r1, r2, r3, r9, r10, r12 corrupted
> + * ?r0, r1, r2, r3, r9, r10, r12 corrupted

OK.

> ?* This routine must preserve:
> ?* ?r4, r5, r6, r7, r8
> ?*/
> @@ -774,8 +773,10 @@ proc_types:
> ?* Turn off the Cache and MMU. ?ARMv3 does not support
> ?* reading the control register, but ARMv4 does.
> ?*
> - * On exit, r0, r1, r2, r3, r9, r12 corrupted
> - * This routine must preserve: r4, r6, r7
> + * On exit,
> + * ?r0, r1, r2, r3, r9, r12 corrupted
> + * This routine must preserve:
> + * ?r4, r6, r7

OK, as talked, this looks to align with other comments in this file.

> ?*/
> ? ? ? ? ? ? ? ?.align ?5
> ?cache_off: ? ? mov ? ? r3, #12 ? ? ? ? ? ? ? ? @ cache_off function
> @@ -848,7 +849,7 @@ __armv3_mmu_cache_off:
> ?* Clean and flush the cache to maintain consistency.
> ?*
> ?* On exit,
> - * ?r1, r2, r3, r9, r11, r12 corrupted
> + * ?r1, r2, r3, r9, r10, r11, r12 corrupted

OK, took another look and r10 is corrupted in __armv7_mmu_cache_flush,
where it's used to hold the ID_MMFR1.

> ?* This routine must preserve:
> ?* ?r0, r4, r5, r6, r7
> ?*/

So,

Acked-by: Eric Miao <eric.miao@canonical.com>
