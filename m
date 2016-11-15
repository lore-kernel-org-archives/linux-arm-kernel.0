From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Nov 2016 12:41:51 +0100
Subject: [PATCH] arm/arm64: KVM: clean up useless code in kvm_timer_enable
In-Reply-To: <1478659814-364872-1-git-send-email-longpeng2@huawei.com>
References: <1478659814-364872-1-git-send-email-longpeng2@huawei.com>
Message-ID: <20161115114151.GA3811@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 10:50:14AM +0800, Longpeng(Mike) wrote:
> 1) Since commit:41a54482 changed timer enabled variable to per-vcpu,
>    the correlative comment in kvm_timer_enable is useless now.
> 
> 2) After the kvm module init successfully, the timecounter is always
>    non-null, so we can remove the checking of timercounter.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

> ---
>  virt/kvm/arm/arch_timer.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 27a1f63..17b8fa5 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -498,17 +498,7 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
>  	if (ret)
>  		return ret;
>  
> -
> -	/*
> -	 * There is a potential race here between VCPUs starting for the first
> -	 * time, which may be enabling the timer multiple times.  That doesn't
> -	 * hurt though, because we're just setting a variable to the same
> -	 * variable that it already was.  The important thing is that all
> -	 * VCPUs have the enabled variable set, before entering the guest, if
> -	 * the arch timers are enabled.
> -	 */
> -	if (timecounter)
> -		timer->enabled = 1;
> +	timer->enabled = 1;
>  
>  	return 0;
>  }
> -- 
> 1.8.3.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
