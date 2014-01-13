From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 13 Jan 2014 11:19:13 +0100
Subject: spi-rspi I/O errors
In-Reply-To: <CAMuHMdX+4Z5nzj1t-v3kG4__yjYohOic1b0dUA9ZwHJrt2MRgw@mail.gmail.com>
References: <alpine.DEB.2.02.1401072116370.27579@ayla.of.borg>
 <CAMuHMdVzFeymxW2CZUyKgZ-fxsektE1EpLQksfSzoekj2ex53Q@mail.gmail.com>
 <2820126.AWUstGfrNm@avalon> <1787813.oK07lvnr6k@avalon>
 <CAMuHMdX+4Z5nzj1t-v3kG4__yjYohOic1b0dUA9ZwHJrt2MRgw@mail.gmail.com>
Message-ID: <CAMuHMdUBK8oi2qiUPH6MZrtya06oO1gaKjnpde_tCS7vRZF3JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 10:20 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Jan 9, 2014 at 7:14 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>> > It seems to get a stale value. I ended up doing the printk() anyway, and
>>> > when reading using small buffer sizes, the issues is more likely to
>>> > happen.
>>> >
>>> > If I add a second copy of rspi->spsr, and make that copy volatile OR add
>>> > a few calls to smp_mb() around the places where it's written and read,
>>> > the copy has the right value inside rspi_wait_for_interrupt(), BUT only if
>>> > I also print the spsr value inside rspi_irq(). Note that the original
>>> > rspi->spsr still has the stale value.
>>>
>>> Do I understand it correctly that the SPSR value read from the register in
>>> rspi_irq() is always correct on the first read, and that only the rspi->spsr
>>> value stored in memory and read in rspi_wait_for_interrupt() is wrong ?
>>> > I'd expect wake_up() and wait_event_timeout() to have the right memory
>>> > barriers (cfr. Documentation/memory-barriers.txt), so I don't have to add
>>> > my own. And why does it need the extra printk()? What extra
>>> > synchronization
>>> > does that give?
>>>
>>> Have you tried adding explicit memory barriers without any extra printk ?
>
> Yes, cfr. "add a few calls to smp_mb()" above.
>
>>> > Note that the interrupt handler always runs on CPU core 0, while
>>> > rspi_wait_for_interrupt() can run on core 0 or 1. Is there a
>>> > cache-coherency issue between the two CPU cores?
>>>
>>> I'd be very surprised if that was the case, as there should be lots of other
>>> breakages, but let's not rule that out too fast. Magnus should be able to
>>> help you more than I can regarding that.
>>
>> Could you verify that the SMP bit is set in ACTLR
>> (http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388e/CIHHDDHJ.html)
>
> ACTLR = 0x000000c0 on CPU 0
> ACTLR = 0x00000040 on CPU 1
>
> 0xc0 = EXCL | SMP
> 0x40 = SMP
>
> The different EXCL value seems strange to me, especially considering the comment
> about the matching cache controller configuration:

I tried enabling the EXCL bit for ACTLR on CPU 1, but it doesn't make
a difference.

One other thing: As I was playing with m25p80, I had #define DEBUG at the
top of drivers/mtd/devices/m25p80.c. This doesn't cause much kernel output,
just one message before every read:

    spi0.0: m25p80_read from 0x00108600, len 512

However, without the #define DEBUG, it's _much_ more difficult to trigger
the issue.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
