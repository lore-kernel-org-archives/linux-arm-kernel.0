From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Oct 2017 09:12:22 -0700
Subject: [PATCH 1/9] SOC: brcmstb: add memory API
In-Reply-To: <20171017082413.GA10574@infradead.org>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-2-git-send-email-jim2101024@gmail.com>
 <20171017082413.GA10574@infradead.org>
Message-ID: <abdb1e9d-f8c9-8066-48c5-37b4e2474952@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2017 01:24 AM, Christoph Hellwig wrote:
>> +/* Macros to help extract property data */
>> +#define U8TOU32(b, offs) \
>> +	((((u32)b[0 + offs] << 0)  & 0x000000ff) | \
>> +	 (((u32)b[1 + offs] << 8)  & 0x0000ff00) | \
>> +	 (((u32)b[2 + offs] << 16) & 0x00ff0000) | \
>> +	 (((u32)b[3 + offs] << 24) & 0xff000000))
> 
> Please us helpers like get_unaligned_le32 instead opencoding them.
> 
>> +#define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(U8TOU32(b, offs)))
> 
> And together with this it looks really whacky.  So you're converting
> from le to native first and then do another conversion from be to cpu?
> 
> Something doesn't work out here.
> 
>> +/* -------------------- Functions -------------------- */
> 
> Please remove pointless comments like this one.
> 
>> +
>> +/*
>> + * If the DT nodes are handy, determine which MEMC holds the specified
>> + * physical address.
>> + */
>> +#ifdef CONFIG_ARCH_BRCMSTB
>> +int __brcmstb_memory_phys_addr_to_memc(phys_addr_t pa, void __iomem *base)
> 
> Please move this into the arm arch code.

No, this needs to work on both ARM and ARM64, hence the reason why this
is in a reasonably architecture neutral place.

> 
>> +#elif defined(CONFIG_MIPS)
> 
> And this into the mips arch code.

Same reason as above.

> 
>> +EXPORT_SYMBOL(brcmstb_memory_phys_addr_to_memc);
> 
>> +EXPORT_SYMBOL(brcmstb_memory_memc_size);
> 
> Why is this exported?

Because the PCIE RC driver can be built as a module.
-- 
Florian
