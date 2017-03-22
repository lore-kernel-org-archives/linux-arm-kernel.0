From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 22 Mar 2017 10:19:58 -0500
Subject: [PATCH] of: Fix DMA mask assignment
In-Reply-To: <94ede94e98502a7948085fba5a16994d3805010c.1488910224.git.robin.murphy@arm.com>
References: <94ede94e98502a7948085fba5a16994d3805010c.1488910224.git.robin.murphy@arm.com>
Message-ID: <CAL_JsqKAuyePWUC-K21uZEjBU29EZA3WUQOYQdwAZUMOz+mEFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 7, 2017 at 12:12 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> As we start moving towards mandating that device DMA addressing
> capabilities are correctly described in DT for platforms like arm64,

Why? There's no point to dma-ranges if the bus is not restricting the
device. dma-ranges is supposed to apply to a bus, not a device. For
example, using dma-ranges for a 32-bit device on a 64-bit platform is
wrong. To put it another way, devices know their addressing
capability, so we don't need to describe that in DT, only external
restrictions outside of the device.

> it
> turns out that actually assigning DMA masks wider than 32 bits from
> "dma-ranges" is made largely impossible by the current code. New PCI
> devices are passed in with 32-bit masks, while new platform devices are
> passed in with their masks unset, so we install default 32-bit masks for
> them. As a result, subsequently taking the minimum between any existing
> mask and the size given by "dma-ranges" means that we can never exceed
> 32 bits for the vast majority of devices.
>
> Since the DT can be assumed to describe the hardware appropriately, and
> the device's driver is expected by the DMA API to explicitly set a mask
> later when it probes, we can safely let "dma-ranges" unconditionally
> override any initial mask from device creation (and as a small bonus
> deduplicate the calculation in the process).
>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Murali Karicheri <m-karicheri2@ti.com>
> Fixes: 9a6d7298b083 ("of: Calculate device DMA masks based on DT dma-range size")

Changing behavior since 4.1 doesn't really seem like a fix. A fix
should generally be tagged for stable and I'd be nervous on this one.

Are we sure all the things a driver may do still work the same? A
driver changing the default 32-bit mask to a 64-bit mask for example.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/of/device.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index b1e6bebda3f3..9bb8518b28f2 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -129,15 +129,8 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>         }
>
>         dev->dma_pfn_offset = offset;
> -
> -       /*
> -        * Limit coherent and dma mask based on size and default mask
> -        * set by the driver.
> -        */
> -       dev->coherent_dma_mask = min(dev->coherent_dma_mask,
> -                                    DMA_BIT_MASK(ilog2(dma_addr + size)));
> -       *dev->dma_mask = min((*dev->dma_mask),
> -                            DMA_BIT_MASK(ilog2(dma_addr + size)));
> +       dev->coherent_dma_mask = DMA_BIT_MASK(ilog2(dma_addr + size));
> +       *dev->dma_mask = dev->coherent_dma_mask;
>
>         coherent = of_dma_is_coherent(np);
>         dev_dbg(dev, "device is%sdma coherent\n",
> --
> 2.11.0.dirty
>
