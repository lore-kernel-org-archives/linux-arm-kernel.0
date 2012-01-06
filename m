From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Jan 2012 17:22:27 -0800
Subject: [PATCH v2] arm/tegra: use APB DMA for accessing APB devices
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F1812@HQMAIL01.nvidia.com>
References: <1324599468-12845-3-git-send-email-olof@lixom.net>
 <1325742554-32735-1-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F1812@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMg7GbEeMXAsftq+eZuqEOTLgeufePSC3h4mKn1cVnuEWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2012 at 2:07 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Wednesday, January 04, 2012 10:49 PM:
>> Tegra2 hangs if APB registers are accessed from the cpu during an
>> apb dma operation. The workaround is to use apb dma to read/write the
>> registers instead.
> ...
>> diff --git a/arch/arm/mach-tegra/apbio.c b/arch/arm/mach-tegra/apbio.c
> ...
>> +u32 tegra_apb_readl(unsigned long offset)
> ...
>> + ? ? INIT_COMPLETION(tegra_apb_wait);
>> +
>> + ? ? tegra_dma_enqueue_req(tegra_apb_dma, &req);
>> +
>> + ? ? ret = wait_for_completion_timeout(&tegra_apb_wait,
>> + ? ? ? ? ? ? msecs_to_jiffies(50));
>> +
>> + ? ? if (WARN(ret == 0, "apb read dma timed out")) {
>> + ? ? ? ? ? ? *(u32 *)tegra_apb_bb = 0;
>> + ? ? ? ? ? ? tegra_dma_dequeue_req(tegra_apb_dma, &req);
>
> I think you need to swap those last two lines to make absolutely sure
> that the timeout handling doesn't race with an actual DMA completion.

Ah, of course. Fixing that without reposting.


> Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks!

-Olof
