From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 23 Jun 2015 15:37:33 +0100
Subject: [RFC 23/23] arm/xen: Add support for 64KB page granularity
In-Reply-To: <alpine.DEB.2.02.1506231508050.16917@kaball.uk.xensource.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-24-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1506231508050.16917@kaball.uk.xensource.com>
Message-ID: <55896F2D.5030405@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/06/15 15:19, Stefano Stabellini wrote:
>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>> index 224081c..dcfe251 100644
>> --- a/arch/arm/xen/enlighten.c
>> +++ b/arch/arm/xen/enlighten.c
>> @@ -93,8 +93,8 @@ static void xen_percpu_init(void)
>>  	pr_info("Xen: initializing cpu%d\n", cpu);
>>  	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
>>  
>> -	info.mfn = __pa(vcpup) >> PAGE_SHIFT;
>> -	info.offset = offset_in_page(vcpup);
>> +	info.mfn = __pa(vcpup) >> XEN_PAGE_SHIFT;
>> +	info.offset = xen_offset_in_page(vcpup);
>>  
>>  	err = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_info, cpu, &info);
>>  	BUG_ON(err);
>> @@ -204,7 +204,7 @@ static int __init xen_guest_init(void)
>>  	xatp.domid = DOMID_SELF;
>>  	xatp.idx = 0;
>>  	xatp.space = XENMAPSPACE_shared_info;
>> -	xatp.gpfn = __pa(shared_info_page) >> PAGE_SHIFT;
>> +	xatp.gpfn = __pa(shared_info_page) >> XEN_PAGE_SHIFT;
>>  	if (HYPERVISOR_memory_op(XENMEM_add_to_physmap, &xatp))
>>  		BUG();
> 
> What about xen_remap_domain_mfn_range? I guess we don't support that use
> case on 64K guests? If so, I would appreaciate an assert and/or an error
> message.

The implementation of xen_remap_domain_mfn_range return -ENOSYS no
matter the page granularity.

This function is PV specific and has been added few months ago just for
a stub. See comment in the code:
"/* Not used by XENFEAT_auto_translated guests */"

Any logging/BUG_ON within this function is out of scope for this series.
And I don't think this will be really useful. Feel free to send a patch
for it.

Regards,

-- 
Julien Grall
