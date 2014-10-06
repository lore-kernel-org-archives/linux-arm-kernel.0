From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 6 Oct 2014 11:18:10 +0200
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <CANqRtoTJNb7a9J05U0chrGoxBV7e1s6o0Xxeup0p1sOUZhE+vA@mail.gmail.com>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <CANqRtoTJNb7a9J05U0chrGoxBV7e1s6o0Xxeup0p1sOUZhE+vA@mail.gmail.com>
Message-ID: <CAMuHMdWm=4zqgUXypLZtck1=vx7S7nBtn_cBr32ODViccOY3cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Mon, Oct 6, 2014 at 1:36 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>   - On armadillo-multiplatform there may be a period while garbage data
>>     is output.
>>     This happens because sh_mobile_i2c_init() enables and disables its
>>     clock during probing. As iic0 and scifa1 share the same parent
>>     clock, this causes the scifa1 clock to no longer receive clock
>>     ticks.
>>     On armadillo-legacy, this is mitigated by the pre-CCF clock driver,
>>     which never really disables clocks during boot-up for exactly this
>>     reason. Cfr. "One example of this is the handling of the Mackerel
>>     serial console output that shares clock with the I2C controller.",
>>     in commit 794d78fea51504ba ("drivers: sh: late disabling of clocks
>>     V2").
>>     I'm wondering whether this can be fixed in the i2c driver? Does it
>>     really have to enable and disable the clock?
>
> I've seen this issue on several SoCs actually, and as you describe the
> main issue seems to be that there are clock topologies that present
> for devices used during boot (like serial) but this clock topology is
> not yet managed by software. This does not trigger on all SoCs though.

To work perfectly, (a) everything must be described correctly in DT, and
(b) this information must be used correctly.
IMHO we can live with the deficiencies for DEBUG_LL.

> It is my opinion that it has very little todo with the other devices
> that happen to be using the same parent clock. The legacy clock
> framework solved this by not allowing clocks to be disabled until all
> devices were registered.

Not allowing clocks to be disabled until all devices were registered has its
own problems (some hardware requires disabling clocks for various reasons).

A similar horse is currently being beaten to death in the "simplefb" threads...
Read on if you feel bored ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
