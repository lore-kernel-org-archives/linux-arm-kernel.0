From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 30 Dec 2009 16:55:03 +0800
Subject: [PATCH 1/2] pxa: unable to enable L2 in outer cache
In-Reply-To: <771cded00912292327r2622e514wcfdef51594da0aa3@mail.gmail.com>
References: <771cded00912292327r2622e514wcfdef51594da0aa3@mail.gmail.com>
Message-ID: <f17812d70912300055k41b42ef6o621217ebc1a02fb0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2009 at 3:27 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From fced0fdf9c13155169d27310c28ebdfef218b9dc Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 30 Dec 2009 09:31:47 -0500
> Subject: [PATCH] [ARM] pxa: unable to enable L2 in outer cache
>
> Outer cache checked whether L2 is enabled or not. If L2 isn't enabled in XSC3,
> it would enable L2. This operation is evil that would make system hang.
>
> In XSC3 core document, these words are mentioned in below.
>
> "Following reset, the L2 Unified Cache Enable bit is cleared. To enable the L2
> Cache, software may set the bit to a '1' before or at the same time as enabling
> the MMU. Enabling the L2 Cache after the MMU has been enabled or disabling the
> L2 Cache after the L2 Cache has been enabled, may result in unpredictable
> behavior of the processor."
>
> When outer cache is initialized, the MMU is already enabled. We couldn't enable
> L2 after MMU enabled.
>

Yeah, whatever the manual said, it was actually tested on pxa320 and I remember
Nico had proposed a way to enable this by disabling MMU first and then re-enable
it.

Haojian,

Are you spotting this on pxa320 or some other processors?

> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?arch/arm/mm/cache-xsc3l2.c | ? 11 +++++------
> ?1 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mm/cache-xsc3l2.c b/arch/arm/mm/cache-xsc3l2.c
> index 5d180cb..c315492 100644
> --- a/arch/arm/mm/cache-xsc3l2.c
> +++ b/arch/arm/mm/cache-xsc3l2.c
> @@ -221,15 +221,14 @@ static int __init xsc3_l2_init(void)
> ? ? ? ?if (!cpu_is_xsc3() || !xsc3_l2_present())
> ? ? ? ? ? ? ? ?return 0;
>
> - ? ? ? if (!(get_cr() & CR_L2)) {
> + ? ? ? if (get_cr() & CR_L2) {
> ? ? ? ? ? ? ? ?pr_info("XScale3 L2 cache enabled.\n");
> - ? ? ? ? ? ? ? adjust_cr(CR_L2, CR_L2);
> ? ? ? ? ? ? ? ?xsc3_l2_inv_all();
> - ? ? ? }
>
> - ? ? ? outer_cache.inv_range = xsc3_l2_inv_range;
> - ? ? ? outer_cache.clean_range = xsc3_l2_clean_range;
> - ? ? ? outer_cache.flush_range = xsc3_l2_flush_range;
> + ? ? ? ? ? ? ? outer_cache.inv_range = xsc3_l2_inv_range;
> + ? ? ? ? ? ? ? outer_cache.clean_range = xsc3_l2_clean_range;
> + ? ? ? ? ? ? ? outer_cache.flush_range = xsc3_l2_flush_range;
> + ? ? ? }

What's the difference here? Sorry am in gmail and cann't see exactly.

>
> ? ? ? ?return 0;
> ?}
> --
> 1.5.6.5
>
