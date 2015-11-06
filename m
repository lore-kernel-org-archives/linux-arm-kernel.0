From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 Nov 2015 09:47:37 +0900
Subject: [PATCH v3 7/7] drivers: soc: Add support for Exynos PMU driver
In-Reply-To: <563AE9C7.4030701@samsung.com>
References: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
 <1445864143-25695-8-git-send-email-pankaj.dubey@samsung.com>
 <56381A66.1010406@samsung.com> <563AE9C7.4030701@samsung.com>
Message-ID: <563BF8A9.5040708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2015 14:31, Pankaj Dubey wrote:
> Hi Krzysztof,
> 
> On Tuesday 03 November 2015 07:52 AM, Krzysztof Kozlowski wrote:
> 
>>
>> 1. Please reorder the exynos_sys_powerdown_conf() to be after the
>> statics. I am thinking also about adding EXPORT_SYMBOL... but maybe this
>> would be over-thinking.
>>
> 
> I could not understand your point of reordering, will you please explain
> this.

Usually static functions are put at beginning of a file and the
externally linkable ones (including exportable) are at the end. This
allows quick finding of what is exported by this unit.

Mixing static-nonstatic-static brings confusion/

This is a driver so everything except it is static, so I see two choices:
1. Put it in front, just after pmu_context definition.
2. Put it in back, just before the probe.

> 
>> 2. I think the proper location of everything is drivers/power/reset/.
>> Although I don't have strong opinion.
>>
> 
> There has been discussion about the proper location for this driver,
> initial attempt was done in "drivers/mfd" folder but then we realized
> that this driver is not exactly fitting in MFD category.
> There was suggestion from Catalin Marinas [1], [2] to move it to
> "drivers/power" or a more suitable place other than mfd. As I received
> comments from Bartlomiej [3] and other members also (sorry I could not
> produce all links as it was quite more than a year back), I feel driver
> is very much SoC specific and hence decided to move it here.
> 
> 1: https://lkml.org/lkml/2014/4/28/879
> 2:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/252018.html
> 
> 3:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244690.html

In drivers/power/reset there are already very-SoC-specific reset
handlers. All of them are non-reusable outside of some SoC family.
However I don't think it really matters - both locations (soc and power)
seem fine to me.

Looking at Bart's comments I see that you did not resolve all of them.
One was left:
"what happens if exynos_sys_powerdown_conf() is called
while there are no platform devices binded to a driver but driver itself
is loaded."

Looking at the code NULL pointer exception will happen on pmu_context
dereference.

Best regards,
Krzysztof
