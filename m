From: vigneshr@ti.com (Vignesh R)
Date: Thu, 13 Oct 2016 17:46:53 +0530
Subject: [PATCH RESEND] ARM: dts: keystone-k2*: Increase SPI Flash
 partition size for U-Boot
In-Reply-To: <20161012115703.GE1041@n2100.armlinux.org.uk>
References: <20161010141141.21333-1-vigneshr@ti.com>
 <20161010143144.GB1041@n2100.armlinux.org.uk>
 <c3be6bfc-9cfa-bcd8-5988-ee8bdd9fa506@ti.com>
 <20161012115703.GE1041@n2100.armlinux.org.uk>
Message-ID: <ac18b275-4b84-f95a-1882-b9da983b5cbe@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 12 October 2016 05:27 PM, Russell King - ARM Linux wrote:
> On Wed, Oct 12, 2016 at 04:30:28PM +0530, Vignesh R wrote:
[...]
>>>
>>> - What is this "misc" partition?
>>>
>>
>> This partition seems to exists from the very beginning.  I believe, this
>> is just a spare area of flash that can be used as per end-user
>> requirement. Either to store a small filesystem or kernel. Copying
>> Murali who added above partition if he has any input here.
>>
>>> - Why is it safe to move the "misc" partition in this way?
>>>
>>> - Do users need to do anything with data stored in the "misc" partition
>>>   when changing kernels?
>>>
>>
>> MTD layer will take care of most abstractions (like start address etc).
>> Will add a note in commit message informing about the reduction in size
>> of the partition.
>>
>>> If the "misc" partition is simply unused space on the flash device, why
>>> list it in DT?
>>>
>>
>> If the unused space is not listed in the DT, then there is no /dev/mtdX
>> node created for the unused section. User will then have to manually
>> edit DT, in order to get the node and mount it. Instead, lets make it
>> available by default.
> 
> So, taken all together, your argument is:
> 
> - We want a user partition
> - It's okay to destroy the data in the user's partition by moving it
>   around randomly between kernel versions.
> 
> The two do not naturally go together at all.  You're messing with user
> expectations in ways you should not be.  This really is not an acceptable
> approach.
> 

Ok, I understand that if the user just updates to new kernel(w/o
updating bootloader) then this patch will end up setting "misc"
partition at wrong offset. At this point, I don't see how to provide a
way to upgrade boot loader at the same time support old and new layouts
simultaneously.
Could you please suggest an alternative approach that would enable users
to update U-Boot partition?
If not, then I guess, will have to drop this patch. Note that, this
means there won't be a straight forward way of updating SPI U-Boot
partition from kernel for K2 devices.

-- 
Regards
Vignesh
