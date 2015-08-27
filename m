From: stefan@agner.ch (Stefan Agner)
Date: Wed, 26 Aug 2015 18:02:31 -0700
Subject: [PATCH v10 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <20150825201631.GK81844@google.com>
References: <1438594050-4595-1-git-send-email-stefan@agner.ch>
 <1438594050-4595-2-git-send-email-stefan@agner.ch>
 <20150825201631.GK81844@google.com>
Message-ID: <bf1ed158fe08b51c4668faffde44083f@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-08-25 13:16, Brian Norris wrote:
> A few more comments.
> 
> On Mon, Aug 03, 2015 at 11:27:26AM +0200, Stefan Agner wrote:
>> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
>> new file mode 100644
>> index 0000000..5c8dfe8
>> --- /dev/null
>> +++ b/drivers/mtd/nand/vf610_nfc.c
>> @@ -0,0 +1,645 @@
> 
> ...
> 
>> +/*
>> + * This function supports Vybrid only (MPC5125 would have full RB and four CS)
>> + */
>> +static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
>> +{
>> +#ifdef CONFIG_SOC_VF610
> 
> Why the #ifdef? I don't see anything compile-time specific to SOC_VF610.
> 
> If this is trying to handle the comment above ("This function supports
> Vybrid only (MPC5125 would have full RB and four CS)") then that's the
> wrong way of doing it, as you need to support multiplatform kernels.
> You'll need to have a way to differentiate the different platform
> support at runtime, not compile time.

Yes it is trying to handle the comment above. Well, the other two
platforms I am aware of are also different architectures... (PowerPC and
ColdFire). I think we won't have a multi-architecture kernel anytime
soon, hence I think removing the code at compile time is the right thing
todo.

However, probably CONFIG_SOC_VF610 is the wrong symbol then, I could
just use CONFIG_ARM and add a comment that this might be different on
another other ARM SoC than VF610.

Just checked CodingStyle, and I see that IS_ENABLED is the preferred way
for conditional compiling.

So my suggestion:

static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
{
	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
	u32 tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);

	if (!IS_ENABLED(CONFIG_ARM))
		return;

	/*
	 * This code is only tested on the ARM platform VF610
	 * PowerPC based MPC5125 would have full RB and four CS
	 */
....

With that the compiler should be able to remove this (currently) ARM
VF610 specific code on the other supported architectures...

What do you think?


> 
>> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> +	u32 tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
>> +
>> +	tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
>> +	tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
>> +
>> +	if (chip == 0)
>> +		tmp |= 1 << ROW_ADDR_CHIP_SEL_SHIFT;
>> +	else if (chip == 1)
>> +		tmp |= 2 << ROW_ADDR_CHIP_SEL_SHIFT;
> 
> 	else ... ?
> 
> Maybe you can write this as a formulaic pattern (e.g.:
> 
> 	tmp |= (chip + 1) << ROW_ADDR_CHIP_SEL_SHIFT;
> 
> ) and just do the "max # of chips" checks on a per-platform basis in the
> probe(). Then I'm guessing this same function can apply to both
> platforms. (I'm not looking at HW datasheets for this, BTW, just
> guessing based on the context here.)

It seems that MCP5125 is different than VF610. MCP5125 has 4 chip
selects and 4 R/B signals, whereas VF610 has only 2 chip selects and
just 1 R/B signals...

> But wait...I see that you call nand_scan_ident() with a max of 1 chip.
> So you won't ever see the chip > 0 case, right?
> 
> So does this driver support multiple flash attached or not? Looks like
> you're assuming you'll only be using chip-select 0. (This is fine for
> now, but at least your code should acknowledge this. Perhaps a comment
> at the top under "limitations.")
> 

Ok, will add that information under limitations.


>> +
>> +	vf610_nfc_write(nfc, NFC_ROW_ADDR, tmp);
>> +#endif
>> +}
> 
> ...
> 
>> +static int vf610_nfc_probe(struct platform_device *pdev)
>> +{
> 
> ...
> 
>> +	/* first scan to find the device and get the page size */
>> +	if (nand_scan_ident(mtd, 1, NULL)) {
>> +		err = -ENXIO;
>> +		goto error;
>> +	}

--
Stefan
