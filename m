From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 12 Mar 2015 21:15:11 +0800
Subject: [PATCH v6 13/30] PCI: Introduce new scan function
 pci_scan_host_bridge()
In-Reply-To: <20150312032515.GF10949@google.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
 <1425868467-9667-14-git-send-email-wangyijing@huawei.com>
 <20150312032515.GF10949@google.com>
Message-ID: <5501915F.80404@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +struct pci_host_bridge *pci_scan_host_bridge(struct device *parent,
>> +		u32 db, struct pci_ops *ops, void *sysdata,
>> +		struct list_head *resources,
>> +		struct pci_host_bridge_ops *phb_ops)
> 
> Drop the "phb_" prefix.

OK.

> 
>> +{
>> +	struct pci_host_bridge *host;
>> +	struct pci_bus *bus;
>> +
>> +	host = pci_create_host_bridge(parent, db, resources,
>> +			sysdata, phb_ops);
>> +	if (!host)
>> +		return NULL;
>> +
>> +	bus = __pci_scan_root_bus(host, ops);
>> +	if (!bus)
>> +		pci_free_host_bridge(host);
>> +
>> +	return host;
>> +}
>> +EXPORT_SYMBOL(pci_scan_host_bridge);
>> +
>> +
>>  struct pci_bus *pci_scan_root_bus(struct device *parent, u32 db,
>>  		struct pci_ops *ops, void *sysdata, struct list_head *resources)
>>  {
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index e9922b1..28eafb5 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -790,6 +790,10 @@ void pci_bus_release_busn_res(struct pci_bus *b);
>>  struct pci_bus *pci_scan_root_bus(struct device *parent, u32 dombus,
>>  					     struct pci_ops *ops, void *sysdata,
>>  					     struct list_head *resources);
>> +struct pci_host_bridge *pci_scan_host_bridge(struct device *parent,
>> +		u32 dombus, struct pci_ops *ops, void *sysdata,
>> +		struct list_head *resources,
>> +		struct pci_host_bridge_ops *phb_ops);
>>  struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
>>  				int busnr);
>>  void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing
