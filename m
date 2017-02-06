From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 6 Feb 2017 16:30:38 +0100
Subject: [PATCH] ARM: shmobile: r7s72100: Enable L2 cache
In-Reply-To: <SG2PR06MB11657125A12CC1BDE6AD17748A400@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170202212000.10768-1-chris.brandt@renesas.com>
 <CAMuHMdU6kJDxGtjUT1S2JkQTLvzrgtF3mkqa5Xo08oF6d3tUbw@mail.gmail.com>
 <SG2PR06MB11657125A12CC1BDE6AD17748A400@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdW0-KPEKS5wFRK7aRKwvvUcjQDa7Rmo0cDDwnfGAAmJ5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Mon, Feb 6, 2017 at 3:58 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Monday, February 06, 2017, Geert Uytterhoeven wrote:
>> CC linux-arm-kernel
>>
>> On Thu, Feb 2, 2017 at 10:20 PM, Chris Brandt <chris.brandt@renesas.com>
>> wrote:
>> > This enables the 128KB L2 cache in the RZ/A1 (R7S72100).
>> >
>> > The 'Write full line of zeros mode' of this Cortex-A9 cannot be used
>> > because the sideband signals between the CA9 and PL310 are not connected.
>> > Since there is no option to disable this feature in the cache-l2x0
>> > driver, our only option is to specify a secure write function which
>> > will then cause the cache-l2x0 driver to not enable this feature.
>>
>> What about adding a DT property (e.g. "arm,pl310-broken-sideband", cfr.
>> "arm,pl330-broken-no-flushp"), and handling this in arch/arm/mm/cache-
>> l2x0.c instead?
>
> Well, first I have to say that 'broken-sideband' is not actually "accurate"
> in this case.
>
> From the RZ/A1H Hardware Manual:
>
> 4.  Secondary Cache
> 4.1 Features
>
>   * Sideband signal from CA9: No

OK.

> So the chip designers knew the sideband signals were not connected.
> If you have a look at the next chapter "5. LSI Internal Bus", you'll notice
> that the CA9 is on the North bus (fig 5.2) but the PL310 is on the south
> bus (fig 5.3) in between the AXI and the SDRAM/QSPI controller. So in this
> in SoC, maybe the PL310 looks more like a L3 than an L2 cache???

No, according to Figures 5.1 and 5.3, the CA9 is connected to both the
North and South main buses.

> So, I would say "arm,pl310-no-sideband" is a better name.

OK.

> I agree that faking out a secure write function just so the fill-zeros
> sideband feature is not enabled is a bit of a hack, but I'm not sure if
> modifying the cache-l2x0.c was an option.

Given I've added "arm,shared-override" in the past, I'd say yes ;-)

> If you think so, I can try the "arm,pl310-no-sideband" path first,
> and if that doesn't get in I can fall back to what I'm doing now.
>
> Thoughts???

According to the "CoreLink Level 2 Cache Controller L2C-310" TRM,
"no sideband signals" is even the default configuration?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
