From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 14 May 2018 02:16:08 +0300
Subject: [PATCH v3 1/2] PCI: kirin: Add MSI support
In-Reply-To: <1526030149-23985-2-git-send-email-chenyao11@huawei.com>
References: <1526030149-23985-1-git-send-email-chenyao11@huawei.com>
 <1526030149-23985-2-git-send-email-chenyao11@huawei.com>
Message-ID: <CAHp75VfqfnTw6PkQq_sGeTe+RpV6iqNEf5JV1TQgpNhMk=VyeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 12:15 PM, Yao Chen <chenyao11@huawei.com> wrote:
> Add support for MSI.


> +       int ret;
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {

> +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
> +               if (pci->pp.msi_irq < 0) {
> +                       dev_err(&pdev->dev, "failed to get MSI IRQ (%d)\n",
> +                               pci->pp.msi_irq);

> +                       return -ENODEV;

Why shadowing actual error code?

> +               }
> +               ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> +                                      kirin_pcie_msi_irq_handler,
> +                                      IRQF_SHARED | IRQF_NO_THREAD,
> +                                      "kirin_pcie_msi", &pci->pp);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to request MSI IRQ %d\n",
> +                               pci->pp.msi_irq);
> +                       return ret;
> +               }

It would be easy to read and maintain if this would be a separate function.

> +       }



-- 
With Best Regards,
Andy Shevchenko
