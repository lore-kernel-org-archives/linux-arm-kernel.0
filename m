From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 11 Mar 2015 14:07:11 +0100
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
In-Reply-To: <6286151.8rcX893TN6@wuerfel>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <3439869.6umCuOq6SV@wuerfel>
 <CABxcv=nE_Qd7do+dRyp=fw3wYmWFb+0eEjXYOtdjqE55Cp0zmQ@mail.gmail.com>
 <6286151.8rcX893TN6@wuerfel>
Message-ID: <CABxcv=mPVxW=BqL2PUL=AtS74kcqMG1yxC1WqMpxGiNOqGAnyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Wed, Mar 11, 2015 at 1:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 11 March 2015 12:34:03 Javier Martinez Canillas wrote:
>> Hello Arnd,
>>
>> On Wed, Mar 11, 2015 at 10:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday 11 March 2015 02:00:59 Javier Martinez Canillas wrote:
>> >>
>> >> What do you mean by parsing here? IIUC there isn't a clock driver for
>> >> these clocks and are setup directly in the
>> >> drivers/net/wireless/ti/wl12xx/main.c driver.
>> >>
>> >> So you can't make the WLAN chip dev node a consumer of these clocks by
>> >> adding a phandle to a clock provider and clock specifiers since there
>> >> isn't a provider to be referenced in the DT. Or did I misunderstand?
>> >
>> > As I understand it, the clock signal is provided by an external oscillator,
>>
>> According to [0], it seems the chip can be connected to both external
>> oscillators or internal clocks provided by the chip itself.
>
> I see, that part wasn't clear to me.
>

Yeah, it was not clear to me either before reading Luciano's commit message.

[snip]

>> > If there is no external clock provider for this chip and the clocks
>> > are provided by the device itself, then all we need is a clock-frequency
>> > property in the device node.
>> >
>>
>> Agreed, IIUC Luciano wanted to expose the internal clocks by
>> registering in the common clock framework but if those clocks are not
>> really accessible from outside the wlan chip, then I also think that a
>> device node property should be used instead.
>
> If I understand this right, that measn we can easily distinguish between
> an external XTAL clock and the internal clock by they way they are
> described in the DT: for the internal clock, we just provide a clock-frequency
> property, while the external clock would be referenced through a clocks
> property.
>

That's my understanding as well.

Right now it seems that all boards in mainline with a WiLink6 part are
using internal clocks. So as a first step I think that adding an
optional refclock-frequency and tcxoclock-frequency properties should
be enough.

It would be good if the driver supports getting the refclock and
tcxoclock from an external provider in case a board gets these from
external clocks but that can be done as a followup if there are boards
in the future using that design.

But please bear in mind that I'm not familiar with the clock handling
in WiLink6 since the WiLink8 part used in the IGEP boards does not
need these clocks and I only looked at Luciano's previous patches and
the WiLink today driver today. So it would be good if Eliad can double
check my assumptions to see if those are correct.

Best regards,
Javier
