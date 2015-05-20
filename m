From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 20 May 2015 18:17:34 +0200
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <13641152.Yt4ZI3oT6L@wuerfel>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <2282066.NWoIT9ZyLc@wuerfel>
 <CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>
 <13641152.Yt4ZI3oT6L@wuerfel>
Message-ID: <CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Philipp,

2015-05-13 21:11 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> Ideally the binding should follow closely what is documented
> in the data sheet.
>

Daniel and myself would like your opinion about this binding:

rcc: rcc at 40023800 {
    #reset-cells = <1>;
    #clock-cells = <2>;
    compatible = "st,stm32-rcc";
    reg = <0x40023800 0x10>, <0x40023810 0x20>, <0x40023830 0x20>;
    reg-names = "clock-cfg", "reset", "clock-gates";
};

It would solve a problem Daniel is facing due to conflicting mem
region when clock and reset drivers are enabled, as both would reserve
the same region.

Also, it would make the reset driver very generic.
Doing that, we could even create a generic-reset.c driver that would
be used by STM32 and Sunxi (at least).
In the probe function, it would check the number of reg resources.
If a single resource is passed, it would take it, else it would look
the one named "reset".
The driver and bindings would be the same for the two families, and
the bindings would be backward compatible with sunxi ones.

Philip, Arnd, what do you think?

Kind regards,
Maxime
