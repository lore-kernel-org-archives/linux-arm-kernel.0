From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 24 Jan 2017 10:08:16 +0100
Subject: [PATCH] ARM: tegra: paz00: fix __initdata placement
In-Reply-To: <20170123162428.GB2043@ulmo.ba.sec>
References: <20170123074347.GA29804@dtor-ws> <4072003.S1IBmddlP7@fb07-iapwap2>
 <20170123162428.GB2043@ulmo.ba.sec>
Message-ID: <3638459.E7Mh7VRDt6@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thierry,

Am Montag, 23. Januar 2017, 17:24:28 CET schrieb Thierry Reding:
> On Mon, Jan 23, 2017 at 11:04:22AM +0100, Marc Dietrich wrote:
> > Hello Dmitry,
> > 
> > Am Sonntag, 22. Januar 2017, 23:43:47 CET schrieb Dmitry Torokhov:
> > > To have expected effect the __initdata attribute should go after
> > > variable
> > > name and before initializer.`
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > > 
> > >  arch/arm/mach-tegra/board-paz00.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/mach-tegra/board-paz00.c
> > > b/arch/arm/mach-tegra/board-paz00.c index 7478f6fb3664..ea6bff404161
> > > 100644
> > > --- a/arch/arm/mach-tegra/board-paz00.c
> > > +++ b/arch/arm/mach-tegra/board-paz00.c
> > > @@ -23,7 +23,7 @@
> > > 
> > >  #include "board.h"
> > > 
> > > -static struct property_entry __initdata wifi_rfkill_prop[] = {
> > > +static struct property_entry wifi_rfkill_prop[] __initdata = {
> > > 
> > >  	PROPERTY_ENTRY_STRING("name", "wifi_rfkill"),
> > >  	PROPERTY_ENTRY_STRING("type", "wlan"),
> > >  	{ },
> > 
> > you are right according to the documentation, but objdump -s always shows
> > that it gets put into the .rodata section. So this patch has no effect,
> > because result is always same (and wrong). It's also possible that I'm
> > doing something wrong :-) Btw, there are hundreds of such __initdata
> > misplacement in the kernel.
> 
> Hmm... I get this:
> 
> 	$ objdump -t build/tegra20/arch/arm/mach-tegra/board-paz00.o
> 
> 	build/tegra20/arch/arm/mach-tegra/board-paz00.o:     file format
> 	elf32-little
> 
> 	SYMBOL TABLE:
> 	00000000 l    df *ABS*  00000000 board-paz00.c
> 	00000000 l    d  .text  00000000 .text
> 	00000000 l    d  .data  00000000 .data
> 	00000000 l    d  .bss   00000000 .bss
> 	00000000 l    d  .init.text     00000000 .init.text
> 	00000000 l       .init.text     00000000 $a
> 	00000000 l       .data  00000000 .LANCHOR1
> 	00000000 l       .init.data     00000000 .LANCHOR0
> 	00000000 l    d  .ARM.extab.init.text   00000000 .ARM.extab.init.text
> 	00000000 l    d  .ARM.exidx.init.text   00000000 .ARM.exidx.init.text
> 	00000000 l       .ARM.exidx.init.text   00000000 $d
> 	00000000 l       .data  00000000 $d
> 	00000000 l     O .data  000001c8 wifi_rfkill_device
> 	000001c8 l     O .data  00000048 wifi_gpio_lookup
> 	00000000 l    d  .rodata.str1.4 00000000 .rodata.str1.4
> 	00000000 l       .rodata.str1.4 00000000 $d
> 	00000000 l    d  .init.data     00000000 .init.data
> 	00000000 l       .init.data     00000000 $d
> 	00000000 l     O .init.data     00000048 wifi_rfkill_prop
> 	00000000 l    d  .debug_frame   00000000 .debug_frame
> 	00000010 l       .debug_frame   00000000 $d
> 	00000000 l    d  .debug_info    00000000 .debug_info
> 	00000000 l    d  .debug_abbrev  00000000 .debug_abbrev
> 	00000000 l    d  .debug_aranges 00000000 .debug_aranges
> 	00000000 l    d  .debug_ranges  00000000 .debug_ranges
> 	00000000 l    d  .debug_line    00000000 .debug_line
> 	00000000 l    d  .debug_str     00000000 .debug_str
> 	00000000 l    d  .note.GNU-stack        00000000 .note.GNU-stack
> 	00000000 l    d  .comment       00000000 .comment
> 	00000000 l    d  .ARM.attributes        00000000 .ARM.attributes
> 	00000000 g     F .init.text     00000030 tegra_paz00_wifikill_init
> 	00000000         *UND*  00000000 platform_device_add_properties
> 	00000000         *UND*  00000000 gpiod_add_lookup_table
> 	00000000         *UND*  00000000 platform_device_register
> 	00000000         *UND*  00000000 __aeabi_unwind_cpp_pr0
> 
> So it correctly ends up in .init.data for me. And it does so with or
> without the patch. GCCs documentation doesn't seem to say where exactly
> these attributes need to be put, though the examples given all have the
> attribute right before the =.

ok, objdump -s is maybe not appropriate to display such things.

Contents of section .init.data:
 0000 2c000000 0c000000 00010000 00000000  ,...............
 0010 34000000 00000000 40000000 05000000  4....... at .......
 0020 00010000 00000000 48000000 00000000  ........H.......
 0030 00000000 00000000 00000000 00000000  ................
 0040 00000000 00000000                    ........        
Contents of section .rodata.str1.4:
 0000 72666b69 6c6c5f67 70696f00 74656772  rfkill_gpio.tegr
 0010 612d6770 696f0000 72657365 74000000  a-gpio..reset...
 0020 73687574 646f776e 00000000 6e616d65  shutdown....name
 0030 00000000 77696669 5f72666b 696c6c00  ....wifi_rfkill.
 0040 74797065 00000000 776c616e 00        type....wlan.   

In fact, .init.data seems to contain relocations to .rodata.str1.4, which "-s" 
does not resolve.
 
> Oh... interestingly checkpatch does seem to have a check for this now,
> and it does recommend that __initdata be placed after wifi_rfkill_prop,
> so I'm going to apply this.

Btw, where is your tree for 4.11? git.kernel.org shows no action since 
November. Please also include https://patchwork.ozlabs.org/patch/704367/ if 
you haven't done yet. I forgot to add a #stable tag for 4.9 and 4.10.

Marc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170124/c090af50/attachment.sig>
