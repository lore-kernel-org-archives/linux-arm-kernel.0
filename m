From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Mar 2015 15:21:21 +0000
Subject: [PATCH 1/2] ARM: imx6: Warn when an old DT is detected
In-Reply-To: <20150313150309.GA20455@dragon>
References: <1426149637-22062-1-git-send-email-marc.zyngier@arm.com>
 <1426149637-22062-2-git-send-email-marc.zyngier@arm.com>
 <20150313032139.GN20455@dragon> <20150313081311.1ebfe8e2@arm.com>
 <20150313150309.GA20455@dragon>
Message-ID: <55030071.8030207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/15 15:03, Shawn Guo wrote:
> On Fri, Mar 13, 2015 at 08:13:11AM +0000, Marc Zyngier wrote:
>> On Fri, 13 Mar 2015 03:21:41 +0000
>> Shawn Guo <shawn.guo@linaro.org> wrote:
>>
>>> On Thu, Mar 12, 2015 at 08:40:36AM +0000, Marc Zyngier wrote:
>>>> Now that the GPC has been converted to be a full blown irqchip
>>>> (and not a mole on the side of the GIC), booting a new kernel
>>>> with an old DT is likely to result in a rough ride for the user.
>>>>
>>>> This patch makes sure such a situation is promptly detected and
>>>> the user made aware that a DT update is in order.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  arch/arm/mach-imx/pm-imx6.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-imx/pm-imx6.c
>>>> b/arch/arm/mach-imx/pm-imx6.c index 6a7c6fc..f03f30f0 100644
>>>> --- a/arch/arm/mach-imx/pm-imx6.c
>>>> +++ b/arch/arm/mach-imx/pm-imx6.c
>>>> @@ -554,11 +554,17 @@ put_node:
>>>>  static void __init imx6_pm_common_init(const struct imx6_pm_socdata
>>>>  					*socdata)
>>>>  {
>>>> +	struct device_node *np;
>>>>  	struct regmap *gpr;
>>>>  	int ret;
>>>>  
>>>>  	WARN_ON(!ccm_base);
>>>>  
>>>> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
>>>> +	if (WARN_ON(!np ||
>>>> +		    !of_find_property(np, "interrupt-controller",
>>>> NULL)))
>>>> +		pr_warn("Outdated DT detected, suspend/resume will
>>>> NOT work\n"); +
>>>
>>> Can this be done in imx_gpc_init() instead?
>>
>> Unfortunately not, as imx_gpc_init() is only called if the above
>> properties are satisfied (that's exactly the case we want to detect: if
>> imx_gpc_init is called, we're already in a pretty good shape).
> 
> Ah, yes.  I forgot that the way imx_gpc_init() is called has been
> changed.
> 
> I just gave the patch a go with an old DTB, and found that the kernel
> stops booting before we can even see this fat warning (see log below).
> It seems detecting at .init_machine time is too late.  I tried to move
> the code to the beginning of function imx6q_init_irq(), and found it
> works as expected.

[...]

Bummer. OK, I'll respin something shortly (we need to cover all three
imx6 variants separately, it seems).

Thanks for testing,

	M.
-- 
Jazz is not dead. It just smells funny...
