From: b32955@freescale.com (Huang Shijie)
Date: Wed, 29 Jun 2011 18:46:46 +0800
Subject: [PATCH v7 1/3] MTD : add the common code for GPMI-NFC controller
	driver
In-Reply-To: <20110629103337.GF1992@pengutronix.de>
References: <1309335878-16678-1-git-send-email-b32955@freescale.com>
	<1309335878-16678-2-git-send-email-b32955@freescale.com>
	<20110629100658.GE1992@pengutronix.de>
	<20110629103337.GF1992@pengutronix.de>
Message-ID: <4E0B0296.6060902@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:
>>> +static int __devinit acquire_interrupt(struct gpmi_nfc_data *this,
>>> +			const char *resource_name,
>>> +			irq_handler_t interrupt_handler, int *lno, int *hno)
>>> +{
>>> +	struct platform_device *pdev = this->pdev;
>>> +	struct resource *r;
>>> +	int err;
>>> +
>>> +	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, resource_name);
>>> +	if (!r) {
>>> +		pr_info("Can't get resource for %s\n", resource_name);
>>> +		return -ENXIO;
>>> +	}
>>> +
>>> +	BUG_ON(r->start != r->end);
>>> +	err = request_irq(r->start, interrupt_handler, 0, resource_name, this);
>>> +	if (err) {
>>> +		pr_info("Can't own %s\n", resource_name);
>>> +		return err;
>>> +	}
>>> +
>>> +	*lno = r->start;
>>> +	*hno = r->end;
>>> +	return 0;
>>> +}
>> This will not work if max_chip_count > 1, because the irq is already
>> taken. (Also, I am not convinced of the resource handling, but I need to
> Doh, I wrote that below the wrong codepath. This is another irq here.
> Still, the problem exists: When a second channel GPMI channel is
> requested, dmaengine will return -EBUSY, because the DMAIRQ is already
> taken.
>
Yes, we should change the DMA code, it is a DMA bug.
I ever submitted a patch about the issue:
http://patchwork.ozlabs.org/patch/87145/

Best Regards
Huang Shijie




> Regards,
>
>    Wolfram
>
