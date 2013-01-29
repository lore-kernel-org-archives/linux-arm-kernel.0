From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Jan 2013 12:54:11 +0530
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <1359410300-26113-2-git-send-email-arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-2-git-send-email-arnd@arndb.de>
Message-ID: <CAKohpomO6tYNYLdMOaJYgqGecXj5KMQprdb=gExi+QuGrtLTzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2013 03:28, Arnd Bergmann <arnd@arndb.de> wrote:
> The original device tree binding for this driver, from Viresh Kumar
> unfortunately conflicted with the generic DMA binding, and did not allow
> to completely seperate slave device configuration from the controller.
>
> This is an attempt to replace it with an implementation of the generic
> binding, but it is currently completely untested, because I do not have
> any hardware with this particular controller.
>
> The patch applies on top of linux-next, which contains both the base
> support for the generic DMA binding, as well as the earlier attempt from
> Viresh. Both of these are currently not merged upstream however.

This was really my work and i am feeling bad that i couldn't allocate any time
for it. Thanks for starting it.

> diff --git a/Documentation/devicetree/bindings/dma/snps-dma.txt b/Documentation/devicetree/bindings/dma/snps-dma.txt
> index 5bb3dfb..212d387 100644
> --- a/Documentation/devicetree/bindings/dma/snps-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
> @@ -3,59 +3,62 @@
>  Required properties:
>  - compatible: "snps,dma-spear1340"
>  - reg: Address range of the DMAC registers
> -- interrupt-parent: Should be the phandle for the interrupt controller
> -  that services interrupts for this device
>  - interrupt: Should contain the DMAC interrupt number
> -- nr_channels: Number of channels supported by hardware
> -- is_private: The device channels should be marked as private and not for by the
> -  general purpose DMA channel allocator. False if not passed.
> +- dma-channels: Number of channels supported by hardware
> +- dma-requests: Number of DMA request lines supported
> +- dma-masters: Number of AHB masters supported by the controller
> +- #dma-cells: must be <3>

Shouldn't this be 4? Would be better to mention what fields are these,
right here.
I have seen them below though.

> +DMA clients connected to the Designware DMA controller must use the format
> +described in the dma.txt file, using a five-cell specifier for each channel.
> +The five cells in order are:
> +
> +1. A phandle pointing to the DMA controller
> +2. The value for the cfg_hi register.
> +3. The value for the cfg_lo register.
> +4. Source master for transfers on allocated channel.
> +5. Destination master for transfers on allocated channel.

> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index 8cfaaf8..88504c2 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> +#include <linux/of_dma.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -1179,49 +1180,69 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>         dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
>  }
>
> -bool dw_dma_generic_filter(struct dma_chan *chan, void *param)
> +/* forward declaration used in filter */
> +static struct platform_driver dw_driver;

extern? This is not a declaration but definition.

> +
> +struct dw_dma_filter_args {
> +       struct dw_dma *dw;
> +       u32 cfg_lo;
> +       u32 cfg_hi;
> +       unsigned src;

Currently named as sms

> +       unsigned dst;

dms

> +};
> +
> +static bool dw_dma_generic_filter(struct dma_chan *chan, void *param)
>  {
>         struct dw_dma *dw = to_dw_dma(chan->device);
> -       static struct dw_dma *last_dw;
> -       static char *last_bus_id;
> -       int i = -1;
> +       struct dw_dma_filter_args *fargs = param;
> +       struct dw_dma_slave *sd;
>
> -       /*
> -        * dmaengine framework calls this routine for all channels of all dma
> -        * controller, until true is returned. If 'param' bus_id is not
> -        * registered with a dma controller (dw), then there is no need of
> -        * running below function for all channels of dw.
> -        *
> -        * This block of code does this by saving the parameters of last
> -        * failure. If dw and param are same, i.e. trying on same dw with
> -        * different channel, return false.
> -        */
> -       if ((last_dw == dw) && (last_bus_id == param))
> +       /* both the driver and the device must match */
> +        if (chan->device->dev->driver != &dw_driver.driver)
> +                return false;

Can this ever happen? Isn't it the case that this routine would be called
only for dw_dmac?

> +       if (dw != fargs->dw)
>                 return false;
> -       /*
> -        * Return true:
> -        * - If dw_dma's platform data is not filled with slave info, then all
> -        *   dma controllers are fine for transfer.
> -        * - Or if param is NULL
> -        */
> -       if (!dw->sd || !param)
> -               return true;
>
> -       while (++i < dw->sd_count) {
> -               if (!strcmp(dw->sd[i].bus_id, param)) {
> -                       chan->private = &dw->sd[i];
> -                       last_dw = NULL;
> -                       last_bus_id = NULL;
> +       /* FIXME: memory leak! could we put this into dw_dma_chan? */
> +       sd = devm_kzalloc(dw->dma.dev, sizeof (*sd), GFP_KERNEL);

Yes.

> +       if (!sd)
> +               return false;
>
> -                       return true;
> -               }
> -       }
> +       sd->dma_dev     = dw->dma.dev;
> +       sd->cfg_hi      = fargs->cfg_hi;
> +       sd->cfg_lo      = fargs->cfg_lo;
> +       sd->src_master  = fargs->src;
> +       sd->dst_master  = fargs->dst;
> +
> +       chan->private = sd;
>
> -       last_dw = dw;
> -       last_bus_id = param;
> -       return false;
> +       return true;
> +}
> +
> +static struct dma_chan *dw_dma_xlate(struct of_phandle_args *dma_spec,
> +                                        struct of_dma *ofdma)
> +{
> +       struct dw_dma *dw = ofdma->of_dma_data;
> +       struct dw_dma_filter_args fargs = {
> +               .dw = dw,
> +       };
> +       dma_cap_mask_t cap;
> +
> +       if (dma_spec->args_count != 4)

args_count contains count of all params leaving the phandle?

> +               return NULL;
> +
> +       /* FIXME: This binding is rather clumsy. Can't we use the
> +          request line numbers here instead? */

yes.

> +       fargs.cfg_lo = be32_to_cpup(dma_spec->args+0);
> +       fargs.cfg_hi = be32_to_cpup(dma_spec->args+1);
> +       fargs.src = be32_to_cpup(dma_spec->args+2);
> +       fargs.dst = be32_to_cpup(dma_spec->args+3);
> +
> +       dma_cap_zero(cap);
> +       dma_cap_set(DMA_SLAVE, cap);
> +       /* FIXME: there should be a simpler way to do this */
> +       return dma_request_channel(cap, dw_dma_generic_filter, &dma_spec->args[0]);

don't you need to send &fargs as the last argument?
