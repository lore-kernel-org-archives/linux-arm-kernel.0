From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 7 Jan 2015 16:42:04 +0000
Subject: [PATCH 1/7] arm64: introduce common ESR_ELx_* definitions
In-Reply-To: <20150107162320.GG2199@e104818-lin.cambridge.arm.com>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
 <1420632260-8798-2-git-send-email-mark.rutland@arm.com>
 <20150107162320.GG2199@e104818-lin.cambridge.arm.com>
Message-ID: <20150107164203.GB23642@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 04:23:20PM +0000, Catalin Marinas wrote:
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
> 
> I assume this series would go in via the kvm tree. In which case, for
> the first two patches in the series:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

Patches 3 and 4 also affect the arm64 core code and shouldn't affect
KVM. Can I get your ack for those too, or do you have any comments?

Mark.
