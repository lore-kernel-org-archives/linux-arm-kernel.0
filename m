From: wmills@ti.com (William Mills)
Date: Mon, 6 Jun 2016 08:50:58 -0400
Subject: [RFC v2 4/4] ARM: keystone: dma-coherent with safe fallback
In-Reply-To: <20160606114256.GF6831@leverpostej>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <1465183229-24147-5-git-send-email-wmills@ti.com>
 <20160606085627.GA6831@leverpostej> <5480709.cGbSehIKrE@wuerfel>
 <20160606114256.GF6831@leverpostej>
Message-ID: <575571B2.7090601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/06/2016 07:42 AM, Mark Rutland wrote:
> On Mon, Jun 06, 2016 at 11:09:07AM +0200, Arnd Bergmann wrote:
>> On Monday, June 6, 2016 9:56:27 AM CEST Mark Rutland wrote:
>>> [adding devicetree]
>>>
>>> On Sun, Jun 05, 2016 at 11:20:29PM -0400, Bill Mills wrote:
>>>> Keystone2 can do DMA coherency but only if:
>>>> 1) DDR3A DMA buffers are in high physical addresses (0x8_0000_0000)
>>>>     (DDR3B does not have this constraint)
>>>> 2) Memory is marked outer shared
>>>> 3) DMA Master marks transactions as outer shared
>>>>     (This is taken care of in bootloader)
>>>>
>>>> Use outer shared instead of inner shared.
>>>> This choice is done at early init time and uses the attr_mod facility
>>>>
>>>> If the kernel is not configured for LPAE and using high PA, or if the
>>>> switch to outer shared fails, then we fail to meet this criteria.
>>>> Under any of these conditions we veto any dma-coherent attributes in
>>>> the DTB.
>>>
>>> I very much do not like this. As I previously mentioned [1],
>>> dma-coherent has de-facto semantics today. This series deliberately
>>> changes that, and inverts the relationship between DT and kernel (as the
>>> describption in the DT would now depend on the configuration of the
>>> kernel).
>>>
>>> I would prefer that we have a separate property (e.g.
>>> "dma-outer-coherent") to describe when a device can be coherent with
>>> Normal, Outer Shareable, Inner Write-Back, Outer Write-Back memory.
>>> Then the kernel can figure out whether or not device can be used
>>> coherently, depending on how it is configured.
>>
>> I share your concern, but I don't think the dma-outer-coherent attribute
>> would be a good solution either.
>>
>> The problem really is that keystone is a platform that is sometimes
>> coherent, depending purely on what kernel we run, and not at all on
>> anything we can describe in devicetree, and I don't see any good way
>> to capture the behavior of the hardware in generic DT bindings.
> 
> I think that above doesn't quite capture the situation:
> 
> Some DMA masters can be cache-coherent (only) with Outer Shareable
> transactions. That is a property we could capture inthe DT (e.g.
> dma-outer-coherent), and is independent of the kernel configuration.
> 
> Whether or not the devices are coherent with the kernel's chosen memory
> attributes certainly depends on the kernel configuration, but that is
> not what we capture in the DT.
> 
>> So far, the assumption has been:
>>
>> - when running a non-LPAE kernel, keystone is not coherent, and we
>>   must ignore both the dma-coherent properties in devices and the
>>   dma-ranges properties in bus nodes.
> 
> I wasn't able to spot if/where that was enforced. Is it possible to boot
> Keystone UP, !LPAE?
> 

Yes ...  with the right combination of DTB, u-boot, u-boot vars, and
kernel config.  Mismatches either fail hard or use dma-coherent ops
without actually providing coherency. I am attempting to make this less
fragile.

Mis-configured coherency can be dead-wrong and still only fail 1
transaction in 1,000,000.  I have seen customers run for weeks or months
w/o detecting the issue.  Thats why I wanted the veto logic.

There are 3 cases to cover:
LPAE w/ high PA:
	this is the normal mode for KS2.  Uses coherent dma-ops.
!LPAE:
	obviously uses low PA and must use non-coherent dma-ops.
LPAE w/ low PA:
	This happens with an LPAE kernel but the user has passed a low
	PA memory DTB and u-boot has not fixed it up.
	This case must also use non-coherent dma-ops

Upstream DTS has keystone memory at the low PA.  I agree with that.
U-boot and kernel opt-in to the use of high PA.

If you give high PA to a non-LPAE kernel I believe it will fail hard and
fast.  I can check.

Thanks,
Bill
