From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 23 Jun 2016 10:11:04 +0200
Subject: [PATCH] ARM: dts: r8a7794: add SMP support
In-Reply-To: <CAMuHMdWY+hZMFQo7iGaeZkbVnK1cZ9=oyM7RvX_8mhyCuCxD9Q@mail.gmail.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <27171008.uuY7altQup@wasted.cogentembedded.com>
 <CAMuHMdWcVRBxZO85_MhYVvODcbi-GYDNKfQH9LJEcrJRd=p7Vw@mail.gmail.com>
 <adbc6358-d3fb-c608-15c2-c425332435f3@cogentembedded.com>
 <CAMuHMdWY+hZMFQo7iGaeZkbVnK1cZ9=oyM7RvX_8mhyCuCxD9Q@mail.gmail.com>
Message-ID: <CAMuHMdXb8dVPbOv0-cskN+owKJbgjcdFwLRW6J8+=XDO3EfCWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jun 22, 2016 at 12:20 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Jun 22, 2016 at 12:08 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
>> On 6/22/2016 10:20 AM, Geert Uytterhoeven wrote:
>>
>>>> Add the device tree node for the Advanced Power Management Unit (APMU).
>>>> Use the "enable-method" prop to  point out that the APMU should be used
>>>> for the SMP support.
>>>>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>>> SMP/PM basically works but you can't offline CPU0 (system hangs)...
>>>
>>>
>>> On #renesas-soc you said it hangs on SILK only, and succeeds on Porter,
>>> with a WARNING in the clk core (which one?) during suspend?
>>
>>    Porter is based on R8A7791 (WARNING seemed to be caused by the CAN
>> driver). :-)
>
> Oh right, mixing up boards.
>
> Will try on (remote) ALT when I find some time...

The second CPU boots (irrespective of MD21 setting), but the kernel
starts spewing:

    clocksource: Switched to clocksource arch_sys_counter
    WARNING: Underflow in clocksource 'arch_sys_counter' observed,
time update ignored.
             Please report this, consider using a different
clocksource, if possible.
             Your kernel is probably still fine.
    WARNING: Underflow in clocksource 'arch_sys_counter' observed,
time update ignored.
             Please report this, consider using a different
clocksource, if possible.
             Your kernel is probably still fine.

Seems like the secondary CPU also needs CNTVOFF initialization,
which is done in the BSP in arch/arm/mach-shmobile/headsmp.S.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
