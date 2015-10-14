From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Oct 2015 18:32:07 +0100
Subject: [PATCHv3 08/11] arm64: Check for selected granule support
In-Reply-To: <20151014172418.GI5041@leverpostej>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
 <20151014172418.GI5041@leverpostej>
Message-ID: <20151014173206.GK5041@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 06:24:18PM +0100, Mark Rutland wrote:
> > @@ -613,10 +614,28 @@ ENDPROC(__secondary_switched)
> >   *  x0  = SCTLR_EL1 value for turning on the MMU.
> >   *  x27 = *virtual* address to jump to upon completion
> >   *
> > - * other registers depend on the function called upon completion
> > + * Other registers depend on the function called upon completion.
> > + *
> > + * Checks if the selected granule size is supported by the CPU.
> > + * If it doesn't park the CPU
> 
> Nit: "If it isn't, park the CPU."
> 
> >   */
> > +#if	defined(CONFIG_ARM64_64K_PAGES)
> > +
> > +#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN64_SHIFT
> > +#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN64_ON
> > +
> > +#else
> > +
> > +#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN4_SHIFT
> > +#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN4_ON
> 
> Any reason for not using upper-case names for the macros?
> 
> Given they're local you could just call them TGRAN_SHIFT and TRGRAN_ON
> to make the asm slightly nicer.

Actually, even better, s/TGRAN_ON/TGRAN_SUPPORTED/

Mark.
