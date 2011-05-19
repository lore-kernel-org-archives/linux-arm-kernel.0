From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 19 May 2011 09:40:55 +0800
Subject: [PATCH v4] ARM: vfp: Always save VFP state in vfp_pm_suspend
In-Reply-To: <1304975791-8175-1-git-send-email-21cnbao@gmail.com>
References: <1304975791-8175-1-git-send-email-21cnbao@gmail.com>
Message-ID: <BANLkTikPd5AVJa-n1V1eyqh-HBACOi-ggQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any update for this?

2011/5/10 Barry Song <21cnbao@gmail.com>:
> From: Colin Cross <ccross@android.com>
>
> vfp_pm_suspend should save the VFP state any time there is
> a last_VFP_context. ?If it only saves when the VFP is enabled,
> the state can get lost when, on a UP system:
> ? Thread 1 uses the VFP
> ? Context switch occurs to thread 2, VFP is disabled but the
> ? ? ?VFP context is not saved to allow lazy save and restore
> ? Thread 2 initiates suspend
> ? vfp_pm_suspend is called with the VFP disabled, but the
> ? ? ?context has not been saved.
>
> Modify vfp_pm_suspend to save the VFP context whenever
> last_VFP_context is set.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> Cc: Binghua Duan <binghua.duan@csr.com>
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> Signed-off-by: Barry Song <21cnbao@gmail.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> ?arch/arm/vfp/vfpmodule.c | ? ?4 ++++
> ?1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index f746950..e6fe6ae 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -412,6 +412,10 @@ static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
>
> ? ? ? ? ? ? ? ?/* disable, just in case */
> ? ? ? ? ? ? ? ?fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
> + ? ? ? } else if (last_VFP_context[ti->cpu]) {
> + ? ? ? ? ? ? ? fmxr(FPEXC, fpexc | FPEXC_EN);
> + ? ? ? ? ? ? ? vfp_save_state(last_VFP_context[ti->cpu], fpexc);
> + ? ? ? ? ? ? ? fmxr(FPEXC, fpexc);
> ? ? ? ?}
>
> ? ? ? ?/* clear any information we had about last context state */
> --
> 1.6.0.4
>
>
