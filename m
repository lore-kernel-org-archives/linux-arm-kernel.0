From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 11 May 2016 11:31:25 +0800
Subject: [PATCH] pinctrl: rockchip: fix pull setting error for rk3399
In-Reply-To: <CAD=FV=VrE=9=sgqUXBMwmoQin8S+yPbAgnrO1VUgx5QafYWXhA@mail.gmail.com>
References: <1462878896-28956-1-git-send-email-wxt@rock-chips.com>
 <CAD=FV=VrE=9=sgqUXBMwmoQin8S+yPbAgnrO1VUgx5QafYWXhA@mail.gmail.com>
Message-ID: <5732A78D.7040308@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug,

? 2016?05?11? 05:07, Doug Anderson ??:
> Caesar / David,
>
> On Tue, May 10, 2016 at 4:14 AM, Caesar Wang <wxt@rock-chips.com> wrote:
>> From: David Wu <david.wu@rock-chips.com>
>>
>> This patch fixes the pinctrl pull bias setting, since the pull up/down
>> setting is the contrary for gpio0.
> Commit message only mentions gpio0, but gpio2 is also fixed in the
> commit.  Please mention gpio2 in the commit message.

Fix it in next version.

>
>>  From the TRM said, the gpio0 pull polarity setting:
>> gpio0a_p (gpio0 )
>> GPIO0A PE/PS programmation section, every
>> GPIO bit corresponding to 2bits[PS:PE]
>> 2'b00: Z(Noraml operaton);
>> 2'b11: weak 1(pull-up);
>> 2'b01: weak 0(pull-down);
>> 2'b10: Z(Noraml operaton);
> Despite the fact that the typo (Noralm vs. Normal) is present in the
> TRM, maybe we should fix it here?

Yep, ditto.

> <cut>
>
> +
> +               if (ret < 0) {
> +                       dev_err(info->dev, "unknown pull setting %d\n", pull);
> nit: why change the error message?  Old message was "unsupported"
> instead of your new "unknown".  "unsupported" was better IMHO.

Okay, sound resonable.

>
>
>> -       PIN_BANK_DRV_FLAGS(2, 32, "gpio2", DRV_TYPE_IO_1V8_OR_3V0,
>> -                          DRV_TYPE_IO_1V8_OR_3V0,
>> -                          DRV_TYPE_IO_1V8_ONLY,
>> -                          DRV_TYPE_IO_1V8_ONLY
>> -                          ),
>> +       PIN_BANK_DRV_FLAGS_PULL_FLAGS(2, 32, "gpio2", DRV_TYPE_IO_1V8_OR_3V0,
>> +                                     DRV_TYPE_IO_1V8_OR_3V0,
>> +                                     DRV_TYPE_IO_1V8_ONLY,
>> +                                     DRV_TYPE_IO_1V8_ONLY,
>> +                                     PULL_TYPE_IO_DEFAULT,
>> +                                     PULL_TYPE_IO_DEFAULT,
>>
> Are you certain that gpio2 behaves the same way?  The TRM I have says
> this for GPIO2C and GPIO2D:

+                                     PULL_TYPE_IO_1V8_ONLY,
+                                     PULL_TYPE_IO_1V8_ONLY

Yep, so this just set the gpio2c&gpio2d in this function.

>
> 2'b00: pervious-state
> 2'b01: weak 0(pull-down);
> 2'b10: pervious-state
> 2'b11: weak 1(pull-up);
>
> Assuming that "pervious-state" is a simple typo for "previous state"
> that would imply that it was behaving as "bus hold" and _not_ "bias
> disable".

I will say that TRM made the mistake since this is *not* exist.
Okay, fixes by the newer TRM.

>
> Note: if it actually is a "bus hold" state then we'll have to figure
> out how this would work with existing device trees.  I'd imagine that
> they are currently specifying "bias disable" and technically that
> might not be possible?
>
>
>
> -Doug
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
