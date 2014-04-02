From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 2 Apr 2014 17:07:56 +0530
Subject: [PATCH 63/75] ARM: l2c: zynq: remove cache size override
In-Reply-To: <533BC56D.4010600@monstr.eu>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYZQ-0007H7-L6@rmk-PC.arm.linux.org.uk> <533BC56D.4010600@monstr.eu>
Message-ID: <533BF694.7030805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 April 2014 01:38 PM, Michal Simek wrote:
> Hi Russell,
> 
> On 03/28/2014 04:19 PM, Russell King wrote:
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>>  arch/arm/mach-zynq/common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
>> index 8c09a8393fb6..b58f17178006 100644
>> --- a/arch/arm/mach-zynq/common.c
>> +++ b/arch/arm/mach-zynq/common.c
>> @@ -67,7 +67,7 @@ static void __init zynq_init_machine(void)
>>  	/*
>>  	 * 64KB way size, 8-way associativity, parity disabled
>>  	 */
>> -	l2x0_of_init(0x02060000, 0xF0F0FFFF);
>> +	l2x0_of_init(0x02000000, 0xf0ffffff);
>>  
>>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>  
> 
> We have done one fix some days/weeks ago which is here.
> https://github.com/Xilinx/linux-xlnx/commit/1a85939af40acca2bf963407b497cc31c303ff3e
> (Feel free to ignore L2_PREFETCH config option)
> 
> There are 2 things there.
> 1. Extending macros in cache-l2x0.h which I believe can go to the mainline
> (when we align with changes you have done in 49/75)
> 2. Set L2X0_AUX_CTRL_SHARE_OVERRIDE_EN_MASK bit  which is what vexpress did.
> The reason was problem with gem driver with iperf testing.

So reading the original commit text from Catalin
(1a8e41cd672f894bbd74874eac601e6cedf838fb):

    ARM: 6395/1: VExpress: Set bit 22 in the PL310 (cache controller)
AuxCtlr register

    Clearing bit 22 in the PL310 Auxiliary Control register (shared
    attribute override enable) has the side effect of transforming Normal
    Shared Non-cacheable reads into Cacheable no-allocate reads.

    Coherent DMA buffers in Linux always have a Cacheable alias via the
    kernel linear mapping and the processor can speculatively load cache
    lines into the PL310 controller. With bit 22 cleared, Non-cacheable
    reads would unexpectedly hit such cache lines leading to buffer
    corruption.

    Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
    Cc: <stable@kernel.org>
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>


It looks like all Linux systems will have to use Sharable override to
avoid corruption? I see OMAP4 had a similar commit to enable bit 22 of
aux control register.

If yes, how about doing it by default in cache-l2x0.c rather than
leaving it to each platform?

Thanks,
Sekhar
