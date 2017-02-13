From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 13 Feb 2017 11:29:27 +0100
Subject: [PATCH/RFC] arm64: defconfig: Enlarge CMA alignment to 2 MiB
In-Reply-To: <CANqRtoQJaRK7Kys-fudyxJuojBmZyXMsNoDudSt4p=gj5srviA@mail.gmail.com>
References: <1485532996-19719-1-git-send-email-geert+renesas@glider.be>
 <CANqRtoQJaRK7Kys-fudyxJuojBmZyXMsNoDudSt4p=gj5srviA@mail.gmail.com>
Message-ID: <CAMuHMdUaOW2uchx5kwgc01vPnrQ86M6pGJ6Cpdct_GxEwJ3DOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Wed, Feb 1, 2017 at 2:45 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Sat, Jan 28, 2017 at 1:03 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> Some IOMMUs (e.g. Renesas IPMMU/VMSA) support only page sizes of 4 KiB,
>> 2 MiB, and 1 GiB.
>>
>> With the default setting of CONFIG_CMA_ALIGNMENT = 8, allocations larger
>> than 1 MiB are aligned to a 1 MiB boundary only.  Hence a 2 MiB
>> allocation may not be aligned, leading to a mapping of 512 4 KiB pages.
>>
>> Increase CONFIG_CMA_ALIGNMENT to allow mapping a 2 MiB buffer using a
>> single PTE, decreasing memory usage and TLB pressure.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Is this useful?
>>
>> Should there instead be different defaults in Kconfig, depending on
>> enabled platform support?
>
> I think there is a dependency on the kernel page size configuration as
> well. In case of 16 KiB or 64 KiB page size configuration other large
> page sizes may be required.

This is about IOMMU pages, not (CPU)MMU pages?

Still, there is indeed some dependency, as CONFIG_CMA_ALIGNMENT is a
shift relative to PAGE_SHIFT (i.e. CONFIG_ARM64_PAGE_SHIFT = 12 in
arm64_defconfig).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
