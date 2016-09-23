From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 23 Sep 2016 14:11:41 +0200
Subject: [PATCH v6] KVM: arm/arm64: Route vtimer events to user space
In-Reply-To: <1474628854-69945-1-git-send-email-agraf@suse.de>
References: <1474628854-69945-1-git-send-email-agraf@suse.de>
Message-ID: <dd9267b6-2323-2d74-0553-71a89d05a654@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/09/2016 13:07, Alexander Graf wrote:
> +		timer_ret = kvm_timer_sync_hwstate(vcpu);
>  
>  		kvm_vgic_sync_hwstate(vcpu);
>  
>  		preempt_enable();
>  
>  		ret = handle_exit(vcpu, run, ret);
> +
> +		if ((ret == 1) && timer_ret) {
> +			/*
> +			 * We have to exit straight away to ensure that we only
> +			 * ever notify user space once about a level change
> +			 */

Is this really a requirement?  It complicates the logic noticeably.

Paolo

> +			ret = -EINTR;
> +			run->exit_reason = KVM_EXIT_INTR;
> +		}
>  	}
