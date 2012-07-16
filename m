From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jul 2012 12:33:02 +0100
Subject: [PATCH v5] ARM: vfp: Always save VFP state in vfp_pm_suspend
In-Reply-To: <CAGsJ_4x5S4Aq-nJU1nyyw7E8Q82UPm0pNP-NYJ5N8aGn=nMdgw@mail.gmail.com>
References: <20120715215342.4DAB99D401E@zog.reactivated.net>
 <CAGsJ_4x5S4Aq-nJU1nyyw7E8Q82UPm0pNP-NYJ5N8aGn=nMdgw@mail.gmail.com>
Message-ID: <20120716113302.GG26723@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 02:40:06AM +0100, Barry Song wrote:
> 2012/7/16 Daniel Drake <dsd@laptop.org>:
> > From: Colin Cross <ccross@android.com>
> >
> > vfp_pm_suspend should save the VFP state any time there is
> > a vfp_current_hw_state.  If it only saves when the VFP is enabled,
> > the state can get lost when, on a UP system:
> >    Thread 1 uses the VFP
> >    Context switch occurs to thread 2, VFP is disabled but the
> >       VFP context is not saved to allow lazy save and restore
> >    Thread 2 initiates suspend
> >    vfp_pm_suspend is called with the VFP disabled, but the
> >       context has not been saved.
> >
> > Modify vfp_pm_suspend to save the VFP context whenever
> > vfp_current_hw_state is set.
> >
> > Signed-off-by: Colin Cross <ccross@android.com>
> > Cc: Binghua Duan <binghua.duan@csr.com>
> > Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> > Signed-off-by: Barry Song <21cnbao@gmail.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> we also found this kind of issue too, sometimes suspend/resume will
> fail with this bug.
> so we refined this patch before. but i am really wondering why it has
> not been committed yet.

At a guess, it hasn't been applied because nobody has submitted it to the
patch system.

> > diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> > index 58696192..c86fc52 100644
> > --- a/arch/arm/vfp/vfpmodule.c
> > +++ b/arch/arm/vfp/vfpmodule.c
> > @@ -457,6 +457,10 @@ static int vfp_pm_suspend(void)
> >
> >                 /* disable, just in case */
> >                 fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
> > +       } else if (vfp_current_hw_state[ti->cpu]) {
> > +               fmxr(FPEXC, fpexc | FPEXC_EN);
> > +               vfp_save_state(vfp_current_hw_state[ti->cpu], fpexc);
> > +               fmxr(FPEXC, fpexc);

Given that we don't do lazy saving on SMP systems, can we make this
conditional on !SMP?

Will
