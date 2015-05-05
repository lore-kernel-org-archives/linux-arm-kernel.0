From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 May 2015 13:31:27 -0600
Subject: [PATCH] ARM: bcm2835: Use 0x4 prefix for DMA bus addresses to
 SDRAM.
In-Reply-To: <5547D5BA.5070407@tronnes.org>
References: <1430768034-12734-1-git-send-email-eric@anholt.net>
 <5547D5BA.5070407@tronnes.org>
Message-ID: <55491A8F.3020401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2015 02:25 PM, Noralf Tr?nnes wrote:
>
> Den 04.05.2015 21:33, skrev Eric Anholt:
>> There exists a tiny MMU, configurable only by the VC (running the
>> closed firmware), which maps from the ARM's physical addresses to bus
>> addresses.  These bus addresses determine the caching behavior in the
>> VC's L1/L2 (note: separate from the ARM's L1/L2) according to the top
>> 2 bits.  The bits in the bus address mean:
>>
>>  From the VideoCore processor:
>> 0x0... L1 and L2 cache allocating and coherent
>> 0x4... L1 non-allocating, but coherent. L2 allocating and coherent
>> 0x8... L1 non-allocating, but coherent. L2 non-allocating, but coherent
>> 0xc... SDRAM alias. Cache is bypassed. Not L1 or L2 allocating or
>> coherent
>>
>>  From the GPU peripherals (note: all peripherals bypass the L1
>> cache. The ARM will see this view once through the VC MMU):
>> 0x0... Do not use
>> 0x4... L1 non-allocating, and incoherent. L2 allocating and coherent.
>> 0x8... L1 non-allocating, and incoherent. L2 non-allocating, but coherent
>> 0xc... SDRAM alias. Cache is bypassed. Not L1 or L2 allocating or
>> coherent
>>
>> The 2835 firmware always configures the MMU to turn ARM physical
>> addresses with 0x0 top bits to 0x4, meaning present in L2 but
>> incoherent with L1.  However, any bus addresses we were generating in
>> the kernel to be passed to a device had 0x0 bits.  That would be a
>> reserved (possibly totally incoherent) value if sent to a GPU
>> peripheral like USB, or L1 allocating if sent to the VC (like a
>> firmware property request).  By setting dma-ranges, all of the devices
>> below it get a dev->dma_pfn_offset, so that dma_alloc_coherent() and
>> friends return addresses with 0x4 bits and avoid cache incoherency.
>>
>> This matches the behavior in the downstream 2708 kernel (see
>> BUS_OFFSET in arch/arm/mach-bcm2708/include/mach/memory.h).
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Cc: popcornmix at gmail.com
>> ---
>>   arch/arm/boot/dts/bcm2835.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi
>> b/arch/arm/boot/dts/bcm2835.dtsi
>> index 5734650..2df1b5c 100644
>> --- a/arch/arm/boot/dts/bcm2835.dtsi
>> +++ b/arch/arm/boot/dts/bcm2835.dtsi
>> @@ -15,6 +15,7 @@
>>           #address-cells = <1>;
>>           #size-cells = <1>;
>>           ranges = <0x7e000000 0x20000000 0x02000000>;
>> +        dma-ranges = <0x40000000 0x00000000 0x1f000000>;
>>           timer at 7e003000 {
>>               compatible = "brcm,bcm2835-system-timer";
>
> This was quite a coincidence. I discovered the need for 'dma-ranges'
> yesterday while trying to get the downstream bcm2708_fb driver to
> work with ARCH_BCM2835. The driver is using the mailbox to get info
> about the framebuffer from the firmware. When it failed I discovered
> that the bus address was wrong.
>
> What I don't understand, is that mmc and spi works fine with a "wrong"
> bus address. It's only the framebuffer driver and the vchiq driver
> when using mailbox that fails.

It's possible this is just a fluke. After all, having the wrong value 
for the upper 2 bits of DMA-mastered accesses will only have any affect 
if there's a live entry in the cache for that address. Of course as Eric 
says, perhaps different peripherals treat the invalid 0 value 
differently too.
