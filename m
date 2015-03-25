From: slash.tmp@free.fr (Mason)
Date: Wed, 25 Mar 2015 18:56:22 +0100
Subject: String literals in __init functions
Message-ID: <5512F6C6.1020304@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

AFAIU, functions only used at system init are tagged __init to have
the linker store them in a separate .init.text section, so memory can
be reclaimed once initialization is complete. Is that correct?

The corresponding tag for data is __initdata (section .init.data)

I started wondering if the string literals used in an __init functions
were automatically marked __initdata.

Looking at the objdump output, I see that the string literals are,
in fact, stored in the .rodata section. I suppose that .rodata is NOT
reclaimed after init?

This way seems to work:

static       char XyZa[] __initdata  = KERN_ALERT "foo";
static const char XyZb[] __initconst = KERN_ALERT "bar";
void __init XyZc(void) { printk(XyZa); printk(XyZb); }

$ arm-linux-gnueabihf-objdump -xd arch/arm/mach-tangox/time.o | grep XyZ
00000000 l     O .init.data	00000006 XyZa
00000000 l     O .init.rodata	00000006 XyZb
00000000 g     F .init.text	00000028 XyZc
00000000 <XyZc>:

$ arm-linux-gnueabihf-objdump -xd vmlinux | grep XyZ
c021e360 l     O .init.data	00000006 XyZa
c0220090 l     O .init.data	00000006 XyZb
c020d928 g     F .init.text	00000028 XyZc
c020d928 <XyZc>:

c020d928 <XyZc>:
c020d928:       e1a0c00d        mov     ip, sp
c020d92c:       e92dd800        push    {fp, ip, lr, pc}
c020d930:       e24cb004        sub     fp, ip, #4
c020d934:       e30e0360        movw    r0, #58208      ; 0xe360
c020d938:       e34c0021        movt    r0, #49185      ; 0xc021
c020d93c:       ebfe00c9        bl      c018dc68 <printk>
c020d940:       e3000090        movw    r0, #144        ; 0x90
c020d944:       e34c0022        movt    r0, #49186      ; 0xc022
c020d948:       ebfe00c6        bl      c018dc68 <printk>
c020d94c:       e89da800        ldm     sp, {fp, sp, pc}

Did I miss something in init.h?
Or should it be done like above to reclaim string literals?

Regards.
