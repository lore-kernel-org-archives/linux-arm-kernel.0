From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jan 2017 10:55:53 +0000
Subject: [Patch v4 2/2] firmware: qcom: scm: Fix interrupted SCM calls
In-Reply-To: <CAOesGMi4xUxJNHO5hEbZHBCnTZ6xXVyzoszawPiJxBiRP1DitA@mail.gmail.com>
References: <1484845120-3364-1-git-send-email-andy.gross@linaro.org>
 <1484845120-3364-3-git-send-email-andy.gross@linaro.org>
 <CAOesGMi4xUxJNHO5hEbZHBCnTZ6xXVyzoszawPiJxBiRP1DitA@mail.gmail.com>
Message-ID: <20170130105553.GB16461@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Sun, Jan 29, 2017 at 04:24:51PM -0800, Olof Johansson wrote:
> On Thu, Jan 19, 2017 at 8:58 AM, Andy Gross <andy.gross@linaro.org> wrote:
> > This patch adds a Qualcomm specific quirk to the arm_smccc_smc call.
> >
> > On Qualcomm ARM64 platforms, the SMC call can return before it has
> > completed.  If this occurs, the call can be restarted, but it requires
> > using the returned session ID value from the interrupted SMC call.
> >
> > The quirk stores off the session ID from the interrupted call in the
> > quirk structure so that it can be used by the caller.
> >
> > This patch folds in a fix given by Sricharan R:
> > https://lkml.org/lkml/2016/9/28/272
> >
> > Signed-off-by: Andy Gross <andy.gross@linaro.org>
> > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/smccc-call.S |  9 ++++++++-
> >  drivers/firmware/qcom_scm-64.c | 13 ++++++++++---
> >  include/linux/arm-smccc.h      | 11 ++++++++---
> >  3 files changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
> > index 6290696..72ecdca 100644
> > --- a/arch/arm64/kernel/smccc-call.S
> > +++ b/arch/arm64/kernel/smccc-call.S
> > @@ -12,6 +12,7 @@
> >   *
> >   */
> >  #include <linux/linkage.h>
> > +#include <linux/arm-smccc.h>
> >  #include <asm/asm-offsets.h>
> >
> >         .macro SMCCC instr
> > @@ -20,7 +21,13 @@
> >         ldr     x4, [sp]
> >         stp     x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
> >         stp     x2, x3, [x4, #ARM_SMCCC_RES_X2_OFFS]
> > -       ret
> > +       ldr     x4, [sp, #8]
> > +       cbz     x4, 1f /* no quirk structure */
> > +       ldr     x9, [x4, #ARM_SMCCC_QUIRK_ID_OFFS]
> > +       cmp     x9, #ARM_SMCCC_QUIRK_QCOM_A6
> > +       b.ne    1f
> > +       str     x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
> > +1:     ret
> >         .cfi_endproc
> >         .endm
> 
> This extends the SMC entry/return path quite a bit.

I honestly doubt it's measurable. You've got an independent load from the
stack and a cbz that's likely predicted correctly given the static nature
of the quirk. Then you have an SMC, which is going to trap and dominate
the cost of this function.

> Is this truly a qualcomm-only quirk, or are other vendors also picking it
> up?

Currently, it's just qualcomm. Whilst I'd love to say they'll be the only
people to interpret the SMCCC in an imaginative fashion, I'd be surprised
if we don't see other vendors making mistakes in this area in the future.

> Why not either make arm_smccc_.* function pointers and update them
> accordingly, or use a custom version for the specific locations where
> you want/need to restart the calls? You are after all already wrapping
> them in qcom_scm_call().

Having the low-level SMC entry code in one place is advantageous because
it means the SMCCC contract is enforced in common code, making it easier
to debug and maintain. If a vendor got the contract so badly wrong that
it didn't resemble SMCCC, then I'd agree with you, but here we're just
saving and restoring an extra register.

> Seems like a more appropriate change than burden all platforms with
> longer code path due to your quirk.

I really don't think it's a problem. Do you have numbers suggesting
otherwise?

Will
