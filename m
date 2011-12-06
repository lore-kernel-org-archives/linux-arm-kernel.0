From: robherring2@gmail.com (Rob Herring)
Date: Tue, 06 Dec 2011 10:51:28 -0600
Subject: [PATCH] ARM: pl2x0/pl310: Refactor Kconfig to be more maintainable
In-Reply-To: <20111206162646.GE13769@linaro.org>
References: <1322584345-19193-1-git-send-email-dave.martin@linaro.org>
 <4ED531C3.8050004@gmail.com> <20111206162646.GE13769@linaro.org>
Message-ID: <4EDE4810.4020003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2011 10:26 AM, Dave Martin wrote:
> On Tue, Nov 29, 2011 at 01:25:55PM -0600, Rob Herring wrote:
>> On 11/29/2011 10:32 AM, Dave Martin wrote:
>>> Making CACHE_L2X0 depends on (huge list of MACH_ and ARCH_ configs)
>>> is bothersome to maintain and likely to lead to merge conflicts.
>>>
>>> This patch moves the knowledge of which platforms have a L2x0 or
>>> PL310 cache controller to the individual machines.  To enable this,
>>> a new HAVE_L2X0_L2CC config option is introduced to allow machines
>>> to indicate that they have such a cache controller independently of
>>> each other.
>>>
>>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>>> ---
>>>  arch/arm/Kconfig               |    8 ++++++++
>>>  arch/arm/mach-exynos/Kconfig   |    1 +
>>>  arch/arm/mach-omap2/Kconfig    |    1 +
>>>  arch/arm/mach-realview/Kconfig |    5 +++++
>>>  arch/arm/mach-vexpress/Kconfig |    1 +
>>>  arch/arm/mm/Kconfig            |   13 ++++++++-----
>>>  arch/arm/plat-mxc/Kconfig      |    1 +
>>>  7 files changed, 25 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 44789ef..4068fe5 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -339,6 +339,7 @@ config ARCH_HIGHBANK
>>>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>>>  	select ARM_AMBA
>>>  	select ARM_GIC
>>> +	select HAVE_L2X0_L2CC
>>>  	select ARM_TIMER_SP804
>>>  	select CLKDEV_LOOKUP
>>>  	select CPU_V7
>>
>> These entries are sorted per rmk's review, so please keep it that way.
> 
> Can you explain what order they should be in?  Alphabetical?

Yes, alphabetical.

> 
>>
>>> @@ -359,6 +360,7 @@ config ARCH_CLPS711X
>>>  config ARCH_CNS3XXX
>>>  	bool "Cavium Networks CNS3XXX family"
>>>  	select CPU_V6K
>>> +	select HAVE_L2X0_L2CC
>>>  	select GENERIC_CLOCKEVENTS
>>>  	select ARM_GIC
>>>  	select MIGHT_HAVE_PCI
>>
>> But as you can see, that's rarely the case...
> 
> Do you mean "things are not always in alphabetical order?"
> 
> Apologies if I'm being obtuse -- your comments are rather terse for me.

Yes.

> 
> [...]
> 
>>> +config HAVE_L2X0_L2CC
>>> +	bool
>>> +	default n
>>
>> n is the default already.
> 
> Good point -- I'll kill that.
> 
>>> +	help
>>> +	  This option should be selected by machines which have a L2x0
>>> +	  or PL310 cache controller.
>>> +
>>>  config CACHE_L2X0
>>>  	bool "Enable the L2x0 outer cache controller"
>>> -	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
>>> -		   REALVIEW_EB_A9MP || ARCH_IMX_V6_V7 || MACH_REALVIEW_PBX || \
>>> -		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
>>> -		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || \
>>> -		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX || ARCH_HIGHBANK
>>> +	depends on HAVE_L2X0_L2CC
>>
>> For platforms that run in non-secure mode, this shouldn't really be a
>> user selectable option. Perhaps those should just select CACHE_L2X0
>> directly. I'm not sure which one's those are other than Highbank and OMAP4.
> 
> The idea here is to make the option user-selectable on platforms where it
> makes sense (and only those platforms).
> 
> So yes, I think that platforms which require this option _should_ select
> it directly, rather than it being reverse-selected from arch/arm/mm/Kconfig.
> This puts the knowledge in the logical place.  Does this apply to OMAP3?
> I think we're always running in the Normal World there too.

No, as OMAP3 has the integrated L2 of the Cortex-A8.

Rob
