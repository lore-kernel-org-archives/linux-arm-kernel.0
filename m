From: noralf@tronnes.org (=?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?=)
Date: Tue, 05 May 2015 15:33:15 +0200
Subject: [PATCH] ARM: bcm2835: Use 0x4 prefix for DMA bus addresses to
 SDRAM.
In-Reply-To: <878ud3q43p.fsf@eliezer.anholt.net>
References: <1430768034-12734-1-git-send-email-eric@anholt.net>
 <5547D5BA.5070407@tronnes.org> <878ud3q43p.fsf@eliezer.anholt.net>
Message-ID: <5548C69B.3080201@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Den 05.05.2015 02:07, skrev Eric Anholt:
> Noralf Tr?nnes <noralf@tronnes.org> writes:
>
>> Den 04.05.2015 21:33, skrev Eric Anholt:
>>> There exists a tiny MMU, configurable only by the VC (running the
>>> closed firmware), which maps from the ARM's physical addresses to bus
>>> addresses.  These bus addresses determine the caching behavior in the
>>> VC's L1/L2 (note: separate from the ARM's L1/L2) according to the top
>>> 2 bits.  The bits in the bus address mean:
>>>
>>>   From the VideoCore processor:
>>> 0x0... L1 and L2 cache allocating and coherent
>>> 0x4... L1 non-allocating, but coherent. L2 allocating and coherent
>>> 0x8... L1 non-allocating, but coherent. L2 non-allocating, but coherent
>>> 0xc... SDRAM alias. Cache is bypassed. Not L1 or L2 allocating or coherent
>>>
>>>   From the GPU peripherals (note: all peripherals bypass the L1
>>> cache. The ARM will see this view once through the VC MMU):
>>> 0x0... Do not use
>>> 0x4... L1 non-allocating, and incoherent. L2 allocating and coherent.
>>> 0x8... L1 non-allocating, and incoherent. L2 non-allocating, but coherent
>>> 0xc... SDRAM alias. Cache is bypassed. Not L1 or L2 allocating or coherent
>>>
>>> The 2835 firmware always configures the MMU to turn ARM physical
>>> addresses with 0x0 top bits to 0x4, meaning present in L2 but
>>> incoherent with L1.  However, any bus addresses we were generating in
>>> the kernel to be passed to a device had 0x0 bits.  That would be a
>>> reserved (possibly totally incoherent) value if sent to a GPU
>>> peripheral like USB, or L1 allocating if sent to the VC (like a
>>> firmware property request).  By setting dma-ranges, all of the devices
>>> below it get a dev->dma_pfn_offset, so that dma_alloc_coherent() and
>>> friends return addresses with 0x4 bits and avoid cache incoherency.
>>>
>>> This matches the behavior in the downstream 2708 kernel (see
>>> BUS_OFFSET in arch/arm/mach-bcm2708/include/mach/memory.h).
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>> Cc: popcornmix at gmail.com
>>> ---
>>>    arch/arm/boot/dts/bcm2835.dtsi | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
>>> index 5734650..2df1b5c 100644
>>> --- a/arch/arm/boot/dts/bcm2835.dtsi
>>> +++ b/arch/arm/boot/dts/bcm2835.dtsi
>>> @@ -15,6 +15,7 @@
>>>    		#address-cells = <1>;
>>>    		#size-cells = <1>;
>>>    		ranges = <0x7e000000 0x20000000 0x02000000>;
>>> +		dma-ranges = <0x40000000 0x00000000 0x1f000000>;
>>>    
>>>    		timer at 7e003000 {
>>>    			compatible = "brcm,bcm2835-system-timer";
>> This was quite a coincidence. I discovered the need for 'dma-ranges'
>> yesterday while trying to get the downstream bcm2708_fb driver to
>> work with ARCH_BCM2835. The driver is using the mailbox to get info
>> about the framebuffer from the firmware. When it failed I discovered
>> that the bus address was wrong.
>>
>> What I don't understand, is that mmc and spi works fine with a "wrong"
>> bus address. It's only the framebuffer driver and the vchiq driver
>> when using mailbox that fails.
>>
>> Tested-by: Noralf Tr?nnes <noralf@tronnes.org>
> Yeah, it was the mailbox driver I've been trying to merge, on pi2, that
> made me get this patch together.  I'm suspicious that 0x0 works the same
> as 0x4 for GPU peripherals (mmc, spi, vc4) on pi1, though I've had
> occasional instability (something like 3 events per ~5000 tests) that I
> sure hope is due to this.

Since you mention Pi2:
Dom Cobley made me aware that 0xC is used on MACH_BCM2709.
The macros in arch/arm/mach-bcm270X/include/mach/memory.h are identical,
but arch/arm/mach-bcm2709/Kconfig has BCM2708_NOL2CACHE as default (as 
opposed to 2708/Kconfig).
This changes the _REAL_BUS_OFFSET macro:

#ifdef CONFIG_BCM2708_NOL2CACHE
  #define _REAL_BUS_OFFSET UL(0xC0000000)   /* don't use L1 or L2 caches */
#else
  #define _REAL_BUS_OFFSET UL(0x40000000)   /* use L2 cache */
#endif
