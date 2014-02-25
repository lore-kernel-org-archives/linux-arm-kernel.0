From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 25 Feb 2014 17:19:59 +0200
Subject: [PATCH 4/4] ARM: keystone: Use dma-ranges for dma_pfn_offset
 configuration
In-Reply-To: <201402251437.06400.arnd@arndb.de>
References: <1393275235-1087-1-git-send-email-santosh.shilimkar@ti.com>
 <530BBBB8.3020607@ti.com> <530CA534.9080001@ti.com>
 <201402251437.06400.arnd@arndb.de>
Message-ID: <530CB49F.9060505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2014 03:37 PM, Arnd Bergmann wrote:
> On Tuesday 25 February 2014, Grygorii Strashko wrote:
>> On 02/24/2014 11:38 PM, Santosh Shilimkar wrote:
>>> On Monday 24 February 2014 04:11 PM, Arnd Bergmann wrote:
>>>> On Monday 24 February 2014 15:53:55 Santosh Shilimkar wrote:
>>>>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>>>> Hmm, isn't this function the same as of_translate_dma_address()?
>>>>
>>>> I think we should have the implementation in common code, not hidden
>>>> in the keystone platform, to avoid duplication. If of_translate_dma_address
>>>> doesn't work, what is the problem, and can you fix it there?
>>>>
>>> Will have a look at it and get back. At least it makes sense to
>>> use/update the common function.
>>
>> This function isn't the same as of_translate_dma_address(), more over
>> it calls of_translate_dma_address() to get CPU address.
>>
>> To calculate DMA bus offset we need to know the first DMA address explicitly,
>> so then we can translate it to the corresponding CPU address.
> 
> Ah, got it. Sorry for being sloppy in my review. You are absolutely right.
> 
>> get_dma_pfn_offset() function does:
>> - traverse DT and look for the first "dma-ranges" prop;
>> - reads the first DMA address of the range;
>> - translates it in CPU address using of_translate_dma_address();
>> - calculates DMA bus offset as PFN_DOWN(cpu_addr - dma_addr);
> 
> I was confused about the first step here and thought you were actually
> doing the translation there. After a more careful reading, I only
> have comments on details:
> 
>> +static unsigned long get_dma_pfn_offset(struct device *dev)
>> +{
>> +       while (1) {
>> +               naddr = of_n_addr_cells(node);
>> +               nsize = of_n_size_cells(node);
>> +               node = of_get_next_parent(node);
>> +               if (!node)
>> +                       break;
>> +
>> +               ranges = of_get_property(node, "dma-ranges", &len);
>> +
>> +               /* Ignore empty ranges, they imply no translation required */
>> +               if (ranges && len > 0)
>> +                       break;
>> +       }
> 
> I think we should require an empty "dma-ranges" property to be
> present to signify "no translation required" and interpret the
> absence of the property as "no dma possible".
> 
> A special case is having no "dma-ranges" at all, which we have
> on all existing systems, and I  would interpret that as "all
> devices can do 32-bit DMA, no more but no less".

The Keystone can work in two modes:
- LPAE disabled: In this case Platform bus notifier will not be called at all
and DMA range == MEM range (32 bits mode)
- LPAE enabled: In this case, I'll update code to treat absence of "dam-ranges"
property as "no dma possible" and clean up DMA mask. Is it ok?
In this mode "dam-ranges" prop has to be defined always to enable DMA.

Empty "dma-ranges" can't be treated as "no translation required" because it is used
to move one level up while traversing DT to find the valid "dma-ranges" prop.
Used to handle child devices like:

 bus {
 	dma-ranges = <...>;
	
	Dev A {
		dma-ranges;

		child_dev_A1 { }
		child_dev_A2 { }

This is standard behavior for "[dma-]ranges".

> 
> 
>> +       /*
>> +        * dma-ranges format:
>> +        * DMA addr     : naddr cells
>> +        * CPU addr     : pna cells
>> +        * size         : nsize cells
>> +        */
>> +       len /= sizeof(u32);
>> +       pna = of_n_addr_cells(node);
>> +       dma_addr = of_read_number(ranges, nsize);
> 
> This should probably use naddr, not nsize.

agree. 

Regards,
-grygorii
