From: stefan@agner.ch (Stefan Agner)
Date: Thu, 30 Jul 2015 19:00:38 +0200
Subject: [PATCH v8 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <20150730181321.3bd38db7.albert.aribaud@3adev.fr>
References: <1438015365-15685-1-git-send-email-stefan@agner.ch>
 <1438015365-15685-2-git-send-email-stefan@agner.ch>
 <20150730181321.3bd38db7.albert.aribaud@3adev.fr>
Message-ID: <36ffdc45494ab888ba375ff8478864ad@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Albert,

On 2015-07-30 18:13, Albert ARIBAUD wrote:
> Hi Stefan,
> 
> Le Mon, 27 Jul 2015 18:42:41 +0200, Stefan Agner <stefan@agner.ch> a
> ?crit :
> 
>> This driver supports Freescale NFC (NAND flash controller) found on
>> Vybrid (VF610), MPC5125, MCF54418 and Kinetis K70. The driver has
>> been tested on 8-bit and 16-bit NAND interface and supports ONFI
>> parameter page reading.
>>
>> [...]
>>
>> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
>> new file mode 100644
>> index 0000000..0da500e
>> --- /dev/null
>> +++ b/drivers/mtd/nand/vf610_nfc.c
>> @@ -0,0 +1,640 @@
>> [...]
> 
> ... about line 708:
> 
>> +	err = devm_request_irq(nfc->dev, irq, vf610_nfc_irq, 0, DRV_NAME, mtd);
>> +	if (err) {
>> +		dev_err(nfc->dev, "Error requesting IRQ!\n");
>> +		goto error;
>> +	}
>> +
>> +	vf610_nfc_init_controller(nfc);
> 
> The call above is too early: vf610_nfc_init_controller() will test
> for (nfc->chip.options & NAND_BUSWIDTH_16) but this option bit is only
> set once nand_scan_ident() below has been run.
> 
> This has the effect that even when the DT node specifies a 16-bit wide
> bus, the controller is configured for 8-bit mode at this point, which of
> course causes read failures. I've experienced this with a Vybrid SoC
> and a Micron MT29F4G16ABADAH4 16-bit NAND.
> 
>> +	/* first scan to find the device and get the page size */
>> +	if (nand_scan_ident(mtd, 1, NULL)) {
>> +		err = -ENXIO;
>> +		goto error;
>> +	}
> 
> Placing the call to vf610_nfc_init_controller() here, after the call
> to nand_scan_ident() rather than before it, fixed the issue for me.

Hm, since nand_scan_ident access the devices we actually want the
controller initialized before we access it the first time. In most
cases, the boot loader/boot ROM probably initialized the controller in a
way that identifying the chip should work non the less. However, the
safe way would be to initialize it before calling nand_scan_ident.

However, I see your point regarding bus width: With the change to
nand_dt_init, we have that information after nand_scan_ident. There is
actually more: Also the HW ECC settings are not yet parsed at that
point, hence the ECC status and offset will not be initialized right. 

We could call the whole initialization twice. This would configure 8-Bit
mode for the 16-Bit devices, but during initialization this is anyway
the required default (ONFI). Or we split it up and call it something
like vf610_nfc_preinit_controller and vf610_nfc_init_controller.

What do you think?

--
Stefan
