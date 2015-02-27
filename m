From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 27 Feb 2015 12:07:51 +0000
Subject: [PATCH] arm/arm64: KVM: fix missing unlock on error in
 kvm_vgic_create()
In-Reply-To: <1425037305-23292-1-git-send-email-weiyj_lk@163.com>
References: <1425037305-23292-1-git-send-email-weiyj_lk@163.com>
Message-ID: <54F05E17.9090904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On 27/02/15 11:41, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing unlock before return from function kvm_vgic_create()
> in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  virt/kvm/arm/vgic.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 0cc6ab6..4b2c2e7 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1583,8 +1583,10 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>  	 * emulation. So check this here again. KVM_CREATE_DEVICE does
>  	 * the proper checks already.
>  	 */
> -	if (type == KVM_DEV_TYPE_ARM_VGIC_V2 && !vgic->can_emulate_gicv2)
> -		return -ENODEV;
> +	if (type == KVM_DEV_TYPE_ARM_VGIC_V2 && !vgic->can_emulate_gicv2) {
> +		ret = -ENODEV;
> +		goto out;
> +	}

Ah, good catch. Embarrassing that that could slip through ...


Acked-by: Andre Przywara <andre.przywara@arm.com>


Out of curiosity: did you see it hang or was this just by looking at the
code? I thought that I tested this case ...

Cheers,
Andre.
