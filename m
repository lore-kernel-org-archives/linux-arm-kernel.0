From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 24 Jul 2013 14:24:29 -0700
Subject: updates for be8 patch series
In-Reply-To: <CAA3XUr1zHQbh+baVzQfgEebqYsEzUVp6wGOMe2PE6PUamAnbbw@mail.gmail.com>
References: <CAA3XUr3h5C0oJVrN5iXsM=NFkLMz_Tssp28CysZfwMNS5KvO-Q@mail.gmail.com>
 <51EEC002.9070808@codethink.co.uk>
 <CAA3XUr2oDEDD6LFjnZ_N0JGTFUMDZG6O9b3JoeJ8AELrK2KDiw@mail.gmail.com>
 <CAA3XUr1BJD-ypfJiEsp079qHDERjGp-xFxc_ke_Ep9z3N=UPaA@mail.gmail.com>
 <51EECBBD.20000@codethink.co.uk>
 <CAA3XUr1zHQbh+baVzQfgEebqYsEzUVp6wGOMe2PE6PUamAnbbw@mail.gmail.com>
Message-ID: <CAA3XUr0rYPB2X_p36ovouKmCF0EsOrWPcXEE859X7dT2d2+WLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

> I believe largely your series covers the same things, in more accurate way,
> and should be continued. I plan to review your series and will try to
> integrate it and run on Pandaboard ES. Note for this testing I would use big
> patch of TI OMAP4 drivers to be endian neutral. It will take me several days.
> If I find anything I will let you know accross these days.

Here is what I got so far:

setend be under ARM_BE8 or CPU_ENDIAN_BE8 usage
-----------------------------------------------

In many places I see 'setend be' instruction under ARM_BE8

ARM_BE8(    setend    be )

and ARM_BE8 defined as

+/* Select code for any configuration running in BE8 mode */
+#ifdef CONFIG_CPU_ENDIAN_BE8
+#define ARM_BE8(code...) code
+#else
+#define ARM_BE8(code...)
+#endif

but strictly speaking you need to do that only if CPU_BE8_BOOT_LE config set.
I.e if loader is not in little endian mode, you do not need those commands. CPU
will be already in BE mode.

IMHO ARM_BE8 should be used only if it is really be8 specific issue. There
could be just big endian issues, those should be done under CPU_BIG_ENDIAN
config. There could be ARM CPU_BIG_ENDIAN system, but not CPU_ENDIAN_BE8.
I.e ARCH_IXP4xx is example of that.

For example 'ARM: pl01x debug code endian fix' patch IMHO should
use CPU_BIG_ENDIAN rather than CONFIG_CPU_ENDIAN_BE8 (as it is now through
ARM_BE8). I.e if the same serial console output function will run on
CPU_BIG_ENDIAN but not CONFIG_CPU_ENDIAN_BE8 it would need such byteswap. I
understand that it is a bit contrived example where code is really BSP
specific and this BSP would never have CONFIG_CPU_ENDIAN_BE8 missing, but I am
concerned that meaning of configs got blured if it is used like this.

Note you do have BE8_LE defined in latter patch ...

Few places miss atags swaps on the read
---------------------------------------

I've tried to compare your atags reading changes vs my byteswap in place code. I
agree that byte swap on reading is better. It seems to me that you've missed
few places when conversion should happen (unless I am missing something). Also I
think you  need to add atag16_to_cpu, and cpu_to_atag16 so short atag values
could be handled.

1) arch/arm/kernel/atags_parse.c <global>
            87 __tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);

It needs to swap (only relevant fields listed)

struct tag_videotext {
    __u16        video_page;
    __u16        video_ega_bx;
    __u16        video_points;
};


2) arch/arm/kernel/atags_parse.c <global>
            140 __tagtable(ATAG_CMDLINE, parse_tag_cmdline);

It needs to swap cmdline, as far as I read the code it is a pointer ...
wondering what is going on in 64bit case ...

struct tag_cmdline {
    char    cmdline[1];    /* this is the minimum size */
};

3) arch/arm/mach-footbridge/common.c <global>
            51 __tagtable(ATAG_MEMCLK, parse_tag_memclk);

For consistency sake it is good idea to convert this too. It needs to swap
fmemclk on the read

struct tag_memclk {
    __u32 fmemclk;
};

4) arch/arm/mach-rpc/riscpc.c <global>
            65 __tagtable(ATAG_ACORN, parse_tag_acorn);

For consistency sake it is good idea to convert this too. It needs to swap
when reading the following fields

struct tag_acorn {
    __u32 memc_control_reg;
    __u32 vram_pages;
};

5) arch/arm/mm/init.c <global>
            68 __tagtable(ATAG_INITRD, parse_tag_initrd);
6) arch/arm/mm/init.c <global>
            77 __tagtable(ATAG_INITRD2, parse_tag_initrd2);

Need to swap

struct tag_initrd {
    __u32 start;    /* physical start address */
    __u32 size;    /* size of compressed ramdisk image in bytes */
};

Other than these notes, it looks very very good!

Thanks,
Victor
