From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 19 Feb 2013 11:37:03 +0100
Subject: [PATCH] omap2: twl-common: Add default power configuration
In-Reply-To: <CABuKBe+NrMiX0nuEgwnHBqu-DqHST+uGG_Zyc7Ek=4WCOV1T6g@mail.gmail.com>
References: <1358967038-6615-1-git-send-email-matthias.bgg@gmail.com>
 <CAOCHtYjufr+MS1=6Cnsn-EgvkPs+Y5oWejAG98aLkVjdQbu1ZA@mail.gmail.com>
 <20130201224242.GE22517@atomide.com>
 <CABuKBe+NrMiX0nuEgwnHBqu-DqHST+uGG_Zyc7Ek=4WCOV1T6g@mail.gmail.com>
Message-ID: <512355CF.6070605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On 02/15/2013 04:59 PM, Matthias Brugger wrote:
> 2013/2/1 Tony Lindgren <tony@atomide.com>:
>> Hi,
>>
>> * Robert Nelson <robertcnelson@gmail.com> [130124 07:58]:
>>> On Wed, Jan 23, 2013 at 12:50 PM, Matthias Brugger
>>> <matthias.bgg@gmail.com> wrote:
>>>> This patch adds a generic power script configuration.
>>>> When rebooting an OMAP3530 at 125 MHz, the reboot hangs.
>>>> With the generic power script, TWL4030 will be reset
>>>> when a warm reset occures. This way the OMAP3530 does not
>>>> hang on reboot.
>>
>> Both look OK to me. I've added Peter to cc, it's best that he queues
>> all the twl changes.
>>
> 
> Peter any comments on this patch?

The patch looks good to me as well.

> Are you maintaining the whole twl4030 support or just the codec driver?

Right now I'm maintaining the audio support (audio MFD, vibra, ASoC) in twl*
While I have done some cleanup in the twl-core and related drivers recently
and I'm reviewing patches sent for any *twl* driver (if I'm in the CC) I have
not declared myself as Maintainer of the twl stack.
The problem with the twl stack is that the drivers are spread around in
different subsystem so if one takes maintainer responsibility for the stack,
he/she need to have several entries in MAINTAINERS file to cover twl. I still
don't think it is a good idea to 'bloat' the MAINTAINERS file for this.
I'm happy to review patches. About a year ago we had internal discussion
regarding to twl in upstream and Tero Kristo 'volunteered' to review patches
as well.

I still think that the twl patches should be queued via the corresponding
subsystem (OMAP, MFD, Input, GPIO, PWM, etc).

-- 
P?ter

> 
> Best regards,
> Matthias
> 
> 
>> Regards,
>>
>> Tony
>>
>>>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>>> ---
>>>>  arch/arm/mach-omap2/twl-common.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>>  arch/arm/mach-omap2/twl-common.h |  1 +
>>>>  2 files changed, 39 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
>>>> index e49b40b..f096beb 100644
>>>> --- a/arch/arm/mach-omap2/twl-common.c
>>>> +++ b/arch/arm/mach-omap2/twl-common.c
>>>> @@ -120,6 +120,41 @@ static struct twl4030_audio_data omap3_audio_pdata = {
>>>>         .codec = &omap3_codec,
>>>>  };
>>>>
>>>> +static struct twl4030_ins wrst_seq[] __initdata = {
>>>> +       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
>>>> +       {MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
>>>> +       {MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
>>>> +       {MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
>>>> +       {MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
>>>> +       {MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
>>>> +};
>>>> +
>>>> +static struct twl4030_script wrst_script __initdata = {
>>>> +       .script = wrst_seq,
>>>> +       .size   = ARRAY_SIZE(wrst_seq),
>>>> +       .flags  = TWL4030_WRST_SCRIPT,
>>>> +};
>>>> +
>>>> +static struct twl4030_script *omap3_power_scripts[] __initdata = {
>>>> +       &wrst_script,
>>>> +};
>>>> +
>>>> +static struct twl4030_resconfig omap3_rconfig[] = {
>>>> +       { .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
>>>> +               .type2 = -1 },
>>>> +       { .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
>>>> +               .type2 = -1 },
>>>> +       { .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
>>>> +               .type2 = -1 },
>>>> +       { 0, 0},
>>>> +};
>>>> +
>>>> +static struct twl4030_power_data omap3_power_pdata = {
>>>> +       .scripts        = omap3_power_scripts,
>>>> +       .num            = ARRAY_SIZE(omap3_power_scripts),
>>>> +       .resource_config = omap3_rconfig,
>>>> +};
>>>> +
>>>>  static struct regulator_consumer_supply omap3_vdda_dac_supplies[] = {
>>>>         REGULATOR_SUPPLY("vdda_dac", "omapdss_venc"),
>>>>  };
>>>> @@ -224,6 +259,9 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
>>>>         if (pdata_flags & TWL_COMMON_PDATA_AUDIO && !pmic_data->audio)
>>>>                 pmic_data->audio = &omap3_audio_pdata;
>>>>
>>>> +       if (pdata_flags & TWL_COMMON_PDATA_POWER && !pmic_data->power)
>>>> +               pmic_data->power = &omap3_power_pdata;
>>>> +
>>>>         /* Common regulator configurations */
>>>>         if (regulators_flags & TWL_COMMON_REGULATOR_VDAC && !pmic_data->vdac)
>>>>                 pmic_data->vdac = &omap3_vdac_idata;
>>>> diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
>>>> index dcfbad5..dbeb905 100644
>>>> --- a/arch/arm/mach-omap2/twl-common.h
>>>> +++ b/arch/arm/mach-omap2/twl-common.h
>>>> @@ -7,6 +7,7 @@
>>>>  #define TWL_COMMON_PDATA_BCI           (1 << 1)
>>>>  #define TWL_COMMON_PDATA_MADC          (1 << 2)
>>>>  #define TWL_COMMON_PDATA_AUDIO         (1 << 3)
>>>> +#define TWL_COMMON_PDATA_POWER         (1 << 4)
>>>>
>>>>  /* Common LDO regulators for TWL4030/TWL6030 */
>>>>  #define TWL_COMMON_REGULATOR_VDAC      (1 << 0)
>>>> --
>>>> 1.7.11.7
>>>
>>> Thanks for making this generic Matthias..
>>>
>>> Tested-by: Robert Nelson <robertcnelson@gmail.com>
>>>
>>> Tested on Beagle C4 (omap3530) and Beagle xM (DM3730, no regressions)
>>> with this patch to enable it on the Beagle..
>>>
>>> From 65004dafc8d37c69dd839803dc8ea5dcefd993df Mon Sep 17 00:00:00 2001
>>> From: Robert Nelson <robertcnelson@gmail.com>
>>> Date: Thu, 24 Jan 2013 09:43:51 -0600
>>> Subject: [PATCH] ARM: OMAP: Beagle: use TWL4030 generic reset script
>>>
>>> Enable TWL_COMMON_PDATA_POWER such that OMAP3530 revisions of the
>>> Beagle (Bx/Cx) will not hang on reboot when running at 125 Mhz.
>>>
>>> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
>>> ---
>>>  arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
>>> b/arch/arm/mach-omap2/board-omap3beagle.c
>>> index 22c483d..0974e08 100644
>>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>>> @@ -353,7 +353,7 @@ static int __init omap3_beagle_i2c_init(void)
>>>  {
>>>       omap3_pmic_get_config(&beagle_twldata,
>>>                       TWL_COMMON_PDATA_USB | TWL_COMMON_PDATA_MADC |
>>> -                     TWL_COMMON_PDATA_AUDIO,
>>> +                     TWL_COMMON_PDATA_AUDIO | TWL_COMMON_PDATA_POWER,
>>>                       TWL_COMMON_REGULATOR_VDAC | TWL_COMMON_REGULATOR_VPLL2);
>>>
>>>       beagle_twldata.vpll2->constraints.name = "VDVI";
>>> --
>>> 1.7.10.4
>>>
>>> Regards,
>>>
>>> --
>>> Robert Nelson
>>> http://www.rcn-ee.com/
> 
> 
> 
