From: briannorris@chromium.org (Brian Norris)
Date: Fri, 18 Aug 2017 10:01:08 -0700
Subject: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <20170817120431.12398-2-jeffy.chen@rock-chips.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
Message-ID: <20170818170107.GA119461@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Tony

On Thu, Aug 17, 2017 at 08:04:29PM +0800, Jeffy Chen wrote:
> Add support for PCIE_WAKE pin in rockchip pcie driver.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq
>         -- Suggested by Brian Norris <briannorris@chromium.com>
> 
>  drivers/pci/host/pcie-rockchip.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 7bb9870f6d8c..c2b973c738fe 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -36,6 +36,7 @@
>  #include <linux/pci_ids.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/reset.h>
>  #include <linux/regmap.h>
>  
> @@ -853,7 +854,6 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> -
>  /**
>   * rockchip_pcie_parse_dt - Parse Device Tree
>   * @rockchip: PCIe port information
> @@ -1018,6 +1018,14 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  		return err;
>  	}
>  
> +	device_init_wakeup(dev, true);
> +	irq = platform_get_irq_byname(pdev, "wake");
> +	if (irq >= 0) {
> +		err = dev_pm_set_dedicated_wake_irq(dev, irq);

Did you test that this works out correctly as a level-triggered
interrupt? IIUC, the dummy handler won't mask the interrupt, so it might
keep firing. See:

static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
{
        struct wake_irq *wirq = _wirq;
        int res;

        /* Maybe abort suspend? */
        if (irqd_is_wakeup_set(irq_get_irq_data(irq))) {
                pm_wakeup_event(wirq->dev, 0);
        
                return IRQ_HANDLED; <--- We can return here, with the trigger still asserted
        }
...

This could cause some kind of an IRQ storm, including a lockup or
significant slowdown, I think.

BTW, in another context, Tony suggested we might need to fix up the IRQ flags
like this:

int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
{
...
        err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
-                                  IRQF_ONESHOT, dev_name(dev), wirq);
+                                  IRQF_ONESHOT | irq_get_trigger_type(irq), dev_name(dev), wirq);

But IIUC, that's not actually necessary, because __setup_irq()
automatically configures the trigger type if the driver didn't request
one explicitly.

Brian

> +		if (err)
> +			dev_err(dev, "failed to setup PCIe wake IRQ\n");
> +	}
> +
>  	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
>  	if (IS_ERR(rockchip->vpcie3v3)) {
>  		if (PTR_ERR(rockchip->vpcie3v3) == -EPROBE_DEFER)
> @@ -1524,6 +1532,9 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>  
> +	dev_pm_clear_wake_irq(dev);
> +	device_init_wakeup(dev, false);
> +
>  	pci_stop_root_bus(rockchip->root_bus);
>  	pci_remove_root_bus(rockchip->root_bus);
>  	pci_unmap_iospace(rockchip->io);
> -- 
> 2.11.0
> 
> 
