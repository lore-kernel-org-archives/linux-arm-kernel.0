From: ccross@android.com (Colin Cross)
Date: Thu, 7 Jul 2011 18:41:37 -0700
Subject: [PATCH 03/17] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <4E165ECD.9070905@ti.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>
	<4E165ECD.9070905@ti.com>
Message-ID: <CAMbhsRT-Z4AmYmen9B9+mJ+c5YWyVbcsx0mykrn7L_JxgOLVDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 7, 2011 at 6:35 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
>>
>> From: Colin Cross<ccross@android.com>
>>
>> When the cpu is powered down in a low power mode, the gic cpu
>> interface may be reset, and when the cpu complex is powered
>> down, the gic distributor may also be reset.
>>
>> This patch uses CPU_PM_ENTER and CPU_PM_EXIT notifiers to save
>> and restore the gic cpu interface registers, and the
>> CPU_COMPLEX_PM_ENTER and CPU_COMPLEX_PM_EXIT notifiers to save
>> and restore the gic distributor registers.
>>
>> Signed-off-by: Colin Cross<ccross@android.com>
>> ---
>> ?arch/arm/common/gic.c | ?212
>> +++++++++++++++++++++++++++++++++++++++++++++++++
>> ?1 files changed, 212 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>> index 4ddd0a6..8d62e07 100644
>> --- a/arch/arm/common/gic.c
>> +++ b/arch/arm/common/gic.c
>
> [...]
>
>> +
>> +static int gic_notifier(struct notifier_block *self, unsigned long cmd,
>> ? ? ?void *v)
>> +{
>> + ? ? ? int i;
>> +
>> + ? ? ? for (i = 0; i< ?MAX_GIC_NR; i++) {
>> + ? ? ? ? ? ? ? switch (cmd) {
>> + ? ? ? ? ? ? ? case CPU_PM_ENTER:
>> + ? ? ? ? ? ? ? ? ? ? ? gic_cpu_save(i);
>> + ? ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? ? case CPU_PM_ENTER_FAILED:
>> + ? ? ? ? ? ? ? case CPU_PM_EXIT:
>> + ? ? ? ? ? ? ? ? ? ? ? gic_cpu_restore(i);
>> + ? ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? ? case CPU_COMPLEX_PM_ENTER:
>> + ? ? ? ? ? ? ? ? ? ? ? gic_dist_save(i);
>> + ? ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? ? case CPU_COMPLEX_PM_ENTER_FAILED:
>> + ? ? ? ? ? ? ? case CPU_COMPLEX_PM_EXIT:
>> + ? ? ? ? ? ? ? ? ? ? ? gic_dist_restore(i);
>> + ? ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? ? }
>> + ? ? ? }
>> +
>> + ? ? ? return NOTIFY_OK;
>> +}
>
> Just to put forth OMAP requirements for GIC and see how much
> we can leverage these for OMAP.
>
> OMAP support GP(general) and HS(secure) devices and implements
> the trustzone on these devices. on Secure devices the GIC save
> and restore is completely done by secure ROM code. There are
> API's for save and restore is automatic on CPU reset based
> on the last CPU cluster state.
>
> On GP devices too, very few GIC registers needs to be saved
> in a pre-defined memory/register layout and restore is again
> done by boot-ROM code.
>
> OMAP need to enable/disable distributor and CPU interfaces
> based on CPU power states and that is something can be useful.
> Would be good if there is a provision to over-write the gic
> save/restore function using function pointers so that OMAP
> PM code can use the notifiers.
>
> Any more thoughts how we can handle this? We would like to
> use common ARM code as much as possible.

Is it strictly necessary to use the custom OMAP save and restore?
Anything that was modified by the kernel is obviously writable, and
could be saved and restored using the common code.  Anything that can
only be modified by TrustZone already has to be restored by the custom
OMAP code.  There aren't many registers in the GIC, so it shouldn't be
much of a performance difference.
