From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Tue, 25 Apr 2017 11:41:39 -0600
Subject: [PATCH V15 06/11] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <20170425172154.ggg56j52inf3522e@pd.tnic>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-7-git-send-email-tbaicar@codeaurora.org>
 <20170425172154.ggg56j52inf3522e@pd.tnic>
Message-ID: <6d7249d3-e0b2-afa7-b5fa-8e85c40d8a13@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2017 11:21 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 05:05:18PM -0600, Tyler Baicar wrote:
>> ARM APEI extension proposal added SEA (Synchronous External Abort)
>> notification type for ARMv8.
>> Add a new GHES error source handling function for SEA. If an error
>> source's notification type is SEA, then this function can be registered
>> into the SEA exception handler. That way GHES will parse and report
>> SEA exceptions when they occur.
>> An SEA can interrupt code that had interrupts masked and is treated as
>> an NMI. To aid this the page of address space for mapping APEI buffers
>> while in_nmi() is always reserved, and ghes_ioremap_pfn_nmi() is
>> changed to use the helper methods to find the prot_t to map with in
>> the same way as ghes_ioremap_pfn_irq().
> ...
>
>> @@ -518,6 +520,17 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>   	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
>>   		inf->name, esr, addr);
>>   
>> +	/*
>> +	 * Synchronous aborts may interrupt code which had interrupts masked.
>> +	 * Before calling out into the wider kernel tell the interested
>> +	 * subsystems.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA)) {
>> +		nmi_enter();
>> +		ghes_notify_sea();
>> +		nmi_exit();
>> +	}
> Well, the other GHES notification methods use a notifier:
> ghes_notify_sci, ghes_notify_nmi. You probably should do that too
> instead of calling straight into a driver from arch code.
I originally had this as a notifier, but Will requested to remove the 
notifier. That conversation is here: https://lkml.org/lkml/2017/1/18/1018

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
