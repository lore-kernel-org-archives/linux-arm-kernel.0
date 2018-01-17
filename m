From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Wed, 17 Jan 2018 16:48:46 +0800
Subject: [PATCH v2 12/13] iommu/rockchip: Add runtime PM support
In-Reply-To: <5A5F00D1.5010506@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-13-jeffy.chen@rock-chips.com>
 <CAAFQd5DCxgsL52+5XetV9MRDecL7dN6_QdHysKUOWaEqSf=ijw@mail.gmail.com>
 <5A5EFAB2.7040001@rock-chips.com>
 <CAAFQd5ATRh5hdJhVxDoXjFz72cBmv-yNaW7v-eUxkVRYA3=uJg@mail.gmail.com>
 <5A5F00D1.5010506@rock-chips.com>
Message-ID: <5A5F0DEE.9030508@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 01/17/2018 03:52 PM, JeffyChen wrote:
> Hi Tomasz,
>
> On 01/17/2018 03:38 PM, Tomasz Figa wrote:
>>>> >>Don't we need to check here (and in _shutdown() too) if we have a
>>>> >>domain attached?
>>> >
>>> >hmmm, right, the startup might been called by resume, so should check
>>> >iommu->domain here.
>>> >
>>> >but the shutdown would be called at the end of detach or suspend, it
>>> could
>>> >be not attached or attached.
>> If startup might be called by resume, without domain attached, what
>> prevents shutdown from being called by suspend after that resume,
>> still without domain attached? Is it guaranteed that if resume is
>> called, someone will attach a domain before suspend is called?
>>
> no, the shutdown would be called by:
> 1/ end of detach_dev
> so it would be not attached at that time
>
> 2/ suspend
> so it could be attached, and also could be not attached
>
>
> anyway, i think the shutdown would work without domain attached(just
> disable paging and clear the iommu bases) ;)
>
hmmm, i see the problem.

so we need to:
1/ move shutdown a little earlier in detach_dev, so it could still see 
the iommu->domain

2/ check iommu->domain in shutdown, to prevent unnecessary shutdown


or maybe just add iommu->domain check in suspend and resume.
>> Best regards,
>> Tomasz
>>
>>
>>
>
