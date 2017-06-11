From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 11 Jun 2017 22:37:18 +0000
Subject: [RFC PATCH 1/4] EDAC: mvebu: Add driver for Marvell Armada SoCs
References: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
 <20170608041124.4624-2-chris.packham@alliedtelesis.co.nz>
 <1497014062.3536.52.camel@pengutronix.de>
Message-ID: <1ddc23d9f25c4952a1ca04d20cbb598c@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/17 01:19, Jan L?bbe wrote:
>> +
>> +	if (edac_op_state == EDAC_OPSTATE_INT) {
>> +		/* acquire interrupt that reports errors */
>> +		pdata->irq = platform_get_irq(pdev, 0);
>> +		res = devm_request_irq(&pdev->dev,
>> +				       pdata->irq,
>> +				       mvebu_mc_isr,
>> +				       0,
>> +				       "[EDAC] MC err",
>> +				       mci);
> Which IRQ do you use? The current DT doesn't configure interrupts. Also
> it seems that the events are passed through additional layers of
> mask/status registers which are not yet represented in the Armada-XP IRQ
> hierarchy. So my driver currently uses polling.

Yes I'd been forcing polling too. To get this working properly I think 
we'd need to add another irqchip driver for the SoC Err interrupts. 
Which is kind of where I'd got stuck, the datasheet is a little 
confusing in that area. I think I'd figured out that the root interrupt 
comes through INT 4 which could be cascaded to the as yet unwritten SoC 
Err irqchip.
