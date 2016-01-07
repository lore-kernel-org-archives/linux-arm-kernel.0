From: dgdegra@tycho.nsa.gov (Daniel De Graaf)
Date: Thu, 7 Jan 2016 16:40:09 -0500
Subject: [PATCH v3 59/62] xen/arm: Add a hypercall for device mmio mapping
In-Reply-To: <568E511402000078000C44C6@prv-mh.provo.novell.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-60-git-send-email-shannon.zhao@linaro.org>
 <564B17EA02000078000B5D34@prv-mh.provo.novell.com>
 <568E0CA9.4090307@huawei.com>
 <568E25A702000078000C43EA@prv-mh.provo.novell.com>
 <568E2BB4.8080802@huawei.com>
 <568E511402000078000C44C6@prv-mh.provo.novell.com>
Message-ID: <568EDB39.6050804@tycho.nsa.gov>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2016 05:50 AM, Jan Beulich wrote:
>>>> On 07.01.16 at 10:11, <zhaoshenglong@huawei.com> wrote:
>> Hi Jan,
>>
>> On 2016/1/7 15:45, Jan Beulich wrote:
>>>>>> On 07.01.16 at 07:58, <zhaoshenglong@huawei.com> wrote:
>>>>> On 2015/11/17 19:04, Jan Beulich wrote:
>>>>>>>>>>>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
>>>>>>>>>>> --- a/xen/arch/arm/mm.c
>>>>>>>>>>> +++ b/xen/arch/arm/mm.c
>>>>>>>>>>> @@ -1138,6 +1138,10 @@ int xenmem_add_to_physmap_one(
>>>>>>>>>>>           rcu_unlock_domain(od);
>>>>>>>>>>>           break;
>>>>>>>>>>>       }
>>>>>>>>>>> +    case XENMAPSPACE_dev_mmio:
>>>>>>>>>>> +        rc = map_dev_mmio_region(d, gpfn, 1, idx);
>>>>>>>>>>> +        return rc;
>>>>>>>>>>> +        break;
>>>>>>> Blindly for any kind of domain? The XSM check in the
>>>>>>> XENMEM_add_to_physmap_batch handler (in common code) doesn't
>>>>>>> even know which map space is to be used...
>>>>>
>>>>> Sorry, I know little about XSM. Could you suggest me how to add the
>>>>> check for this new type here?
>>> I'm sorry to push back here, but did you at least try to derive
>>> what is wanted from the multitude of other XSM checks present
>>> throughout the tree?
>>
>> IIUC, you mean that it doean't need to change the XSM check itself, but
>> we should check if the current->domain is hardware domain and it maps
>> the space to itself before the XSM check, right?
>
> No, I actually think that you need to add a new, secondary XSM
> check. But you may want to consult with Daniel (who so far wasn't
> even Cc-ed).

Looking at the original patch, I am not sure if I understand the
checks: it seems like the iomem_access_permitted check is being done
on the guest's page range instead of the actual IO memory, which
ends up allowing the guest to map anything as long as it maps it in
the right guest area.  The iomem_permit_access call there also seems
to be redundant because it is the same range that was just checked.

If the [start_gfn, start_gfn + nr) memory range actually describes
the physical addresses, then this operation is taking advantage of
the existing XSM checks on XEN_DOMCTL_iomem_permission, and the
only XSM check that is needed would be that current->domain has
permission to modify (d)'s mappings - and this is done by the
xsm_add_to_physmap check in XENMEM_add_to_physmap.

-- 
Daniel De Graaf
National Security Agency
