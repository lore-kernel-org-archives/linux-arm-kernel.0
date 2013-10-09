From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 09 Oct 2013 22:42:54 +0200
Subject: [PATCH v2] ARM: tlb: ASID macro should give 32bit result for
 BE correct operation
In-Reply-To: <20131008202207.8f66d24415079f0cff98ab7d@linaro.org>
References: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
 <5252DA06.8000303@codethink.co.uk>
 <CAA3XUr2wYFL9WAQd9uAJSKK5KhWF3bPzYbh-3x=B3oLVXk79og@mail.gmail.com>
 <52533A70.5040705@ti.com>
 <20131007195525.f56083f0d91df6a6396cc494@linaro.org>
 <5253AFBF.7040002@codethink.co.uk>
 <20131008202207.8f66d24415079f0cff98ab7d@linaro.org>
Message-ID: <5255BFCE.7020708@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/13 03:22, Kim Phillips wrote:
> On Tue, 08 Oct 2013 09:09:51 +0200
> Ben Dooks<ben.dooks@codethink.co.uk>  wrote:
>
>> On 08/10/13 02:55, Kim Phillips wrote:
>>> On Mon, 7 Oct 2013 18:49:20 -0400
>>> Santosh Shilimkar<santosh.shilimkar@ti.com>   wrote:
>>>
>>>> On Monday 07 October 2013 12:37 PM, Victor Kamensky wrote:
>>>>> On 7 October 2013 08:57, Ben Dooks<ben.dooks@codethink.co.uk>   wrote:
>>>>>> On 07/10/13 17:48, Victor Kamensky wrote:
>>> apologies if this was explained earlier in the thread, but what has
>>> __raw_xxx ->   xxx_relaxed have to do with endianness?  the relaxed
>>> accessor variants allow the compiler to reorder the instruction: it's
>>> got nothing to do with byte swapping the data, no?
>
> [I've since read the thread explaining this, thanks Victor]
>
>>>>> I think above position is consistent with similar discussion on
>>>>> some of BE related threads - changing BSP to support BE mode
>>>>> is BSP owners call.
>>>>>
>>>> Am just wondering a better method than the patch [1] which touches
>>>> many drivers for readl/writel() replacement. Drivers are using
>>>> that as standard based on device driver guide and was thinking
>>>> we should not change that rule to support BE. We definitely need
>>>
>>> I think readl/writel were originally devised for accessing PCI devices
>>> (else why would readl's definition include an __le32_to_cpu byteswap)?
>>> In any case, this makes read/writel incompatible with big endian
>>> devices.
>>
>> Generally, in ARM, the devices stay little endian when the CPU is
>> running big endian, therefore we need this in there.
>
> generally, yes, but with SoC vendors switching to arch ARM, more ARM
> cores will be having to access legacy big endian devices :)
>
>> If we end up having to change all the drivers, then this series
>> is going to become a huge incovenience to everyone and at that
>> point it will probably be better to drop it.
>
> well that depends on the change: a simple search and replace vs. one
> requiring more knowledge of the device, and what you mean by 'all
> drivers' (the devices the arm defconfigs configure are mostly drivers
> for LE devices, at least for the time being).  If we need to transition
> from an old set of accessors to new ones, drivers can be changed
> incrementally, and by their maintainers - we just need to establish a
> standard set of guidelines.
>
>>>> to get the byte swap achieved but probably through some other
>>>> means.
>>>
>>> back when I looked into this, I found in/out_be32() accessors were Power
>>> arch centric, read/writel ARM arch centric, whereas ioread/writebe32
>>> were available in other arches.  See e.g., upstream commit
>>> 0c69fb037a6bb1faf06ea776872da54a6705c154 "mtd: fsl_ifc_nand: use more
>>> portable i/o accessors".
>>
>> readl and writel should work pretty much everywhere.
>
> well, they currently work unfavourably for big endian devices on
> arch/arm.

I've not see any big endian devices on ARM as of yet. Pretty much
everything I have seen is little endian.

In this case, read/writel are not the issue, it is the __raw versions
that get used in bits of ARM that are. I'm still not sure of how many
are of `native endian` devices or just little endian devices that have
never been tested with a big endian cpu core.

>> I'm not sure if device drivers /should/ know much about what
>> endian bus or the endian-ness of the peripheral they are managing,
>> especially if we have the case the bus-bus bridge is doing a swap.
>>
>> Personally, I'd just like to rip out the IO accessors we have at
>> the moment and just replace it with a much more BSD like system
>> where the device struct provides a set of accessor functions. Then
>> if we are on strange busses, or multi-function devices, or the
>> latest in inter-periphreal connect we don't have to keep re-working
>> drivers.
>>
>> It'd even make regmap nicer as it could sit in a layer below any
>> device and would not need and explicit changes for a driver to use
>> it.
>
> yes, some devices can be endianness programmable at runtime - and with
> mixed-endian VMs having direct access to devices, it may be better to
> leave it to a combination of the driver and its bus.

It doesn't really matter what endian-ness the VM is as long as it
treats device memory as little-endian just as it would have to do
if it was running on a device.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
