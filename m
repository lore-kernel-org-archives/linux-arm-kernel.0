From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Jan 2015 19:46:05 +0100
Subject: [PATCH 2/4] ARM: shmobile: r8a7740: Migrate to generic l2c OF
 initialization
In-Reply-To: <1829825.nytgIBNlTf@wuerfel>
References: <1416232388-2611-1-git-send-email-geert+renesas@glider.be>
 <1416232388-2611-3-git-send-email-geert+renesas@glider.be>
 <1829825.nytgIBNlTf@wuerfel>
Message-ID: <CAMuHMdUO8uv4fCBCCA1mB2z51k8Ompq+WC48DD26kSL-H3OSfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Nov 17, 2014 at 3:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 17 November 2014 14:53:06 Geert Uytterhoeven wrote:
>>  DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
>> +       /* Shared attribute override enable, 32K*8way */
>> +       .l2c_aux_val    = 0x00400000,
>> +       .l2c_aux_mask   = 0xc20f0fff,
>>         .map_io         = r8a7740_map_io,
>>         .init_early     = shmobile_init_delay,
>>         .init_irq       = r8a7740_init_irq_of,
>
> You are only now adding it to DT, so you should have enough freedom
> to put the correct values in it.
>
> Please use the 0/0xffffffff settings here and use the generic
> code to set up the L2X0.

Thanks!

I looked into adding a proper cache-controller node in DT.
While l2c_aux_mask can indeed be ~0, we still need a non-zero l2c_aux_val
to set L2C_AUX_CTRL_SHARED_OVERRIDE.
Alternatively, should there be a DT property to set this flag?

Note that I only try to preserve the register value before and after
migrating to generic l2c OF initialization. I did read (part of) the pl310
documentation, but it's still not clear to me if we really need
L2C_AUX_CTRL_SHARED_OVERRIDE. Perhaps this was just copied from
somewhere else without much afterthought?

Note that OMAP2+ has just made the switch, too, keeping
L2C_AUX_CTRL_SHARED_OVERRIDE, in commit 944e9df1d4f71f94 ("ARM: 8257/1:
OMAP2+: use common l2cache initialization code").

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
