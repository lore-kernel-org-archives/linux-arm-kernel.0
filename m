From: poza@codeaurora.org (poza at codeaurora.org)
Date: Tue, 14 Nov 2017 04:56:30 +0530
Subject: [3/4] PCI/portdrv: Implement interface to query the registered
 service
In-Reply-To: <73379e2c-b0c3-885c-bb5d-b981863b6042@codeaurora.org>
References: <1510260399-14886-4-git-send-email-poza@codeaurora.org>
 <73379e2c-b0c3-885c-bb5d-b981863b6042@codeaurora.org>
Message-ID: <b98f5b7e1b64f9d5ce1ff7e52fa0887d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-11-14 02:22, Sinan Kaya wrote:
> Some nits only.
> 
>>  /**
>> + * pcie_port_service_query - query if particula port service is 
>> enabled.
>> + * dev: pcie device
>> + * @port service: PCI express port service
>> + */
>> +int pcie_port_query_service(struct pci_dev *dev, u32 port_service)
>> +{
>> +	struct pcie_device *pdev;
>> +	struct pci_dev *parent, *this = dev;
>> +
>> +	do {
> 
> While I understand the motivation why this function is searching for 
> DPC capable
> parent until the root port, the name of the function does not represent 
> this.
> 

Will change it to more relevant one.

> It might make sense to split this into two where the first function 
> just queries
> the capabilities of the immediate device (the list_for_each_section).
> 
>> +		list_for_each_entry(pdev, &this->service_list, slist) {
>> +			if (pdev->service == port_service)
>> +				return 1;
>> +		}
> 
> Another function to query all parents until you reach the root port.
> 
>> +		parent = pci_upstream_bridge(this);
>> +		this = parent;
>> +	} while (parent && pci_is_pcie(parent));
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(pcie_port_query_service);
>> +

yes that makes sense; will split the function as you are suggesting.

Regards,
Oza.
