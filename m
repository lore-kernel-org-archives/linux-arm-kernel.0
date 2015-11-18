From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 18 Nov 2015 08:45:22 -0500 (EST)
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <CANqRtoTkHecGEsbi3EtM8dkHQ=V0RGm7iZcU_igMqLE7Od=xBA@mail.gmail.com>
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
Message-ID: <alpine.LFD.2.20.1511180841000.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Nov 2015, Magnus Damm wrote:

> Hi Nicolas,
> 
> On Wed, Nov 18, 2015 at 12:58 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 17 Nov 2015, Chris Brandt wrote:
> >
> >> I think this one is more of a coding issue.
> >> These were the attempts to fix the temporary stack issue:
> >>
> >> My first patch:
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/357106.html
> >>
> >> Magnus's try:
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/383394.html
> >
> > Here's my proposal:
> >
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index de2b246fed..2d0ac32320 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -274,10 +274,12 @@ __v7_ca15mp_setup:
> >  __v7_b15mp_setup:
> >  __v7_ca17mp_setup:
> >         mov     r10, #0
> > -1:     adr     r12, __v7_setup_stack           @ the local stack
> > -       stmia   r12, {r0-r5, lr}                @ v7_invalidate_l1 touches r0-r6
> > +1:     adr     r0, __v7_setup_stack_ptr
> > +       ldr     r12, [r0]
> > +       add     r12, r12, r0                    @ the local stack
> > +       stmia   r12, {r1-r6, lr}                @ v7_invalidate_l1 touches r0-r6
> >         bl      v7_invalidate_l1
> > -       ldmia   r12, {r0-r5, lr}
> > +       ldmia   r12, {r1-r6, lr}
> >  #ifdef CONFIG_SMP
> >         ALT_SMP(mrc     p15, 0, r0, c1, c0, 1)
> >         ALT_UP(mov      r0, #(1 << 6))          @ fake it for UP
> 
> [snip]
> 
> > @@ -480,11 +484,16 @@ __errata_finish:
> >         orr     r0, r0, r6                      @ set them
> >   THUMB(        orr     r0, r0, #1 << 30        )       @ Thumb exceptions
> >         ret     lr                              @ return to head.S:__ret
> > +
> > +       .align  2
> > +__v7_setup_stack_ptr:
> > +       .word   __v7_setup_stack - .
> >  ENDPROC(__v7_setup)
> 
> Thanks for your take on this. I did a couple of local implementations
> before submitting, and one of the issues I ran into was the need to
> get rid of PAGE_OFFSET due to the code running without MMU enabled. I
> suppose that is taken care of the "__v7_setup_stack - ." calculation
> above?

Yes.  That provides the offset from __v7_setup_stack_ptr to reach 
__v7_setup_stack. And __v7_setup_stack_ptr is obtained with adr which is 
relative to the current pc. So this works whether or not the MMU is 
enabled.


Nicolas
