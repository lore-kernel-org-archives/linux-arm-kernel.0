From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 Sep 2011 13:25:17 -0500
Subject: Git pull request: mach/vmalloc.h removal,
	and ioremap optimizations
In-Reply-To: <20110929173731.GB21718@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1109230908410.12663@xanadu.home>
	<4E8495D9.2030009@gmail.com>
	<20110929173731.GB21718@n2100.arm.linux.org.uk>
Message-ID: <4E84B80D.2020605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/2011 12:37 PM, Russell King - ARM Linux wrote:
> On Thu, Sep 29, 2011 at 10:59:21AM -0500, Rob Herring wrote:
>> commit e0438e2f333005c217a2f65aacab23a39261c64c
>> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
>> Date:   Thu Aug 25 00:35:59 2011 -0400
>>
>>     ARM: move iotable mappings within the vmalloc region
>>
>>     In order to remove the build time variation between different SOCs with
>>     regards to VMALLOC_END, the iotable mappings are now allocated inside
>>     the vmalloc region.  This allows for VMALLOC_END to be identical across
>>     all machines.
>>
>>     The value for VMALLOC_END is now set to 0xff000000 which is right where
>>     the consistent DMA area starts.
>>
>>     To accommodate all static mappings on machines with possible highmem
>> usage,
>>     the default vmalloc area size is changed to 240 MB so that VMALLOC_START
>>     is no higher than 0xf0000000 by default in that case.
>>
>>     Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>>
>>
>> It dies after "Data cache writeback" with BUG at vmalloc.c:1139.
> 
> My guess would be:
> 
>         }, {
>                 .virtual        =  IO_ADDRESS(VERSATILE_SCTL_BASE),
>                 .pfn            = __phys_to_pfn(VERSATILE_SCTL_BASE),
>                 .length         = SZ_4K * 9,
>                 .type           = MT_DEVICE
>         },
> #ifdef CONFIG_MACH_VERSATILE_AB
>         {
>                 .virtual        =  IO_ADDRESS(VERSATILE_GPIO0_BASE),
>                 .pfn            = __phys_to_pfn(VERSATILE_GPIO0_BASE),
>                 .length         = SZ_4K,
>                 .type           = MT_DEVICE
> 
> #define VERSATILE_SCTL_BASE            0x101E0000	/* System controller */
> #define VERSATILE_GPIO0_BASE           0x101E4000	/* GPIO port 0 */
> 
> I don't see why GPIO0 is explicitly listed here.

It works for PB and AB with that removed. Here's a patch:

Author: Rob Herring <rob.herring@calxeda.com>
Date:   Thu Sep 29 13:18:29 2011 -0500

    ARM: versatile: remove overlapping map_desc entry

    The map_desc for VERSATILE_GPIO0_BASE overlaps with VERSATILE_SCTL_BASE.
    The overlapping entry can be removed.

    Signed-off-by: Rob Herring <rob.herring@calxeda.com>

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e340a54..4d8dfc1 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -141,11 +141,6 @@ static struct map_desc versatile_io_desc[]
__initdata = {
 	},
 #ifdef CONFIG_MACH_VERSATILE_AB
  	{
-		.virtual	=  IO_ADDRESS(VERSATILE_GPIO0_BASE),
-		.pfn		= __phys_to_pfn(VERSATILE_GPIO0_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	=  IO_ADDRESS(VERSATILE_IB2_BASE),
 		.pfn		= __phys_to_pfn(VERSATILE_IB2_BASE),
 		.length		= SZ_64M,
