From: ccross@android.com (Colin Cross)
Date: Wed, 23 Feb 2011 13:03:07 -0800
Subject: [PATCH v2] ARM: Tegra: DMA: Fail safe if initialization fails
In-Reply-To: <1298491602-20072-1-git-send-email-swarren@nvidia.com>
References: <1298491602-20072-1-git-send-email-swarren@nvidia.com>
Message-ID: <AANLkTimrhHO=kWp9c__qfub3jBYrpsjy5J2zKb+LCnsh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 12:06 PM, Stephen Warren <swarren@nvidia.com> wrote:
> tegra_dma_init currently simply bails out early if any initialization fails.
> This skips various data-structure initialization. In turn, this means that
> tegra_dma_allocate_channel can still hand out channels. In this case, when
> tegra_dma_free_channel is called, which calls tegra_dma_cancel, the walking
> on ch->list will OOPS since the list's next/prev pointers may still be
> NULL.
>
> To solve this, add an explicit "initialized" flag, only set this once _init
> has fully completed successfully, and have _allocate_channel refuse to hand
> out channels if this is not set.
>
> While at it, simplify _init:
> * Remove redundant memsets
> * Use bitmap_fill to mark all channels as in-use up-front, and remove
> ?some now-redundant bitmap initialization loops.
> * Only mark a channel as free once all channel-related initialization has
> ?completed.
>
> Finally, the successful exit path from _init always has ret==0, so just
> hard-code that return. The error path still returns ret.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2:
> * Added explicit initialized flag. I chose not to re-use the shared-channel
> ?bitmap entry for this purpose, since that bit needs to be marked in-use
> ?so that the non-shared-channel path doesn't hand out that channel.
> * Removed redundant memsets
> * Use bitmap_fill instead of a loop
> * Hard-code success return value
>
> ?arch/arm/mach-tegra/dma.c | ? 23 ++++++++++-------------
> ?1 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
> index bd4f62a..01db832 100644
> --- a/arch/arm/mach-tegra/dma.c
> +++ b/arch/arm/mach-tegra/dma.c
> @@ -127,8 +127,8 @@ struct tegra_dma_channel {
>
> ?#define ?NV_DMA_MAX_CHANNELS ?32
>
> +static int initialized;
Use a bool, and call it something like tegra_dma_initialized to
prevent warnings if someone else forgets a static on a variable called
initialized.

> ?static DEFINE_MUTEX(tegra_dma_lock);
> -
Unnecessary whitespace change

> ?static DECLARE_BITMAP(channel_usage, NV_DMA_MAX_CHANNELS);
> ?static struct tegra_dma_channel dma_channels[NV_DMA_MAX_CHANNELS];
>
> @@ -352,6 +352,9 @@ struct tegra_dma_channel *tegra_dma_allocate_channel(int mode)
> ? ? ? ?int channel;
> ? ? ? ?struct tegra_dma_channel *ch = NULL;
>
> + ? ? ? if (!initialized)
Maybe if (WARN_ON(!initialized))?

> + ? ? ? ? ? ? ? return NULL;
> +
> ? ? ? ?mutex_lock(&tegra_dma_lock);
>
> ? ? ? ?/* first channel is the shared channel */
> @@ -678,6 +681,8 @@ int __init tegra_dma_init(void)
> ? ? ? ?void __iomem *addr;
> ? ? ? ?struct clk *c;
>
> + ? ? ? bitmap_fill(channel_usage, NV_DMA_MAX_CHANNELS);
> +
> ? ? ? ?c = clk_get_sys("tegra-dma", NULL);
> ? ? ? ?if (IS_ERR(c)) {
> ? ? ? ? ? ? ? ?pr_err("Unable to get clock for APB DMA\n");
> @@ -696,18 +701,9 @@ int __init tegra_dma_init(void)
> ? ? ? ?writel(0xFFFFFFFFul >> (31 - TEGRA_SYSTEM_DMA_CH_MAX),
> ? ? ? ? ? ? ? addr + APB_DMA_IRQ_MASK_SET);
>
> - ? ? ? memset(channel_usage, 0, sizeof(channel_usage));
> - ? ? ? memset(dma_channels, 0, sizeof(dma_channels));
> -
> - ? ? ? /* Reserve all the channels we are not supposed to touch */
> - ? ? ? for (i = 0; i < TEGRA_SYSTEM_DMA_CH_MIN; i++)
> - ? ? ? ? ? ? ? __set_bit(i, channel_usage);
> -
> ? ? ? ?for (i = TEGRA_SYSTEM_DMA_CH_MIN; i <= TEGRA_SYSTEM_DMA_CH_MAX; i++) {
> ? ? ? ? ? ? ? ?struct tegra_dma_channel *ch = &dma_channels[i];
>
> - ? ? ? ? ? ? ? __clear_bit(i, channel_usage);
> -
> ? ? ? ? ? ? ? ?ch->id = i;
> ? ? ? ? ? ? ? ?snprintf(ch->name, TEGRA_DMA_NAME_SIZE, "dma_channel_%d", i);
>
> @@ -726,14 +722,15 @@ int __init tegra_dma_init(void)
> ? ? ? ? ? ? ? ? ? ? ? ?goto fail;
> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?ch->irq = irq;
> +
> + ? ? ? ? ? ? ? __clear_bit(i, channel_usage);
> ? ? ? ?}
> ? ? ? ?/* mark the shared channel allocated */
> ? ? ? ?__set_bit(TEGRA_SYSTEM_DMA_CH_MIN, channel_usage);
>
> - ? ? ? for (i = TEGRA_SYSTEM_DMA_CH_MAX+1; i < NV_DMA_MAX_CHANNELS; i++)
> - ? ? ? ? ? ? ? __set_bit(i, channel_usage);
> + ? ? ? initialized = 1;
intialized = true

>
> - ? ? ? return ret;
> + ? ? ? return 0;
> ?fail:
> ? ? ? ?writel(0, addr + APB_DMA_GEN);
> ? ? ? ?for (i = TEGRA_SYSTEM_DMA_CH_MIN; i <= TEGRA_SYSTEM_DMA_CH_MAX; i++) {
> --
> 1.7.1
>
>
