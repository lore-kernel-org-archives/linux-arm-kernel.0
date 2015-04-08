From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 8 Apr 2015 09:18:48 +0800
Subject: [PATCH v9 06/30] PCI: Separate pci_host_bridge creation out of
 pci_create_root_bus()
In-Reply-To: <20150407213839.GJ10892@google.com>
References: <1428053164-28277-1-git-send-email-wangyijing@huawei.com>
 <1428053164-28277-8-git-send-email-wangyijing@huawei.com>
 <20150407213839.GJ10892@google.com>
Message-ID: <552481F8.1090308@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +	/*
>> +	 * If support CONFIG_PCI_DOMAINS_GENERIC, use
>> +	 * pci_host_assign_domain_nr() to update domain
>> +	 * number.
>> +	 */
>> +	host->domain = domain;
>> +	pci_host_assign_domain_nr(host);
> 
> I think it's a bit confusing that there's another "host->domain ="
> assignment buried inside pci_host_assign_domain_nr(), so the first
> assignment is overwritten when CONFIG_PCI_DOMAINS_GENERIC is set.
> 
> Can you do something like this instead:
> 
>   int pci_host_assign_domain_nr(struct pci_host_bridge *host, int domain)
>   {
>   #ifdef CONFIG_PCI_DOMAINS_GENERIC
>     host->domain = pci_assign_domain_nr(host->dev.parent);
>   #else
>     host->domain = domain;
>   #endif
>   }
> 
> Then the alternatives (CONFIG_PCI_DOMAINS_GENERIC=y and
> CONFIG_PCI_DOMAINS_GENERIC being unset) are close together and right at the
> #ifdef CONFIG_PCI_DOMAINS_GENERIC, so no extra comments are needed.

OK, I would use #ifdef to update pci_host_assign_domain_nr(), and I would drop the
last patch [PATCH v9 30/30] PCI: Clean up CONFIG_PCI_DOMAINS_GENERIC.

Thanks!
Yijing.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing
