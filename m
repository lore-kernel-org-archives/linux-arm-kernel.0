From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 06 Dec 2010 20:48:08 +0300
Subject: [PATCH v9 6/6] davinci: USB1.1 support for Omapl138-Hawkboard
In-Reply-To: <AANLkTikO9zvyFT7-LDc+kq9ZD0AH=U_WiP6rnHZyLmZF@mail.gmail.com>
References: <1291231949-23835-1-git-send-email-vm.rod25@gmail.com>	<1291231949-23835-7-git-send-email-vm.rod25@gmail.com>	<B85A65D85D7EB246BE421B3FB0FBB5930247AFDD7E@dbde02.ent.ti.com>	<AANLkTinMGvRS4N2rSRp43Osnn_Df=JRAJB0iBdZLzrZ-@mail.gmail.com>	<B85A65D85D7EB246BE421B3FB0FBB5930247B9A907@dbde02.ent.ti.com>	<AANLkTinwj27dSdv9Djs9Fv6QN5vv5JY+br4xCHk=8YEu@mail.gmail.com>	<B85A65D85D7EB246BE421B3FB0FBB5930247C46537@dbde02.ent.ti.com>	<4CFCCC56.3010700@mvista.com>	<AANLkTikZiHTZV2PD8jKMZ+9h8XnUGPpAth2wSXM4oZmJ@mail.gmail.com>	<AANLkTinqSzcnSSAaCE+uNp5iHubFLpabgWty+zzWwHg4@mail.gmail.com>
	<AANLkTikO9zvyFT7-LDc+kq9ZD0AH=U_WiP6rnHZyLmZF@mail.gmail.com>
Message-ID: <4CFD21D8.3040402@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Victor Rodriguez wrote:

>>>>>>  arch/arm/mach-davinci/board-omapl138-hawk.c |   38
>>>>>> ++++++++++++++++++++------
>>>>>>  1 files changed, 29 insertions(+), 9 deletions(-)
>>>>>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
>>>>>> b/arch/arm/mach-davinci/board-omapl138-hawk.c
>>>>>> index da51136..8fc78f2 100644
>>>>>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>>>>>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>>>> [...]
>>>>>> @@ -165,13 +165,23 @@ static __init void omapl138_hawk_mmc_init(void)
>>>>>>       if (ret<  0) {
>>>>>>               pr_warning("%s: can not open GPIO %d\n",
>>>>>>                       __func__, DA850_HAWK_MMCSD_WP_PIN);
>>>>>> -             return;
>>>>>> +             goto exp_setup_wp_fail;
>>>>>>       }
>>>>>>
>>>>>>       ret = da8xx_register_mmcsd0(&da850_mmc_config);
>>>>>> -     if (ret)
>>>>>> +     if (ret) {
>>>>>>               pr_warning("%s: MMC/SD0 registration failed: %d\n",
>>>>>>                       __func__, ret);
>>>>>> +             goto exp_setup_mmcsd_fail;
>>>>>> +     }
>>>>>> +             return;

>>>>> This return has extra indentation.

>>>>>> +
>>>>>> +exp_setup_mmcsd_fail:
>>>>>> +     gpio_free(DA850_HAWK_MMCSD_WP_PIN);
>>>>>> +exp_setup_wp_fail:
>>>>>> +     gpio_free(DA850_HAWK_MMCSD_CD_PIN);
>>>>>> +exp_setup_cd_fail:
>>>>>> +             return;

>>>>> This one too.

>>>>   Moreover, it's not needed at all.

>>> Ok

    ... except you can't probably put a label next to }.

>>>>> Other than that, it all looks good to me.

>>>>   Except those 'exp_setup_'prefixes which I'm not sure where are coming
>>>> from...

>>> it comes from

>>> arch/arm/mach-davinci/board-da850-evm.c

>>> I took this as a template and I think that is better to keep this
>>> exp_setup_  as a template

>>> but if you have any other suggestion please tell me

>> I think those are based on the error handling in
>> da850_evm_ui_expander_setup() which means that the 'exp' in
>> 'exp_setup_' stands-for IO-expander.

>> Based on the function names where the your exp_setup_* labels were
>> introduced I think that the label could be renamed 'mmc_setup_*' and
>> 'usb11_setup_*'.

> I like it thanks I will submit the patches with that names. Sergei are
> you ok with this ?

    I'm not sure the prefixes are necessary at all, but won't have objection to 
those ones...

> Regards

> Victor Rodriguez

WBR, Sergei
