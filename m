From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 11 May 2015 16:26:58 +0800
Subject: [PATCH 1/2] ARM: dts: sun9i: cubieboard4: Enable USB support
In-Reply-To: <20150508114040.GR11057@lukather>
References: <1431017037-28331-1-git-send-email-wens@csie.org>
 <1431017037-28331-2-git-send-email-wens@csie.org>
 <20150508074616.GP11057@lukather>
 <CAGb2v64VQpNkd2zmHdhTXQEfk8z1FnhYZMQW0vmLVq1Ahzg2Zw@mail.gmail.com>
 <20150508114040.GR11057@lukather>
Message-ID: <CAGb2v64eKcn6-J+Dae-YOtaZ3kdiT7=JMvnRJfBafXpEDLsYLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 8, 2015 at 7:40 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, May 08, 2015 at 04:01:14PM +0800, Chen-Yu Tsai wrote:
>> >> +&ehci0 {
>> >> +     status = "okay";
>> >> +};
>> >> +
>> >> +&ehci2 {
>> >> +     status = "okay";
>> >> +};
>> >> +
>> >> +/* usb1 is connected to a GL850G USB hub chip, so no need to enable OHCI */
>> >
>> > You're mentionning usb1, but I don't see it enabled anywhere, is that
>> > a typo?
>>
>> usb1 (or usbphy1) == ehci/ohci0. usb0 is otg.
>>
>> This numbering matches the fex files, and (mostly) matches the
>> specs.
>
> Ok, having this comment between ehci2 and ohci2 is confusing then :)
>
> It's not the first board that has a hub, we usually don't really care
> as it's kind of obvious. Maybe we can just remove it?

Why not. :)

>> >>  &mmc0 {
>> >> @@ -92,8 +130,30 @@
>> >>       status = "okay";
>> >>  };
>> >>
>> >> +&reg_usb1_vbus {
>> >> +     pinctrl-0 = <&usb1_vbus_pin_cubieboard4>;
>> >> +     gpio = <&pio 7 14 GPIO_ACTIVE_HIGH>; /* PH14 */
>> >> +     status = "okay";
>> >> +};
>> >> +
>> >>  &uart0 {
>> >>       pinctrl-names = "default";
>> >>       pinctrl-0 = <&uart0_pins_a>;
>> >>       status = "okay";
>> >>  };
>> >> +
>> >> +&usbphy1 {
>> >> +     phy-supply = <&reg_usb1_vbus>;
>> >> +     status = "okay";
>> >> +};
>> >> +
>> >> +/*
>> >> + * Unfortunately reg_usb1_vbus also powers one of the ports from usb3's hub.
>> >> + * One should always make sure both regulators are enabled and working for
>> >> + * all USB ports to have power.
>> >> + */
>> >
>> > Can't we just provide the two regulators, and enable both of them so
>> > that we know that we always have the needed regulators enabled,
>> > disregarding which USB port is used?
>>
>> Would setting "always-on" for both regulators work for you?
>> Or maybe just the one that's used by both USB hosts?
>
> I was more thinking of giving to the phy an additional regulator, so
> that it would enable both the regulators needed to power up all ports.

That would require adding back all the regulator-related code I
removed from the phy driver before it was merged. (sigh) It's not
like the regulator bindings takes a list.

I see this as more of a hardware design flaw, and we should label
it as such. And it might still work for self-powered devices even
if VBUS is off. The USB hub chip is always on.


ChenYu
