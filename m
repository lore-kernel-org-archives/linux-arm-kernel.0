From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 15 Oct 2018 11:23:44 -0400 (EDT)
Subject: [PATCH v2] usb: host: ohci-at91: fix request of irq for optional
 gpio
In-Reply-To: <20181015090001.5195-1-tudor.ambarus@microchip.com>
Message-ID: <Pine.LNX.4.44L0.1810151123330.1394-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Oct 2018 Tudor.Ambarus at microchip.com wrote:

> atmel,oc-gpio is optional. Request its irq only when atmel,oc is set
> in device tree.
> 
> devm_gpiod_get_index_optional returns NULL if -ENOENT. Check its
> return value for NULL before error, because it is more probable that
> atmel,oc is not set.
> 
> This fixes the following errors on boards where atmel,oc is not set in
> device tree:
> [    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
> [    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
> [    0.970000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v2: fix typos in commit message s/it's/its, s/probably/probable
> 
> Based on https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git,
> usb-next branch.
> 
>  drivers/usb/host/ohci-at91.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index e98673954020..ec6739ef3129 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -551,6 +551,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
>  		pdata->overcurrent_pin[i] =
>  			devm_gpiod_get_index_optional(&pdev->dev, "atmel,oc",
>  						      i, GPIOD_IN);
> +		if (!pdata->overcurrent_pin[i])
> +			continue;
>  		if (IS_ERR(pdata->overcurrent_pin[i])) {
>  			err = PTR_ERR(pdata->overcurrent_pin[i]);
>  			dev_err(&pdev->dev, "unable to claim gpio \"overcurrent\": %d\n", err);

Acked-by: Alan Stern <stern@rowland.harvard.edu>
