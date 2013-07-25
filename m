From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 11:30:40 +0100
Subject: [PATCH 03/14] ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
In-Reply-To: <51F0FC21.8050108@codethink.co.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-4-git-send-email-ben.dooks@codethink.co.uk>
 <20130724143335.GL11072@mudshark.cambridge.arm.com>
 <51EFF1B2.4050609@codethink.co.uk>
 <20130725101442.GA5609@mudshark.cambridge.arm.com>
 <51F0FC21.8050108@codethink.co.uk>
Message-ID: <20130725103039.GC5609@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 11:21:21AM +0100, Ben Dooks wrote:
> On 25/07/13 11:14, Will Deacon wrote:
> > What's wrong with the following?
> >
> > --->8
> >
> > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> > index 9cf6063..ee660c2 100644
> > --- a/arch/arm/kernel/head.S
> > +++ b/arch/arm/kernel/head.S
> > @@ -581,8 +581,13 @@ __fixup_a_pv_table:
> >          b       2f
> >   1:     add     r7, r3
> >          ldrh    ip, [r7, #2]
> > +#ifdef CONFIG_CPU_ENDIAN_BE8
> > +       and     ip, 0x008f
> > +       orr     ip, ip, r6, lsl #24
> > +#else
> >          and     ip, 0x8f00
> >          orr     ip, r6  @ mask in offset bits 31-24
> > +#endif
> >          strh    ip, [r7, #2]
> >   2:     cmp     r4, r5
> >          ldrcc   r7, [r4], #4    @ use branch for delay slot
> 
> If the offset bits are 8bits, then that would
> be fine (apart from the lsl #8).

Ah yes, I see the problem now. Maybe it's easier to rev r6 for the
big-endian case and leave the orr alone.

Will
