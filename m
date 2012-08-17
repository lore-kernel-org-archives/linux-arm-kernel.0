From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 17 Aug 2012 09:08:51 -0500
Subject: [PATCH 4/9] ARM: pmu: remove arm_pmu_type enumeration
In-Reply-To: <1344620195-22372-5-git-send-email-will.deacon@arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <1344620195-22372-5-git-send-email-will.deacon@arm.com>
Message-ID: <502E5073.6000901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Tony,

On 08/10/2012 12:36 PM, Will Deacon wrote:
> From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
> 
> The arm_pmu_type enumeration was initially introduced to identify
> different PMU types in the system, the usual one being that on the CPU
> (ARM_PMU_DEVICE_CPU). With the removal of the PMU reservation code and
> the introduction of devicetree bindings for the CPU PMU, the enumeration
> is no longer required.
> 
> This patch removes the enumeration and updates the various CPU PMU
> platform devices so that they no longer pass an .id field referring
> to identify the PMU type.

[snip]

> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index c00c689..02b9478 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -23,7 +23,6 @@
>  #include <mach/irqs.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> -#include <asm/pmu.h>
>  
>  #include "iomap.h"
>  #include <plat/board.h>
> @@ -448,7 +447,7 @@ static struct resource omap3_pmu_resource = {
>  
>  static struct platform_device omap_pmu_device = {
>  	.name		= "arm-pmu",
> -	.id		= ARM_PMU_DEVICE_CPU,
> +	.id		= -1,
>  	.num_resources	= 1,
>  };

I know that I have already ack-ed the change and it is fine with me,
however, I see a potential merge conflict here with my patch [1]
(assuming that these all go into v3.7) where I am moving the above
structure.

For testing I have rebased my series on top of this series and it is
working well so far on OMAP4460.

I am hoping to get the next version of my series for omap out next week.
However, before I did I wanted to ask how we should handle the above
change. Should I submit my series as rebased on top of this?

Thanks
Jon

[1]
https://github.com/jonhunter/linux/commit/6a07e3aa21f956bea7858704c224b7f50d25e1c0
