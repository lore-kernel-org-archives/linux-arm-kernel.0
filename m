From: tthayer@opensource.altera.com (Thor Thayer)
Date: Fri, 17 Jun 2016 12:42:39 -0500
Subject: [PATCHv3 5/7] EDAC, altera: Add Arria10 ECC memory init functions
In-Reply-To: <20160617172150.GJ3912@pd.tnic>
References: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
 <1465852752-11018-6-git-send-email-tthayer@opensource.altera.com>
 <20160617172150.GJ3912@pd.tnic>
Message-ID: <5764368F.6040800@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/17/2016 12:21 PM, Borislav Petkov wrote:
> On Mon, Jun 13, 2016 at 04:19:10PM -0500, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> In preparation for additional memory module ECCs, add the
>> memory initialization functions and helper functions used
>> for memory initialization.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v2: Specify INTMODE selection -> IRQ on each ECC error.
>>      Insert functions above memory-specific functions so that function
>>      declarations are not required.
>>      Use ERRINTENS & ERRINTENR registers instead of read/modify/write.
>> v3: Changes for common compatibility string:
>>      - Pass node instead of compatibility string.
>>      - New altr_init_a10_ecc_device_type() for peripherals.
>>      - Add __init to altr_init_a10_ecc_block().
>>      - Add a10_get_irq_mask().
>> ---
>>   drivers/edac/altera_edac.c |  197 ++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/edac/altera_edac.h |    8 ++
>>   2 files changed, 205 insertions(+)
>
>> +/*
>> + * This function uses the memory initialization block in the Arria10 ECC
>> + * controller to initialize/clear the entire memory data and ECC data.
>> + */
>> +static int altr_init_memory_port(void __iomem *ioaddr, int port)
>> +{
>> +	int limit = ALTR_A10_ECC_INIT_WATCHDOG_10US;
>> +	u32 init_mask = ALTR_A10_ECC_INITA;
>> +	u32 stat_mask = ALTR_A10_ECC_INITCOMPLETEA;
>> +	u32 clear_mask = ALTR_A10_ECC_ERRPENA_MASK;
>> +	int ret = 0;
>> +
>> +	if (port) {
>> +		init_mask = ALTR_A10_ECC_INITB;
>> +		stat_mask = ALTR_A10_ECC_INITCOMPLETEB;
>> +		clear_mask = ALTR_A10_ECC_ERRPENB_MASK;
>> +	}
>
> Do a
> 	u32 init_mask, stat_mask, clear_mask;
>
> 	if (port) {
> 		init_mask = ALTR_A10_ECC_INITB;
> 		...
> 	} else {
> 		init_mask = ALTR_A10_ECC_INITA;
> 		...
> 	}
>
> so that you don't have to repeat the assignments in the if (port) case.
>
OK. I only have one PORTB peripheral so normally the if (port) branch 
won't execute but I see your point.

>> +
>> +	ecc_set_bits(init_mask, (ioaddr + ALTR_A10_ECC_CTRL_OFST));
>> +	while (limit--) {
>> +		if (ecc_test_bits(stat_mask,
>> +				  (ioaddr + ALTR_A10_ECC_INITSTAT_OFST)))
>> +			break;
>> +		udelay(1);
>> +	}
>> +	if (limit < 0)
>> +		ret = -EBUSY;
>> +
>> +	/* Clear any pending ECC interrupts */
>> +	writel(clear_mask, (ioaddr + ALTR_A10_ECC_INTSTAT_OFST));
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Aside from the L2 ECC, the Arria10 ECC memories have a common register
>> + * layout so the following functions can be shared between all peripherals.
>
> I don't understand - we're here under
>
> #if defined(CONFIG_EDAC_ALTERA_ETHERNET)
>
> What sharing do you mean?
>
I'll be adding a number of peripheral FIFOs in future patches but I 
agree that the comment is misleading in this case. I'll fix it.
