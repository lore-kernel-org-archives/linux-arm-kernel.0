From: cdall@linaro.org (Christoffer Dall)
Date: Fri, 9 Jun 2017 10:41:34 +0200
Subject: [PATCH] KVM: ARM64: fix phy counter access failure in guest.
In-Reply-To: <20170609162220.1460-1-huhuajun@huawei.com>
References: <20170609162220.1460-1-huhuajun@huawei.com>
Message-ID: <20170609084134.GC6378@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 10, 2017 at 12:22:20AM +0800, Hu Huajun wrote:
> When reading the cntpct_el0 in guest with VHE (Virtual Host Extension)
> enabled in host, the "Unsupported guest sys_reg access" error reported.
> The reason is cnthctl_el2.EL1PCTEN is not enabled, which is expected
> to be done in kvm_timer_init_vhe(). The problem is kvm_timer_init_vhe
> is called by cpu_init_hyp_mode, and which is called when VHE is disabled.
> This patch calls kvm_timer_init_vhe() to enable cnthctl_el2.EL1PCTEN
> in cpu_hyp_reinit().
> 
> Signed-off-by: Hu Huajun <huhuajun@huawei.com>
> ---
>  virt/kvm/arm/arm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 3417e18..b703741 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1137,6 +1137,7 @@ static void cpu_hyp_reinit(void)
>  		 * event was cancelled before the CPU was reset.
>  		 */
>  		__cpu_init_stage2();
> +		kvm_timer_init_vhe();
>  	} else {
>  		cpu_init_hyp_mode(NULL);
>  	}
> -- 
> 2.10.1
> 

Could you rework this patch to remove the incorrect call to
kvm_timer_init_vhe() from cpu_init_hyp_mode() as well?

Thanks,
-Christoffer
