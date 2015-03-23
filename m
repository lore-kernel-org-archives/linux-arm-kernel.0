From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 23 Mar 2015 09:08:41 +0800
Subject: [PATCH v6 09/30] PCI: Separate pci_host_bridge creation out of
 pci_create_root_bus()
In-Reply-To: <550DFD13.9080505@amd.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
 <1425868467-9667-10-git-send-email-wangyijing@huawei.com>
 <550DFD13.9080505@amd.com>
Message-ID: <550F6799.1000301@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +struct pci_host_bridge *pci_create_host_bridge(
>> +        struct device *parent, u32 db, struct list_head *resources)
>> +{
>> +    int error;
>> +    int bus = PCI_BUSNUM(db);
>> +    int domain = PCI_DOMAIN(db);
>> +    struct pci_host_bridge *host;
>> +    struct resource_entry *window, *n;
>> +
>> +    host = kzalloc(sizeof(*host), GFP_KERNEL);
>> +    if (!host)
>> +        return NULL;
>> +
>> +    host->busnum = bus;
>> +    host->domain = domain;
>> +    /* If support CONFIG_PCI_DOMAINS_GENERIC, use
>> +     * pci_host_assign_domain_nr() to assign domain
>> +     * number instead PCI_DOMAIN(db).
>> +     */
>> +    pci_host_assign_domain_nr(host);
> 
> At this point, host->dev.parent has not been assigned. However, when calling pci_host_assign_domain_nr(host), it calls pci_assign_domain_nr(host->dev.parent), which uses parent->of_node directly w/o checking if parent is NULL. This ended up causing NULL pointer exception when I do the test.
> 
> I think we need to moveo host->dev.parent = parent before calling pci_host_assign_domain_nr(host).

Good catch! Hi Suravee, thanks for your test, I would assign host->dev.parent before pci_host_assign_domain_nr().

Thanks!
Yijing.

> 
> .
> 


-- 
Thanks!
Yijing
