From: monstr@monstr.eu (Michal Simek)
Date: Tue, 12 Nov 2013 16:40:56 +0100
Subject: Physical memory start contraints in the Linux kernel  (Was: Re:
 Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel] [xen-unstable
 test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <20131112153904.GP16735@n2100.arm.linux.org.uk>
References: <1383731526.26213.25.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311061111580.26077@kaball.uk.xensource.com>
 <1383736784.26213.72.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311061938080.26077@kaball.uk.xensource.com>
 <1383822868.26213.181.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311111825090.26077@kaball.uk.xensource.com>
 <1384250005.1883.35.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
 <20131112132001.GJ16735@n2100.arm.linux.org.uk> <5282483E.1000101@monstr.eu>
 <20131112153904.GP16735@n2100.arm.linux.org.uk>
Message-ID: <52824C08.70301@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2013 04:39 PM, Russell King - ARM Linux wrote:
> On Tue, Nov 12, 2013 at 04:24:46PM +0100, Michal Simek wrote:
>> On 11/12/2013 02:20 PM, Russell King - ARM Linux wrote:
>>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>>> index f52150d2ec00..1957d54198ad 100644
>>> --- a/arch/arm/kernel/setup.c
>>> +++ b/arch/arm/kernel/setup.c
>>> @@ -660,6 +660,17 @@ int __init arm_add_memory(u64 start, u64 size)
>>>  	}
>>>  #endif
>>>  
>>> +	if (aligned_start < PHYS_OFFSET) {
>>> +		if (aligned_start + size < PHYS_OFFSET) {
>>
>> just a note I sent to Russell. Here should be "<=" instead of just "<"
>>
>>> +			pr_info("Ignoring memory below PHYS_OFFSET: 0x%08llx-0x%08llx\n",
>>> +				aligned_start, aligned_start + size);
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		size -= PHYS_OFFSET - aligned_start;
>>> +		aligned_start = PHYS_OFFSET;
>>
>> We should printk a message here to be aware that alignment was done.
> 
> Yep, you sent me an updated patch, I haven't added anything to my
> kernel tree for about a week and a bit now as I want to get what's
> already there into Linus' tree.  Once that stuff has gone, I'll see
> about adding some of these fixes we need into the queue.

No problem. Take you time.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131112/d0555f6a/attachment.sig>
