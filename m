From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 11 Jan 2016 20:27:56 +0100
Subject: r8a7794/alt and CONFIG_PROVE_LOCKING=y
In-Reply-To: <20160111185512.GW19062@n2100.arm.linux.org.uk>
References: <CAMuHMdXGgbpsC+JdbGc5D0fd5YSdogpqvffPAB4PU-7H_-jM_Q@mail.gmail.com>
 <20160111185512.GW19062@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdXET+Ls2gsoDhTQXne=sa4GDPCcdxXE7p1nRswBTFVm0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Jan 11, 2016 at 7:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 11, 2016 at 07:46:57PM +0100, Geert Uytterhoeven wrote:
>> When CONFIG_PROVE_LOCKING=y, r8a7794/alt doesn't boot (no output).
>> Earlycon doesn't help, but DEBUG_LL=y and earlyprintk gave me:
>>
>>     Error: unrecognized/unsupported machine ID (r1 = 0x18009008).
>>
>>     Available machine support:
>>
>>     ID (hex) NAME
>>     ffffffff    Generic DT based system
>>     ffffffff Generic R8A7794 (Flattened Device Tree)
>>
>>     Please check your kernel config and/or bootloader.
>>
>> I'm booting using
>>
>>     tftp 41000000 alt/zImage
>>     tftp 40f00000 alt/r8a7794-alt.dtb
>>     bootz 41000000 - 40f00000
>>
>> just like on r8a7791/koelsch, where CONFIG_PROVE_LOCKING does work.
>>
>> If I disable CONFIG_PROVE_LOCKING (e.g. shmobile_defconfig), the same kernel
>> boots fine.
>>
>> Anyone with a clue?
>
> You're probably overwriting the dtb.  Presumably, RAM starts at
> 0x40000000, which means if your kernel is larger than 16MB-32k
> after decompression, the dtb will get overwritten.

That's what I was assuming, too.
But why would it work on the koelsch sister board, even with the same
kernel config?

Upon closer look, koelsch loads the DT a bit higher in memory:

## Flattened Device Tree blob at 40f00000
   Booting using the fdt blob at 0x40f00000
      Loading Device Tree to 40fed000, end 40fff5b1 ... OK

than alt:

## Flattened Device Tree blob at 40f00000
   Booting using the fdt blob at 0x40f00000
      Loading Device Tree to 40ef6000, end 40effc4b ... OK

This extra ca. 1 MiB seems to make the difference. Adding a bit more to
the kernel makes it fail on koelsch too, even without any output.

Doh, newer board, more stringent kernel size limitation...

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
