From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 21 May 2015 22:10:35 +0200
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <20150521185122.GD8557@lukather>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <2282066.NWoIT9ZyLc@wuerfel>
 <CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>
 <13641152.Yt4ZI3oT6L@wuerfel>
 <CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>
 <20150521185122.GD8557@lukather>
Message-ID: <CALszF6BuvTf86k6S5UEYZs-DJSTehy=+Csb3c6jxMU90MN05zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-21 20:51 GMT+02:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> On Wed, May 20, 2015 at 06:17:34PM +0200, Maxime Coquelin wrote:
>> Hi Arnd, Philipp,
>>
>> 2015-05-13 21:11 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> > Ideally the binding should follow closely what is documented
>> > in the data sheet.
>> >
>>
>> Daniel and myself would like your opinion about this binding:
>>
>> rcc: rcc at 40023800 {
>>     #reset-cells = <1>;
>>     #clock-cells = <2>;
>>     compatible = "st,stm32-rcc";
>>     reg = <0x40023800 0x10>, <0x40023810 0x20>, <0x40023830 0x20>;
>>     reg-names = "clock-cfg", "reset", "clock-gates";
>> };
>>
>> It would solve a problem Daniel is facing due to conflicting mem
>> region when clock and reset drivers are enabled, as both would reserve
>> the same region.
>>
>> Also, it would make the reset driver very generic.
>> Doing that, we could even create a generic-reset.c driver that would
>> be used by STM32 and Sunxi (at least).
>> In the probe function, it would check the number of reg resources.
>> If a single resource is passed, it would take it, else it would look
>> the one named "reset".
>> The driver and bindings would be the same for the two families, and
>> the bindings would be backward compatible with sunxi ones.
>>
>> Philip, Arnd, what do you think?
>
> I lack a bit of context here, but I'd be very happy to use a generic
> driver. As a matter of fact, the sunxi reset driver is already pretty
> much there (not that it's very difficult to do).

Ok, good. The two drivers are almost the same, so squashing to a
generic one would be trivial.

>
> The only thing we did that stands out a bit is that we actually need
> the reset driver much earlier than the default probe, since some of
> our timers are maintained in reset. We have some code to do just that
> already, we just need have something similar to be on board.

We have the same problem on stm32, as just discussed with Andreas [0].
I decided to patch the bootloader to deassert timers reset, after
discussions with Rob Herring and Arnd.

Moving to a common driver, stm32 could use the same early init method
to initiliaze reset before timers.

Regards,
Maxime

[0]: http://marc.info/?l=linux-arm-kernel&m=143223846802405&w=2#0
