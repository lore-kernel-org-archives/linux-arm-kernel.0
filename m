From: baolin.wang@linaro.org (Baolin Wang)
Date: Wed, 21 Dec 2016 15:57:07 +0800
Subject: [PATCH 3/3] phy: rockchip-inno-usb2: Set EXTCON_USB when
 EXTCON_CHG_USB_SDP was set
In-Reply-To: <585A2F61.20403@samsung.com>
References: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482300213.git.baolin.wang@linaro.org>
 <CGME20161221061515epcas3p457a1cc4c0961f75d82118e7327af21f6@epcas3p4.samsung.com>
 <767c3dfccde4807e3645951d4aeebca0ab5cc5e4.1482300213.git.baolin.wang@linaro.org>
 <585A2F61.20403@samsung.com>
Message-ID: <CAMz4kuJxsoPiWGPMU85wNfGeeKq0Vm7Bz7H5yFc9Ls0Ai7+Z7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21 December 2016 at 15:29, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Hi,
>
> On 2016? 12? 21? 15:10, Baolin Wang wrote:
>> According to the documentation, we should set the EXTCON_USB when
>> one SDP charger connector was reported.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/phy/phy-rockchip-inno-usb2.c |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
>> index 2f99ec9..71fbe0f 100644
>> --- a/drivers/phy/phy-rockchip-inno-usb2.c
>> +++ b/drivers/phy/phy-rockchip-inno-usb2.c
>> @@ -595,9 +595,14 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
>>               if (rport->vbus_attached != vbus_attach) {
>>                       rport->vbus_attached = vbus_attach;
>>
>> -                     if (notify_charger && rphy->edev)
>> +                     if (notify_charger && rphy->edev) {
>>                               extcon_set_cable_state_(rphy->edev,
>>                                                       cable, vbus_attach);
>> +                             if (cable == EXTCON_CHG_USB_SDP)
>> +                                     extcon_set_cable_state_(rphy->edev,
>> +                                                             EXTCON_USB,
>> +                                                             vbus_attach);
>> +                     }
>>               }
>>               break;
>>       case OTG_STATE_B_PERIPHERAL:
>>
>
> Looks good to me. But I prefer to use the 'extcon_set_state_sync' intead of extcon_set_cable_state_().
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> I sent the patches[1] for extcon API to alter the deprecated API.
> If you possible, I'd like you to alter the extcon API instead of deprecated API.

Okay, I will change to extcon_set_state_sync() in next version patch. Thanks.

> [1] https://patchwork.kernel.org/patch/9453645/
> - extcon_set_cable_state_() -> extcon_set_state_sync()
> - extcon_get_cable_state_() -> extcon_get_state()
> - Use devm_extcon_register_notifier() instead of extcon_register_notifier().
>
> --
> Regards,
> Chanwoo Choi



-- 
Baolin.wang
Best Regards
