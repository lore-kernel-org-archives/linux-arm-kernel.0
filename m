From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Fri, 14 Nov 2014 07:19:22 +0800
Subject: [PATCH 2/2] PCI: generic: Add set_msi_parent callback
In-Reply-To: <20141113152243.GB9726@red-moon>
References: <1415647480-3320-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1415647480-3320-3-git-send-email-suravee.suthikulpanit@amd.com>
 <20141111112424.GB16265@arm.com>
 <20141111115227.GF12037@e106497-lin.cambridge.arm.com>
 <20141113152243.GB9726@red-moon>
Message-ID: <54653C7A.6060003@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/13 23:22, Lorenzo Pieralisi wrote:
> On Tue, Nov 11, 2014 at 11:52:27AM +0000, Liviu Dudau wrote:
>> On Tue, Nov 11, 2014 at 11:24:24AM +0000, Will Deacon wrote:
>>> Hi Suravee,
>>>
>>> On Mon, Nov 10, 2014 at 07:24:40PM +0000, suravee.suthikulpanit at amd.com wrote:
>>>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>>
>>> I don't think this makes much sense a host controller callback. Why can't
>>> bus->msi be set in generic code?
>>
>> Because of the current way in which a bus gets created and them immediately used for
>> scanning devices if you use pci_scan_root_bus(). Alternative is to use pci_create_root_bus()
>> and increase your code size with the body of pci_scan_root_bus().
>>
>> Solution is to have pci_host_bridge holding the msi_chip pointer and that gets created
>> before root bus, with pci_scan_root_bus() now having all the info needed to do successful
>> setup of scanned devices.
> 
> Why can't we add a hook like pci_bus_assign_domain_nr(), say:
> 
> pci_bus_msi_init()
> 
> in pci_create_root_bus() that does what Suravee wants in a generic way ?
+1
BTW, x86 may have multiple MSI controllers/domains under a host bridge,
so prefer calling it for every bus instead of for root bus only.
Regards!
Gerry
> 
> What am I missing ?
> 
> Lorenzo
> 
>>
>> Best regards,
>> Liviu
>>
>>>
>>>>  static struct pci_ops gen_pci_ops = {
>>>>  	.read	= gen_pci_config_read,
>>>>  	.write	= gen_pci_config_write,
>>>> +	.set_msi_parent = gen_pci_set_msi_parent,
>>>>  };
>>>>  
>>>>  static const struct of_device_id gen_pci_of_match[] = {
>>>> @@ -313,6 +324,9 @@ static int gen_pci_probe(struct platform_device *pdev)
>>>>  		return err;
>>>>  	}
>>>>  
>>>> +	pci->mchip = of_pci_find_msi_chip_by_node(of_parse_phandle(np,
>>>> +						  "msi-parent", 0));
>>>
>>> This bit should be in the generic of_pci.c code and not duplicated for
>>> each host controller.
>>>
>>> Will
>>>
>>
>> -- 
>> ====================
>> | I would like to |
>> | fix the world,  |
>> | but they're not |
>> | giving me the   |
>>  \ source code!  /
>>   ---------------
>>     ?\_(?)_/?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
