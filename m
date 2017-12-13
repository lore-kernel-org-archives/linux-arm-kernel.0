From: ludovic.barre@st.com (Ludovic BARRE)
Date: Wed, 13 Dec 2017 10:02:43 +0100
Subject: [PATCH 2/6] ARM: stm32: add initial support for STM32MP157
In-Reply-To: <20171212232425.shf56g2uivl57fdp@rob-hp-laptop>
References: <1512742277-28205-1-git-send-email-ludovic.Barre@st.com>
 <1512742277-28205-3-git-send-email-ludovic.Barre@st.com>
 <20171212232425.shf56g2uivl57fdp@rob-hp-laptop>
Message-ID: <b0e989fa-3490-0697-0954-1f15f4dfd3ab@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/13/2017 12:24 AM, Rob Herring wrote:
> On Fri, Dec 08, 2017 at 03:11:13PM +0100, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds initial support of STM32MP157 microprocessor (MPU)
>> based on Arm Cortex-A7. Under new ARCH_STM32_MPU flag we select the
>> needed Cortex-A infrastructure (like gic, timer,...)
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   Documentation/arm/stm32/stm32mp157-overview.txt | 12 ++++++++++++
>>   Documentation/devicetree/bindings/arm/stm32.txt |  1 +
> 
> Please split bindings to separate patches.
OK, I will split stm32.txt in separate commit
> 
>>   arch/arm/mach-stm32/Kconfig                     | 22 ++++++++++++++++++++--
>>   arch/arm/mach-stm32/Makefile                    |  1 +
>>   arch/arm/mach-stm32/board-mpu-dt.c              | 16 ++++++++++++++++
>>   5 files changed, 50 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/arm/stm32/stm32mp157-overview.txt
>>   create mode 100644 arch/arm/mach-stm32/board-mpu-dt.c
>>
>> diff --git a/Documentation/arm/stm32/stm32mp157-overview.txt b/Documentation/arm/stm32/stm32mp157-overview.txt
>> new file mode 100644
>> index 0000000..8a3e7cb
>> --- /dev/null
>> +++ b/Documentation/arm/stm32/stm32mp157-overview.txt
> 
> I think new documentation files should be rst format and fit into the
> built documentation. We don't have an SoC description doc for most SoCs.
the existing documentation of stm32 are txt format
-overview.txt
-stm32f429-overwiew.txt
-stm32f746-overview.txt
-stm32h743-overview.txt

what do you prefer:
-omit stm32mp157-overview.txt of this serie and change all in next commit.
-write only this file in rst format
-change all in this serie?

> 
>> @@ -0,0 +1,12 @@
>> +			STM32MP157 Overview
>> +			===================
>> +
>> +  Introduction
>> +  ------------
>> +	The STM32MP157 is a Cortex-A MPU aimed at various applications.
>> +	It features:
>> +	- Dual core Cortex-A7 application core
>> +	- 2D/3D image composition with GPU
>> +	- Standard memories interface support
>> +	- Standard connectivity, widely inherited from the STM32 MCU family
>> +	- Comprehensive security support
> 
> Perhaps make this part of the kconfig entry help.
yes, I could add some details in MACH_STM32MP157 kconfig entry
> 
>> diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32.txt
>> index 05762b0..6808ed9 100644
>> --- a/Documentation/devicetree/bindings/arm/stm32.txt
>> +++ b/Documentation/devicetree/bindings/arm/stm32.txt
>> @@ -7,3 +7,4 @@ using one of the following compatible strings:
>>     st,stm32f469
>>     st,stm32f746
>>     st,stm32h743
>> +  st,stm32mp157
>> diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
>> index c8059ea..2b227c7 100644
>> --- a/arch/arm/mach-stm32/Kconfig
>> +++ b/arch/arm/mach-stm32/Kconfig
>> @@ -1,12 +1,12 @@
>>   menuconfig ARCH_STM32
>> -	bool "STMicrolectronics STM32 family" if ARM_SINGLE_ARMV7M
>> +	bool "STMicrolectronics STM32 family" if ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
>>   	select ARCH_HAS_RESET_CONTROLLER
>>   	select CLKSRC_STM32
>>   	select PINCTRL
>>   	select RESET_CONTROLLER
>>   	select STM32_EXTI
>>   	help
>> -	  Support for STMicroelectronics STM32 MCU family
>> +	  Support for STMicroelectronics STM32 MCU/MPU family
>>   
>>   if ARCH_STM32
>>   
>> @@ -40,4 +40,22 @@ config MACH_STM32H743
>>   
>>   endif
>>   
>> +if ARCH_MULTI_V7
>> +
>> +config ARCH_STM32_MPU
>> +	bool "STMicrolectronics STM32 MPU"
>> +	default y
>> +	select ARM_GIC
>> +	select HAVE_ARM_ARCH_TIMER
>> +	select ARM_PSCI
>> +	help
>> +	  Support for STMicroelectronics STM32 Microprocessors.
>> +
>> +config MACH_STM32MP157
> 
> Is this actually used?
Yes, it's used in pinctrl driver.
> 
>> +	bool "STMicrolectronics STM32MP157"
>> +	depends on ARCH_STM32_MPU
>> +	default y
>> +
>> +endif
>> +
>>   endif
