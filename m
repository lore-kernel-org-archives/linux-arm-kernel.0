From: Suravee.Suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Tue, 25 Nov 2014 11:46:50 +0000
Subject: [PATCH V4] arm64: amd-seattle: Adding device tree for AMD
 Seattle platform
In-Reply-To: <547458B9.2000805@arm.com>
Message-ID: <D09A7217.A4E1%suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 11/25/14, 17:23, "Marc Zyngier" <marc.zyngier@arm.com> wrote:

>Hi Suravee,
>
>Just spotted a small issue below (looks like a recurring mistake in a
>number of DTs I've seem lately):
>
>On 24/11/14 21:51, suravee.suthikulpanit at amd.com wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> 
>> Initial revision of device tree for AMD Seattle platform.
>> 
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
>> Signed-off-by: Joel Schopp <Joel.Schopp@amd.com>
>> ---
>> V4 Changes:
>>     * Remove unnecessary smb layer and move motherbord to top level
>>     * Move include dtsi to top level
>>     * Remove apb_pclk from sata0 and i2c
>>     * Fix GIC Virtual Maintanance Interrupt from PPI24 (8) to PPI25 (9)
>>     * Add 40-bit dma-ranges for motherboard (simple-bus)
>>     * Remove dma0 (pl330) entry for now since it only supports 32-bit
>>DMA.
>>       It is basically not used at the moment. It would also need SMMU
>>       to allow dma remapping to 40-bit DMA range.
>>     * Add phandle spi0 and spi1
>>     * Hook up gpio0 pin 7 with MMC Card Detection (CD) support.
>>     * Changes in pcie0 entry:
>>         - Add 40-bit dma-ranges
>>         - Remove interrupts property
>>         - Add interrupt-map/mask property
>>         - Fix PCI I/O range
>>         - Merge PCI 32-bit ranges
>>         - Merge PCI 64-bit ranges
>> 
>> NOTE: I am not add a new compatible ID for the sata0 as Rob Herring
>>       suggested since there is no need at the momement, and I am trying
>>       to avoid introducing ID unnecessarily.
>> 
>>  arch/arm64/Kconfig                          |   5 +
>>  arch/arm64/boot/dts/Makefile                |   1 +
>>  arch/arm64/boot/dts/amd-seattle-periph.dtsi | 156
>>++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/amd-seattle.dts         |  89 ++++++++++++++++
>>  4 files changed, 251 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amd-seattle-periph.dtsi
>>  create mode 100644 arch/arm64/boot/dts/amd-seattle.dts
>> 
>
>[...]
>
>> diff --git a/arch/arm64/boot/dts/amd-seattle.dts
>>b/arch/arm64/boot/dts/amd-seattle.dts
>> new file mode 100644
>> index 0000000..d5fc482
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amd-seattle.dts
>> @@ -0,0 +1,89 @@
>> +/*
>> + * DTS file for AMD Seattle
>> + *
>> + * Copyright (C) 2014 Advanced Micro Devices, Inc.
>> + */
>> +
>> +/dts-v1/;
>> +

[...] 

>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <1 13 0xff01>,
>> +			     <1 14 0xff01>,
>> +			     <1 11 0xff01>,
>> +			     <1 10 0xff01>;
>> +	};
>
>The Cortex-A57 TRM clearly states that these interrupts are level
>triggered.

Thanks for pointing this out. I?ll fix this to <1 1X 0xff04> (4 for the
Active-High) then.

Suravee

>
