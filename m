From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 6 Oct 2015 13:38:10 +0200
Subject: [PATCH v6 2/4] spi: bcm2835: add bcm2835 auxiliary spi device
 driver
In-Reply-To: <20151006112320.GP12635@sirena.org.uk>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
 <1441970527-2403-3-git-send-email-kernel@martin.sperl.org>
 <20151006112320.GP12635@sirena.org.uk>
Message-ID: <5613B2A2.9020309@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.10.2015 13:23, Mark Brown wrote:
> On Fri, Sep 11, 2015 at 11:22:04AM +0000, kernel at martin.sperl.org wrote:
>
>> +	bs->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
>> +	if (bs->irq <= 0) {
>> +		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
>> +		err = bs->irq ? bs->irq : -ENODEV;
>> +		goto out_master_put;
>> +	}
>
> Why are we using this unusual DT specific API here?  I'd expect to see
> just use platform_get_irq() here and this seems to be the only DT
> dependency in the driver.

I copied it from spi-bcm2835.c, where it is also used in exactly that
fashion.

You want me to move to your recommended api instead for both drivers?

>
>> +	err = devm_request_irq(&pdev->dev, bs->irq,
>> +			       bcm2835aux_spi_interrupt,
>> +			       IRQF_SHARED,
>> +			       dev_name(&pdev->dev), master);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
>> +		goto out_clk_disable;
>> +	}
>> +
>> +	/* reset SPI-HW block */
>> +	bcm2835aux_spi_reset_hw(bs);
>
> I'd expect to request the IRQ after we reset the hardware in order to
> ensure that the hardware is in a known good state

Same copy/paste in this case - i can change the order for both
drivers if you want.

Martin
