From: labbott@redhat.com (Laura Abbott)
Date: Thu, 5 Nov 2015 17:24:01 -0800
Subject: [PATCH 1/2] arm64: Get existing page protections in split_pmd
In-Reply-To: <563B2C32.10307@huawei.com>
References: <1446587315-18145-1-git-send-email-labbott@fedoraproject.org>
 <1446587315-18145-2-git-send-email-labbott@fedoraproject.org>
 <563B2C32.10307@huawei.com>
Message-ID: <563C0131.2060707@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2015 02:15 AM, Xishi Qiu wrote:
> On 2015/11/4 5:48, Laura Abbott wrote:
>
>>
>> Rather than always putting the least restrictived permissions
>> (PAGE_KERNEL_EXEC) when spliting a pmd into pages, use
>> the existing permissions from the pmd for the page.
>>
>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>> ---
>>   arch/arm64/mm/mmu.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 9211b85..ff41efa 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -75,14 +75,13 @@ static void __init *early_alloc(unsigned long sz)
>>   static void split_pmd(pmd_t *pmd, pte_t *pte)
>>   {
>>   	unsigned long pfn = pmd_pfn(*pmd);
>> +	unsigned long addr = pfn << PAGE_SHIFT;
>> +	pgprot_t prot = __pgprot(pmd_val(*pmd) ^ addr) | PTE_TYPE_PAGE;
>> +
>
> Hi Laura,
>
> I'm not quite understand, I find split_pud() doesn't set the flag
> PMD_TYPE_TABLE. If we clear xx_TABLE_BIT, does that means the page
> is large page?

I'm assuming by large page you mean a block mapping. Yes, without
that entry the kernel treats this as a block mapping

> And what is the different from the flag xx_TYPE_SECT?

That would mark it this as a block mapping which is not what we want
here.

>
> Thanks,
> Xishi Qiu
>
