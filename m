From: york.sun@nxp.com (york sun)
Date: Tue, 9 Aug 2016 15:27:33 +0000
Subject: [Patch v3 10/11] driver/edac/layerscape_edac: Add Layerscape EDAC
 support
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-11-git-send-email-york.sun@nxp.com>
 <20160808190652.6456fae0@arm.com>
 <AM4PR0401MB17322F172D369D841F820C029A1B0@AM4PR0401MB1732.eurprd04.prod.outlook.com>
 <20160809111241.GH27508@arm.com>
Message-ID: <AM4PR0401MB1732E37CB496CCB3075DF2429A1C0@AM4PR0401MB1732.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2016 04:12 AM, Will Deacon wrote:
> On Mon, Aug 08, 2016 at 07:56:04PM +0000, york sun wrote:
>> On 08/08/2016 11:07 AM, Marc Zyngier wrote:
>>> On Thu, 4 Aug 2016 15:58:35 -0700
>>> York Sun <york.sun@nxp.com> wrote:
>>>
>>>> Add DDR EDAC for ARM-based compatible controllers. Both big-endian
>>>> and little-endian are supported.
>>>>
>>>> Signed-off-by: York Sun <york.sun@nxp.com>
>>>>
>>>> ---
>>>> Change log
>>>>   v3: no change
>>>>   v2: Create new driver using shared DDR object
>>>>
>>>>  arch/arm64/Kconfig.platforms           |  1 +
>>>>  arch/{arm => arm64}/include/asm/edac.h | 21 +++++------
>>>>  arch/arm64/include/asm/irq.h           |  4 ++
>>>>  drivers/edac/Kconfig                   |  7 ++++
>>>>  drivers/edac/Makefile                  |  3 ++
>>>>  drivers/edac/fsl_ddr_edac.c            |  1 +
>>>>  drivers/edac/layerscape_edac.c         | 67 ++++++++++++++++++++++++++++++++++
>>>>  7 files changed, 92 insertions(+), 12 deletions(-)
>>>>  copy arch/{arm => arm64}/include/asm/edac.h (79%)
>>>>  create mode 100644 drivers/edac/layerscape_edac.c
>>>>
>>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>>> index 7ef1d05..185a215 100644
>>>> --- a/arch/arm64/Kconfig.platforms
>>>> +++ b/arch/arm64/Kconfig.platforms
>>>> @@ -41,6 +41,7 @@ config ARCH_EXYNOS
>>>>
>>>>  config ARCH_LAYERSCAPE
>>>>  	bool "ARMv8 based Freescale Layerscape SoC family"
>>>> +	select EDAC_SUPPORT
>>>>  	help
>>>>  	  This enables support for the Freescale Layerscape SoC family.
>>>>
>>>> diff --git a/arch/arm/include/asm/edac.h b/arch/arm64/include/asm/edac.h
>>>> similarity index 79%
>>>> copy from arch/arm/include/asm/edac.h
>>>> copy to arch/arm64/include/asm/edac.h
>>>> index 5189fa8..36a226c 100644
>>>> --- a/arch/arm/include/asm/edac.h
>>>> +++ b/arch/arm64/include/asm/edac.h
>>>> @@ -18,16 +18,15 @@
>>>>  #define ASM_EDAC_H
>>>>  /*
>>>>   * ECC atomic, DMA, SMP and interrupt safe scrub function.
>>>> - * Implements the per arch edac_atomic_scrub() that EDAC use for software
>>>> + * Implements the per arch atomic_scrub() that EDAC use for software
>>>>   * ECC scrubbing.  It reads memory and then writes back the original
>>>>   * value, allowing the hardware to detect and correct memory errors.
>>>>   */
>>>> -
>>>> -static inline void edac_atomic_scrub(void *va, u32 size)
>>>> +static inline void atomic_scrub(void *va, u32 size)
>>>>  {
>>>> -#if __LINUX_ARM_ARCH__ >= 6
>>>> -	unsigned int *virt_addr = va;
>>>> -	unsigned int temp, temp2;
>>>> +	unsigned long *virt_addr = va;
>>>> +	unsigned long temp;
>>>> +	unsigned int temp2;
>>>>  	unsigned int i;
>>>>
>>>>  	for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
>>>> @@ -35,15 +34,13 @@ static inline void edac_atomic_scrub(void *va, u32 size)
>>>>  		 * so we are interrupt, DMA and SMP safe.
>>>>  		 */
>>>>  		__asm__ __volatile__("\n"
>>>> -			"1:	ldrex	%0, [%2]\n"
>>>> -			"	strex	%1, %0, [%2]\n"
>>>> -			"	teq	%1, #0\n"
>>>> -			"	bne	1b\n"
>>>> +			"1:	ldxr	%0, [%2]\n"
>>>> +			"	stxr	%w1, %0, [%2]\n"
>>>> +			"	cbnz	%w1, 1b\n"
>>>
>>> Hiding architecture code in a driver, are we? Hmmm.
>>
>> This adds atomic_scrub() for arm64. Arm already has this function. Are
>> you suggesting to separate this part as an individual patch?
>>>
>>> Also, how can this be safe if you have non cache-coherent DMA going on?
>>
>> I am clueless on this topic. What's your suggestion.
>
> We've discussed this in the past for ARMv7 and the bottom line is that
> it's not safe to scrub memory backing non-coherent DMA buffers. You will
> likely end up with data corruption if you do that.
>
> The two options are:
>
>   (1) Restrict scrubbing to non-DMA memory, or
>   (2) Only enable scrubbing if the system is completely cache-coherent
>
> The problem with (1) is that we can't detect that, particularly when
> the streaming DMA API is in use.
>
> The problem with (2) is that you can have a coherent system that decides
> dynamically to drop in and out of coherency as a result of, e.g. PCI
> NoSnoop transactions.
>

Good information! I realize I added this code on an older kernel and 
rebased to the latest one. This code is actually not needed, as long as 
CONFIG_EDAC_ATOMIC_SCRUB.

You said this has been discussed for ARMv7, what was the conclusion? I 
see edac_atomic_scrub() is still used for ARM.

York
