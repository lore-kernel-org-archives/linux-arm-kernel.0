From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 14 Aug 2017 16:09:52 -0500
Subject: [PATCH 1/2] of: Fix DMA mask generation
In-Reply-To: <0819179085df6c41c70e83a2c5c138b95c0386b3.1502468875.git.robin.murphy@arm.com>
References: <0819179085df6c41c70e83a2c5c138b95c0386b3.1502468875.git.robin.murphy@arm.com>
Message-ID: <CAL_JsqJHYC0Pg404es8YJfownj7qwHpkfq6u9yx72hdqiDewKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 11:29 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> Historically, DMA masks have suffered some ambiguity between whether
> they represent the range of physical memory a device can access, or the
> address bits a device is capable of driving, particularly since on many
> platforms the two are equivalent. Whilst there are some stragglers left
> (dma_max_pfn(), I'm looking at you...), the majority of DMA code has
> been cleaned up to follow the latter definition, not least since it is
> the only one which makes sense once IOMMUs are involved.
>
> In this respect, of_dma_configure() has always done the wrong thing in
> how it generates initial masks based on "dma-ranges". Although rounding
> down did not affect the TI Keystone platform where dma_addr + size is
> already a power of two, in any other case it results in a mask which is
> at best unnecessarily constrained and at worst unusable.
>
> BCM2837 illustrates the problem nicely, where we have a DMA base of 3GB
> and a size of 1GB - 16MB, giving dma_addr + size = 0xff000000 and a
> resultant mask of 0x7fffffff, which is then insufficient to even cover
> the necessary offset, effectively making all DMA addresses out-of-range.
> This has been hidden until now (mostly because we don't yet prevent
> drivers from simply overwriting this initial mask later upon probe), but
> due to recent changes elsewhere now shows up as USB being broken on
> Raspberry Pi 3.
>
> Make it right by rounding up instead of down, such that the mask
> correctly correctly describes all possisble bits the device needs to
> emit.
>
> Fixes: 9a6d7298b083 ("of: Calculate device DMA masks based on DT dma-range size")
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reported-by: Andreas F?rber <afaerber@suse.de>
> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Either of these patches alone should be sufficient to un-break RPi3,
> and they apply independently, so I'm quite happy for one to go in as a
> fix now and the other to wait for 4.14.

Acked-by: Rob Herring <robh@kernel.org>

>
> Robin.
>
>  drivers/of/device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 28c38c756f92..e0a28ea341fe 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -89,6 +89,7 @@ int of_dma_configure(struct device *dev, struct device_node *np)
>         bool coherent;
>         unsigned long offset;
>         const struct iommu_ops *iommu;
> +       u64 mask;
>
>         /*
>          * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> @@ -134,10 +135,9 @@ int of_dma_configure(struct device *dev, struct device_node *np)
>          * Limit coherent and dma mask based on size and default mask
>          * set by the driver.
>          */
> -       dev->coherent_dma_mask = min(dev->coherent_dma_mask,
> -                                    DMA_BIT_MASK(ilog2(dma_addr + size)));
> -       *dev->dma_mask = min((*dev->dma_mask),
> -                            DMA_BIT_MASK(ilog2(dma_addr + size)));
> +       mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
> +       dev->coherent_dma_mask &= mask;
> +       *dev->dma_mask &= mask;
>
>         coherent = of_dma_is_coherent(np);
>         dev_dbg(dev, "device is%sdma coherent\n",
> --
> 2.13.4.dirty
>
