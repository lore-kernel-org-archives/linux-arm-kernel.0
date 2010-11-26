From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 26 Nov 2010 15:16:05 +0100
Subject: [PATCH 3/7] i2c/pxa2xx: Add PCI support for PXA I2C controller
In-Reply-To: <20101125235933.GD15948@trinity.fluff.org>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
	<1290633617-15311-4-git-send-email-bigeasy@linutronix.de>
	<20101125235933.GD15948@trinity.fluff.org>
Message-ID: <4CEFC125.8010905@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
>> +#define IBMR            (0x14)
>> +#define IDBR            (0x0c)
>> +#define ICR             (0x00)
>> +#define ISR             (0x04)
>> +
>> +#define _IBMR(i2c)	((i2c)->reg_base + IBMR)
>> +#define _IDBR(i2c)	((i2c)->reg_base + IDBR)
>> +#define _ICR(i2c)	((i2c)->reg_base + ICR)
>> +#define _ISR(i2c)	((i2c)->reg_base + ISR)
> 
> couldn't these be in common code?

Yes. I'm going to move these back into the driver and ifdef x86 & arm
specific.

>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-pxa-pci.c
>> +static void __devexit ce4100_i2c_remove(struct pci_dev *dev)
>> +{
>> +	struct ce4100_devices *sds;
>> +	unsigned int i;
>> +
>> +	sds = pci_get_drvdata(dev);
>> +	pci_set_drvdata(dev, NULL);
>> +
>> +	for (i = 0; i < CE4100_PCI_I2C_DEVS; i++)
> how about using ARRAY_SIZE of sds->sd[i] ?

I'm still thinking whether to use this or pci_select_bars() as Florian
suggested.

Sebastian
