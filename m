From: vigneshr@ti.com (Vignesh R)
Date: Fri, 31 Aug 2018 20:56:22 +0530
Subject: [PATCH] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
In-Reply-To: <20180828162556.GQ7523@atomide.com>
References: <20180828102642.26482-1-kishon@ti.com>
 <20180828162556.GQ7523@atomide.com>
Message-ID: <6f5f8747-46c2-6133-d31a-6c441c24bcd4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kishon,

On 28-Aug-18 9:55 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [180828 10:31]:
>> AM65 has two PCIe controllers and each PCIe controller has '2' address
>> spaces one within the 4GB address space of the SoC and the other above
>> the 4GB address space of the SoC in addition to the register space. The
>> size of the address space above the 4GB SoC address space is 4GB. These
>> address ranges will be used by CPU/DMA to access the PCIe address space.
>> In order to represent the address space above the 4GB SoC address space
>> and to represent the size of this address space as 4GB, change
>> address-cells and size-cells of interconnect to 2.
> ...
>>  		cbass_mcu: interconnect at 28380000 {
>>  			compatible = "simple-bus";
>>  			#address-cells = <1>;
>>  			#size-cells = <1>;
> 

Looking at Table 2-2. MCU Domain Memory Map in TRM, OSPI has similar
need. There are two address ranges to access OSPI flash in memory mapped
mode:
MCU_FSS0_DAT_REG1 0x0050000000 0x0058000000 128 MB(32bit space)
MCU_FSS0_DAT_REG0 0x0400000000 0x0500000000 4 GB(64bit space with ECC)
MCU_FSS0_DAT_REG3 0x0500000000 0x0600000000 4 GB(64bit space w/o ECC)

Since, there are already OSPI flashes with size > 128MB, we would need
to use 4GB address space in kernel (which is above 32 bit space)

Therefore, could you also change cbass_mcu also to have
#address-cells = <2>?

Regards
Vignesh
