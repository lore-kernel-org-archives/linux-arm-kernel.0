From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 22 Aug 2017 18:22:24 +0100
Subject: [PATCH 12/27] arm64/sve: Support vector length resetting for new
 processes
In-Reply-To: <871so3bmj0.fsf@linaro.org>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
 <1502280338-23002-13-git-send-email-Dave.Martin@arm.com>
 <871so3bmj0.fsf@linaro.org>
Message-ID: <20170822172224.GY6321@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 05:22:11PM +0100, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > It's desirable to be able to reset the vector length to some sane
> > default for new processes, since the new binary and its libraries
> > processes may or may not be SVE-aware.
> >
> > This patch tracks the desired post-exec vector length (if any) in a
> > new thread member sve_vl_onexec, and adds a new thread flag
> > TIF_SVE_VL_INHERIT to control whether to inherit or reset the
> > vector length.  Currently these are inactive.  Subsequent patches
> > will provide the capability to configure them.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/include/asm/processor.h   |  1 +
> >  arch/arm64/include/asm/thread_info.h |  1 +
> >  arch/arm64/kernel/fpsimd.c           | 13 +++++++++++++
> >  3 files changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> > index 969feed..da8802a 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -87,6 +87,7 @@ struct thread_struct {
> >  	struct fpsimd_state	fpsimd_state;
> >  	void			*sve_state;	/* SVE registers, if any */
> >  	u16			sve_vl;		/* SVE vector length */
> > +	u16			sve_vl_onexec;	/* SVE vl after next
> > exec */
> 
> Inconsistent size usage here as well...

Agreed, the same history applies as for sve_vl.  I'll replace this with
an unsigned int.

[...]

Cheers
---Dave
