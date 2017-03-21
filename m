From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Tue, 21 Mar 2017 13:19:12 -0600
Subject: [PATCH V12 05/10] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <58CC121F.5030807@arm.com>
References: <1488833103-21082-1-git-send-email-tbaicar@codeaurora.org>
 <1488833103-21082-6-git-send-email-tbaicar@codeaurora.org>
 <58CC121F.5030807@arm.com>
Message-ID: <a3de014f-a5b8-a7ed-fbd4-305e73a1f783@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello James,


On 3/17/2017 10:43 AM, James Morse wrote:
> On 06/03/17 20:44, Tyler Baicar wrote:
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
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index b25e7cf..b0596ba 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -1023,6 +1075,13 @@ static int ghes_probe(struct platform_device *ghes_dev)
>>   		pr_warning(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
>>   			   generic->header.source_id);
>>   		goto err;
>> +	case ACPI_HEST_NOTIFY_GPIO:
>> +	case ACPI_HEST_NOTIFY_SEI:
>> +	case ACPI_HEST_NOTIFY_GSIV:
>> +		pr_warn(GHES_PFX "Generic hardware error source: %d notified via notification type %u is not supported\n",
>> +			generic->header.source_id, generic->header.source_id);
>> +		rc = -ENOTSUPP;
>> +		goto err;
>>   	default:
>>   		pr_warning(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
>>   			   generic->notify.type, generic->header.source_id);
>
> This hunk will conflict with Shiju Jose's patch[0] that adds GPIO and GSIV
> support. Can we remove it?
Yes, I was planning on removing this when I saw Shiju's patch. It will 
be removed in my v13.

Thanks,
Tyler
>
> [0] https://www.spinics.net/lists/linux-acpi/msg72654.html

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
