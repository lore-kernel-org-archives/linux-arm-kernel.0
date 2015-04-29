From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Apr 2015 18:25:04 +0200
Subject: [PATCH 2/2] ACPI / scan: Parse _CCA and setup device coherency
In-Reply-To: <1430315049-4663-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1430315049-4663-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <2968069.n1L1S3Mp2q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015 08:44:09 Suravee Suthikulpanit wrote:
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 4bf7559..a4db208 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -108,9 +108,12 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
>         if (IS_ERR(pdev))
>                 dev_err(&adev->dev, "platform device creation failed: %ld\n",
>                         PTR_ERR(pdev));
> -       else
> +       else {
> +               arch_setup_dma_ops(&pdev->dev, 0, 0, NULL,
> +                                  adev->flags.is_coherent);
>                 dev_dbg(&adev->dev, "created platform device %s\n",
>                         dev_name(&pdev->dev));
> +       }
>  
>         kfree(resources);
> 

Looking at this code in more detail, it seems that it unconditionally
sets pdevinfo.dma_mask = DMA_BIT_MASK(32), before calling
arch_setup_dma_ops(). This assignment should really done inside of
arch_setup_dma_ops() instead, which means we should implement that
function on all architectures that support ACPI.

For the case where _CCA is missing (or coherency disabled, if you ask
me), we would not call that function.

On a related note, I'm not sure how to handle different DMA masks here.
arch_setup_dma_ops() gets passed a size (and offset) argument, which should
match the DMA mask, but I don't know if there is a way to find out the
size from ACPI. Should we assume it's always 64-bit DMA capable?

For legacy reasons, the default mask is probably best left at 32-bit,
but drivers are expected to call dma_set_mask() if they can do 64-bit DMA,
and that should fail based on the information provided by the platform
if the bus is not capable of doing that.

	Arnd
