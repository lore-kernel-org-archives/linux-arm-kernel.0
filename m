From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 16 Jan 2014 11:33:17 +0100
Subject: [linux-sunxi] Re: [PATCH] ARM: sunxi: Add driver for sunxi usb phy
In-Reply-To: <CAGb2v65rSc7iAKCcPMYaQZ+q=m85RcSE2dmpgE6MoeXNgRCwfg@mail.gmail.com>
References: <1389740305-6993-1-git-send-email-hdegoede@redhat.com>
 <52D6A27A.4090600@ti.com> <52D6ADEA.1050900@redhat.com>
 <CAGb2v65rSc7iAKCcPMYaQZ+q=m85RcSE2dmpgE6MoeXNgRCwfg@mail.gmail.com>
Message-ID: <52D7B56D.8060403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/16/2014 08:07 AM, Chen-Yu Tsai wrote:
> Hi Hans,
>
> On Wed, Jan 15, 2014 at 11:48 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 01/15/2014 04:00 PM, Kishon Vijay Abraham I wrote:
>>>
>>> On Wednesday 15 January 2014 04:28 AM, Hans de Goede wrote:
> [...]
>>>> +static int sun4i_usb_phy_init(struct phy *_phy)
>>>> +{
>>>> +       struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
>>>> +       struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
>>>> +       int ret;
>>>> +
>>>> +       ret = clk_prepare_enable(data->clk);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       ret = reset_control_deassert(phy->reset);
>>>> +       if (ret) {
>>>> +               clk_disable_unprepare(data->clk);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       /* Adjust PHY's magnitude and rate */
>>>> +       sun4i_usb_phy_write(phy, 0x20, 0x14, 5);
>>>
>>>
>>> No magic values. Use macros instead.
>>
>>
>> We don't have docs, these values come from the Android code (and the comment
>> above has been translated from Chinese). I can make up some random
>> macros for this, but seems counter-productive, it seems best to just leave
>> this as magic until the day we actually have documentation and thus can use
>> defines with the proper register names, etc.
>
> We have some names for the registers from Allwinner code:
> https://github.com/linux-sunxi/linux-sunxi/blob/lichee-3.0.8-sun4i/drivers/usb/sun4i_usb/usbc/usbc_phy.c#L39

Ah good catch, thanks. I'll use those in the next revision of the phy driver.

Regards,

Hans
