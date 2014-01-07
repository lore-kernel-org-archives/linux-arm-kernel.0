From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Jan 2014 20:53:41 +0100
Subject: [PATCH 1/3] pinctrl: sh-pfc: r8a7791: Add QSPI pin groups
In-Reply-To: <11491980.GOk5XT7hjl@avalon>
References: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
 <1388763256-25851-2-git-send-email-geert@linux-m68k.org>
 <11491980.GOk5XT7hjl@avalon>
Message-ID: <CAMuHMdVuDWi+6LCscS0U8vVV=VXXSwXJoTSdokdNjYWHP_8QoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 7, 2014 at 3:58 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +static const unsigned int qspi_pins[] = {
>> +     /* SPCLK, MOSI_IO0, MISO_IO1, IO2, IO3, SSL */
>> +     RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
>> +     RCAR_GP_PIN(1, 7), RCAR_GP_PIN(1, 8), RCAR_GP_PIN(1, 9),
>> +};
>
> The QSPI controller can be used in 1-bit, 2-bit or 4-mode mode, so you should
> split the pins group to allow that. You could use one pin group for the
> control signals (SPCLK and SSL), one group for 2-bit data (MOSI + MISO, or IO0
> + IO1 depending on the mode) and one group for 4-bit data (IO0 + IO1 + IO2 +
> IO3).

OK, while you can't mix "real" functions (half of the pins are FN2, the other
half FN3), I forgot you can still configure the SoC to use IO2 and IO3 for GPIO.

Will split in qspi_ctrl (2 control wires), qspi_data2 (2 data wires),
and qspi_data4 (4 data wires).

> I assume that usage of the SSL signal is always required. If that's not the
> case the control signals group should be split in two.
>
> Similarly, if the hardware supports "write-only" mode (where the MISO signal
> isn't connected), that should be supported through a 1-bit data signals group.

No, the hardware doesn't support three-wire mode.
Only four-wire (Single/Dual SPI) and six-wire (Quad SPI) are supported.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
