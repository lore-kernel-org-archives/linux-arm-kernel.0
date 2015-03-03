From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 3 Mar 2015 10:37:52 +0100
Subject: [PATCH] [RFC] ARM: shmobile: R-Car Gen2: Add da9063/da9210
 regulator quirk
In-Reply-To: <20150302224415.GB25163@verge.net.au>
References: <1425317323-5898-1-git-send-email-geert+renesas@glider.be>
 <20150302183246.GA25839@katana>
 <CAMuHMdUa6H_GYf9p8OS+ne3YvLWzi=CNi44NGmjaWjQ080B7Yw@mail.gmail.com>
 <20150302224415.GB25163@verge.net.au>
Message-ID: <CAMuHMdUhk+5_1SghtmP=Gb_Qr+Ojgd93Ke0jLSJBk6yvWgA1ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Mar 2, 2015 at 11:44 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Mar 02, 2015 at 09:49:11PM +0100, Geert Uytterhoeven wrote:
>> On Mon, Mar 2, 2015 at 7:32 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > On Mon, Mar 02, 2015 at 06:28:43PM +0100, Geert Uytterhoeven wrote:
>> >> The r8a7791/koelsch development board has da9063 and da9210 regulators.
>> >> Both regulators have their interrupt request lines tied to the same
>> >> interrupt pin (IRQ2) on the SoC.
>> >>
>> >> After boot-up, both the da9063 and da9210 seem to assert their interrupt
>> >> request lines.  Hence as soon as one driver requests this irq, it gets
>> >> stuck in an interrupt storm, as it only manages to deassert its own
>> >> interrupt request line, and the other driver hasn't installed an
>> >> interrupt handler yet.
>> >>
>> >> To handle this, install a quirk that masks the interrupts in both the
>> >> da9063 and da9210.  This quirk has to run after the i2c master driver
>> >> has been initialized, but before the i2c slave drivers are initialized.

>> >> +#ifdef CONFIG_I2C
>> >
>> > Is it a realistic scenario that I2C and slave drivers are modules?
>>
>> Yes.
>>
>> Unfortunately that's more difficult to support, as the code references
>> i2c_bus_type and i2c_adapter_type.
>>
>> i2c_bus_type is needed to register the notifier.
>> i2c_adapter_type is needed to distinguish between i2c adapters and clients,
>> as the notifier is called for both with action BUS_NOTIFY_ADD_DEVICE.

Given we already have a few "select I2C" under arch/arm, I guess it won't
hurt much to let ARCH_R8A7790 and ARCH_R8A7791 select I2C, too.

> this seems reasonable enough to me, however, I'd like to let it hang out
> for a bit longer to see if there is any further review. To that end could
> you consider posting a non-RFC version for review if you wish to pursue
> this approach further?

Sure, will do after a bit of more cooking, and updating with the findings of
more test results, if needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
