From: baolin.wang@linaro.org (Baolin Wang)
Date: Wed, 21 Dec 2016 15:55:02 +0800
Subject: [PATCH 2/3] extcon: axp288: Set EXTCON_USB when
 EXTCON_CHG_USB_SDP was set
In-Reply-To: <585A2DBB.8070504@samsung.com>
References: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482300213.git.baolin.wang@linaro.org>
 <CGME20161221061312epcas5p182c45848e940dc20134ac55091dd8341@epcas5p1.samsung.com>
 <11fb7adc2982a9134faee9abb1de4dcfb253f2d2.1482300213.git.baolin.wang@linaro.org>
 <585A2DBB.8070504@samsung.com>
Message-ID: <CAMz4ku+YwjBX4ypwrbv=SnhUkHefa2fd4yjExo7qiv6MqqbUOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21 December 2016 at 15:22, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Hi,
>
> On 2016? 12? 21? 15:10, Baolin Wang wrote:
>> According to the documentation, we should set the EXTCON_USB when
>> one SDP charger connector was reported.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/extcon/extcon-axp288.c |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
>> index 42f41e8..4490726 100644
>> --- a/drivers/extcon/extcon-axp288.c
>> +++ b/drivers/extcon/extcon-axp288.c
>> @@ -102,6 +102,7 @@ enum axp288_extcon_irq {
>>  };
>>
>>  static const unsigned int axp288_extcon_cables[] = {
>> +     EXTCON_USB,
>>       EXTCON_CHG_USB_SDP,
>>       EXTCON_CHG_USB_CDP,
>>       EXTCON_CHG_USB_DCP,
>> @@ -225,8 +226,12 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>>                       vbus_attach ? USB_EVENT_VBUS : USB_EVENT_NONE, NULL);
>>       }
>>
>> -     if (notify_charger)
>> +     if (notify_charger) {
>>               extcon_set_state_sync(info->edev, cable, vbus_attach);
>> +             if (cable == EXTCON_CHG_USB_SDP)
>> +                     extcon_set_state_sync(info->edev, EXTCON_USB,
>> +                                           vbus_attach);
>> +     }
>>
>>       /* Clear the flags on disconnect event */
>>       if (!vbus_attach)
>>
>
> The extcon-axp288.c driver has some patches on extcon-next[1] branch.
> [1] https://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-next
>
> I rework your patch on extcon-next branch as following:
> If you ok, I'll merge it for v4.11.

It is okay for me. Thanks.

>
> commit 1a96f92bdfab86d0b634e56092f543cad348fd0b
> Refs: extcon-next, extcon-next-for-4.10-15-g1a96f92bdfab
> Author:     Baolin Wang <baolin.wang@linaro.org>
> AuthorDate: Wed Dec 21 15:51:26 2016 +0900
> Commit:     Chanwoo Choi <cw00.choi@samsung.com>
> CommitDate: Wed Dec 21 15:52:00 2016 +0900
>
>     extcon: axp288: Set EXTCON_USB when EXTCON_CHG_USB_SDP was set
>
>     According to the documentation, we should set the EXTCON_USB when
>     one SDP charger connector was reported.
>
>     Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>     Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/extcon/extcon-axp288.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 3e145e2a4860..f4fd03e58e37 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -96,6 +96,7 @@ enum axp288_extcon_irq {
>         EXTCON_CHG_USB_SDP,
>         EXTCON_CHG_USB_CDP,
>         EXTCON_CHG_USB_DCP,
> +       EXTCON_USB,
>         EXTCON_NONE,
>  };
>
> @@ -206,8 +207,15 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
>                                         : EXTCON_GPIO_MUX_SEL_PMIC);
>
>         extcon_set_state_sync(info->edev, info->previous_cable, false);
> +       if (info->previous_cable == EXTCON_CHG_USB_SDP)
> +               extcon_set_state_sync(info->edev, EXTCON_USB, false);
> +
>         if (vbus_attach) {
>                 extcon_set_state_sync(info->edev, cable, vbus_attach);
> +               if (cable == EXTCON_CHG_USB_SDP)
> +                       extcon_set_state_sync(info->edev, EXTCON_USB,
> +                                               vbus_attach);
> +
>                 info->previous_cable = cable;
>         }
>
> --
> Regards,
> Chanwoo Choi



-- 
Baolin.wang
Best Regards
