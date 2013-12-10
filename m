From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 10 Dec 2013 10:11:36 -0500
Subject: [PATCH v3 1/2] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <20131210025110.GA20090@saruman.home>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-2-git-send-email-w-kwok2@ti.com>
 <20131210025110.GA20090@saruman.home>
Message-ID: <52A72F28.10909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013 09:51 PM, Balbi, Felipe wrote:
> Hi,
> 
> On Mon, Dec 09, 2013 at 05:17:03PM -0500, WingMan Kwok wrote:
>> +static void kdwc3_enable_irqs(struct dwc3_keystone *kdwc)
>> +{
>> +	u32 val;
>> +
>> +	val = kdwc3_readl(kdwc->usbss, USBSS_IRQENABLE_SET_0);
>> +	val = USBSS_IRQ_COREIRQ_EN;
> 
> this misses the | in |=. I can fix it up while applying, this time only.
> 
>> +static int kdwc3_probe(struct platform_device *pdev)
>> +{
>> +	struct device		*dev = &pdev->dev;
>> +	struct device_node	*node = pdev->dev.of_node;
>> +	struct dwc3_keystone	*kdwc;
>> +	struct resource		*res;
>> +	int			error, irq;
>> +
>> +	kdwc = devm_kzalloc(dev, sizeof(*kdwc), GFP_KERNEL);
>> +	if (!kdwc)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, kdwc);
>> +
>> +	kdwc->dev = dev;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(dev, "missing usbss resource\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	kdwc->usbss = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(kdwc->usbss))
>> +		return PTR_ERR(kdwc->usbss);
>> +
>> +	kdwc3_dma_mask = dma_get_mask(dev);
>> +	dev->dma_mask = &kdwc3_dma_mask;
>> +
>> +	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
>> +	if (IS_ERR_OR_NULL(kdwc->clk)) {
> 
> clk_get() will never return NULL. This time, I'll fix it while applying.
> 
>> +static int kdwc3_remove(struct platform_device *pdev)
>> +{
>> +	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
>> +
>> +	kdwc3_disable_irqs(kdwc);
>> +	clk_disable_unprepare(kdwc->clk);
> 
> I hope the clock isn't shared between core and wrapper, otherwise you
> could run into some troubles here. Can you confirm ?
> 
Yes. the clock isn't shared. Thanks for taking care of other parts.
