From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 18 Nov 2015 20:51:52 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1511181445550.22569@knanqh.ubzr>
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
 <alpine.LFD.2.20.1511181445550.22569@knanqh.ubzr>
Message-ID: <HK2PR06MB05610952B8DAE3C16E1ABC6E8A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Probably the best way to fix it would be something like:
>
> in asm/memory.h or similar:
>
> #ifdef CONFIG_XIP_KERNEL
> #define PHYS_OFFSET_FIXUP \
>	( XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR) - PAGE_OFFSET + \
>	  PLAT_PHYS_OFFSET - CONFIG_XIP_PHYS_ADDR ) #else #define
> PHYS_OFFSET_FIXUP 0 #endif
>
> And then, after my patch is applied, changing:
>
> __v7_setup_stack_ptr:
>        .word   __v7_setup_stack - .
>
> into:
>
> __v7_setup_stack_ptr:
>        .word   __v7_setup_stack - . + PHYS_OFFSET_FIXUP
>
> should do the trick. This way it'll work for all those places where
> the code is getting at the data area when the MMU is off with no XIP
> conditionals in the code.


Tested....it works!



Here's your new results:

__v7_ca17mp_setup:
	mov	r10, #0
1:	adr	r0, __v7_setup_stack_ptr
r0=0x18213df4

	ldr	r12, [r0]
r12=0x7e174cc

	add	r12, r12, r0			@ the local stack
r12=0x2002b2c0

	stmia	r12, {r1-r6, lr}		@ v7_invalidate_l1 touches r0-r6
	bl      v7_invalidate_l1


0x2002b2c0 is indeed the correct physical address of __v7_setup_stack_ptr.

So, you still need to use #ifdef XIP_KERNEL and PLAT_PHYS_OFFSET....but...you bury it in another file. I'm good with that!!


> Then another patch could bring all those places XIP compatible with
> the simple addition of that PHYS_OFFSET_FIXUP constant.

Yes, the less CONFIG_XIP_KERNEL is sprinkled around the arm tree code, the better.

Chris
