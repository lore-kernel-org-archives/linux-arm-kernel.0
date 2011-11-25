From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 25 Nov 2011 09:05:07 +0530
Subject: [PATCH 33/41] ARM: restart: spear: use new restart hook
In-Reply-To: <20111124203240.GT9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6s9-0001Yp-Sd@rmk-PC.arm.linux.org.uk>
 <20111124203240.GT9581@n2100.arm.linux.org.uk>
Message-ID: <4ECF0CEB.9060108@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2011 2:02 AM, Russell King - ARM Linux wrote:
> Ack?
> 
> On Sun, Nov 06, 2011 at 05:51:09PM +0000, Russell King - ARM Linux wrote:
>> Hook these platforms restart code into the new restart hook rather
>> than using arch_reset().
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>>  arch/arm/mach-spear3xx/include/mach/generic.h |    2 +
>>  arch/arm/mach-spear3xx/spear300_evb.c         |    1 +
>>  arch/arm/mach-spear3xx/spear310_evb.c         |    1 +
>>  arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
>>  arch/arm/mach-spear6xx/include/mach/generic.h |    2 +
>>  arch/arm/mach-spear6xx/spear600_evb.c         |    1 +
>>  arch/arm/plat-spear/Makefile                  |    2 +-
>>  arch/arm/plat-spear/include/plat/system.h     |   11 ----------
>>  arch/arm/plat-spear/restart.c                 |   27 +++++++++++++++++++++++++
>>  9 files changed, 36 insertions(+), 12 deletions(-)
>>  create mode 100644 arch/arm/plat-spear/restart.c
>>

Sorry for missing it earlier.

Acked-by: Viresh Kumar <viresh.kumar@st.com>

>> diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
>> index b8f31c3..14276e5 100644
>> --- a/arch/arm/mach-spear3xx/include/mach/generic.h
>> +++ b/arch/arm/mach-spear3xx/include/mach/generic.h
>> @@ -42,6 +42,8 @@ void __init spear3xx_map_io(void);
>>  void __init spear3xx_init_irq(void);
>>  void __init spear3xx_init(void);
>>  
>> +void spear_restart(char, const char *);
>> +
>>  /* pad mux declarations */
>>  #define PMX_FIRDA_MASK		(1 << 14)
>>  #define PMX_I2C_MASK		(1 << 13)
>> diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
>> index a5ff98e..8b429f0 100644
>> --- a/arch/arm/mach-spear3xx/spear300_evb.c
>> +++ b/arch/arm/mach-spear3xx/spear300_evb.c
>> @@ -69,4 +69,5 @@ MACHINE_START(SPEAR300, "ST-SPEAR300-EVB")
>>  	.init_irq	=	spear3xx_init_irq,
>>  	.timer		=	&spear3xx_timer,
>>  	.init_machine	=	spear300_evb_init,
>> +	.restart	=	spear_restart,
>>  MACHINE_END
>> diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
>> index 45d180d..a11d6ea 100644
>> --- a/arch/arm/mach-spear3xx/spear310_evb.c
>> +++ b/arch/arm/mach-spear3xx/spear310_evb.c
>> @@ -75,4 +75,5 @@ MACHINE_START(SPEAR310, "ST-SPEAR310-EVB")
>>  	.init_irq	=	spear3xx_init_irq,
>>  	.timer		=	&spear3xx_timer,
>>  	.init_machine	=	spear310_evb_init,
>> +	.restart	=	spear_restart,
>>  MACHINE_END
>> diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
>> index 2287984..4239a70 100644
>> --- a/arch/arm/mach-spear3xx/spear320_evb.c
>> +++ b/arch/arm/mach-spear3xx/spear320_evb.c
>> @@ -73,4 +73,5 @@ MACHINE_START(SPEAR320, "ST-SPEAR320-EVB")
>>  	.init_irq	=	spear3xx_init_irq,
>>  	.timer		=	&spear3xx_timer,
>>  	.init_machine	=	spear320_evb_init,
>> +	.restart	=	spear_restart,
>>  MACHINE_END
>> diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
>> index 183f023..116b993 100644
>> --- a/arch/arm/mach-spear6xx/include/mach/generic.h
>> +++ b/arch/arm/mach-spear6xx/include/mach/generic.h
>> @@ -41,6 +41,8 @@ void __init spear6xx_init(void);
>>  void __init spear600_init(void);
>>  void __init spear6xx_clk_init(void);
>>  
>> +void spear_restart(char, const char *);
>> +
>>  /* Add spear600 machine device structure declarations here */
>>  
>>  #endif /* __MACH_GENERIC_H */
>> diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
>> index 8238fe3..0a16559 100644
>> --- a/arch/arm/mach-spear6xx/spear600_evb.c
>> +++ b/arch/arm/mach-spear6xx/spear600_evb.c
>> @@ -48,4 +48,5 @@ MACHINE_START(SPEAR600, "ST-SPEAR600-EVB")
>>  	.init_irq	=	spear6xx_init_irq,
>>  	.timer		=	&spear6xx_timer,
>>  	.init_machine	=	spear600_evb_init,
>> +	.restart	=	spear_restart,
>>  MACHINE_END
>> diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
>> index b4f340b..e0f2e5b 100644
>> --- a/arch/arm/plat-spear/Makefile
>> +++ b/arch/arm/plat-spear/Makefile
>> @@ -3,6 +3,6 @@
>>  #
>>  
>>  # Common support
>> -obj-y	:= clock.o time.o
>> +obj-y	:= clock.o restart.o time.o
>>  
>>  obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
>> diff --git a/arch/arm/plat-spear/include/plat/system.h b/arch/arm/plat-spear/include/plat/system.h
>> index 1171f22..4a0d125 100644
>> --- a/arch/arm/plat-spear/include/plat/system.h
>> +++ b/arch/arm/plat-spear/include/plat/system.h
>> @@ -14,10 +14,6 @@
>>  #ifndef __PLAT_SYSTEM_H
>>  #define __PLAT_SYSTEM_H
>>  
>> -#include <linux/io.h>
>> -#include <asm/hardware/sp810.h>
>> -#include <mach/hardware.h>
>> -
>>  static inline void arch_idle(void)
>>  {
>>  	/*
>> @@ -29,13 +25,6 @@ static inline void arch_idle(void)
>>  
>>  static inline void arch_reset(char mode, const char *cmd)
>>  {
>> -	if (mode == 's') {
>> -		/* software reset, Jump into ROM at address 0 */
>> -		soft_restart(0);
>> -	} else {
>> -		/* hardware reset, Use on-chip reset capability */
>> -		sysctl_soft_reset((void __iomem *)VA_SPEAR_SYS_CTRL_BASE);
>> -	}
>>  }
>>  
>>  #endif /* __PLAT_SYSTEM_H */
>> diff --git a/arch/arm/plat-spear/restart.c b/arch/arm/plat-spear/restart.c
>> new file mode 100644
>> index 0000000..2b4e3d8
>> --- /dev/null
>> +++ b/arch/arm/plat-spear/restart.c
>> @@ -0,0 +1,27 @@
>> +/*
>> + * arch/arm/plat-spear/restart.c
>> + *
>> + * SPEAr platform specific restart functions
>> + *
>> + * Copyright (C) 2009 ST Microelectronics
>> + * Viresh Kumar<viresh.kumar@st.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +#include <linux/io.h>
>> +#include <asm/hardware/sp810.h>
>> +#include <mach/hardware.h>
>> +#include <mach/generic.h>
>> +
>> +void spear_restart(char mode, const char *cmd)
>> +{
>> +	if (mode == 's') {
>> +		/* software reset, Jump into ROM at address 0 */
>> +		soft_restart(0);
>> +	} else {
>> +		/* hardware reset, Use on-chip reset capability */
>> +		sysctl_soft_reset((void __iomem *)VA_SPEAR_SYS_CTRL_BASE);
>> +	}
>> +}
>> -- 
>> 1.7.4.4
>>
