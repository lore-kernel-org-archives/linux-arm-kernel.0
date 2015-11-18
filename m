From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 18 Nov 2015 15:23:12 -0500 (EST)
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <HK2PR06MB0561CA7E856CEAA89D0752488A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
 <HK2PR06MB056142FFDA4E99A764DF9ECB8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161730030.5826@knanqh.ubzr>
 <HK2PR06MB05614D47A9C35ECB4CA72D3F8A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511162127180.5826@knanqh.ubzr>
 <HK2PR06MB056175E6E4356DD8C3566D758A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511172255410.22569@knanqh.ubzr>
 <CANqRtoTkHecGEsbi3EtM8dkHQ=V0RGm7iZcU_igMqLE7Od=xBA@mail.gmail.com>
 <alpine.LFD.2.20.1511180841000.22569@knanqh.ubzr>
 <alpine.LFD.2.20.1511181156250.22569@knanqh.ubzr>
 <HK2PR06MB0561CA7E856CEAA89D0752488A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <alpine.LFD.2.20.1511181445550.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Nov 2015, Chris Brandt wrote:

> Hi Nicolas,
> 
> > Here's the patch with proper changelog, etc.  I don't have XIP
> > capable hardware to test it with though.
> 
> 
> I'm testing it now...but it's crashing.
> 
> I fired up GDB, so here the reason:
> 
> 
> __v7_ca17mp_setup:
> 	mov	r10, #0
> 1:	adr	r0, __v7_setup_stack_ptr
> r0=0x18213df4
> 
> 	ldr	r12, [r0]
> r12=0x10174cc
> 
> 	add	r12, r12, r0			@ the local stack
> r12=0x1922b2c0
> 
> 	stmia	r12, {r1-r6, lr}		@ v7_invalidate_l1 touches r0-r6
> 	bl      v7_invalidate_l1
> 
> 
> 0x1922b2c0 is NOT RAM....it's nothing.
> 
> 
> As point of reference, here's the memory map of my XIP system:
>   Physical ROM address: 0x18000000 (I have my XIP kernel starting at 0x18200000)
>   Physical RAM address: 0x20000000
>   Virtual ROM  address: 0xBF0000000
>   Virtual RAM  address: 0xC00000000
> 
> 
> Basically, you made the same mistake that Magnus first did: You can't 
> rely on the current PC address to obtain an address in physical RAM 
> because the ROM virt-to-phys relationship is different than the RAM 
> virt-to-phys relationship.

Crap... you're right of course.  I suspect a couple other places might 
have problems as they use similar constructs. See kernel/sleep.S for 
example.

Probably the  best way to fix it would be something like:

in asm/memory.h or similar:

#ifdef CONFIG_XIP_KERNEL
#define PHYS_OFFSET_FIXUP \
	( XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR) - PAGE_OFFSET + \
	  PLAT_PHYS_OFFSET - CONFIG_XIP_PHYS_ADDR )
#else
#define PHYS_OFFSET_FIXUP 0
#endif

And then, after my patch is applied, changing:

__v7_setup_stack_ptr:
        .word   __v7_setup_stack - .

into:

__v7_setup_stack_ptr:
        .word   __v7_setup_stack - . + PHYS_OFFSET_FIXUP

should do the trick. This way it'll work for all those places where the 
code is getting at the data area when the MMU is off with no XIP 
conditionals in the code.

I think my patch should be applied as is (minus the mention of XIP) to 
remove the write access to the .text area for the general case which is 
a worthy goal in itself.  We did a bunch of similar cleanups a while 
ago.

Then another patch could bring all those places XIP compatible with the 
simple addition of that PHYS_OFFSET_FIXUP constant.


Nicolas
