From: james.morse@arm.com (James Morse)
Date: Tue, 24 Jan 2017 17:55:32 +0000
Subject: [PATCH V7 05/10] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <8b9d254a-5450-d841-baf7-5819a88043e4@codeaurora.org>
References: <1484244924-24786-1-git-send-email-tbaicar@codeaurora.org>
 <1484244924-24786-6-git-send-email-tbaicar@codeaurora.org>
 <587F80A7.10008@arm.com>
 <3de443d7-2c68-f179-daae-bc8f851470b7@codeaurora.org>
 <5880FDFC.7060304@arm.com>
 <8b9d254a-5450-d841-baf7-5819a88043e4@codeaurora.org>
Message-ID: <58879514.1020501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 20/01/17 20:58, Baicar, Tyler wrote:
> On 1/19/2017 10:57 AM, James Morse wrote:
>> On 18/01/17 23:51, Baicar, Tyler wrote:
>>> On 1/18/2017 7:50 AM, James Morse wrote:
>>>> On 12/01/17 18:15, Tyler Baicar wrote:
>>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c

>> There are two other things that need changing to make the in_nmi() code path
>> work on arm64.
>> Always reserve the virtual-address-space forcing GHES_IOREMAP_PAGES to be 2
>> regardless of CONFIG_HAVE_ACPI_APEI_NMI. This is almost revert of
>> 594c7255dce7a13cac50cf2470cc56e2c3b0494e (but that did a few other things too).

> Looks simple enough, should I force it to 2 in all cases, or add a check for
> CONFIG_HAVE_ACPI_APEI_SEA
> similar to the check for CONFIG_HAVE_ACPI_APEI_NMI?

Its just address space not actual memory it is reserving right? I think just
reserve two pages all the time to save eye-sore #ifdefs!


>> We also need to fix ghes_ioremap_pfn_nmi() to use arch_apei_get_mem_attribute()
>> and not assume PAGE_KERNEL.

> So just change the call to ioremap_page_range to:
> 
> ioremap_page_range(vaddr, vaddr + PAGE_SIZE, pfn << PAGE_SHIFT,
> arch_apei_get_mem_attribute());

(you need to give arch_apei_get_mem_attribute() the address...) copying whatever
ghes_ioremap_pfn_irq() does a few lines down is probably best.


Thanks,

James
