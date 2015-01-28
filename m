From: robherring2@gmail.com (Rob Herring)
Date: Tue, 27 Jan 2015 20:37:14 -0600
Subject: [PATCH v5 3/8] of: fix size when dma-range is not used
In-Reply-To: <1422392405-32196-4-git-send-email-m-karicheri2@ti.com>
References: <1422392405-32196-1-git-send-email-m-karicheri2@ti.com>
 <1422392405-32196-4-git-send-email-m-karicheri2@ti.com>
Message-ID: <CAL_JsqJCE2c7PjwN_ynC5_hufe=Xo55E0j=EW5GbuX9saf82dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 3:00 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> Fix the dma-range size when the DT attribute is missing. i.e  set size to
> dev->coherent_dma_mask + 1 instead of dev->coherent_dma_mask. Also add
> code to check invalid values of size configured in DT and log error.
>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/of/device.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 2de320d..17504f4 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -105,12 +105,19 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>         ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>         if (ret < 0) {
>                 dma_addr = offset = 0;
> -               size = dev->coherent_dma_mask;
> +               size = dev->coherent_dma_mask + 1;

This is fine since coherent_dma_mask will always be 4G - 1 in this case.

>         } else {
>                 offset = PFN_DOWN(paddr - dma_addr);
>                 dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>         }
>
> +       if (is_power_of_2(size + 1))
> +               size = size + 1;
> +       else if (!is_power_of_2(size)) {
> +               dev_err(dev, "invalid size\n");
> +               return;

I think this is too restrictive. I think checking bit 0 is 1 is enough
to tell the size is a mask.

I would like it to be a WARN if detected and just add 1.

Rob
