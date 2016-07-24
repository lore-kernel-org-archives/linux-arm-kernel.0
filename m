From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 24 Jul 2016 12:12:56 +0530
Subject: [PATCH 10/10] dmaengine: qcom_hidma: add MSI support for
 interrupts
In-Reply-To: <1468867177-15007-11-git-send-email-okaya@codeaurora.org>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
 <1468867177-15007-11-git-send-email-okaya@codeaurora.org>
Message-ID: <20160724064256.GA9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 12:09:37AM +0530, Sinan Kaya wrote:

> @@ -567,6 +578,98 @@ static int hidma_create_sysfs_entry(struct hidma_dev *dev, char *name,
>         return device_create_file(dev->ddev.dev, attrs);
>  }
> 
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN

This can be true on machine with your older HW, so I would be bit more
careful here..

> +       if (rc)
> +               dev_warn(&pdev->dev,
> +                        "failed to request MSI irq, falling back to wired IRQ\n");
> +       return rc;
> +#else
> +       return -EINVAL;

-EINVAL doesnt sound apt here..

> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +       const char *of_compat;
> +       int ret;
> +
> +       if (!adev || acpi_disabled) {
> +               ret = device_property_read_string(dev, "compatible",
> +                                                 &of_compat);
> +               if (ret)
> +                       return false;
> +
> +               ret = strcmp(of_compat, "qcom,hidma-1.1");
> +       } else {
> +               ret = strcmp(acpi_device_hid(adev), "QCOM8062");

Okay if you ahve a device ID then why do we need new binding? This device as
you said implies the support for MSI interrupts.

Thanks
-- 
~Vinod
