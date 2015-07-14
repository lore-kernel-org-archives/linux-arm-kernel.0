From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Tue, 14 Jul 2015 11:28:30 -0400
Subject: [PATCH v2 19/20] xen/privcmd: Add support for Linux 64KB page
 granularity
In-Reply-To: <55A43638.4030503@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-20-git-send-email-julien.grall@citrix.com>
 <55A41BE4.3080104@oracle.com> <55A43638.4030503@citrix.com>
Message-ID: <55A52A9E.2000400@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2015 06:05 PM, Julien Grall wrote:
> Hi Boris,
>
> On 13/07/2015 22:13, Boris Ostrovsky wrote:
>> On 07/09/2015 04:42 PM, Julien Grall wrote:
>>> -
>>>   struct remap_data {
>>>       xen_pfn_t *fgmfn; /* foreign domain's gmfn */
>>> +    xen_pfn_t *efgmfn; /* pointer to the end of the fgmfn array */
>>
>> It might be better to keep size of fgmfn array instead.
>
> It would means to have an other variable to check that we are at the 
> end the array.


I thought that's what h_iter is. Is it not?


>
> What about a variable which will be decremented?
>
>>>
>>> +static int unmap_gfn(struct page *page, unsigned long pfn, void *data)
>>> +{
>>> +    int *nr = data;
>>> +    struct xen_remove_from_physmap xrp;
>>> +
>>> +    /* The Linux Page may not have been fully mapped to Xen */
>>> +    if (!*nr)
>>> +        return 0;
>>> +
>>> +    xrp.domid = DOMID_SELF;
>>> +    xrp.gpfn = pfn;
>>> +    (void)HYPERVISOR_memory_op(XENMEM_remove_from_physmap, &xrp);
>>> +
>>> +    (*nr)--;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
>>>                     int nr, struct page **pages)
>>>   {
>>>       int i;
>>> +    int nr_page = round_up(nr, XEN_PFN_PER_PAGE);
>>> -    for (i = 0; i < nr; i++) {
>>> -        struct xen_remove_from_physmap xrp;
>>> -        unsigned long pfn;
>>> +    for (i = 0; i < nr_page; i++) {
>>> +        /* unmap_gfn guarantees ret == 0 */
>>> +        BUG_ON(xen_apply_to_page(pages[i], unmap_gfn, &nr));
>>
>>
>> TBH, I am not sure how useful xen_apply_to_page() routine is. In this
>> patch especially, but also in others.
>
> It avoids an open loop in each place where it's needed (here, 
> balloon...) which means another indentation layer. You can give a look 
> it's quite ugly.

I didn't notice that it was an inline, in which case it is indeed cleaner.

-boris

>
> Furthermore, the helper will avoid possible done by developers who are 
> working on PV drivers on x86. If you see code where the MFN 
> translation is done directly via virt_to_mfn or page_to_mfn... it will 
> likely means that the code will be broking when 64KB page granularity 
> will be in used.
> Though, there will still be some place where it's valid to use 
> virt_to_mfn and page_to_mfn.
>
> Regards,
>
