From: robherring2@gmail.com (Rob Herring)
Date: Fri, 29 May 2015 09:04:15 -0500
Subject: [RFC/PATCH 4/9] of: dma: Make of_dma_deconfigure() public
In-Reply-To: <1431644410-2997-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1431644410-2997-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CAL_JsqKu-geUsL69MjeFNOYb9Ye9SobxoiEXNc1pwBr5P1oEOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 6:00 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> As part of moving DMA initializing to probe time the
> of_dma_deconfigure() function will need to be called from different
> source files. Make it public and move it to drivers/of/device.c where
> the of_dma_configure() function is.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

One minor fix below, but otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/of/device.c       | 12 ++++++++++++
>  drivers/of/platform.c     |  5 -----
>  include/linux/of_device.h |  3 +++
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 530aa1ed3e1b..f1b84f464fe1 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -135,6 +135,18 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure);
>
> +/**
> + * of_dma_deconfigure - Clean up DMA configuration
> + * @dev:       Device for which to clean up DMA configuration
> + *
> + * Clean up all configuration performed by of_dma_configure_ops() and free all
> + * resources that have been allocated.
> + */
> +void of_dma_deconfigure(struct device *dev)
> +{
> +       arch_teardown_dma_ops(dev);
> +}

You need an EXPORT_SYMBOL_GPL
