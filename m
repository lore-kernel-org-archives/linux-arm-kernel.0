From: b32955@freescale.com (Huang Shijie)
Date: Tue, 6 Sep 2011 18:31:57 +0800
Subject: [PATCH v11 1/3] MTD : add the common code for GPMI-NAND controller
	driver
In-Reply-To: <20110905151752.GA10987@pengutronix.de>
References: <1314616381-11615-1-git-send-email-b32955@freescale.com>
	<1314616381-11615-2-git-send-email-b32955@freescale.com>
	<20110905151752.GA10987@pengutronix.de>
Message-ID: <4E65F69D.5010808@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:
> On Mon, Aug 29, 2011 at 07:12:59PM +0800, Huang Shijie wrote:
>> These files contain the common code for the GPMI-NAND driver.
>>
>> Signed-off-by: Huang Shijie <b32955@freescale.com>
>> Acked-by: Marek Vasut <marek.vasut@gmail.com>
>> Tested-by: Koen Beel <koen.beel@barco.com>
> ...
>
>> +static int __devinit
>> +acquire_register_block(struct gpmi_nand_data *this, const char *res_name)
>> +{
>> +	struct platform_device *pdev = this->pdev;
>> +	struct resources *res = &this->resources;
>> +	struct resource *r;
>> +	void *p;
>> +
>> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
>> +	if (!r) {
>> +		pr_err("Can't get resource for %s\n", res_name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	p = ioremap(r->start, resource_size(r));
>> +	if (!p) {
>> +		pr_err("Can't remap %s\n", res_name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (res_name == GPMI_NAND_GPMI_REGS_ADDR_RES_NAME)
>> +		res->gpmi_regs = p;
>> +	else if (res_name == GPMI_NAND_BCH_REGS_ADDR_RES_NAME)
>> +		res->bch_regs = p;
> Am I the only one getting warnings here?
>
> drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function 'acquire_register_block':
> drivers/mtd/nand/gpmi-nand/gpmi-nand.c:345:15: warning: comparison with string literal results in unspecified behavior
> drivers/mtd/nand/gpmi-nand/gpmi-nand.c:347:20: warning: comparison with string literal results in unspecified behavior
>
> Really worth fixing IMHO...
>
>> +	else
>> +		BUG();
> dev_err + ENODEV?
>
> Might be worth checking the other BUG()-occurences as well if they really need
> to halt the kernel.
>
Should i wait for your test result, and send out the new version v12?
or I send out the new version first, and then you test it again?


thanks

Huang Shijie
> Regards,
>
>    Wolfram
>
