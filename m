From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 20 Jan 2011 10:32:58 -0500
Subject: [PATCH] ARM: pxa: fix mfpr_sync to read from valid offset
In-Reply-To: <1295446734-18464-1-git-send-email-ytang5@marvell.com>
References: <1295446734-18464-1-git-send-email-ytang5@marvell.com>
Message-ID: <AANLkTikuqZkOVReznUM0FuJy7t3SiT+NV-3syRd0BA=H@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 9:18 AM, Yu Tang <ytang5@marvell.com> wrote:
> Since mfpr_mmio_base[0] is not always valid on later SoCs,
> fixed mpfr_sync() to read back from valid mfp offset always.
>
> Signed-off-by: Yu Tang <ytang5@marvell.com>

Good catch. Applied to 'fix'. Thanks Yu!

> ---
> ?arch/arm/plat-pxa/mfp.c | ? ?8 ++++++--
> ?1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/mfp.c b/arch/arm/plat-pxa/mfp.c
> index b77e018..a9aa5ad 100644
> --- a/arch/arm/plat-pxa/mfp.c
> +++ b/arch/arm/plat-pxa/mfp.c
> @@ -139,10 +139,11 @@ static const unsigned long mfpr_edge[] = {
> ?#define mfp_configured(p) ? ? ?((p)->config != -1)
>
> ?/*
> - * perform a read-back of any MFPR register to make sure the
> + * perform a read-back of any valid MFPR register to make sure the
> ?* previous writings are finished
> ?*/
> -#define mfpr_sync() ? ?(void)__raw_readl(mfpr_mmio_base + 0)
> +static unsigned long mfpr_off_readback;
> +#define mfpr_sync() ? ?(void)__raw_readl(mfpr_mmio_base + mfpr_off_readback)
>
> ?static inline void __mfp_config_run(struct mfp_pin *p)
> ?{
> @@ -248,6 +249,9 @@ void __init mfp_init_addr(struct mfp_addr_map *map)
>
> ? ? ? ?spin_lock_irqsave(&mfp_spin_lock, flags);
>
> + ? ? ? /* mfp offset for readback */
> + ? ? ? mfpr_off_readback = map[0].offset;
> +
> ? ? ? ?for (p = map; p->start != MFP_PIN_INVALID; p++) {
> ? ? ? ? ? ? ? ?offset = p->offset;
> ? ? ? ? ? ? ? ?i = p->start;
> --
> 1.7.1
>
>
