From: york.sun@nxp.com (York Sun)
Date: Thu, 15 Mar 2018 15:15:20 +0000
Subject: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
 <5AAA7640.3010506@arm.com>
Message-ID: <VI1PR04MB20780A707157E71922BD72BA9AD00@VI1PR04MB2078.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2018 06:36 AM, James Morse wrote:
> Hi York,
> 
> You have a DT binding in here, please CC the devicetree list. You're touching
> code under arch/arm64, so you need the arm list too. get_maintainer.pl will take
> your patch and give you the list of which lists and maintainers to CC.
> 
> (I've added those lists, the full patch is here:

Thanks for doing this.

> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F10283783%2F&data=02%7C01%7Cyork.sun%40nxp.com%7C794bff898fae4046bb9d08d58a79c482%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636567177956904165&sdata=xWmuUtS9dk7PSq1R11L%2F4vpoztnXATAPgtmiqytpnAs%3D&reserved=0
> )
> 
> Some comments below, I haven't looked in to edac or the manuals for A53/A57.
> 
> On 15/03/18 00:17, York Sun wrote:
>> Add error detection for A53 and A57 cores. Hardware error injection
>> is supported on A53. Software error injection is supported on both.
>> For hardware error injection on A53 to work, proper access to
>> L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This
>> is done by making an SMC call in the driver. Failure to enable access
>> disables hardware error injection. For error interrupt to work,
>> another SMC call enables access to L2ECTLR_EL1. Failure to enable
>> access disables interrupt for error reporting.
> 
> This is tricky as there are shipped systems out there without these SMC calls.
> They need to be discovered in some way. We can't even assume firmware has PSCI,
> it has to be discovered via APCI/DT.

Using the return values from SMC calls, we can detect if such calls
exist. Without these SMC calls, hardware error injection is removed from
/sys interface for A53. A57 doesn't have this feature anyway. Similarly,
without these SMC calls, interrupt is not used so the driver only works
in polling mode.

> 
> I think it will be cleaner for the presence of this device/compatible to
> indicate that the registers are enabled for the normal-world, instead of having
> the OS try to call into firmware to enable it.

I don't disagree. Doing this requires updating device tree. For my case
using U-Boot, this needs to sync with U-Boot. I would prefer not to. I
can imaging this would be the same for UEFI.

> 
> 
>> Signed-off-by: York Sun <york.sun@nxp.com>
>> ---
>>  .../devicetree/bindings/edac/cortex-arm64-edac.txt |  37 +
>>  arch/arm64/include/asm/cacheflush.h                |   1 +
>>  arch/arm64/mm/cache.S                              |  35 +
>>  drivers/edac/Kconfig                               |   6 +
>>  drivers/edac/Makefile                              |   1 +
>>  drivers/edac/cortex_arm64_l1_l2.c                  | 741 +++++++++++++++++++++
>>  drivers/edac/cortex_arm64_l1_l2.h                  |  55 ++
>>  7 files changed, 876 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
>>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
>>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.h
>>
>> diff --git a/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
>> new file mode 100644
>> index 0000000..74a1c2f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
>> @@ -0,0 +1,37 @@
>> +ARM Cortex A57 and A53 L1/L2 cache error reporting
>> +
>> +CPU Memory Error Syndrome and L2 Memory Error Syndrome registers can be used
>> +for checking L1 and L2 memory errors. However, only A53 supports double-bit
>> +error injection to L1 and L2 memory. This driver uses the hardware error
>> +injection when available, but also provides a way to inject errors by
>> +software. Both A53 and A57 supports interrupt when multi-bit errors happen.
> 
>> +To use hardware error injection and the interrupt, proper access needs to be
>> +granted in ACTLR_EL3 (and/or ACTLR_EL2) register by EL3 firmware SMC call.
> 
> How can Linux know whether firmware toggled these bits? How can it know if it
> needs to make an SMC call to do the work?

It is done in probe function in this driver.

> 
> This looks like platform policy, I'm not sure how this gets described...
> 
> 
>> +Correctable errors do not trigger such interrupt. This driver uses dynamic
>> +polling internal to check for errors. The more errors detected, the more
>> +frequently it polls. Combining with interrupt, this driver can detect
>> +correctable and uncorrectable errors. However, if the uncorrectable errors
>> +cause system abort exception, this drivr is not able to report errors in time.
>> +
>> +The following section describes the Cortex A57/A53 EDAC DT node binding.
>> +
>> +Required properties:
>> +- compatible: Should be "arm,cortex-a57-edac" or "arm,cortex-a53-edac"
>> +- cpus: Should be a list of compatible cores
>> +
>> +Optional properties:
>> +- interrupts: Interrupt number if supported
>> +
>> +Example:
>> +	edac {
>> +		compatible = "arm,cortex-a53-edac";
>> +		cpus = <&cpu0>,
>> +		       <&cpu1>,
>> +		       <&cpu2>,
>> +		       <&cpu3>;
>> +		interrupts = <0 108 0x4>;
>> +
>> +	};
>> +
> 
>> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
>> index 76d1cc8..f1cd090 100644
>> --- a/arch/arm64/include/asm/cacheflush.h
>> +++ b/arch/arm64/include/asm/cacheflush.h
>> @@ -73,6 +73,7 @@ extern void __clean_dcache_area_pop(void *addr, size_t len);
>>  extern void __clean_dcache_area_pou(void *addr, size_t len);
>>  extern long __flush_cache_user_range(unsigned long start, unsigned long end);
>>  extern void sync_icache_aliases(void *kaddr, unsigned long len);
>> +extern void __flush_l1_dcache_way(phys_addr_t ptr);
>>  
>>  static inline void flush_cache_mm(struct mm_struct *mm)
>>  {
> 
>> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
>> index 7f1dbe9..5e65c20 100644
>> --- a/arch/arm64/mm/cache.S
>> +++ b/arch/arm64/mm/cache.S
>> @@ -221,3 +221,38 @@ ENTRY(__dma_unmap_area)
>>  	b.ne	__dma_inv_area
>>  	ret
>>  ENDPIPROC(__dma_unmap_area)
>> +
>> +/*
>> + *	Flush L1 dcache by way, using physical address to find sets
>> + *
>> + *	__flush_l1_dcache_way(ptr)
>> + *	- ptr	- physical address to be flushed
>> + */
> 
> We don't have set/way maintenance in the kernel because its impossible to do
> correctly outside EL3's CPU power-on code.
> 
> The ARM-ARM has a half page 'note' explaining the issues, under 'Performing
> cache maintenance instructions' in section "D3.4.8 A64 Cache maintenance
> instructions". If you have DDI0487B.b, its on Page D3-2020.
> 
> These may also help:
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2016%2F3%2F21%2F190&data=02%7C01%7Cyork.sun%40nxp.com%7C794bff898fae4046bb9d08d58a79c482%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636567177956904165&sdata=cGfumC%2BDk6y5XVnkH3orgVYovhT1KHPmsXfkKo6veIE%3D&reserved=0
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fevents.static.linuxfound.org%2Fsites%2Fevents%2Ffiles%2Fslides%2Fslides_17.pdf&data=02%7C01%7Cyork.sun%40nxp.com%7C794bff898fae4046bb9d08d58a79c482%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636567177956904165&sdata=z0HTGOfZeuhY9YtFFAm4rBB9v%2BsapRHOZX2TPPZEjus%3D&reserved=0
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.linux.com%2Fnews%2Ftaming-chaos-modern-caches&data=02%7C01%7Cyork.sun%40nxp.com%7C794bff898fae4046bb9d08d58a79c482%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636567177956904165&sdata=KZOY2ESFrl55ojinzG7eiPzwFHLTBx1VJvGZ3hdchiE%3D&reserved=0
> 
> Why do you need to do this? There is no way to guarantee an address isn't in the
> cache.
> 

It was suggested by ARM support. The purpose is to flush L1 cache with
concerned address and cause a write to L2 cache, which in turn injects
the error. The whole idea is to safely inject uncorrectable error(s)
without corrupt the system.

I am going to stop here since I received Mark's comment in another
email. Your comments are very valuable and very much appreciated.

York
