From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 21 Dec 2015 16:44:10 +0800
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <56749B58.4040306@maciej.szmigiero.name>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
 <CAOMZO5CfBKuJ584jwbg98s9tn+0Z7W0nOaZnUkm4cJUSvNGTZw@mail.gmail.com>
 <20151215062821.GA11241@shlinux2>
 <CAOMZO5DiRzfy5dULh0C7qU2KUM-i8fBh6W5rS9zOTHJJK6fqwg@mail.gmail.com>
 <20151216041058.GC23482@shlinux2>
 <CAOMZO5An3CK-a3NQtOF3nnPc8vzu2+SKnfJ=iOuAhjCBvZwToQ@mail.gmail.com>
 <5671C40F.3000000@maciej.szmigiero.name> <20151217065756.GB3793@shlinux2>
 <56749B58.4040306@maciej.szmigiero.name>
Message-ID: <CAL411-o5nEcjKA+AePX7ka+i5Mn62FeY3ZU9NLr4XdJpNTyQmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 7:48 AM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> On 17.12.2015 07:57, Peter Chen wrote:
>> On Wed, Dec 16, 2015 at 09:05:35PM +0100, Maciej S. Szmigiero wrote:
>>> Hi Fabio,
>>> Hi Peter,
>>>
>>> On 16.12.2015 11:11, Fabio Estevam wrote:
>>>> Hi Peter,
>>>>
>>>> On Wed, Dec 16, 2015 at 2:11 AM, Peter Chen <peter.chen@freescale.com> wrote:
>>>>
>>>>> Thanks, Fabio, but I am curious how things like that? The USBOH3 clock
>>>>> is not opened, the usb driver will hang when it tries to access
>>>>> registers. If this clock is always on, then, why the system will
>>>>> hang later?
>>>>
>>>> I found the issue with your patch. You missed to add the pinctrl node.
>>>>
>>>> With the change below USB is functional in Udoo:
>>>>
>>>> --- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
>>>> +++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
>>>> @@ -22,6 +22,8 @@
>>>>
>>>>         usb_hub1 {
>>>>                 compatible = "generic-onboard-hub";
>>>> +               pinctrl-names = "default";
>>>> +               pinctrl-0 = <&pinctrl_usbh>;
>>>>                 clocks = <&clks IMX6QDL_CLK_CKO>;
>>>>                 reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
>>>>                 reset-duration-us = <2>;
>>>>
>>>
>>> Thanks for your work, I didn't notice it previously (sorry).
>>>
>>> I can confirm, too that with Peter's patches and the above change
>>> the USB support works again on my UDOO DualLite board.
>>>
>>> However, I noticed that when you have host USB support configured to be
>>> build as modules then (due to its location under "if USB") it is only
>>> possible to compile generic onboard USB HUB as module, too.
>>>
>>> Then this module would need to be loaded before loading USB support
>>> (or quickly after it), otherwise USB enumeration would time out after
>>> few secs and loading it later wouldn't help.
>>
>> Thanks for testing it, it maybe this hardware limitation.
>> The USB device should be back to work whenever do hardware reset,
>> otherwise, this reset is not clean.
>
> I looked deeper into it and looks like the reset GPIO have to be
> explicitly configured as output and also the reset pulse duration
> have to be longer in order for hub the successfully reset and reattach
> to USB host (at least on the one UDOO board that I have).
>
> The shortest working time seems to be 3000us - 2000us didn't work even
> when I changed GPIO pin mode to fast and drive strength to maximum.
>
> Summing up, this change allows me to load generic_onboard_hub driver
> in any order with respect to USB host modules:
> --- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> @@ -26,7 +26,7 @@
>                 pinctrl-0 = <&pinctrl_usbh>;
>                 clocks = <&clks IMX6QDL_CLK_CKO>;
>                 reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
> -               reset-duration-us = <2>;
> +               reset-duration-us = <3000>;
>         };
>  };
>
> --- a/drivers/usb/misc/generic_onboard_hub.c
> +++ b/drivers/usb/misc/generic_onboard_hub.c
> @@ -89,7 +89,7 @@ static int usb_hub_generic_probe(struct platform_device *pdev)
>         of_property_read_u32(node, "reset-duration-us", &duration_us);
>
>         if (gpiod_reset) {
> -               gpiod_set_value(gpiod_reset, 1);
> +               gpiod_direction_output(gpiod_reset, 1);
>                 usleep_range(duration_us, duration_us + 10);
>                 gpiod_set_value(gpiod_reset, 0);
>         }
>
>
> Best regards,
> Maciej Szmigiero
>
> --

Thanks, I will change the duration next time, and at my RFC version
(you are CCed), I have already
fixed problem that without setting output.


-- 
BR,
Peter Chen
