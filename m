From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 12:57:56 +0200
Subject: [PATCH 3/4] edac, altera: Addition of Arria10 EDAC
In-Reply-To: <1431553787-27741-4-git-send-email-tthayer@opensource.altera.com>
References: <1431553787-27741-1-git-send-email-tthayer@opensource.altera.com>
 <1431553787-27741-4-git-send-email-tthayer@opensource.altera.com>
Message-ID: <2896031.Yz7YCP9E71@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 16:49:46 tthayer at opensource.altera.com wrote:
> +static int a10_unmask_irq(struct platform_device *pdev, u32 mask)
> +{
> +       void __iomem  *sm_base;
> +
> +       if (!devm_request_mem_region(&pdev->dev, A10_SYMAN_INTMASK_CLR,
> +                                    sizeof(u32), dev_name(&pdev->dev))) {
> +               edac_printk(KERN_ERR, EDAC_MC,
> +                           "Unable to request mem region\n");
> +               return -EBUSY;
> +       }
> +
> +       sm_base = devm_ioremap(&pdev->dev, A10_SYMAN_INTMASK_CLR,
> +                              sizeof(u32));
> +       if (!sm_base) {
> +               edac_printk(KERN_ERR, EDAC_MC,
> +                           "Unable to ioremap device\n");
> +
> +               return -ENOMEM;
> +       }
> +
> +       iowrite32(mask, sm_base);
> +
> +       devm_iounmap(&pdev->dev, sm_base);
> +       devm_release_mem_region(&pdev->dev, A10_SYMAN_INTMASK_CLR,
> +                               sizeof(u32));
> +
> +       return 0;
> +}

If you always unmap right away, better use the normal request_mem_region
and ioremap functions rather than their devm counterparts.


>  
> +       /* Only the Arria10 has separate IRQs */
> +       if (irq2 > 0) {
> +               /* Arria10 specific initialization */
> +               res = a10_init(mc_vbase);
> +               if (res < 0)
> +                       goto err2;
> +
> +               res = a10_unmask_irq(pdev, A10_DDR0_IRQ_MASK);
> +               if (res < 0)
> +                       goto err2;
> +
> +               res = devm_request_irq(&pdev->dev, irq2,
> +                                      altr_sdram_mc_err_handler,
> +                                      IRQF_SHARED, dev_name(&pdev->dev), mci);
> +               if (res < 0) {
> +                       edac_mc_printk(mci, KERN_ERR,
> +                                      "Unable to request irq %d\n", irq2);
> +                       res = -ENODEV;
> +                       goto err2;
> +               }
> +               irqflags = IRQF_SHARED;
> +       }
> +
> 

Should the unmask be done after the request?

	Arnd
