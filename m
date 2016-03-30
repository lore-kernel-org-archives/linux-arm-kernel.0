From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Wed, 30 Mar 2016 20:42:20 +0800
Subject: [PATCH v7 03/17] Xen: xlate: Use page_to_xen_pfn instead of
 page_to_pfn
In-Reply-To: <56FBB709.5050802@arm.com>
References: <1458830676-27075-1-git-send-email-shannon.zhao@linaro.org>
 <1458830676-27075-4-git-send-email-shannon.zhao@linaro.org>
 <56FAAD48.2010401@arm.com> <56FB8258.7030303@huawei.com>
 <56FBB709.5050802@arm.com>
Message-ID: <56FBC9AC.1070203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?03?30? 19:22, Julien Grall wrote:
> Hi Shannon,
> 
> On 30/03/16 08:38, Shannon Zhao wrote:
>>
>>
>> On 2016/3/30 0:28, Julien Grall wrote:
>>> On 24/03/16 14:44, Shannon Zhao wrote:
>>>> Make xen_xlate_map_ballooned_pages work with 64K pages. In that case
>>>> Kernel pages are 64K in size but Xen pages remain 4K in size. Xen pfns
>>>> refer to 4K pages.
>>>>
>>>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>>>> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>>>> ---
>>>>    drivers/xen/xlate_mmu.c | 26 ++++++++++++++++----------
>>>>    1 file changed, 16 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
>>>> index 9692656..28f728b 100644
>>>> --- a/drivers/xen/xlate_mmu.c
>>>> +++ b/drivers/xen/xlate_mmu.c
>>>> @@ -207,9 +207,12 @@ int __init
>>>> xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
>>>>        void *vaddr;
>>>>        int rc;
>>>>        unsigned int i;
>>>> +    unsigned long nr_pages;
>>>> +    xen_pfn_t xen_pfn = 0;
>>>>
>>>>        BUG_ON(nr_grant_frames == 0);
>>>> -    pages = kcalloc(nr_grant_frames, sizeof(pages[0]), GFP_KERNEL);
>>>> +    nr_pages = DIV_ROUND_UP(nr_grant_frames, XEN_PFN_PER_PAGE);
>>>> +    pages = kcalloc(nr_pages, sizeof(pages[0]), GFP_KERNEL);
>>>>        if (!pages)
>>>>            return -ENOMEM;
>>>>
>>>> @@ -218,22 +221,25 @@ int __init
>>>> xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
>>>>            kfree(pages);
>>>>            return -ENOMEM;
>>>>        }
>>>> -    rc = alloc_xenballooned_pages(nr_grant_frames, pages);
>>>> +    rc = alloc_xenballooned_pages(nr_pages, pages);
>>>>        if (rc) {
>>>> -        pr_warn("%s Couldn't balloon alloc %ld pfns rc:%d\n",
>>>> __func__,
>>>> -            nr_grant_frames, rc);
>>>> +        pr_warn("%s Couldn't balloon alloc %ld pages rc:%d\n",
>>>> __func__,
>>>> +            nr_pages, rc);
>>>>            kfree(pages);
>>>>            kfree(pfns);
>>>>            return rc;
>>>>        }
>>>> -    for (i = 0; i < nr_grant_frames; i++)
>>>> -        pfns[i] = page_to_pfn(pages[i]);
>>>> +    for (i = 0; i < nr_grant_frames; i++) {
>>>> +        if ((i % XEN_PFN_PER_PAGE) == 0)
>>>> +            xen_pfn = page_to_xen_pfn(pages[i / XEN_PFN_PER_PAGE]);
>>>> +        pfns[i] = pfn_to_gfn(xen_pfn++);
>>>> +    }
>>>
>>> Would it be possible to re-use xen_for_each_gfn? This will avoid
>>> open-coding the loop to break down the Linux page.
>> I don't think so. Using xen_acpi_guest_init will require factoring
>> "pfns[i] = pfn_to_gfn(xen_pfn++)" to a function with parameter pfns[i].
>> How can we pass pfns[i]?
> 
> By using the variable data. Something along those lines:
> 
> struct map_balloon_pages
> {
>       xen_pfn_t *pfns;
>       unsigned int idx;
> };
> 
> static void setup_balloon_gfn(unsigned long gfn, void *data)
> {
>       struct map_balloon_pages *info = data;
> 
> 
>       data->pfns[data->idx] = gfn;
>       data->idx++;
> }
> 
> And then in xen_xlate_map_ballooned_pages
> 
> xen_for_each_gfn(pages, nr_grant_frames, setup_balloon_gfn, &data);
I think this looks like less direct. Anyway I will update this patch as
you said.

Thanks,
-- 
Shannon
