From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 12 May 2015 23:49:05 +0800
Subject: [PATCH 1/2] ARM: dts: sun9i: cubieboard4: Enable USB support
In-Reply-To: <20150512145717.GN10961@lukather>
References: <1431017037-28331-1-git-send-email-wens@csie.org>
 <1431017037-28331-2-git-send-email-wens@csie.org>
 <20150508074616.GP11057@lukather>
 <CAGb2v64VQpNkd2zmHdhTXQEfk8z1FnhYZMQW0vmLVq1Ahzg2Zw@mail.gmail.com>
 <20150508114040.GR11057@lukather>
 <CAGb2v64eKcn6-J+Dae-YOtaZ3kdiT7=JMvnRJfBafXpEDLsYLg@mail.gmail.com>
 <20150512145717.GN10961@lukather>
Message-ID: <CAGb2v67_-m29AEg=1JKsuumqQYgJTcUMZYOmq6ucKdarbdiGjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 10:57 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, May 11, 2015 at 04:26:58PM +0800, Chen-Yu Tsai wrote:
>> >> >> +&usbphy1 {
>> >> >> +     phy-supply = <&reg_usb1_vbus>;
>> >> >> +     status = "okay";
>> >> >> +};
>> >> >> +
>> >> >> +/*
>> >> >> + * Unfortunately reg_usb1_vbus also powers one of the ports from usb3's hub.
>> >> >> + * One should always make sure both regulators are enabled and working for
>> >> >> + * all USB ports to have power.
>> >> >> + */
>> >> >
>> >> > Can't we just provide the two regulators, and enable both of them so
>> >> > that we know that we always have the needed regulators enabled,
>> >> > disregarding which USB port is used?
>> >>
>> >> Would setting "always-on" for both regulators work for you?
>> >> Or maybe just the one that's used by both USB hosts?
>> >
>> > I was more thinking of giving to the phy an additional regulator, so
>> > that it would enable both the regulators needed to power up all ports.
>>
>> That would require adding back all the regulator-related code I
>> removed from the phy driver before it was merged. (sigh) It's not
>> like the regulator bindings takes a list.
>
> Yeah, but maybe we can just add an optional device-supply property or
> something like that to power up the devices connected on the bus.

(CC-ed Kishon)
Do we think this generic enough to go into the generic phy core?

>> I see this as more of a hardware design flaw, and we should label
>> it as such.
>
> This can be seen as one, and we can debate it for some time I guess,
> but if the hardware guys were not making crazy stuff like that, we
> would run out of work pretty quickly :)

Ah yes, but the users would be happier. :)

> What we really need to do is find a proper and reliable way to handle
> this case. Whether we declare it as a flaw or not is a separate
> debate.
>
>> And it might still work for self-powered devices even if VBUS is
>> off. The USB hub chip is always on.
>
> That still leaves a significant amount of devices out and non
> functional, especially very standard devices like USB keys, keyboards
> or headsets that you would expect to just work.

I agree. So the question is where should this go in.

ChenYu
