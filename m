From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 16 Jul 2012 09:40:06 +0800
Subject: [PATCH v5] ARM: vfp: Always save VFP state in vfp_pm_suspend
In-Reply-To: <20120715215342.4DAB99D401E@zog.reactivated.net>
References: <20120715215342.4DAB99D401E@zog.reactivated.net>
Message-ID: <CAGsJ_4x5S4Aq-nJU1nyyw7E8Q82UPm0pNP-NYJ5N8aGn=nMdgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/16 Daniel Drake <dsd@laptop.org>:
> From: Colin Cross <ccross@android.com>
>
> vfp_pm_suspend should save the VFP state any time there is
> a vfp_current_hw_state.  If it only saves when the VFP is enabled,
> the state can get lost when, on a UP system:
>    Thread 1 uses the VFP
>    Context switch occurs to thread 2, VFP is disabled but the
>       VFP context is not saved to allow lazy save and restore
>    Thread 2 initiates suspend
>    vfp_pm_suspend is called with the VFP disabled, but the
>       context has not been saved.
>
> Modify vfp_pm_suspend to save the VFP context whenever
> vfp_current_hw_state is set.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> Cc: Binghua Duan <binghua.duan@csr.com>
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> Signed-off-by: Barry Song <21cnbao@gmail.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/vfp/vfpmodule.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> Fixes a real-life issue found on OLPC laptops:
> http://lists.arm.linux.org.uk/lurker/message/20120715.044946.c30fff2b.en.html

we also found this kind of issue too, sometimes suspend/resume will
fail with this bug.
so we refined this patch before. but i am really wondering why it has
not been committed yet.

>
> v4->v5: last_VFP_context has been renamed to vfp_current_hw_state.
>
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 58696192..c86fc52 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -457,6 +457,10 @@ static int vfp_pm_suspend(void)
>
>                 /* disable, just in case */
>                 fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
> +       } else if (vfp_current_hw_state[ti->cpu]) {
> +               fmxr(FPEXC, fpexc | FPEXC_EN);
> +               vfp_save_state(vfp_current_hw_state[ti->cpu], fpexc);
> +               fmxr(FPEXC, fpexc);
>         }
>
>         /* clear any information we had about last context state */
> --
> 1.7.10.4
>

-barry
