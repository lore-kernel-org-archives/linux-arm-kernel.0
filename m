From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 28 Feb 2017 10:04:06 -0500
Subject: [PATCH V2] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B2846666830C@IRSMSX101.ger.corp.intel.com>
References: <1485891928-14573-1-git-send-email-okaya@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846666830C@IRSMSX101.ger.corp.intel.com>
Message-ID: <b78207b6-2c22-3e6d-4837-8b4b396c4f5d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/28/2017 6:03 AM, Patel, Mayurkumar wrote:
>> -	/* Save default state */
>> -	link->aspm_default = link->aspm_enabled;
> But, I am finding a problem with this change, if Policy is set to default,
> BIOS enables ASPM L1, but pcie_config_aspm_link() disables ASPM L1
> due to link->aspm_enabled is different than link->aspm_default while
> called from pcie_aspm_init_link_state() during hotplug insertion.
> 

Thanks for testing. I think it means the enable count logic I put below
is not working.

I was trying to figure out when to use saved values vs. the values in
registers by looking at the enable_cnt.

enable_cnt is 0 during boot on my system.

The enable_cnt should have been non-zero following an insertion following
remove and default and enabled values should have been identical. 

Can you print out the values of pdev->aspm_default, link->aspm_default, 
and link->aspm_enabled in this function along with atomic_read(&pdev->enable_cnt)?

> 
>> +	/*
>> +	 * Save default state from FW when enabling ASPM for the first time
>> +	 * during boot by looking at the calculated link->aspm_enabled bits
>> +	 * above and enable_cnt will be zero.
>> +	 *
>> +	 * If this path is getting called for the second/third time
>> +	 * (enable_cnt will be non-zero). Assume that the current state of the
>> +	 * ASPM registers may not necessarily match what FW asked us to do as
>> +	 * in the case of hotplug insertion/removal.
>> +	 */
>> +	if (!atomic_read(&pdev->enable_cnt))
>> +		pdev->aspm_default = link->aspm_default = link->aspm_enabled;
>> +	else
>> +		link->aspm_default = pdev->aspm_default;


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
