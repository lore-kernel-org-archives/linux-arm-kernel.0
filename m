From: stefan@agner.ch (Stefan Agner)
Date: Wed, 03 Jun 2015 11:45:50 +0200
Subject: [PATCH v4 1/6] mtd: nand: =?UTF-8?Q?vf=36=31=30=5Fnfc=3A=20Fr?=
 =?UTF-8?Q?eescale=20NFC=20for=20VF=36=31=30=2C=20MPC=35=31=32=35=20and=20?=
 =?UTF-8?Q?others?=
In-Reply-To: <20150603081059.GA6944@breakpoint.cc>
References: <1427300909-20825-1-git-send-email-stefan@agner.ch>
 <1427300909-20825-2-git-send-email-stefan@agner.ch>
 <20150603081059.GA6944@breakpoint.cc>
Message-ID: <821b4731043fef279b6a82b920707982@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-03 10:10, Sebastian Andrzej Siewior wrote:
> On 2015-03-25 17:28:24 [+0100], Stefan Agner wrote:
>> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
>> new file mode 100644
>> index 0000000..23c1510
>> --- /dev/null
>> +++ b/drivers/mtd/nand/vf610_nfc.c
> ?
>> +static void vf610_nfc_addr_cycle(struct vf610_nfc *nfc, int column, int page)
>> +{
>> +	if (column != -1) {
>> +		if (nfc->chip.options | NAND_BUSWIDTH_16)
>> +			column = column/2;
>> +		vf610_nfc_set_field(nfc, NFC_COL_ADDR, COL_ADDR_MASK,
>> +				    COL_ADDR_SHIFT, column);
>> +	}
>> +	if (page != -1)
>> +		vf610_nfc_set_field(nfc, NFC_ROW_ADDR, ROW_ADDR_MASK,
>> +				    ROW_ADDR_SHIFT, page);
>> +}
> 
> Do you have here also a different NAND layout on your boot-page vs
> remaining pages? The mpc5125 has this different layout.

There is the boot configuration block which uses a Parity 13/8
algorithm, is it that you are referring to? The format parity is in the
main area, hence it doesn't clash with the HW ECC of the controller. One
can use normal NAND write functions to write this page. See the
implementation in our downstream U-Boot:

http://git.toradex.com/cgit/u-boot-toradex.git/commit/?h=2015.04-toradex-next&id=b004926168f3bc15f9e26f14c16ae60a252b1304

--
Stefan
