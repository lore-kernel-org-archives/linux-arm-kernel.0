From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 13 Mar 2015 09:57:25 +0800
Subject: [PATCH v6 03/30] PCI: Export busn_resource to drivers/pci
In-Reply-To: <20150312193219.GA7346@google.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
 <1425868467-9667-4-git-send-email-wangyijing@huawei.com>
 <20150311222835.GA1082@google.com> <55017BA1.7020700@huawei.com>
 <20150312193219.GA7346@google.com>
Message-ID: <55024405.8040504@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Hi Bjorn, busn_resource may would not be shared by multi domains,
>>
>> We insert bus number resource like:
>>
>> pci_add_resource(&resources, &busn_resource);	
>> 	pci_bus_insert_busn_res(root_bus, start, bus_max);	//start is the root bus number provided by arch pci host driver, bus max here == 255
>> 		get_pci_domain_busn_res(domain)	//for root bus	//try to get a domain specific pci_domain_busn_res, if not exist, create it.
>> 			request_resource_conflict(domain_specific_busn_res, res)   //request busn res(start, bus_max) from the pci_domain_busn_res.
>>
>> So every domain has its own pci_domain_busn_res , different domain would not share the same bus number resource.
> 
> The intent of pci_add_resource() and passing the resulting resource list
> into pci_scan_root_bus(), etc., is that the host bridge may consume any
> resources described by the list.  If we pass the same resource to multiple
> calls, that means the resource must be shared between the multiple host
> bridges involved.  For bus numbers, that makes some sense if the platform
> considers the bridges to be in the same domain, but not if they are in
> different domains.
> 
> If we export busn_resource, we have no control over what domains it becomes
> associated with because the domain is passed into pci_scan_root_bus() by
> the caller.

Agree, I will drop this patch, thanks!

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing
