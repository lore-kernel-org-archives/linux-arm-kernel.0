From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 2 Aug 2017 14:16:51 -0400
Subject: [PATCH V6 2/2] PCI: handle CRS returned by device after FLR
In-Reply-To: <20170802114924.18dd30e2@w520.home>
References: <1501694304-16554-1-git-send-email-okaya@codeaurora.org>
 <1501694304-16554-2-git-send-email-okaya@codeaurora.org>
 <20170802114924.18dd30e2@w520.home>
Message-ID: <563c7f28-851b-b531-34d0-2cee252766d0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/2/2017 1:49 PM, Alex Williamson wrote:
> On Wed,  2 Aug 2017 13:18:24 -0400

[snip]

>>  static void pci_flr_wait(struct pci_dev *dev)
>>  {
>> -	int i = 0;
>> +	u32 sleep = 1000, total = 0;
>>  	u32 id;
>> +	bool ret;
>>  
>>  	if (dev->is_virtfn) {
>>  		msleep(100);
>>  		return;
>>  	}
>>  
>> +	/* don't touch the HW before waiting 100ms */
>> +	msleep(100);
>> +
> 
> 
> Wouldn't it be better as:
> 

Sure, that looks reasonable.

> 	msleep(100);
> 
> 	if (dev->is_virtfn)
> 		return;
> 
> Perhaps with a spec reference in a comment why we don't care about
> checking config space for the vf.

The spec reference is in the commit message of 

"PCI: limit FLR wait time to 100ms maximum"

where I introduce this check. Do you prefer a reference in the code?
I was under the impression that commit messages are used for these
kind of documentation.

> 
>>  	do {
>> -		msleep(100);
>> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
>> -	} while (i++ < 10 && id == ~0);
>> -
>> -	if (id == ~0)
>> -		dev_warn(&dev->dev, "Failed to return from FLR\n");
>> -	else if (i > 1)
>> -		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
>> -			 (i - 1) * 100);
>> +		ret = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
>> +						 sleep);
>> +		if (ret)
>> +			break;
>> +		total += sleep;
>> +		sleep *= 2;
>> +	} while (total < 60000 && !ret);
>> +
>> +	if (!ret)
>> +		dev_warn(&dev->dev, "Failed to return from FLR after %ds\n",
>> +			 total);
>> +	else if (total)
>> +		dev_info(&dev->dev, "Required additional %ds to return from FLR\n",
>> +			 total);
>>  }
> 
> I'm not a big fan.  Nested exponential backoff is pretty nasty.  Are
> there users of pci_bus_read_dev_vendor_id() that don't want a "still
> trying" message?  It seems better to add that to the function than try
> to wrap this bandage around it.  Thanks,

I can work towards that if Bjorn doesn't have any objections.

> 
> Alex
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
