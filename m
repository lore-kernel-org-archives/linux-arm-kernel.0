From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 07 Jul 2011 19:07:09 -0700
Subject: [PATCH 03/17] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <CAMbhsRT-Z4AmYmen9B9+mJ+c5YWyVbcsx0mykrn7L_JxgOLVDg@mail.gmail.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>	<1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>	<4E165ECD.9070905@ti.com>
	<CAMbhsRT-Z4AmYmen9B9+mJ+c5YWyVbcsx0mykrn7L_JxgOLVDg@mail.gmail.com>
Message-ID: <4E16664D.7010206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/7/2011 6:41 PM, Colin Cross wrote:
> On Thu, Jul 7, 2011 at 6:35 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
>>>
>>> From: Colin Cross<ccross@android.com>
>>>
>>> When the cpu is powered down in a low power mode, the gic cpu
>>> interface may be reset, and when the cpu complex is powered
>>> down, the gic distributor may also be reset.
>>>
>>> This patch uses CPU_PM_ENTER and CPU_PM_EXIT notifiers to save
>>> and restore the gic cpu interface registers, and the
>>> CPU_COMPLEX_PM_ENTER and CPU_COMPLEX_PM_EXIT notifiers to save
>>> and restore the gic distributor registers.
>>>
>>> Signed-off-by: Colin Cross<ccross@android.com>
>>> ---
>>>   arch/arm/common/gic.c |  212
>>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 files changed, 212 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>>> index 4ddd0a6..8d62e07 100644
>>> --- a/arch/arm/common/gic.c
>>> +++ b/arch/arm/common/gic.c
>>
>> [...]
>>
>>> +
>>> +static int gic_notifier(struct notifier_block *self, unsigned long cmd,
>>>       void *v)
>>> +{
>>> +       int i;
>>> +
>>> +       for (i = 0; i<    MAX_GIC_NR; i++) {
>>> +               switch (cmd) {
>>> +               case CPU_PM_ENTER:
>>> +                       gic_cpu_save(i);
>>> +                       break;
>>> +               case CPU_PM_ENTER_FAILED:
>>> +               case CPU_PM_EXIT:
>>> +                       gic_cpu_restore(i);
>>> +                       break;
>>> +               case CPU_COMPLEX_PM_ENTER:
>>> +                       gic_dist_save(i);
>>> +                       break;
>>> +               case CPU_COMPLEX_PM_ENTER_FAILED:
>>> +               case CPU_COMPLEX_PM_EXIT:
>>> +                       gic_dist_restore(i);
>>> +                       break;
>>> +               }
>>> +       }
>>> +
>>> +       return NOTIFY_OK;
>>> +}
>>
>> Just to put forth OMAP requirements for GIC and see how much
>> we can leverage these for OMAP.
>>
>> OMAP support GP(general) and HS(secure) devices and implements
>> the trustzone on these devices. on Secure devices the GIC save
>> and restore is completely done by secure ROM code. There are
>> API's for save and restore is automatic on CPU reset based
>> on the last CPU cluster state.
>>
>> On GP devices too, very few GIC registers needs to be saved
>> in a pre-defined memory/register layout and restore is again
>> done by boot-ROM code.
>>
>> OMAP need to enable/disable distributor and CPU interfaces
>> based on CPU power states and that is something can be useful.
>> Would be good if there is a provision to over-write the gic
>> save/restore function using function pointers so that OMAP
>> PM code can use the notifiers.
>>
>> Any more thoughts how we can handle this? We would like to
>> use common ARM code as much as possible.
>
> Is it strictly necessary to use the custom OMAP save and restore?
Yes. On secure devices there is no choice.

> Anything that was modified by the kernel is obviously writable, and
> could be saved and restored using the common code.  Anything that can
> only be modified by TrustZone already has to be restored by the custom
> OMAP code.  There aren't many registers in the GIC, so it shouldn't be
> much of a performance difference.
In that case we will end up doing things two time un-necessary and 
that's not useful at all. You need to save all those extra cycles
to have less latency on C-states. And otherside you can't skip the
secure API save otherwise the boot-ROM code will end up re-initializing
the GIC and all secure interrupt state will be lost.

 From above code, today we use need dist/cpu interface disable/enable
functions.

Regards
Santosh

Regards
Santosh
