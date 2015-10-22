From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 22 Oct 2015 16:16:00 -0700
Subject: [PATCH] clk: iproc: Make clocks visible options
In-Reply-To: <20151022201433.GK651@broadcom.com>
References: <1445541913-25066-1-git-send-email-jonmason@broadcom.com>
 <56293D26.7080006@broadcom.com> <20151022201433.GK651@broadcom.com>
Message-ID: <56296E30.7050804@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,


On 15-10-22 01:14 PM, Jon Mason wrote:
> On Thu, Oct 22, 2015 at 12:46:46PM -0700, Scott Branden wrote:
>> Hi Jon,
>>
>> comments inline.
>>
>> On 15-10-22 12:25 PM, Jon Mason wrote:
>>> Make the clocks visible options that can be selected by anyone.  This
>>> avoids the problems of:
>>>   1) Select is a reverse dependency and is hard for people to understand
>>>      and can sometimes be a pain to track down
>> This doesn't make any sense to me - there are many selects in the
>> system and this is one of them.
>
> This was specifically requested by Stephen Boyd, and the above are
> his words verbatum
> https://lkml.org/lkml/2015/10/21/956
>
Yes, thanks.  Not all of the comments are needed.  If you look closer 
COMMON_CLK_IPROC should be a non-visible option.  It is just an internal 
config option used in the Makefile only.  There's no benefit to exposing 
an option here and adding another layer to the Kconfig hierarchy.

See my proposed (revised) changes below which remove the code bloat and 
allow build coverage to be increased.  Even if you expose it there are 
additional changes you need to make to your patchset dealing with 
COMPILE_TEST

> Thanks,
> Jon
>
>>>   2) Build coverage goes down because configs are hidden
>>>   3) Code bloat
>>>
>>> Patch suggested by Stephen Boyd
>>>
>>> Signed-off-by: Jon Mason <jonmason@broadcom.com>
>>> ---
>>>   arch/arm/mach-bcm/Kconfig |  1 -
>>>   drivers/clk/bcm/Kconfig   | 35 ++++++++++++++++++++++++++++++++++-
>>>   drivers/clk/bcm/Makefile  |  7 +++----
>>>   3 files changed, 37 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>>> index 679798b..cacaaec 100644
>>> --- a/arch/arm/mach-bcm/Kconfig
>>> +++ b/arch/arm/mach-bcm/Kconfig
>>> @@ -14,7 +14,6 @@ config ARCH_BCM_IPROC
>>>   	select HAVE_ARM_SCU if SMP
>>>   	select HAVE_ARM_TWD if SMP
>>>   	select ARM_GLOBAL_TIMER
>>> -	select COMMON_CLK_IPROC
>>>   	select CLKSRC_MMIO
>>>   	select ARCH_REQUIRE_GPIOLIB
>>>   	select ARM_AMBA
>>> diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
>>> index 46ee475..0352ccf 100644
>>> --- a/drivers/clk/bcm/Kconfig
>>> +++ b/drivers/clk/bcm/Kconfig
>>> @@ -9,8 +9,41 @@ config CLK_BCM_KONA
 >  	  in the BCM281xx and BCM21664 families.
 >
 >  config COMMON_CLK_IPROC
 > -	bool
 > +	bool "Broadcom iProc clock support"
Please leave as is
 > +	depends on ARCH_BCM_IPROC
 >  	depends on COMMON_CLK
 > +	default ARCH_BCM_IPROC
 >  	help
 >  	  Enable common clock framework support for Broadcom SoCs
 >  	  based on the iProc architecture
 > +
 > +if COMMON_CLK_IPROC
Remove all the changes above from patchset - not needed.

>>> +config CLK_BCM_CYGNUS
>>> +	bool "Broadcom Cygnus clock support"
>>> +	depends on COMMON_CLK_IPROC
not needed - keep hidden and do this instead
select COMMON_CLK_IPROC
>>> +	depends on ARCH_BCM_CYGNUS
|| COMPILE_TEST
>>> +	default ARCH_BCM_CYGNUS
>>> +	help
>>> +	  Enable common clock framework support for the Broadcom Cygnus SoC
>>> +
>>> +config CLK_BCM_NSP
>> not needed
>>> +	bool "Broadcom Northstar/Northstar Plus clock support"
>>> +	depends on COMMON_CLK_IPROC
not needed - keep hidden and do this instead
select COMMON_CLK_IPROC
>>> +	depends on ARCH_BCM_5301X || ARCH_BCM_NSP
|| COMPILE_TEST
>>> +	default ARCH_BCM_5301X || ARCH_BCM_NSP
>>> +	help
>>> +	  Enable common clock framework support for the Broadcom Northstar and
>>> +	  Northstar Plus SoCs
>>> +
>>> +config CLK_BCM_NS2
>>> +	bool "Broadcom Northstar 2 clock support"
>>> +	depends on ARM64
|| COMPILE_TEST
>>> +	depends on COMMON_CLK_IPROC
not needed - keep hidden and do this instead
select COMMON_CLK_IPROC
>>> +	default ARCH_BCM_IPROC
>>> +	help
>>> +	  Enable common clock framework support for the Broadcom Northstar 2 SoC
>>> +
>>> +endif
remove endif
>>> diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
>>> index 2d1cbc5..05d5830 100644
>>> --- a/drivers/clk/bcm/Makefile
>>> +++ b/drivers/clk/bcm/Makefile
>>> @@ -3,7 +3,6 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona-setup.o
>>>   obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
>>>   obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
>>>   obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
>>> -obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-ns2.o
>> yes, change this one
>>> -obj-$(CONFIG_ARCH_BCM_CYGNUS)	+= clk-cygnus.o
>> you can leave this
>>> -obj-$(CONFIG_ARCH_BCM_NSP)	+= clk-nsp.o
>> you can leave this
>>> -obj-$(CONFIG_ARCH_BCM_5301X)	+= clk-nsp.o
>> and this
>>> +obj-$(CONFIG_CLK_BCM_CYGNUS)	+= clk-cygnus.o
>> no
>>> +obj-$(CONFIG_CLK_BCM_NSP)	+= clk-nsp.o
>> no
>>> +obj-$(CONFIG_CLK_BCM_NS2)	+= clk-ns2.o
>> yes needed
>>>
>>
