From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Tue, 11 May 2010 11:03:41 +0200
Subject: [PATCH 1/1] ehci-mxc: Fix mx31 OTG host initialisation
In-Reply-To: <20100511063907.GU31199@pengutronix.de>
References: <1273515220-18909-1-git-send-email-philippe.retornaz@epfl.ch>
	<1273515220-18909-2-git-send-email-philippe.retornaz@epfl.ch>
	<20100511063907.GU31199@pengutronix.de>
Message-ID: <4BE91D6D.5010207@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See the comments below.

On 05/11/2010 08:39 AM, Sascha Hauer wrote:
> On Mon, May 10, 2010 at 08:13:40PM +0200, Philippe R?tornaz wrote:
>> On mx31 the OTG host initialisation fail if you need to have
>> an ULPI transfert to initialize the PHY.
>>
>> In order to be able to communicate with the PHY a complete reset
>> of the usb host is needed. After the PHY initialization the host
>> usb configuration registers need to be rewritten to avoid a host
>> controller lockup.
>>
>> Signed-off-by: Philippe R?tornaz<philippe.retornaz@epfl.ch>
>> ---
>>   drivers/usb/host/ehci-mxc.c |   68 +++++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 68 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
>> index 544ccfd..39d28da 100644
>> --- a/drivers/usb/host/ehci-mxc.c
>> +++ b/drivers/usb/host/ehci-mxc.c
>> @@ -29,6 +29,11 @@
>>   #define PORTSC_OFFSET		0x184
>>   #define USBMODE_OFFSET		0x1a8
>>   #define USBMODE_CM_HOST		3
>> +#define USBCMD_OFFSET		0x140
>> +#define USBCMD_RS		(1<<  0)
>> +#define USBCMD_RST		(1<<  1)
>> +#define USBSTS_OFFSET		0x144
>> +#define USBSTS_HCH		(1<<  12)
>>
>>   struct ehci_mxc_priv {
>>   	struct clk *usbclk, *ahbclk;
>> @@ -120,6 +125,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>>   	int irq, ret, temp;
>>   	struct ehci_mxc_priv *priv;
>>   	struct device *dev =&pdev->dev;
>> +	int i;
>>
>>   	dev_info(&pdev->dev, "initializing i.MX USB Controller\n");
>>
>> @@ -204,6 +210,51 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>>   	if (ret<  0)
>>   		goto err_init;
>>
>> +	/* i.Mx31 OTG host has a bug, if you don't do a reset, then ULPI
>> +	 * transfert timeout. */
>
> s/transfert/transfers/
> Same below.
>
>> +	if (cpu_is_mx31()&&  pdev->id == 0) {
>> +		/* Wait for the controller to go idle */
>> +		for (i = 0; i<  10000; i++) {
>> +			if (readl(hcd->regs + USBSTS_OFFSET)&  USBSTS_HCH)
>> +				break;
>> +			udelay(1);
>> +		}
>> +		if (i == 10000) {
>> +			dev_err(dev, "Timeout while stopping USB controller\n");
>> +			goto err_init;
>> +		}
>> +
>> +		/* Stop the usb controller */
>> +		temp = readl(hcd->regs + USBCMD_OFFSET);
>> +		writel(temp&  (~USBCMD_RS), hcd->regs + USBCMD_OFFSET);
>> +
>> +		for (i = 0; i<  10000; i++) {
>> +			if (!(readl(hcd->regs + USBCMD_OFFSET)&  USBCMD_RS))
>> +				break;
>> +			udelay(1);
>> +		}
>> +
>> +		if (i == 10000) {
>> +			dev_err(dev, "Timeout while stopping USB controller\n");
>> +			goto err_init;
>> +		}
>> +
>> +		/* Reset the usb controller */
>> +		temp = readl(hcd->regs + USBCMD_OFFSET);
>> +		writel(temp | USBCMD_RST, hcd->regs + USBCMD_OFFSET);
>> +
>> +		for (i = 0; i<  10000; i++) {
>> +			if (!(readl(hcd->regs + USBCMD_OFFSET)&  USBCMD_RST))
>> +				break;
>> +			udelay(1);
>> +		}
>> +
>> +		if (i == 10000) {
>> +			dev_err(dev, "Timeout while reseting USB controller\n");
>> +			goto err_init;
>> +		}
>> +	}
>
> You add the resetting of the controller after setting up USBMODE/PORTSC
> setup. Wouldn't it be possible to change the order so that we do not
> have to do it twice?

It has to be tested, but if it works the code would then be clearer.

> Also, I think the whole reset functionality should be a seperate
> function. I can imagine we'll need it elsewhere or on different SoCs in
> which case the if clause above gets complicated.

I also think most of the things could be implemented as functions for a 
better readability (reset, and as Mark suggested a static inline 
function for the delay).

Val

>
> Sascha
>
>
>> +
>>   	/* Initialize the transceiver */
>>   	if (pdata->otg) {
>>   		pdata->otg->io_priv = hcd->regs + ULPI_VIEWPORT_OFFSET;
>> @@ -213,6 +264,23 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>>   			dev_err(dev, "unable to enable vbus on transceiver\n");
>>   	}
>>
>> +	/* i.Mx31 OTG host has a bug, if you do an ULPI transfert then the host
>> +	 * controller stay busy. Rewriting the register is enough to make it
>> +	 * working */
>> +	if (cpu_is_mx31()&&  pdev->id == 0) {
>> +		/* set USBMODE to host mode */
>> +		temp = readl(hcd->regs + USBMODE_OFFSET);
>> +		writel(temp | USBMODE_CM_HOST, hcd->regs + USBMODE_OFFSET);
>> +
>> +		/* set up the PORTSCx register */
>> +		writel(pdata->portsc, hcd->regs + PORTSC_OFFSET);
>> +
>> +		/* setup USBCONTROL. */
>> +		ret = mxc_initialize_usb_hw(pdev->id, pdata->flags);
>> +		if (ret<  0)
>> +			goto err_init;
>> +	}
>> +
>>   	priv->hcd = hcd;
>>   	platform_set_drvdata(pdev, priv);
>>
>> --
>> 1.6.3.3
>>
>>
>


-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEB3494, Station 9, CH-1015 Lausanne
