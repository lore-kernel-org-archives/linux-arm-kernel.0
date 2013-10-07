From: arokux@gmail.com (Arokux X)
Date: Mon, 7 Oct 2013 21:57:50 +0200
Subject: [linux-sunxi] [PATCH 0/4] Add support for the Allwinner A31 Reset
 Controllers
In-Reply-To: <20131007142603.GE3106@lukather>
References: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAPNxggaUW1B8Ea-gSo+XV2P9s4MRa1L25_ZAvOWyLN6VqQ6wsQ@mail.gmail.com>
 <20131006082917.GD3106@lukather>
 <CAPNxggb_dhQWPDkO_7LVyyn5537tDThtBU5SY1oZfZhri0QacQ@mail.gmail.com>
 <20131007142603.GE3106@lukather>
Message-ID: <CAPNxggZX+cXpXL4DZstaNm=68=pc=kLUYYZpERLMO9=i3en5Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We could do that by overriding the default of_xlate function. I'm not
> exactly convinced it makes sense in that case, since bogus data will
> possibly come from the DT, and in that case, you are screwed.

Yes, I agree it makes little sense to override of_xlate function.

>
>> Let me now ask how I should go about my reset bits.
>>
>> So far you were dealing with the registers where all the bits were
>> used for reset bits. In the case of USB clock module (and several
>> others) only several bits are reset bits. So I will proceed to use
>> your new driver like this (here, for the sake of clarity I use names
>> for registers and reset bits)
>>
>> +               usb_rst: reset at USB_CLK_REG {
>> +                       #reset-cells = <1>;
>> +                       compatible = "allwinner,sun4i-a10-usb-reset";
>> +                       reg = <USB_CLK_REG 0x4>;
>> +               };
>>
>> And somewhere in the EHCI/OHCI binding:
>>
>>                  ohci0: .... {
>>                           ...
>> +                       resets = <&usb_rst USB0_RESET_BIT>;
>>                           ...
>>                 }
>>
>>                  ehci0: .... {
>>                           ...
>> +                       resets = <&usb_rst USB0_RESET_BIT>;
>>                           ...
>>                 }
>>
>> If I understand right, here is the problem with this approach. As you
>> see ohci0/ehci0 are sharing the very same bit. So if device_reset is
>> used in both ohci0/ehci0 kernel modules we will have a situation where
>> one kernel module will reset the hardware used by the other kernel
>> module. The problem is that reset bit really belongs to a USB PHY,
>> which is shared between ohci0/ehci0. So as it looks like I would need
>> to add another module that handles USB PHY?
>>
>>                  usb0-phy: {
>>                           resets = <&usb_rst USB0_RESET_BIT>;
>>                  }
>>
>>                  ohci0: .... {
>>                           ...
>> +                       phy = <&usb0-phy>
>>                           ...
>>                 }
>>
>>                  ehci0: .... {
>>                           ...
>> +                       phy = <&usb0-phy>
>>                           ...
>>                 }
>
> Are those ohci and ehci nodes the same IP?
As far as I understand - yes.

> Anyway, it seems like it's the way to go, yes. There's a USB PHY
> framework in review right now: https://lwn.net/Articles/548814/

Thanks a lot for this pointer. This is actually merged already and is
currently in Greg's usb-next tree

https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=ff764963479a1b18721ab96e531404c50fefe8b1

So I'd need to use yet another framework in my miniature glue
driver... it actually only touches a bunch of registers. :)

>> By the way, now you can see the advantages of the semantics that clock
>> framework is offering. If several devices want to disable a clock it
>> will only be disabled if no other devices are using it. Reset
>> framework does not offer this feature.
>
> Good thing we have the code and that we can patch it then.
What do you mean?

> However, it's
> not much of a problem in our case, since both drivers will only want to
> deassert the reset.

It is a problem, since there will be two different modules one for
ohci and the other for ehci. So if you unload ohci for example it will
assert (write 0 to) the reset register. The ehci module will get into
trouble then.

Best regards
