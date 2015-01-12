From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Jan 2015 11:20:54 +0000
Subject: [PATCH 1/7] arm64: introduce common ESR_ELx_* definitions
In-Reply-To: <20150111165906.GG21444@cbox>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
 <1420632260-8798-2-git-send-email-mark.rutland@arm.com>
 <20150111165906.GG21444@cbox>
Message-ID: <20150112112054.GB16706@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 04:59:06PM +0000, Christoffer Dall wrote:
> On Wed, Jan 07, 2015 at 12:04:14PM +0000, Mark Rutland wrote:
> > Currently we have separate ESR_EL{1,2}_* macros, despite the fact that
> > the encodings are common. While encodings are architected to refer to
> > the current EL or a lower EL, the macros refer to particular ELs (e.g.
> > ESR_ELx_EC_DABT_EL0). Having these duplicate definitions is redundant,
> > and their naming is misleading.
> > 
> > This patch introduces common ESR_ELx_* macros that can be used in all
> > cases, in preparation for later patches which will migrate existing
> > users over. Some additional cleanups are made in the process:
> > 
> > * Suffixes for particular exception levelts (e.g. _EL0, _EL1) are
> >   replaced with more general _LOW and _CUR suffixes, matching the
> >   architectural intent.
> > 
> > * ESR_ELx_EC_WFx, rather than ESR_ELx_EC_WFI is introduced, as this
> >   EC encoding covers traps from both WFE and WFI. Similarly,
> >   ESR_ELx_WFx_ISS_WFE rather than ESR_ELx_EC_WFI_ISS_WFE is introduced.
> > 
> > * Multi-bit fields are given consistently named _SHIFT and _MASK macros.
> > 
> > * UL() is used for compatiblity with assembly files.
> > 
> > * Comments are added for currently unallocated ESR_ELx.EC encodings.
> > 
> > For fields other than ESR_ELx.EC, macros are only implemented for fields
> > for which there is already an ESR_EL{1,2}_* macro.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/esr.h | 78 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)

[...]

> > +#define ESR_ELx_IL		(UL(1) << 25)
> > +#define ESR_ELx_ISS_MASK	(ESR_ELx_IL - 1)
> > +#define ESR_ELx_ISV		(UL(1) << 24)
> > +#define ESR_ELx_SAS		(UL(1) << 22)
> 
> shouldn't this be UL(3) << 22 (or a mask/shift equivalend declaration)?

Yes, it should.

[...]

> > +#define ESR_ELx_FSC		(0x3F)
> > +#define ESR_ELx_FSC_TYPE	(0x3C)
> > +#define ESR_ELx_FSC_EXTABT	(0x10)
> > +#define ESR_ELx_FSC_FAULT	(0x04)
> > +#define ESR_ELx_FSC_PERM	(0x0F)
> 
> this should be 0x0C right?

Yes.

Thanks for spotting these! I've fixed them up locally and I'll give the
rest another once-over before I post v2.

Mark.
