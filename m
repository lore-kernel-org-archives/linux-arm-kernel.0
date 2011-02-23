From: ccross@android.com (Colin Cross)
Date: Wed, 23 Feb 2011 09:38:12 -0800
Subject: [PATCH] ARM: Tegra: DMA: Fail safe if initialization fails
In-Reply-To: <1298482170-3678-1-git-send-email-swarren@nvidia.com>
References: <1298482170-3678-1-git-send-email-swarren@nvidia.com>
Message-ID: <AANLkTi=iWsX_UN6pE7nE=7NBXRPv7=6Ja68B=u8U4Ww=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 9:29 AM, Stephen Warren <swarren@nvidia.com> wrote:
> tegra_dma_init currently simply bails out early if any initialization fails.
> This skips various data-structure initialization. In turn, this means that
> tegra_dma_allocate_channel can still hand out channels. In this case, when
> tegra_dma_free_channel is called, which calls tegra_dma_cancel, the walking
> on ch->list will OOPS since the list's next/prev pointers may still be
> NULL.
>
> To solve this:
> * Mark all possible channels as in-use before doing anything else in init.
> * Only mark a channel as free once all channel-related initialization has
> ?completed.
>
> This prevents allocate_channel from handing out uninitialized channels.
>
> There is still one small hole; allocate_channel can't check the usage array
> for the shared channel, since this channel is permanently marked in-use.
> This could be solved using an explicit "init OK" flag that allocate_channel
> could check.
If we still need an init complete flag, why not skip this patch and
just add that?

>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> ?arch/arm/mach-tegra/dma.c | ? 20 ++++++++------------
> ?1 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
> index 2d720f2..79765ca 100644
> --- a/arch/arm/mach-tegra/dma.c
> +++ b/arch/arm/mach-tegra/dma.c
> @@ -678,6 +678,12 @@ int __init tegra_dma_init(void)
> ? ? ? ?void __iomem *addr;
> ? ? ? ?struct clk *c;
>
> + ? ? ? memset(channel_usage, 0, sizeof(channel_usage));
> + ? ? ? memset(dma_channels, 0, sizeof(dma_channels));
I noticed yesterday these memsets were unnecessary, channel_usage and
dma_channels will be allocated as 0.

> +
> + ? ? ? for (i = 0; i < NV_DMA_MAX_CHANNELS; i++)
> + ? ? ? ? ? ? ? __set_bit(i, channel_usage);
> +
> ? ? ? ?c = clk_get_sys("tegra-dma", NULL);
> ? ? ? ?if (IS_ERR(c)) {
> ? ? ? ? ? ? ? ?pr_err("Unable to get clock for APB DMA\n");
> @@ -696,18 +702,9 @@ int __init tegra_dma_init(void)
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
> @@ -726,13 +723,12 @@ int __init tegra_dma_init(void)
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
> -
> ? ? ? ?return ret;
> ?fail:
> ? ? ? ?writel(0, addr + APB_DMA_GEN);
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
