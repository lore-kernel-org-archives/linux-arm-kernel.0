From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Aug 2018 13:55:03 +0100
Subject: Query on dma_set_mask_and_coherent() Usage
In-Reply-To: <CANdmM3O_q_dAzVAd5Lk+u_OHqgEkHR2p1ucgEZ5v_tLQ6G+3Rw@mail.gmail.com>
References: <CANdmM3O_q_dAzVAd5Lk+u_OHqgEkHR2p1ucgEZ5v_tLQ6G+3Rw@mail.gmail.com>
Message-ID: <20180828125503.ws66n2oxrhmuereb@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 08:20:36PM +0530, Kedareswararao Appana wrote:
>               On arm64 platform I have booted Linux only with > 32-bit
> Address i.e from 0x800000000 (reg =  <0x8 0x00000000 0x0 0x80000000>)

So you have 2GB of RAM starting at 0x8_0000_0000.

> In my driver, I am using dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32)); which should fail if I boot Linux
> with the above configuration but the API is returning success.
> 
> I have debugged it further and observed that, in the arm64
> dma-mapping.c swiotlb is zero resulting dma_supported ops always
> returning 1
> 
> https://elixir.bootlin.com/linux/v4.17.8/source/arch/arm64/mm/dma-mapping.c#L321
> 
>  I will be grateful if someone can send me some pointers for fixing this issue

It's an assumption we've made here:

https://elixir.bootlin.com/linux/v4.17.8/source/arch/arm64/mm/init.c#L224

32-bit devices are expected to have a dma_pfn_offset (and the hardware
configured accordingly).

-- 
Catalin
