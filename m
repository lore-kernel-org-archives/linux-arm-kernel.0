From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 3 Apr 2016 21:37:07 +0200
Subject: [PATCH v3] dma: pl08x: allocate OF slave channel data at probe
 time
In-Reply-To: <1459710079-8525-1-git-send-email-linus.walleij@linaro.org>
References: <1459710079-8525-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAGhQ9VxsAg1ib2fnOsHUbG=rQt7CfC_v6yrgH6smY67g5kSxxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 3 April 2016 at 21:01, Linus Walleij <linus.walleij@linaro.org> wrote:
> The current OF translation of channels can never work with
> any DMA client using the DMA channels directly: the only way
> to get the channels initialized properly is in the
> dma_async_device_register() call, where chan->dev etc is
> allocated and initialized.
>
> Allocate and initialize all possible DMA channels and
> only augment a target channel with the periph_buses at
> of_xlate(). Remove some const settings to make things work.
>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Cc: Johannes Stezenbach <js@sig21.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Drop the patch and variable for fixed signal assignment.
> - Always assign a fixed channel number when registering
>   the channels.
> ChangeLog v1->v2:
> - Rely on the number of signals for the variant coming in
>   from vendor data.
>
> Joachim: I hope this works with LPC, I assign the signal number
> now.

Did a quick test and it works now. Thanks!
Tested-by: Joachim Eastwood <manabian@gmail.com>

Couple of comments below.


>  drivers/dma/amba-pl08x.c   | 85 +++++++++++++++++++++++++++++++---------------
>  include/linux/amba/pl08x.h |  2 +-
>  2 files changed, 58 insertions(+), 29 deletions(-)
>
>  static int pl08x_of_probe(struct amba_device *adev,
> @@ -2091,9 +2094,11 @@ static int pl08x_of_probe(struct amba_device *adev,
>                           struct device_node *np)
>  {
>         struct pl08x_platform_data *pd;
> +       struct pl08x_channel_data *chanp = NULL;
>         u32 cctl_memcpy = 0;
>         u32 val;
>         int ret;
> +       int i;
>
>         pd = devm_kzalloc(&adev->dev, sizeof(*pd), GFP_KERNEL);
>         if (!pd)
> @@ -2195,6 +2200,26 @@ static int pl08x_of_probe(struct amba_device *adev,
>         /* Use the buses that can access memory, obviously */
>         pd->memcpy_channel.periph_buses = pd->mem_buses;
>
> +       /*
> +        * Allocate channel data for all possible slave channels (one
> +        * for each possible signal), channels will then be allocated
> +        * for a device and have it's AHB interfaces set up at
> +        * translation time.
> +        */
> +       chanp = devm_kzalloc(&adev->dev,
> +                       pl08x->vd->signals *
> +                       sizeof(struct pl08x_channel_data),
> +                       GFP_KERNEL);

devm_kcalloc() would be a better fit here I think.

> +       if (!chanp)
> +               return -ENOMEM;

Nit: new line after return.

> +       pd->slave_channels = chanp;
> +       for (i = 0; i < pl08x->vd->signals; i++) {
> +               /* chanp->periph_buses will be assigned at translation */
> +               chanp->bus_id = kasprintf(GFP_KERNEL, "slave%d", i);
> +               chanp++;
> +       }
> +       pd->num_slave_channels = pl08x->vd->signals;
> +
>         pl08x->pd = pd;
>
>         return of_dma_controller_register(adev->dev.of_node, pl08x_of_xlate,
> @@ -2234,6 +2259,10 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>                 goto out_no_pl08x;
>         }
>
> +       /* Assign useful pointers to the driver state */
> +       pl08x->adev = adev;
> +       pl08x->vd = vd;
> +
>         /* Initialize memcpy engine */
>         dma_cap_set(DMA_MEMCPY, pl08x->memcpy.cap_mask);
>         pl08x->memcpy.dev = &adev->dev;
> @@ -2284,10 +2313,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>                 }
>         }
>
> -       /* Assign useful pointers to the driver state */
> -       pl08x->adev = adev;
> -       pl08x->vd = vd;
> -
>         /* By default, AHB1 only.  If dualmaster, from platform */
>         pl08x->lli_buses = PL08X_AHB1;
>         pl08x->mem_buses = PL08X_AHB1;
> @@ -2438,6 +2463,7 @@ out_no_pl08x:
>  static struct vendor_data vendor_pl080 = {
>         .config_offset = PL080_CH_CONFIG,
>         .channels = 8,
> +       .signals = 16,
>         .dualmaster = true,
>         .max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
>  };
> @@ -2445,6 +2471,7 @@ static struct vendor_data vendor_pl080 = {
>  static struct vendor_data vendor_nomadik = {
>         .config_offset = PL080_CH_CONFIG,
>         .channels = 8,
> +       .signals = 32,
>         .dualmaster = true,
>         .nomadik = true,
>         .max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
> @@ -2453,6 +2480,7 @@ static struct vendor_data vendor_nomadik = {
>  static struct vendor_data vendor_pl080s = {
>         .config_offset = PL080S_CH_CONFIG,
>         .channels = 8,
> +       .signals = 32,
>         .pl080s = true,
>         .max_transfer_size = PL080S_CONTROL_TRANSFER_SIZE_MASK,
>  };
> @@ -2460,6 +2488,7 @@ static struct vendor_data vendor_pl080s = {
>  static struct vendor_data vendor_pl081 = {
>         .config_offset = PL080_CH_CONFIG,
>         .channels = 2,
> +       .signals = 16,
>         .dualmaster = false,
>         .max_transfer_size = PL080_CONTROL_TRANSFER_SIZE_MASK,
>  };

I see you added a signals member to struct vendor_data. You could also
retrieve this information from the standard 'dma-requests' DT
property.
See: Documentation/devicetree/bindings/dma/dma.txt

Note that I think your approach is fine too and may be better in this
case. Guess we could always implement an override from DT if ever
needed.


regards,
Joachim Eastwood
