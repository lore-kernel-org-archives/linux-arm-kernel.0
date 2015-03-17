From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 17 Mar 2015 14:57:15 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Tue, Mar 17, 2015 at 2:46 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
>> Besides, I think a multi-platform XIP (or nommu) kernel is possible, as long as XIP_PHYS_ADDR (or PHYS_OFFSET) is suitable for all platforms included
>
> Possible...but...maybe pointless. If you're doing XIP, then most likely you've got a specific platform that you are trying to do as much as you can in as little (RAM) as possible.

Sure. For your real embedded device, you want a small kernel, without any cruft.

> Was ARCH_MULTIPLATFORM really trying to fix some huge existing problem? Or was it more of a 'here's a cute thing we could do'?
> In my mind, an SoC by nature is used for specific embedded product and you could care less if the binary runs on anything else. Of course the range of SoCs that can run Linux now a days varies greatly, so I don't think you can put them all in the same category like ARCH_MULTIPLATFORM was trying to do.

ARCH_MULTIPLATFORM (the multi-platform part) was also introduced to reduce the
number of kernels you have to built. This matters not only for testing
(increasing build coverage while reducing the number of kernels vs. the number
of machines), but also for Linux distributions, who typically ship only a few
kernels, but want to support as many machine types as possible.

>> Perhaps ARCH_MULTIPLATFORM should be replaced by ARCH_ARM_NEWWORLD almost everywhere, and (new) ARCH_MULTIPLATFORM should be reserved (if needed at all) to protect features that are not compatible with running on multiple machines?
>
> That's not bad. I think it still comes down to if you want to build XIP, you don't care about ARCH_MULTIPLATFORM support, and the XIP_PHYS_ADDR (and PHYS_OFFSET) you need to use is device specific anyway.

Now, to solve your problem: can you get it to work by dropping XIP_KERNEL's
dependency on !ARCH_MULTIPLATFORM in arch/arm/Kconfig?

> It also looks like a couple month ago someone also pointed out that just because the base core is the same, that doesn't mean all the erratas are the same, and ARCH_MULTIPLATFORM doesn't fit there as well.

Possibly.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
