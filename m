From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 11 Aug 2015 15:19:37 +0800
Subject: [PATCH v4 06/10] irqchip / GICv3: Add ACPI support for GICv3+
 initialization
In-Reply-To: <55C38E59.9090802@arm.com>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <1438164539-29256-7-git-send-email-hanjun.guo@linaro.org>
 <55C0BB5E.2080706@arm.com> <55C21709.3070907@linaro.org>
 <55C38E59.9090802@arm.com>
Message-ID: <55C9A209.9060306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 08/07/2015 12:42 AM, Marc Zyngier wrote:
> On 05/08/15 15:00, Hanjun Guo wrote:
>> On 08/04/2015 09:17 PM, Marc Zyngier wrote:
>>> On 29/07/15 11:08, Hanjun Guo wrote:
>>>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>>
>>>> With the refator of gic_of_init(), GICv3/4 can be initialized
>>>> by gic_init_bases() with gic distributor base address and gic
>>>> redistributor region(s).
>>>>
>>>> So get the redistributor region base addresses from MADT GIC
>>>> redistributor subtable, and the distributor base address from
>>>> GICD subtable to init GICv3 irqchip in ACPI way.
>>>>
>>>> Note: GIC redistributor base address may also be provided in
>>>> GICC structures on systems supporting GICv3 and above if the GIC
>>>> Redistributors are not in the always-on power domain, this
>>>> patch didn't implement such feature yet.
>>>>
>>>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>> [hj: Rework this patch and fix multi issues]
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> ---
>>>>    drivers/irqchip/irq-gic-v3.c | 174 +++++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 169 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>>> index c0b96c6..ebc5604 100644
>>>> --- a/drivers/irqchip/irq-gic-v3.c
>>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>>> @@ -15,6 +15,7 @@
>>>>     * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>>>     */
>>>>
>>>> +#include <linux/acpi.h>
>>>>    #include <linux/cpu.h>
>>>>    #include <linux/cpu_pm.h>
>>>>    #include <linux/delay.h>
>>>> @@ -25,6 +26,7 @@
>>>>    #include <linux/percpu.h>
>>>>    #include <linux/slab.h>
>>>>
>>>> +#include <linux/irqchip/arm-gic-acpi.h>
>>>>    #include <linux/irqchip/arm-gic-v3.h>
>>>>
>>>>    #include <asm/cputype.h>
>>>> @@ -802,7 +804,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
>>>>       set_handle_irq(gic_handle_irq);
>>>>
>>>>       if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
>>>> -            its_init(domain_token, &gic_data.rdists, gic_data.domain);
>>>> +            its_init(irq_domain_token_to_of_node(domain_token),
>>>> +                     &gic_data.rdists, gic_data.domain);
>>>
>>> This doesn't make much sense. The first parameter to its_init is indeed
>>> supposed to be an of_node, but what is the point of calling its_init if
>>> you *know* you don't have the necessary topological information to parse
>>> the firmware tables?
>>>
>>> I don't see *any* code that is going to parse the ITS table in this
>>> series, so please don't call its_init passing a NULL pointer to it. This
>>> is just gross.
>>
>> OK, the ITS ACPI code is in later patch which combined with IORT. How
>> about moving it to the GIC of init code temporary?
>
> Just don't call its_init if irq_domain_token_to_of_node(domain_token) is
> NULL. But don't call it with a NULL parameter.

OK.

[...]

>>>> +}
>>>> +IRQCHIP_ACPI_DECLARE(gic_v3, ACPI_MADT_GIC_VERSION_V3, gic_acpi_init);
>>>> +IRQCHIP_ACPI_DECLARE(gic_v4, ACPI_MADT_GIC_VERSION_V4, gic_acpi_init);
>>>
>>> As mentioned before, this doesn't work.
>>
>> hmm, I think we need more discussion for this one, but we need to match
>> V4 for GICv3 drivers, and everything will be the same in the dirver
>> as I said before.
>
> And as I said before, you don't need to distinguish v3 from v4 in the
> ACPI code. Matching GICv3 is enough.

OK, how about the following code when parsing the GIC version?

/*
  * GICv3 driver can find out it's V3 or V4 itself, just set the
  * gic_version to V3 to match the driver if firmware presented V4.
  */
if (gic_version == ACPI_MADT_GIC_VERSION_V4)
         gic_version = ACPI_MADT_GIC_VERSION_V3;

Thanks
Hanjun
