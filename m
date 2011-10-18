From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Tue, 18 Oct 2011 15:21:22 +0400
Subject: [PATCH 04/11] ARM: at91/pata: use gpio_is_valid to check the gpio
In-Reply-To: <20111017122410.GV1459@game.jcrosoft.org>
References: <20111016190528.GI1459@game.jcrosoft.org>
	<1318792160-23279-4-git-send-email-plagnioj@jcrosoft.com>
	<4E9C0970.5000707@ru.mvista.com>
	<20111017122410.GV1459@game.jcrosoft.org>
Message-ID: <4E9D6132.4050006@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-10-2011 16:24, Jean-Christophe PLAGNIOL-VILLARD wrote:

>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
>>> Acked-by: Nicolas Ferre<nicolas.ferre@atmel.com>
>>> ---
>>>   drivers/ata/pata_at91.c |    6 +++---
>>>   1 files changed, 3 insertions(+), 3 deletions(-)

>>     You should post this patch to linux-ide at vger.kernel.org...

> already done it's just a resend of the same one send weeks ago

    I haven't seen this patch on linux-ide...

>>> diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
>>> index 960c725..3915353 100644
>>> --- a/drivers/ata/pata_at91.c
>>> +++ b/drivers/ata/pata_at91.c
>>> @@ -360,7 +360,7 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
>>>   	ap->flags |= ATA_FLAG_SLAVE_POSS;
>>>   	ap->pio_mask = ATA_PIO4;
>>>
>>> -	if (!irq) {
>>> +	if (!gpio_is_valid(irq)) {
>>>   		ap->flags |= ATA_FLAG_PIO_POLLING;
>>>   		ata_port_desc(ap, "no IRQ, using PIO polling");
>>>   	}
>>> @@ -414,8 +414,8 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
>>>
>>>   	host->private_data = info;
>>>
>>> -	return ata_host_activate(host, irq ? gpio_to_irq(irq) : 0,
>>> -			irq ? ata_sff_interrupt : NULL,
>>> +	return ata_host_activate(host, gpio_is_valid(irq) ? gpio_to_irq(irq) : 0,
>>> +			gpio_is_valid(irq) ? ata_sff_interrupt : NULL,
>>>   			irq_flags,&pata_at91_sht);
>>>   err_put:

>>     BTW, the driver forgets to call clk_put() iff ata_host_activate()
>> fails; I've already posted a patch to fix this -- it conflicts with
>> this one.

> Didn't receive it

http://marc.info/?l=linux-ide&m=131825944706266

> Best Regards,
> J.

WBR, Sergei
