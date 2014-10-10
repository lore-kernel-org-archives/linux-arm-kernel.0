From: sbranden@broadcom.com (Scott Branden)
Date: Fri, 10 Oct 2014 12:08:33 -0700
Subject: [PATCH V4 1/7] ARM: cygnus: Initial support for Broadcom Cygnus
 SoC
In-Reply-To: <6682352.2KHnNYBAnS@wuerfel>
References: <1412894671-5921-2-git-send-email-sbranden@broadcom.com>
 <6682352.2KHnNYBAnS@wuerfel>
Message-ID: <54382EB1.6080605@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-10-10 02:50 AM, Arnd Bergmann wrote:
> On Thursday 09 October 2014 15:44:25 Scott Branden wrote:
>> From: Jonathan Richardson <jonathar@broadcom.com>
>>
>> Adds initial support for the Cygnus SoC based on Broadcom?s iProc series.
>> Move ARCH_BCM_5301x under the ARCH_BCM_IPROC architecture.
>>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Desmond Liu <desmondl@broadcom.com>
>> Reviewed-by: JD (Jiandong) Zheng <jdzheng@broadcom.com>
>> Tested-by: Jonathan Richardson <jonathar@broadcom.com>
>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>
> No signoff from the Author?
It is a collaborative effort.  Jonathan is on 2 month leave so I have 
taken over pushing this through or change Author.
>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index b11ad54..85363de 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -1051,7 +1051,7 @@ config DEBUG_UART_PL01X
>>
>>   # Compatibility options for 8250
>>   config DEBUG_UART_8250
>> -	def_bool ARCH_DOVE || ARCH_EBSA110 || \
>> +	def_bool ARCH_BCM_IPROC || ARCH_DOVE || ARCH_EBSA110 || \
>>   		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
>>   		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
>>   		ARCH_IOP33X || ARCH_IXP4XX || \
>
> As I mentioned before, this is the wrong option. Please use
> DEBUG_LL_UART_8250 like all the modern platforms do.
ok, will remove
>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index fc93800..b2b6752 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -5,6 +5,53 @@ menuconfig ARCH_BCM
>>
>>   if ARCH_BCM
>>
>> +menu "iProc SoC based Machine types"
>> +	config ARCH_BCM_IPROC
>> +		bool "Broadcom ARMv7 iProc boards" if ARCH_MULTI_V7
>> +		depends on ARCH_BCM_CYGNUS || ARCH_BCM_5301X
>
> Please make this a silent option by dropping the text after 'bool',
> and the 'depends on' line.
>
ok, will change, thanks
>> +		select ARM_GIC
>> +		select CACHE_L2X0
>> +		select HAVE_ARM_SCU if SMP
>> +		select HAVE_ARM_TWD if SMP
>> +		select ARM_GLOBAL_TIMER
>> +
>> +		select CLKSRC_MMIO
>> +		select ARCH_REQUIRE_GPIOLIB
>> +		select ARM_AMBA
>> +		select PINCTRL
>
>> +
>> +static const char const *bcm_cygnus_dt_compat[] = {
>> +	"brcm,cygnus",
>> +	NULL,
>> +};
>> +
>> +DT_MACHINE_START(BCM_CYGNUS_DT, "Broadcom Cygnus SoC")
>> +	.l2c_aux_val	= 0,
>> +	.l2c_aux_mask	= ~0,
>> +	.dt_compat = bcm_cygnus_dt_compat,
>> +MACHINE_END
>>
>
> This looks good now.
>
> 	Arnd
>
