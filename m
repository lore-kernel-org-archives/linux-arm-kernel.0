From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 May 2013 16:38:28 +0100
Subject: [PATCH v3] ARM: imx: replicate the diagnostic register of boot
 cpu into secondary cores
In-Reply-To: <5181357E.3090805@gmail.com>
References: <1366948645-12060-1-git-send-email-shawn.guo@linaro.org>
 <20130426132130.GE30858@mudshark.cambridge.arm.com>
 <20130426134722.GA1943@S2101-09.ap.freescale.net>
 <5181357E.3090805@gmail.com>
Message-ID: <20130501153828.GC24055@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 04:32:14PM +0100, Dirk Behme wrote:
> Am 26.04.2013 15:47, schrieb Shawn Guo:
> > On Fri, Apr 26, 2013 at 02:21:30PM +0100, Will Deacon wrote:
> >>> diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
> >>> index a58c8b0..cd87970 100644
> >>> --- a/arch/arm/mach-imx/headsmp.S
> >>> +++ b/arch/arm/mach-imx/headsmp.S
> >>> @@ -18,8 +18,20 @@
> >>>   	.section ".text.head", "ax"
> >>>
> >>>   #ifdef CONFIG_SMP
> >>> +diag_reg_offset:
> >>> +	.word	g_diag_reg - .
> >>> +
> >>> +	.macro	set_diag_reg
> >>> +	adr	r0, diag_reg_offset
> >>> +	ldr	r1, [r0]
> >>> +	add	r1, r1, r0		@ r1 = physical &g_diag_reg
> >>> +	ldr	r0, [r1]
> >>> +	mcr	p15, 0, r0, c15, c0, 1	@ write diagnostic register
> >>> +	.endm
> >>
> >> Why not re-read the register directly, rather than mrc on the current core?
> >
> > I do not understand the comment.  What do you mean by "re-read"?  Read
> > the register on secondary cores will only return us 0, as bootloader
> > only sets up the register on cpu0.  The macro set_diag_reg only runs on
> > secondary cores to copy cpu0's diagnostic bits.  I think it's safe on
> > SMP.
> 
> Any news on this?

Well, I don't like copying the register value over from CPU0. I'd rather we
orr'd in the bits we actually need, like we would in __v7_setup. Perhaps the
code there should be factored out into arm_errata_xxxx asm macros, so
platforms can invoke them if they need to without breaking non-secure boot
for multi-platform kernels.

Will
