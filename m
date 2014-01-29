From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 29 Jan 2014 20:02:52 +0100
Subject: [RFC PATCH v2 08/14] mtd: nand: add sunxi NAND flash controller
 support
In-Reply-To: <20140129175641.GF1427@obsidianresearch.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-9-git-send-email-b.brezillon.dev@gmail.com>
 <20140129175641.GF1427@obsidianresearch.com>
Message-ID: <52E9505C.8080001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/01/2014 18:56, Jason Gunthorpe a ?crit :
> On Wed, Jan 29, 2014 at 03:34:18PM +0100, Boris BREZILLON wrote:
>
>> +static int sunxi_nand_chip_init_timings(struct sunxi_nand_chip *chip,
>> +					struct device_node *np)
>> +{
>> +	const struct nand_sdr_timings *timings;
>> +	u32 min_clk_period = 0;
>> +	int ret;
>> +
>> +	ret = onfi_get_async_timing_mode(&chip->nand);
>> +	if (ret == ONFI_TIMING_MODE_UNKNOWN) {
>> +		ret = of_get_nand_onfi_timing_mode(np);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
> [..]
>
>> +static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
> [..]
>> +       ret = sunxi_nand_chip_init_timings(chip, np);
>> +       if (ret)
>> +               return ret;
> [..]
>> +       ret = nand_scan_ident(mtd, nsels, NULL);
> This ordering looks a bit problematic, will onfi_get_async_timing_mode
> ever return anything other than ONFI_TIMING_MODE_UNKNOWN if it is
> called before nand_scan_ident ?
Indeed. I haven't tested this part as I don't own any board with an ONFI 
compatible chip.
> What sets clk_rate to non-zero if there
> is no DT property?
It is set to 20 MHz by default, but it should definitely be set to the 
rate fulfilling mode 0.
I'll fix this.

>
> For a flow that uses onfi_get_async_timing_mode rather than DT the
> driver should set the interface to timing mode 0 (slowest) and then
> call nand_scan_ident, and then reset the interface to the detected
> timing mode.

Absolutely.

>
> Maybe this should be implemented in the core code through a new
> callback (nand->set_timing_mode ?)
>
> Regards,
> Jason
