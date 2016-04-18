From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 18 Apr 2016 14:34:12 +0200
Subject: [PATCH 1/5] doc: DT: Add Generic Serial Device Tree Bindings
In-Reply-To: <5792073.qsBJ1LK659@wuerfel>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
 <1460636003-3011-2-git-send-email-geert+renesas@glider.be>
 <5792073.qsBJ1LK659@wuerfel>
Message-ID: <CAMuHMdWmHUhhwbYDcmNXuxBRC6n+tp=oX03dBaK2VgL4OA72MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

CC Richard (serial-mctrl-gpio)
CC Grant (ePAPR successor) and Frank

On Sat, Apr 16, 2016 at 6:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 14 April 2016 14:13:19 Geert Uytterhoeven wrote:
>> Document a set of generic properties for describing UARTs in a
>> device tree:
>>   1. The GPIO modem control properties are currently duplicated across
>>      hardware-specific binding documentation,
>>   2. The property for dedicated RTS/CTS hardware flow control lines is
>>      already supported by several drivers, albeit with a vendor-specific
>>      prefix, hence make it generic.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Originally the ISA 8250 uart binding (from ieee) was used as the
> template for other uart bindings. How about documenting the parts that
> are used in 8250-of today (current-speed, clock-frequency,
> reg-offset, reg-shift, fifo-size, reg-io-width, auto-flow-control)
> in the same file?

I don't think we have the habit of documenting (duplicating) bindings for ePAPR
under Documentation/devicetree/bindings/. Perhaps we should?

Apart from that, most of the properties you mention look legacy or overly
broad too me.

  - current-speed: This is configuration, not a property of the hardware.
    For the console, this has been deprecated by appending the serial config
    to chosen/stdout-path (e.g. "serial0:115200n8").
    For non-consoles, its use is debatable, IMHO.
    It's users are mostly legacy powerpc and early adaptors of DT on ARM.
  - clock-frequency: Legacy predating the Common Clock Framework.
    Any modern SoC uses clock specifiers with clock handles pointing to clock
    providers.
  - reg-offset, reg-shift, reg-io-width: These are much broader than serial,
    and IMHO thus don't belong in
    Documentation/devicetree/bindings/serial/serial.txt.
  - auto-flow-control: Looks a bit like a vague version of "uart-has-rtscts".
    Documentation/devicetree/bindings/serial/8250.txt doesn't make it clear
    whether this is about hardware capabilities or software configuration.
    Even the driver doesn't make it clear:
    #define UART_CAP_AFE    (1 << 11)       /* MCR-based hw flow control */
    "MCR" could mean RTS/CTS, DSR/DTR, ...
  - fifo-size: This one could be generic. atmel-usart uses a vendor-specific
    version "atmel,fifo-size".

I suggest we move forward with my initial set, as I have patches that depend on
them? We can always add more properties later.

>>  - out1-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
>>    used as the UART's OUT1 line.
>>  - out2-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
>>    used as the UART's OUT2 line.
>
> I had to look up what OUT1 and OUT2 are, but I still don't see how you'd
> implement them using a GPIO line: From all I can tell, these are usually
> internal registers in a hardware uart but they are not assigned to an
> external line on the standard db9 or even the old db25 connectors. Should
> we drop these instead?

They're indeed fairly exotic, and they're burried deeply in the ns16550
datasheet. We do have TIOCM_OUT1 and TIOCM_LOOP in asm-generic/termios.h,
probably for obscure historical reasons.

If we drop them, I guess they should be removed from the helper code in
drivers/tty/serial/serial_mctrl_gpio.c, too? There don't seem to be any
current users.

> On a related note, do you think it would be possible to do a bit-banged
> uart if we defined gpio lines for rxd and txd?

Sure we can. Whether it would work well is another question ;-)
Regardless of flow control, byte transmission and reception has hard real-time
requirements due to the implicit clocking.
Bit-banging i2c and spi (master) is much easier, as clocking is explicit.
Even i2c slave is easier, as the slave can stretch cycles.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
