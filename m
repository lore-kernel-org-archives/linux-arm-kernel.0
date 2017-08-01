From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Tue, 1 Aug 2017 11:08:19 -0700
Subject: [PATCH v3 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
In-Reply-To: <9b856bf5-f404-5cfc-6f1e-5ae527c6e0b1@oracle.com>
References: <20170724212454.27574-1-d-gerlach@ti.com>
 <20170724212454.27574-3-d-gerlach@ti.com>
 <9b856bf5-f404-5cfc-6f1e-5ae527c6e0b1@oracle.com>
Message-ID: <cfb8007b-7f3a-1787-bb9d-9486f547f23f@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/26/2017 9:54 AM, Santosh Shilimkar wrote:
> 
> On 7/24/2017 2:24 PM, Dave Gerlach wrote:
>> Certain SoCs like Texas Instruments AM335x and AM437x require parts
>> of the EMIF PM code to run late in the suspend sequence from SRAM,
>> such as saving and restoring the EMIF context and placing the memory
>> into self-refresh.
>>
>> One requirement for these SoCs to suspend and enter its lowest power
>> mode, called DeepSleep0, is that the PER power domain must be shut off.
>> Because the EMIF (DDR Controller) resides within this power domain, it
>> will lose context during a suspend operation, so we must save it so we
>> can restore once we resume. However, we cannot execute this code from
>> external memory, as it is not available at this point, so the code must
>> be executed late in the suspend path from SRAM.
>>
>> This patch introduces a ti-emif-sram driver that includes several
>> functions written in ARM ASM that are relocatable so the PM SRAM
>> code can use them. It also allocates a region of writable SRAM to
>> be used by the code running in the executable region of SRAM to save
>> and restore the EMIF context. It can export a table containing the
>> absolute addresses of the available PM functions so that other SRAM
>> code can branch to them. This code is required for suspend/resume on
>> AM335x and AM437x to work.
>>
>> In addition to this, to be able to share data structures between C and
>> the ti-emif-sram-pm assembly code, we can automatically generate all of
>> the C struct member offsets and sizes as macros by making use of the ARM
>> asm-offsets file. In the same header that we define our data structures
>> in we also define all the macros in an inline function and by adding a
>> call to this in the asm_offsets file all macros are properly generated
>> and available to the assembly code without cluttering up the asm-offsets
>> file.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
[...]

>>
>>   arch/arm/kernel/asm-offsets.c    |   4 +
>>   drivers/memory/Kconfig           |  10 ++
>>   drivers/memory/Makefile          |   4 +
>>   drivers/memory/emif.h            |  17 ++
>>   drivers/memory/ti-emif-pm.c      | 339 
>> +++++++++++++++++++++++++++++++++++++++
>>   drivers/memory/ti-emif-sram-pm.S | 334 
>> ++++++++++++++++++++++++++++++++++++++
>>   include/linux/ti-emif-sram.h     | 147 +++++++++++++++++
>>   7 files changed, 855 insertions(+)
>>   create mode 100644 drivers/memory/ti-emif-pm.c
>>   create mode 100644 drivers/memory/ti-emif-sram-pm.S
>>   create mode 100644 include/linux/ti-emif-sram.h
>>
> I will need RMKs blessing since he reviewed the ASM code.
> 
> Also need work out how to line this up. Typically I use to get
> driver/memory patches via Greg's driver-core but this is more
> PM code than memory driver and very SOC specific.
> 
> Hi Arnd/Olof,
> Will you be ok to pull this via arm-soc ? There is also follow
> up platform PM code and DTS series which will make use of this.
> 
Looks like I missed to copy Olof. Let me know guys if you are
ok to pull this into your driver-soc given the dependencies.

Regards
Santosh
