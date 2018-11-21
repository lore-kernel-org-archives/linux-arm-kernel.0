From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Nov 2018 16:35:25 +0000
Subject: [RFC PATCH v2 17/23] arm64/sve: In-kernel vector length
 availability query interface
In-Reply-To: <87in0qiexh.fsf@linaro.org>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-18-git-send-email-Dave.Martin@arm.com>
 <87in0qiexh.fsf@linaro.org>
Message-ID: <20181121163525.GD3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 04:16:42PM +0000, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > KVM will need to interrogate the set of SVE vector lengths
> > available on the system.
> >
> > This patch exposes the relevant bits to the kernel, along with a
> > sve_vq_available() helper to check whether a particular vector
> > length is supported.
> >
> > vq_to_bit() and bit_to_vq() are not intended for use outside these
> > functions, so they are given a __ prefix to warn people not to use
> > them unless they really know what they are doing.
> 
> Personally I wouldn't have bothered with the __ but whatever:
> 
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

OK, thanks

I'll probably keep the __ unless somebody else objects, but if you feel
strongly I could get rid of it.

Perhaps I simply shouldn't have called attention to it in the commit
message ;)

Cheers
---Dave

> 
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/include/asm/fpsimd.h | 29 +++++++++++++++++++++++++++++
> >  arch/arm64/kernel/fpsimd.c      | 35 ++++++++---------------------------
> >  2 files changed, 37 insertions(+), 27 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> > index df7a143..ad6d2e4 100644
> > --- a/arch/arm64/include/asm/fpsimd.h
> > +++ b/arch/arm64/include/asm/fpsimd.h
> > @@ -24,10 +24,13 @@
> >
> >  #ifndef __ASSEMBLY__
> >
> > +#include <linux/bitmap.h>
> >  #include <linux/build_bug.h>
> > +#include <linux/bug.h>
> >  #include <linux/cache.h>
> >  #include <linux/init.h>
> >  #include <linux/stddef.h>
> > +#include <linux/types.h>
> >
> >  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
> >  /* Masks for extracting the FPSR and FPCR from the FPSCR */
> > @@ -89,6 +92,32 @@ extern u64 read_zcr_features(void);
> >
> >  extern int __ro_after_init sve_max_vl;
> >  extern int __ro_after_init sve_max_virtualisable_vl;
> > +/* Set of available vector lengths, as vq_to_bit(vq): */
> > +extern __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
> > +
> > +/*
> > + * Helpers to translate bit indices in sve_vq_map to VQ values (and
> > + * vice versa).  This allows find_next_bit() to be used to find the
> > + * _maximum_ VQ not exceeding a certain value.
> > + */
> > +static inline unsigned int __vq_to_bit(unsigned int vq)
> > +{
> > +	return SVE_VQ_MAX - vq;
> > +}
> > +
> > +static inline unsigned int __bit_to_vq(unsigned int bit)
> > +{

[...]
