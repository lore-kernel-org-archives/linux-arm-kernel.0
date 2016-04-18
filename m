From: peter@hurleysoftware.com (Peter Hurley)
Date: Mon, 18 Apr 2016 10:02:55 -0700
Subject: [PATCH 1/5] doc: DT: Add Generic Serial Device Tree Bindings
In-Reply-To: <CACQ1gAhnEuCZbzpyiAcCx_kRhzCBvWAVVaecUdUhvu4vDD0REw@mail.gmail.com>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
 <1460636003-3011-2-git-send-email-geert+renesas@glider.be>
 <5792073.qsBJ1LK659@wuerfel>
 <CAMuHMdWmHUhhwbYDcmNXuxBRC6n+tp=oX03dBaK2VgL4OA72MQ@mail.gmail.com>
 <CACQ1gAhnEuCZbzpyiAcCx_kRhzCBvWAVVaecUdUhvu4vDD0REw@mail.gmail.com>
Message-ID: <5715133F.2040103@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2016 08:43 AM, Richard Genoud wrote:
> 2016-04-18 14:34 GMT+02:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>> Hi Arnd,
>>
>> CC Richard (serial-mctrl-gpio)
>> CC Grant (ePAPR successor) and Frank
>>
>> On Sat, Apr 16, 2016 at 6:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thursday 14 April 2016 14:13:19 Geert Uytterhoeven wrote:

[...]

>>>>  - out1-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
>>>>    used as the UART's OUT1 line.
>>>>  - out2-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
>>>>    used as the UART's OUT2 line.
>>>
>>> I had to look up what OUT1 and OUT2 are, but I still don't see how you'd
>>> implement them using a GPIO line: From all I can tell, these are usually
>>> internal registers in a hardware uart but they are not assigned to an
>>> external line on the standard db9 or even the old db25 connectors. Should
>>> we drop these instead?

Yeah, not sure how those snuck in for gpios.

The original 8250/16550 uarts had OUT1 and OUT2 pins, and OUT1 could be used
like gpio. That was 3 decades ago though so maybe we don't need to try to
recreate that tech again :)


>> They're indeed fairly exotic, and they're burried deeply in the ns16550
>> datasheet. We do have TIOCM_OUT1 and TIOCM_LOOP in asm-generic/termios.h,
>> probably for obscure historical reasons.

Please leave the bit defs alone.


>> If we drop them, I guess they should be removed from the helper code in
>> drivers/tty/serial/serial_mctrl_gpio.c, too? There don't seem to be any
>> current users.
> I must confess that I don't really know what TIOCM_OUT1&2 are for.
> (I implemented them for completeness)
> But it seems that OUT2 is used in some drivers:
> drivers/tty/serial/omap-serial.c:
>         /*
>          * Most PC uarts need OUT2 raised to enable interrupts.
>          */
>         up->port.mctrl |= TIOCM_OUT2;

There's no need for OUT1 and OUT2 gpios; let's fix that.

Regards,
Peter Hurley
