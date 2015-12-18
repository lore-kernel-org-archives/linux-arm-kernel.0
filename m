From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 18 Dec 2015 15:05:38 +0100
Subject: [PATCH 00/13] ARM: shmobile: dts: Update console parameters
In-Reply-To: <20151210070239.GA17682@verge.net.au>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
 <20151210070239.GA17682@verge.net.au>
Message-ID: <CAMuHMdVzEpcZ11EckVW+5eG55UbLoWzsuGaza-Mp+XKZtRmNDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Dec 10, 2015 at 8:02 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Dec 08, 2015 at 06:54:05PM +0100, Geert Uytterhoeven wrote:
>> This patch series updates the console parameters in the DTSes for
>> various Renesas ARM boards.
>>
>>   - For all of them, the serial port config is added to
>>     chosen/stdout-path, as per current best practices,
>>   - On some boards (armadillo, bockw, kzm9d, kzm9g), "console="
>>     parameters are removed from the kernel command lines, as they're no
>>     longer needed for DT-only platforms,
>>   - On some boards (genmai, kzm9g), the console alias is changed to
>>     "serial0", for consistency with other boards (the first serial port
>>     is always called "serial0", unless labeled otherwise); this does
>>     mean the device changes its name to /dev/ttySC0 in userspace, which
>>     also happened on R-Car Gen2 before,
>>   - On kzm9d, a console alias is added.
>>
>> Tested on r8a73a4/ape6evm, r8a7740/armadillo, r8a7778/bockw,
>> r8a7779/marzen, r8a7791/koelsch, and sh73a0/kzm9g.
>>
>> Thanks for applying!
>>
>> Geert Uytterhoeven (13):
>>   ARM: shmobile: alt dts: Add serial port config to chosen/stdout-path
>>   ARM: shmobile: ape6evm dts: Add serial port config to
>>     chosen/stdout-path
>
> alt and ape6evm tested ok.
> I have queued up the changes for those boards.
>
>>   ARM: shmobile: armadillo800eva dts: Update console parameters
>
> I would prefer not to take the serial1 -> serial0 portion of this change at
> this time as it causes a user-space visible change: the console moves from
> ttySC1 to ttySC0. I noticed this because I no longer made it all the way
> to user-space which was expecting a console on ttySC1.
>
> -- start before --
> [    0.050000] e6c50000.serial: ttySC1 at MMIO 0xe6c50000 (irq = 25, base_baud = 0) is a scifa
> [    0.780000] console [ttySC1] enabled
> -- end before --
>
> -- start after --
> [    0.050000] e6c50000.serial: ttySC0 at MMIO 0xe6c50000 (irq = 25, base_baud = 0) is a scifa
> [    0.780000] console [ttySC0] enabled
> -- end after --

We made a similar change on koelsch, lager, and marzen (cfr. below) before,
so I assumed this is OK?

>>   ARM: shmobile: marzen dts: Add serial port config to
>>     chosen/stdout-path
>
> Changing &scif2 to serial0 creates a user-space visible change:
> the console moves from ttySC2 to ttySC0.

Does it? Serial0 was already pointing to scif2 since Magnus' commit
8025e3ff4ca972a0 ("ARM: shmobile: marzen: Board specific serial port order").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
