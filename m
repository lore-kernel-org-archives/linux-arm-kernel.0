From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 03 May 2011 11:33:45 +0100
Subject: [PATCH] arm:pm: save the vfp state of last scheduled-out
	proceed while suspending
In-Reply-To: <BANLkTin_uH+SnQdt7YpjrTpSFEJ4SwD+LA@mail.gmail.com>
References: <1303885825-5411-1-git-send-email-bs14@csr.com>
	<BANLkTik2shB+RPqheM8fFn8DitmsReAJHg@mail.gmail.com>
	<BANLkTinKTm1Qnwwpn1TyHbcXwguXoeC+6w@mail.gmail.com>
	<BANLkTin_uH+SnQdt7YpjrTpSFEJ4SwD+LA@mail.gmail.com>
Message-ID: <1304418825.19196.67.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-29 at 04:26 +0100, Barry Song wrote:
> 2011/4/29 Barry Song <21cnbao@gmail.com>:
> > Seems like Rongjun's codes have handled Russel's last change but in
> > the "else". Russel handles it before the "if (fpexc & FPEXC_EN) {".
> > We will take over the test in
> > http://thread.gmane.org/gmane.linux.kernel/1099558 and continue to
> > send patch v3.
> 
> but we don't think Russel's last change is complelety right by:
> /* If lazy disable, re-enable the VFP ready for it to be saved */
>         if (last_VFP_context[ti->cpu] != &ti->vfpstate) {
>                 fpexc |= FPEXC_EN;
>                 fmxr(FPEXC, fpexc);
>         }
>         /* If VFP is on, then save state for resumption */
>         if (fpexc & FPEXC_EN) {
>                 ...
> 
> there are still risk.  For example, if process p1/p2 switch like this:
> P1:     use vfp
>        swith to -> P2: don't use vfp
>                     switch to  -> P1(use vfp), but it didn't begin to
> use vfp, then  FPEXC_EN is not set, but suspend happen at that moment
> 
> At the last time, last_VFP_context[ti->cpu] will be &ti->vfpstate,
> fpexc & FPEXC_EN will be false. it loses the chance to save status.

I think your scenario is possible on UP systems. On SMP we save the VFP
context during thread switching anyway.

> So looks like Rongjun's codes can avoid this kind of risk:
>        /* if vfp is on, then save state for resumption */
>        if (fpexc & FPEXC_EN) {
> @@ -392,8 +393,16 @@ static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
> 
>                /* disable, just in case */
>                fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
> +       } else {
> +               if (last_VFP_context[cpu]) {
> +                       fmxr(FPEXC, fpexc | FPEXC_EN);
> +                       vfp_save_state(last_VFP_context[cpu], fpexc);
> +                       fmxr(FPEXC, fpexc);
> +               }
>        }

I think we need to set last_VFP_context[cpu] to NULL as well so that the
context is reloaded.

-- 
Catalin
