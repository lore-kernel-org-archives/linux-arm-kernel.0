From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 17 Mar 2015 16:08:04 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
Message-ID: <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

> This matters not only for testing (increasing build coverage while reducing the number of kernels vs. the number of machines), but also for Linux distributions, who typically ship only a few kernels, but want to support as many machine types as possible.

OK, I can see the desire now. But, there must be a happy medium somewhere.


> Now, to solve your problem: can you get it to work by dropping XIP_KERNEL's dependency on !ARCH_MULTIPLATFORM in arch/arm/Kconfig?

Nope, because CONFIG_PHYS_OFFSET doesn't get defined:
        " (.head.text+0x68): undefined reference to `CONFIG_PHYS_OFFSET'"

config PHYS_OFFSET
	hex "Physical address of main memory" if MMU
	depends on !ARM_PATCH_PHYS_VIRT

That was patch #1 to get XIP working in the 3.14 kernel.

So, putting that patch in for ARCH_MULTIPLATFORM:
config ARCH_MULTIPLATFORM
	bool "Allow multiple platforms to be selected"
	depends on MMU
	select ARCH_WANT_OPTIONAL_GPIOLIB
	select ARM_HAS_SG_CHAIN
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL

That will get you to be able to set PHYS_OFFSET and then build, but still not actually work.

For code, it looks like I still need to apply my 3.14 patches to:
    arch/arm/mm/mmu.c
    arch/arm/mm/proc-v7.S
    scripts/link-vmlinux.sh

Unfortunately, I'm still missing something to boot all the way up. Looking at  __log_buf I can see it was starting to boot (4.0.0-rc4), but dies early on.
So, I'm assuming something in the kernel has changed since 3.14 and I have to track it down.

Chris


-----Original Message-----
From: geert.uytterhoeven@gmail.com [mailto:geert.uytterhoeven at gmail.com] On Behalf Of Geert Uytterhoeven
Sent: Tuesday, March 17, 2015 9:57 AM
To: Chris Brandt
Cc: linux-arm-kernel at lists.infradead.org; linux-sh at vger.kernel.org
Subject: Re: XIP_KERNEL and !ARCH_MULTIPLATFORM

Hi Chris,

On Tue, Mar 17, 2015 at 2:46 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
>> Besides, I think a multi-platform XIP (or nommu) kernel is possible, 
>> as long as XIP_PHYS_ADDR (or PHYS_OFFSET) is suitable for all 
>> platforms included
>
> Possible...but...maybe pointless. If you're doing XIP, then most likely you've got a specific platform that you are trying to do as much as you can in as little (RAM) as possible.

Sure. For your real embedded device, you want a small kernel, without any cruft.

> Was ARCH_MULTIPLATFORM really trying to fix some huge existing problem? Or was it more of a 'here's a cute thing we could do'?
> In my mind, an SoC by nature is used for specific embedded product and you could care less if the binary runs on anything else. Of course the range of SoCs that can run Linux now a days varies greatly, so I don't think you can put them all in the same category like ARCH_MULTIPLATFORM was trying to do.

ARCH_MULTIPLATFORM (the multi-platform part) was also introduced to reduce the number of kernels you have to built. This matters not only for testing (increasing build coverage while reducing the number of kernels vs. the number of machines), but also for Linux distributions, who typically ship only a few kernels, but want to support as many machine types as possible.

>> Perhaps ARCH_MULTIPLATFORM should be replaced by ARCH_ARM_NEWWORLD almost everywhere, and (new) ARCH_MULTIPLATFORM should be reserved (if needed at all) to protect features that are not compatible with running on multiple machines?
>
> That's not bad. I think it still comes down to if you want to build XIP, you don't care about ARCH_MULTIPLATFORM support, and the XIP_PHYS_ADDR (and PHYS_OFFSET) you need to use is device specific anyway.

Now, to solve your problem: can you get it to work by dropping XIP_KERNEL's dependency on !ARCH_MULTIPLATFORM in arch/arm/Kconfig?

> It also looks like a couple month ago someone also pointed out that just because the base core is the same, that doesn't mean all the erratas are the same, and ARCH_MULTIPLATFORM doesn't fit there as well.

Possibly.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
