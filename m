From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 6 Dec 2013 16:39:49 -0500
Subject: [PATCH v2 1/5] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <20131206202844.GG21086@saruman.home>
References: <1386187811-9596-1-git-send-email-w-kwok2@ti.com>
 <1386187811-9596-2-git-send-email-w-kwok2@ti.com>
 <20131206202844.GG21086@saruman.home>
Message-ID: <52A24425.7030802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013 03:28 PM, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Dec 04, 2013 at 03:10:07PM -0500, WingMan Kwok wrote:
>> Add Keystone platform specific glue layer to support
>> USB3 Host mode.
>>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
>> ---
>>  drivers/usb/dwc3/Kconfig         |    7 ++
>>  drivers/usb/dwc3/Makefile        |    1 +
>>  drivers/usb/dwc3/dwc3-keystone.c |  210 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 218 insertions(+)
>>  create mode 100644 drivers/usb/dwc3/dwc3-keystone.c

[..]

>> +static irqreturn_t dwc3_keystone_interrupt(int irq, void *_kdwc)
>> +{
>> +	struct dwc3_keystone	*kdwc = _kdwc;
>> +
>> +	spin_lock(&kdwc->lock);
> 
> Isn't this lock unnecessary ? This handler will run with IRQs disabled
> anyway.
> 
Indeed.

>> +	kdwc3_writel(kdwc->usbss, USBSS_IRQENABLE_CLR_0, USBSS_IRQ_COREIRQ_CLR);
>> +	kdwc3_writel(kdwc->usbss, USBSS_IRQSTATUS_0, USBSS_IRQ_EVENT_ST);
>> +	kdwc3_writel(kdwc->usbss, USBSS_IRQENABLE_SET_0, USBSS_IRQ_COREIRQ_EN);
>> +	kdwc3_writel(kdwc->usbss, USBSS_IRQ_EOI, USBSS_IRQ_EOI_LINE(0));
>> +	spin_unlock(&kdwc->lock);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int kdwc3_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node	*node = pdev->dev.of_node;
>> +	struct device		*dev = &pdev->dev;
> 
> if you invert these lines, it'll look a little nicer:
> 
> 	struct device		*dev = &pdev->dev;
> 	struct device_node	*node = dev->of_node;
> 
> everything else looks pretty good, thanks
> 
Looks good to me as well. With above update, 
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
