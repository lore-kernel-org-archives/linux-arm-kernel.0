From: eric.miao@linaro.org (Eric Miao)
Date: Mon, 9 Jan 2012 21:25:12 +0800
Subject: [PATCH v4 2/2] dma/imx-sdma: convert _raw_readl/_raw_writel to
 readl/writel
In-Reply-To: <20120109115143.GL21765@n2100.arm.linux.org.uk>
References: <1326033862-25351-1-git-send-email-richard.zhao@linaro.org>
 <1326033862-25351-3-git-send-email-richard.zhao@linaro.org>
 <20120109115143.GL21765@n2100.arm.linux.org.uk>
Message-ID: <CAMPhdO84p=0D3KrrFnwup4igoh4oNWXOCbW+BOkoRiC8m=JnmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2012 at 7:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jan 08, 2012 at 10:44:22PM +0800, Richard Zhao wrote:
>> readl/writel is more genric. And if CONFIG_ARM_DMA_MEM_BUFFERABLE,
>> they includes necessary memory barriers.
>
> In a DMA engine driver, you need to use the barrier accessors when:
>
> 1. You finally enable the DMA engine to perform a transfer.
> ? The included barrier ensures that writes to the descriptors are visible
> ? to the DMA engine.
>
> 2. You read from a status register before examining the descriptors.
> ? This ensures that the descriptor accesses won't be ordered before the
> ? status register read.
>
> Provided other accesses are within the same 1K region, the remainder of
> them do not have to be the strictly ordered accessors, and you can use
> the _relaxed variants (but only in ARM specific drivers.)

Russell,

Does this also mean when endian conversion is not necessary, the __raw_*
version will be better here? Or generally the _relaxed variants are more
recommended as endian conversion will be optimized away anyway with
these AMBA accesses as both sides are little-endian?

>
> So, if your DMA engine has a control register, and a descriptor pointer
> register, you can write the descriptor pointer register with a
> writel_relaxed(). ?When you write the control register to enable the
> transfer, use writel() to ensure there's a barrier so the descriptors
> are visible.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
