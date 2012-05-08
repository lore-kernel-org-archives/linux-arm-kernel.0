From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 8 May 2012 10:40:27 +0200
Subject: [PATCH 2/6] ARM: OMAP2+: PM: introduce power domains functional
 states
In-Reply-To: <alpine.DEB.2.00.1205070043230.9984@utopia.booyaka.com>
References: <1334752782-28804-1-git-send-email-j-pihet@ti.com>
 <1334752782-28804-3-git-send-email-j-pihet@ti.com>
 <alpine.DEB.2.00.1205070043230.9984@utopia.booyaka.com>
Message-ID: <CAORVsuXUbz_f54x=hoFLEQpfAGTDcZGnTQ-fBgY_j415LC0TiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On Mon, May 7, 2012 at 11:28 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Wed, 18 Apr 2012, jean.pihet at newoldbits.com wrote:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Introduce functional (or logical) states for power domains and the
>> API functions to read the power domains settings and to convert
>> between the functional (i.e. logical) and the internal (or registers)
>> values.
>>
>> OMAP2, OMAP3 and OMAP4 platforms are defining a conversion routine.
>>
>> In the new API the function omap_set_pwrdm_state takes the functional
>> states as parameter; while at it the function is moved to the power
>> domains code.
>>
>> The memory and logic states are not using the functional states, this
>> comes as a subsequent patch.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> This patch results in several checkpatch warnings; please resolve them.
Oops. Will check and update.

>
>> ---
>> ?arch/arm/mach-omap2/pm.c ? ? ? ? ? ? ? ? ? | ? 66 -----------
>> ?arch/arm/mach-omap2/powerdomain-common.c ? | ? 61 ++++++++++
>> ?arch/arm/mach-omap2/powerdomain.c ? ? ? ? ?| ?175 ++++++++++++++++++++++++++++
>> ?arch/arm/mach-omap2/powerdomain.h ? ? ? ? ?| ? 21 ++++
>> ?arch/arm/mach-omap2/powerdomain2xxx_3xxx.c | ? ?5 +
>> ?arch/arm/mach-omap2/powerdomain44xx.c ? ? ?| ? ?2 +
>> ?6 files changed, 264 insertions(+), 66 deletions(-)
>>
...

>> +/*
>> + * Functional (i.e. logical) to internal (i.e. registers)
>> + * values for the power domains states
>> + */
>
> Please use kerneldoc-style function comments.
Ok

>
>> +int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
>> +{
>> + ? ? int ret;
>> +
>> + ? ? switch (func_pwrst) {
>> + ? ? case PWRDM_FUNC_PWRST_ON:
>> + ? ? ? ? ? ? ret = PWRDM_POWER_ON;
>> + ? ? ? ? ? ? break;
>> + ? ? case PWRDM_FUNC_PWRST_INACTIVE:
>> + ? ? ? ? ? ? ret = PWRDM_POWER_INACTIVE;
>> + ? ? ? ? ? ? break;
>> + ? ? case PWRDM_FUNC_PWRST_CSWR:
>> + ? ? case PWRDM_FUNC_PWRST_OSWR:
>> + ? ? ? ? ? ? ret = PWRDM_POWER_RET;
>> + ? ? ? ? ? ? break;
>> + ? ? case PWRDM_FUNC_PWRST_OFF:
>> + ? ? ? ? ? ? ret = PWRDM_POWER_OFF;
>> + ? ? ? ? ? ? break;
>> + ? ? default:
>> + ? ? ? ? ? ? ret = -1;
>> + ? ? }
>> +
>> + ? ? return ret;
>> +}
>
> At a quick glance, I don't think that this function is appropriate for all
> OMAP2+ chips. ?For example, off-mode is not supported in our OMAP2xxx
> kernels. ?And OMAP2xxx/3xxx do not support the INACTIVE powerstate. ?So
> probably this function should differ by chip, and be located in the
> powerdomain[2-4]*xx*.c files.
I hope to make this function as generic as possible, hence the
location (powerdomain-common.c). Some states are not programmed by the
pwrdm_* functions since there forbidden by the contents of the
pwrdm->pwrst field.
Now if the need arises some platform specific function can be defined
for conversion functions since the pwrdm->ops function pointers are
used. I do not think it is needed now but it can easily be changed.

> Also, what about the logic and memory bank power states? ?Shouldn't this
> function pass those back as well?
Cf. in the description "The memory and logic states are not using the
functional states, this comes as a subsequent patch."

>
>> +
>> +/*
>> + * Internal (i.e. registers) to functional (i.e. logical) values
>> + * for the power domains states
>> + */
>
> Please use kerneldoc-style function documentation.
Ok

>
>> +int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
>
> Probably best to use "func_pwrst" or "fpwrst" rather than simply "func"
> here.
Ok. I am for 'omap2_pwrdm_pwrst_to_fpwrst(...)'.

>
>> +{
>> + ? ? int ret;
>> +
>> + ? ? switch (pwrst) {
>> + ? ? case PWRDM_POWER_ON:
>> + ? ? ? ? ? ? ret = PWRDM_FUNC_PWRST_ON;
>> + ? ? ? ? ? ? break;
>> + ? ? case PWRDM_POWER_INACTIVE:
>> + ? ? ? ? ? ? ret = PWRDM_FUNC_PWRST_INACTIVE;
>> + ? ? ? ? ? ? break;
>> + ? ? case PWRDM_POWER_RET:
>> + ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ?* XXX warning: return OSWR in case of pd in RET and
>> + ? ? ? ? ? ? ?* logic in OFF
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? ret = PWRDM_FUNC_PWRST_CSWR;
>> + ? ? ? ? ? ? break;
>> + ? ? case PWRDM_POWER_OFF:
>> + ? ? ? ? ? ? ret = PWRDM_FUNC_PWRST_OFF;
>> + ? ? ? ? ? ? break;
>> + ? ? default:
>> + ? ? ? ? ? ? ret = -1;
>> + ? ? }
>> +
>> + ? ? return ret;
>> +}
>
> This function also needs to check the bank power states and logic power
> states to determine what the actual functional powerstate is.
Same remark as above + there is a comment about it in the code ("XXX warning").

>> +
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>> index 319b277..718fa43 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -466,6 +466,136 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
>> ?}
>>
>> ?/**
>> + * pwrdm_func_to_pwrst - get the internal (i.e. registers) value mapped
>> + * to the functional state
>
> Probably best to use "func_pwrst" or "fpwrst" rather than simply "func"
> here.
Ok

>
>> + * @pwrdm: struct powerdomain * to query
>> + * @func_pwrst: functional power state
>> + *
>> + * Convert the functional power state to the platform specific power
>> + * domain state value.
>> + * Returns the internal power domain state value or -EINVAL in case
>> + * of invalid parameters passed in.
>> + */
>> +int pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
>> +{
>> + ? ? int ret = func_pwrst;
>> +
>> + ? ? if ((!pwrdm)|| (func_pwrst >= PWRDM_MAX_FUNC_PWRSTS))
>> + ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? pr_debug("powerdomain: convert %0x func to pwrst for %s\n",
>> + ? ? ? ? ? ? ?func_pwrst, pwrdm->name);
>> +
>> + ? ? if (arch_pwrdm && arch_pwrdm->pwrdm_func_to_pwrst) {
>> + ? ? ? ? ? ? ret = arch_pwrdm->pwrdm_func_to_pwrst(pwrdm, func_pwrst);
>> + ? ? }
>> +
>> + ? ? return ret;
>> +}
>> +
>> +/**
>> + * pwrdm_pwrst_to_func - get the functional (i.e. logical) value mapped
>> + * to the internal state
>> + * @pwrdm: struct powerdomain * to query
>> + * @pwrst: internal power state
>> + *
>> + * Convert the internal power state to the power domain functional value.
>> + * Returns the functional power domain state value or -EINVAL in case
>> + * of invalid parameters passed in.
>> + */
>> +int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
>> +{
>> + ? ? int ret = pwrst;
>> +
>> + ? ? if ((!pwrdm)|| (pwrst >= PWRDM_MAX_PWRSTS))
>> + ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? pr_debug("powerdomain: convert %0x pwrst to func for %s\n",
>> + ? ? ? ? ? ? ?pwrst, pwrdm->name);
>> +
>> + ? ? if (arch_pwrdm && arch_pwrdm->pwrdm_pwrst_to_func) {
>> + ? ? ? ? ? ? ret = arch_pwrdm->pwrdm_pwrst_to_func(pwrdm, pwrst);
>> + ? ? }
>> +
>> + ? ? return ret;
>> +}
>> +
>> +/* Types of sleep_switch used in omap_set_pwrdm_state */
>> +#define FORCEWAKEUP_SWITCH ? 0
>> +#define LOWPOWERSTATE_SWITCH 1
>> +
>> +/**
>> + * omap_set_pwrdm_state - program next powerdomain power state
>> + * @pwrdm: struct powerdomain * to set
>> + * @func_pwrst: power domain functional state, one of the PWRDM_FUNC_* macros
>> + *
>> + * This programs the pwrdm next functional state, sets the dependencies
>> + * and waits for the state to be applied.
>> + */
>> +int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
>
> This should presumably get renamed to match the other function names in
> this file, to be something like pwrdm_set_func_pwrst() or something
> similar.
Ok that makes sense.

...

>
>
> - Paul

Thanks,
Jean
