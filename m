From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 7 Jul 2017 11:22:08 -0400
Subject: [PATCH V2] PCI: Do not enable extended tags on pre-dated (v1.x)
 systems
In-Reply-To: <f95ae702-1b7b-b2d4-72bd-0518badfefbc@codeaurora.org>
References: <1499439193-16628-1-git-send-email-okaya@codeaurora.org>
 <f95ae702-1b7b-b2d4-72bd-0518badfefbc@codeaurora.org>
Message-ID: <a257422d-206c-a5a9-f964-a1f476ca5850@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/7/2017 11:07 AM, Sinan Kaya wrote:
> On 7/7/2017 10:53 AM, Sinan Kaya wrote:
>> +	ret = pcie_capability_read_word(dev, PCI_EXP_FLAGS, &flags);
>> +	if (ret || ((flags & PCI_EXP_FLAGS_VERS) < 2))
>> +		return 0;
>>  
> 
> Never mind, there is a problem here. I shouldn't have added it here.
> I'll remove these and post again.
> 

I guess I'll wait until Bjorn gets a chance to review it. There is a decision
that needs to be made here. 

Under normal circumstances, extended tags capability is a reserved field on
v1 that's expected to be 0.

Code is checking for extended tags capability being non-zero next
before setting/clearing the bit.

It should be safe to rely on capability being 0 on v1. However, we can go
paranoid and add the check above to not even look at the capability like I
did it. 

That's why, I thought this is redundant. 

I'll wait until Bjorn chimes in. It is OK to keep the code as it is. It is
just doing too much validation in my opinion. Somebody can always say
play safe.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
