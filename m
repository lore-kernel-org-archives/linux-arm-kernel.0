From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 27 Mar 2011 20:47:49 -0500
Subject: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
In-Reply-To: <AANLkTimj9cATwMiZwdDJSw53Qte5qT78VnhDrE3Sfh7T@mail.gmail.com>
References: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
	<AANLkTimj9cATwMiZwdDJSw53Qte5qT78VnhDrE3Sfh7T@mail.gmail.com>
Message-ID: <AANLkTikuAJS32O-acdGs7qYoVw8btHjKyV8KX-MOXWk4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2011 at 8:30 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Mar 26, 2011 at 2:29 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> If an error occurs in the L3 on any other initiator than MPU,
>> the interrupt goes unhandled given that the 'base' register
>> was calculated with the initialized err_base value (which
>> coincidentally points to MPU) and not with the actual source
>> of the error.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>> ?arch/arm/mach-omap2/omap_l3_smx.c | ? ?5 +++--
>> ?1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
>> index 5f2da75..da917c2 100644
>> --- a/arch/arm/mach-omap2/omap_l3_smx.c
>> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
>> @@ -196,11 +196,12 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
>> ? ? ? ? ? ? ? ?/* No timeout error for debug sources */
>> ? ? ? ?}
>>
>> - ? ? ? base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
>> -
>> ? ? ? ?/* identify the error source */
>> ? ? ? ?for (err_source = 0; !(status & (1 << err_source)); err_source++)
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?;
>> +
>> + ? ? ? base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
>> +
>> ? ? ? ?error = omap3_l3_readll(base, L3_ERROR_LOG);
>
> One extra space too much.

Between base and error assignments? Yep, I can remove it.

Regards,

Omar
