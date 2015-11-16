From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 16 Nov 2015 10:53:39 +0100
Subject: [PATCH v11 6/8] arm64: renesas: add Salvator-X board support on
 DTS
In-Reply-To: <CAMuHMdX=LS2sLqtgBUYeWjVkUVZE2WQwsWhbvK+wmdfZ0ycrjg@mail.gmail.com>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-7-git-send-email-horms+renesas@verge.net.au>
 <20151015110139.GG8825@leverpostej>
 <20151023070032.GA4502@verge.net.au>
 <CAMuHMdVzUPyhkfPy3s+jBK1gQ-kZqYfrQZ8Bww-iFxGOPVZn2w@mail.gmail.com>
 <CAMuHMdX=LS2sLqtgBUYeWjVkUVZE2WQwsWhbvK+wmdfZ0ycrjg@mail.gmail.com>
Message-ID: <CAMuHMdV+7L9r-dHKj5x8JFFVYg0O-zAnE7R5QYZQPAOJwi5Sxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 3, 2015 at 3:24 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 29, 2015 at 8:52 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Fri, Oct 23, 2015 at 9:00 AM, Simon Horman <horms@verge.net.au> wrote:
>>> On Thu, Oct 15, 2015 at 12:01:40PM +0100, Mark Rutland wrote:
>>>> > +           stdout-path = &scif2;
>>>>
>>>> No rate? It would be better to be explicit here; you should be able to
>>>> have:
>>>>
>>>>       stdout-path = "serial0:115200n8"
>>>>
>>>> Where "115200n8" is replaced with whatever configuration this board
>>>> actually has.
>>>
>>> I think that we have had this discussion before in relation to
>>> a different board for a different Renesas SoC but I could be mistaken.
>>
>> IIRC, at that time the code to parse the options wasn't upstream yet, so
>> adding the options would have broken the serial console.
>>
>> I can confirm it works fine on Salvator-X with
>>
>>         stdout-path = "serial0:115200n8";
>
> Unfortunately this breaks earlycon support:
>
>         Malformed early option 'earlycon'
>
> The call to fdt_getprop() in early_init_dt_scan_chosen_serial() fails.
> I guess that unlike the standard console handling code, the fdt code can't
> handle aliases yet?

Apparently this issue was fixed in v4.4-rc1. For the backport team:

commit 6296ad9e3375c6c1ddbb371f589ba6a145bb31df
Author: Stefan Agner <stefan@agner.ch>
Date:   Sat Oct 10 01:29:30 2015 -0700

    of/fdt: fix aliases with baudrate in earlycon

> P.S. SCIF earlycon support is not yet upstream, as it still doesn't work on
> arm32 (I discovered today it does on arm64 ;-): it pretends to work, but
> nothing is output to the serial port (until the normal serial console kicks
> in).

And this issue is mostly resolved, too. So v4.5 will be perfect ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
