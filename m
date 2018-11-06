From: john.stultz@linaro.org (John Stultz)
Date: Tue, 6 Nov 2018 15:16:11 -0800
Subject: [PATCH] of/device: Really only set bus DMA mask when appropriate
In-Reply-To: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
Message-ID: <CALAqxLWif1wjRHx5X136sBqdg0KJ8itqXPk9G6NJ70Z_QFavzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 6, 2018 at 3:54 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> of_dma_configure() was *supposed* to be following the same logic as
> acpi_dma_configure() and only setting bus_dma_mask if some range was
> specified by the firmware. However, it seems that subtlety got lost in
> the process of fitting it into the differently-shaped control flow, and
> as a result the force_dma==true case ends up always setting the bus mask
> to the 32-bit default, which is not what anyone wants.
>
> Make sure we only touch it if the DT actually said so.
>
> Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Sorry about that... I guess I only have test setups that either have
> dma-ranges or where a 32-bit bus mask goes unnoticed :(
>
> The Octeon and SMMU issues sound like they're purely down to this, and
> it's probably related to at least one of John's Hikey woes.

Yep! This does seem to resolve the mali bifrost dma address warn-ons I
was seeing, and makes the board seem to function more consistently, so
that's great!

Tested-by: John Stultz <john.stultz@linaro.org>

Though I still find I have to revert "swiotlb: use swiotlb_map_page in
swiotlb_map_sg_attrs" still to boot to UI successfully with AOSP.
Still not sure whats going on there (its sort of soft hangs where some
userland runs ok, but other bits seem to jam up, even console commands
sometimes hang - almost seems like io stalls).

Anyway, thanks so much again for this one!
-john
