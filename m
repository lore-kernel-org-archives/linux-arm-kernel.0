From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Oct 2011 12:12:26 -0700
Subject: [PATCH] [3.3] ARM: tegra: use APB DMA for accessing APB devices
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173CA2CC0C@HQMAIL01.nvidia.com>
References: <1318961898-21254-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CC0C@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMh8mFTkOgHwT-1HTA+XMdo36husYzwWOymL1CBz-mGiiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 11:45 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Tuesday, October 18, 2011 12:18 PM:
>> From: Jon Mayo <jmayo@nvidia.com>
>>
>> Tegra2 hangs if APB registers are accessed from the cpu during an
>> apb dma operation. The workaround is to use apb dma to read/write the
>> registers instead.
> ...
>> +++ b/arch/arm/mach-tegra/apbio.c
> ...
>> +#ifdef CONFIG_TEGRA_SYSTEM_DMA
> ...
>> +static inline u32 apb_readl(unsigned long offset)
> ...
>> +static inline void apb_writel(u32 value, unsigned long offset)
> ...
>> +#else
>> +static inline u32 apb_readl(unsigned long offset)
> ...
>> +static inline void apb_writel(u32 value, unsigned long offset)
> ...
>> +#endif
>> +
>> +u32 tegra_apb_readl(unsigned long offset)
>> +{
>> + ? ? return apb_readl(offset);
>> +}
>> +
>> +void tegra_apb_writel(u32 value, unsigned long offset)
>> +{
>> + ? ? apb_writel(value, offset);
>> +}
>
> Why not just make the actual implementations use the exported names, and
> have them not be static inline? That way, you avoid the extra function
> wrapping them.

Yeah, makes perfect sense. Fixed in next revision.

Also, I can't imagine a case where CONFIG_TEGRA_SYSTEM_DMA makes sense
to keep off. Can you? If so, I'm tempted to just kill it (in a
separate patch).

>> +void tegra_init_apb_dma(void)
>> +{
>> +#ifdef CONFIG_TEGRA_SYSTEM_DMA
>> + ? ? tegra_apb_dma = tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT |
>> + ? ? ? ? ? ? TEGRA_DMA_SHARED);
>> + ? ? if (!tegra_apb_dma) {
>> + ? ? ? ? ? ? pr_err("%s: can not allocate dma channel\n", __func__);
>
> It seems like that should be a lot more noisy if the result is potential
> HW hangs. Same for the other error below.

Yeah, at least a WARN() seems warranted, I'll revise that too.


-Olof
