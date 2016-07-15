From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 15 Jul 2016 16:17:50 +0530
Subject: [PATCH 7/8] uio: bind uio_dmem_genirq via OF
In-Reply-To: <20160715094542.GE1041@n2100.armlinux.org.uk>
References: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
 <1468573443-4670-8-git-send-email-anup.patel@broadcom.com>
 <20160715094542.GE1041@n2100.armlinux.org.uk>
Message-ID: <CAALAos8SWRT1m=R1WDhky_=5CAz9V2MwHjqhDm=bfO5jxVpi_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 3:15 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Fri, Jul 15, 2016 at 02:34:02PM +0530, Anup Patel wrote:
>> +static int uio_dmem_genirq_alloc_platdata(struct platform_device *pdev)
>> +{
>> +     struct uio_dmem_genirq_pdata pdata;
>> +     u32 dma_bits, regions;
>> +     u32 sizes[MAX_UIO_MAPS];
>> +     int ret;
>> +
>> +     memset(&pdata, 0, sizeof(pdata));
>> +
>> +     ret = of_property_read_u32(pdev->dev.of_node,
>> +                                uio_of_dma_bits_prop, &dma_bits);
>> +     if (ret) {
>> +             dev_err(&pdev->dev,
>> +                     "Missing property %s\n", uio_of_dma_bits_prop);
>> +             return ret;
>> +     }
>> +     if (dma_bits > 64)
>> +             dma_bits = 64;
>> +
>> +     dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(dma_bits));
>
> You really need to check the return value from this: this function
> negotiates with the architecture, and if 64-bit DMA is not supported,
> then the call will fail and you as a driver are expected to fall back
> to 32-bit DMA only.
>
> In that case, you're expected to call the same function with a 32-bit
> mask, and if that fails, you're supposed to then decide that DMA is
> not possible.
>

Thanks for pointing out.

I will fix this as-per your suggestion in next revision.

Regards,
Anup
