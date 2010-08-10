From: stepanm@codeaurora.org (stepanm at codeaurora.org)
Date: Mon, 9 Aug 2010 20:42:13 -0700 (PDT)
Subject: [PATCH v3] arm: msm: Add MSM IOMMU support.
In-Reply-To: <1281409689.1954.96.camel@Joe-Laptop.home>
References: <1281407259-28626-1-git-send-email-stepanm@codeaurora.org>
	<1281409689.1954.96.camel@Joe-Laptop.home>
Message-ID: <bf2b5539fdb03a1a9c55ee1122c40b99.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Why use both pr_err and printk(KERN_ERR ?

I had been using pr_err for printing badness messages internal to the
driver, but I guess their functionality is largely paralleled by return
error codes. I had been using printk(KERN_ERR for messages that have been
caused by an event that is more external to the driver and its callers
(like the data for the page fault, which is most likely to be caused by a
misprogrammed client). pr_err gives other information like function name,
line number, etc, which would be noise when looking at an iommu page
fault. And, I guess if the pr_err stuff got turned off, you would want the
page fault data to still be printed... but that's kind of a minor point.

I am actually considering doing away with all the pr_err lines entirely
because they typically also result in returning -Ewhatever and other IOMMU
drivers don't give this level of error reporting. But, they may be helpful
to the users of the API. What are people's thoughts on this?

Thanks
Steve

>> +#define pr_fmt(fmt) "%s %i " fmt, __func__, __LINE__
>> +		pr_err("bad size: %d\n", len);
>> +		pr_err("null page table\n");
>> +			pr_err("could not allocate second level table\n");
>> +		pr_err("null page table\n");
>> +		pr_err("first level PTE is 0\n");
>> +	printk(KERN_ERR "FAR    = %08x    PAR    = %08x\n",
>> +	printk(KERN_ERR "FSR    = %08x [%s%s%s%s%s%s%s%s%s%s]\n", fsr,
>> +	printk(KERN_ERR "FSYNR0 = %08x    FSYNR1 = %08x\n",
>> +	printk(KERN_ERR "TTBR0  = %08x    TTBR1  = %08x\n",
>> +	printk(KERN_ERR "SCTLR  = %08x    ACTLR  = %08x\n",
>> +	printk(KERN_ERR "PRRR   = %08x    NMRR   = %08x\n",
>> +		pr_err("Invalid device ID in context interrupt handler\n");
>> +	printk(KERN_ERR "===== WOAH! =====\n");
>> +	printk(KERN_ERR "Unexpected IOMMU page fault!\n");
>> +	printk(KERN_ERR "base = %08x\n", (unsigned int) base);
>> +			printk(KERN_ERR "Fault occurred in context %d.\n", i);
>> +			printk(KERN_ERR "Interesting registers:\n");
>> +			printk(KERN_ERR "\n");
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
