From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Oct 2013 08:44:55 +0000
Subject: [PULL REQ] Big Endian initial patch series
In-Reply-To: <20131028004736.GG16735@n2100.arm.linux.org.uk>
References: <20131018205405.GA28835@codethink.co.uk>
 <20131019170954.GC25076@mudshark.cambridge.arm.com>
 <5262E2C7.7000106@codethink.co.uk>
 <20131028004736.GG16735@n2100.arm.linux.org.uk>
Message-ID: <20131028084455.GA20218@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Oct 28, 2013 at 12:47:36AM +0000, Russell King - ARM Linux wrote:
> On Sat, Oct 19, 2013 at 08:51:35PM +0100, Ben Dooks wrote:
> > On 19/10/13 18:09, Will Deacon wrote:
> >> Do you think you could send another pull request please?
> >
> > Ok, sorted.
> 
> Pulled, but there was a conflict.  Please check this resolution (it's
> copy'n'pasted).  I'll probably be in linux-next tomorrow in any case,
> but any mistake here can be fixed.

This doesn't look quite right to me, but unfortunately I'm going be spending
most (all?) of today trying to catch a flight out of the UK. Hopefully Dave
or Ben can investigate further, but comments below.

> diff --cc arch/arm/kernel/head.S
> index 54547947a4e9,a047acfa6b6d..000000000000
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@@ -602,28 -586,26 +606,39 @@@ __fixup_a_pv_table
>         b       2f
>   1:    add     r7, r3
>         ldrh    ip, [r7, #2]
> + ARM_BE8(rev16 ip, ip)
>  -      and     ip, 0x8f00
>  -      orr     ip, r6  @ mask in offset bits 31-24
>  +      tst     ip, #0x4000
>  +      and     ip, #0x8f00
>  +      orrne   ip, r6  @ mask in offset bits 31-24
>  +      orreq   ip, r0  @ mask in offset bits 7-0
> + ARM_BE8(rev16 ip, ip)
>         strh    ip, [r7, #2]
>  +      ldrheq  ip, [r7]
>  +      biceq   ip, #0x20
>  +      orreq   ip, ip, r0, lsr #16
>  +      strheq  ip, [r7]

There are new halfword accesses here without any conditional revs.

>   2:    cmp     r4, r5
>         ldrcc   r7, [r4], #4    @ use branch for delay slot
>         bcc     1b
>         bx      lr
>   #else
>  +      moveq   r0, #0x400000   @ set bit 22, mov to mvn instruction
>         b       2f
>   1:    ldr     ip, [r7, r3]
> + #ifdef CONFIG_CPU_ENDIAN_BE8
> +       @ in BE8, we load data in BE, but instructions still in LE
> +       bic     ip, ip, #0xff000000
>  -      orr     ip, ip, r6, lsl#24
> ++      tst     ip, #0x000f0000 @ check the rotation field

Since that orr with shift has been removed, I think the masks for the BE
case are now incorrect...

> ++      orrne   ip, ip, r6, lsl #24 @ mask in offset bits 31-24
> ++      biceq   ip, ip, #0x00004000 @ clear bit 22
> ++      orreq   ip, ip, r0, lsl #24 @ mask in offset bits 7-0
> + #else
>         bic     ip, ip, #0x000000ff
>  -      orr     ip, ip, r6      @ mask in offset bits 31-24
>  +      tst     ip, #0xf00      @ check the rotation field
>  +      orrne   ip, ip, r6      @ mask in offset bits 31-24
>  +      biceq   ip, ip, #0x400000       @ clear bit 22

...which seems to be confirmed by the updated LE code (everything is off
by a byte).

Somebody should probably sit down with the conflicting patch and port the BE
changes over. I think the relevant patch is "ARM: mm: Correct virt_to_phys
patching for 64 bit physical addresses". In fact, looking at *that* patch,
it's *also* broken for BE! It adds the following to head.S:

+#ifdef __ARMEB_
+#define LOW_OFFSET     0x4
+#define HIGH_OFFSET    0x0
+#else
+#define LOW_OFFSET     0x0
+#define HIGH_OFFSET    0x4
+#endif

(spot the missing underscore).

So I guess that means somebody should test whatever the resulting merge
ends up being too...

Will
