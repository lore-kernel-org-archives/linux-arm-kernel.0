From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 10 Jan 2011 17:45:44 -0500 (EST)
Subject: [PATCH 4/4] ARM: support for Thumb-2 instructions with
	CONFIG_ARM_PATCH_PHYS_VIRT
In-Reply-To: <AANLkTi=g+Wf7T60=nLeCpuPtYebZhE5URr4t2T6zzsCC@mail.gmail.com>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-5-git-send-email-nico@fluxnic.net>
	<AANLkTi=g+Wf7T60=nLeCpuPtYebZhE5URr4t2T6zzsCC@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1101101740280.9794@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jan 2011, Dave Martin wrote:

> Hi,
> 
> On Tue, Jan 4, 2011 at 2:20 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > @@ -462,6 +462,8 @@ ENDPROC(__fixup_phys_virt)
> >        .pushsection .text
> >
> >  ENTRY(__fixup_pv_table_loop)
> > +#ifndef CONFIG_THUMB2_KERNEL
> > +       mov     r6, r6, lsr #24 @ constant for add/sub instructions
> >        orr     r6, r6, #0x400  @ mask in rotate right 8 bits
> >  2:     cmp     r4, r5
> >        ldrlo   r7, [r4], #4
> > @@ -471,6 +473,27 @@ ENTRY(__fixup_pv_table_loop)
> >        strlo   ip, [r7, r3]
> >        blo     2b
> >        mov     pc, lr
> > +#else
> > +       teq     r6, #0
> > +       beq     2f
> > +       clz     r7, r6
> > +       lsr     r6, #24
> > +       lsl     r6, r7
> > +       bic     r6, r6, #0x3080
> 
> Should bits 12-13 of r6 ever be nonzero here? The code already throws
> an error of the p2v offset is not a multiple of 16 MiB; i.e., (r6 &
> ~0xff000000) == 0, so r6 >> (24 - clz(r6)) must be in the range
> 0..0xff.

Yes, they should be cleared already.  This is probably a leftover from a 
previous version.

I need to rework this part entirely now anyway to go on top of Russell's 
latest version.

> I've not been able to test this code yet, but it looks to me like it
> should work for the Thumb-2 case.

Thanks for looking at it.


Nicolas
