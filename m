From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 12 Mar 2015 19:46:45 +0800
Subject: [PATCH v6 04/30] xen/PCI: Don't use deprecated function
 pci_scan_bus_parented()
In-Reply-To: <20150311223211.GB1082@google.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
 <1425868467-9667-5-git-send-email-wangyijing@huawei.com>
 <20150311223211.GB1082@google.com>
Message-ID: <55017CA5.2010502@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>  	struct pci_bus *b;
>> +	LIST_HEAD(resources);
>>  	struct pcifront_sd *sd = NULL;
>>  	struct pci_bus_entry *bus_entry = NULL;
>>  	int err = 0;
>> @@ -470,17 +472,21 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
>>  		err = -ENOMEM;
>>  		goto err_out;
>>  	}
>> +	pci_add_resource(&resources, &ioport_resource);
>> +	pci_add_resource(&resources, &iomem_resource);
>> +	pci_add_resource(&resources, &busn_resource);
> 
> Since I don't want to export busn_resource, you might have to allocate your
> own struct resource for it here.  And, of course, figure out the details of
> which PCI domain you're in and whether you need to share one struct
> resource across several host bridges in the same domain.

Allocate its own resource here is ok for me, as I mentioned in previous reply,
so do we still need to add additional info to figure out which domain own the bus resource ?


> 
>>  	pcifront_init_sd(sd, domain, bus, pdev);
>>  
>>  	pci_lock_rescan_remove();
>>  
>> -	b = pci_scan_bus_parented(&pdev->xdev->dev, bus,
>> -				  &pcifront_bus_ops, sd);
>> +	b = pci_scan_root_bus(&pdev->xdev->dev, bus,
>> +				  &pcifront_bus_ops, sd, &resources);
>>  	if (!b) {
>>  		dev_err(&pdev->xdev->dev,
>>  			"Error creating PCI Frontend Bus!\n");
>>  		err = -ENOMEM;
>>  		pci_unlock_rescan_remove();
>> +		pci_free_resource_list(&resources);
>>  		goto err_out;
>>  	}
>>  
>> @@ -488,7 +494,7 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
>>  
>>  	list_add(&bus_entry->list, &pdev->root_buses);
>>  
>> -	/* pci_scan_bus_parented skips devices which do not have a have
>> +	/* pci_scan_root_bus skips devices which do not have a
>>  	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
>>  	err = pcifront_scan_bus(pdev, domain, bus, b);
>>  
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
