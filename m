From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 20 Mar 2017 18:12:52 +0000
Subject: [PATCH v3 04/19] KVM: arm64: ITS: KVM_DEV_ARM_VGIC_GRP_ITS_REGS
 group
In-Reply-To: <1488800074-21991-5-git-send-email-eric.auger@redhat.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
 <1488800074-21991-5-git-send-email-eric.auger@redhat.com>
Message-ID: <0fc9f005-bc80-c66f-ad23-9baaae07fcde@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 06/03/17 11:34, Eric Auger wrote:
> The ITS KVM device exposes a new KVM_DEV_ARM_VGIC_GRP_ITS_REGS
> group which allows the userspace to save/restore ITS registers.
> 
> At this stage the get/set/has operations are not yet implemented.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

> ---
>  arch/arm/include/uapi/asm/kvm.h   |  1 +
>  arch/arm64/include/uapi/asm/kvm.h |  1 +
>  virt/kvm/arm/vgic/vgic-its.c      | 36 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 37 insertions(+), 1 deletion(-)

....

> @@ -1520,10 +1544,20 @@ static int vgic_its_get_attr(struct kvm_device *dev,
>  		if (copy_to_user(uaddr, &addr, sizeof(addr)))
>  			return -EFAULT;
>  		break;
> +	}
> +	case KVM_DEV_ARM_VGIC_GRP_ITS_REGS: {
> +		u64 __user *uaddr = (u64 __user *)(long)attr->addr;
> +		u64 reg;
> +		int ret;
> +
> +		ret = vgic_its_attr_regs_access(dev, attr, &reg, false);
> +		if (ret)
> +			return ret;
> +		return put_user(reg, uaddr);
> +	}
>  	default:
>  		return -ENXIO;
>  	}
> -	}

And thanks for finding and fixing this nasty mishap. Fortunately C
doesn't care about blocks in switch statements too much, so I think this
works as intended (so it's not a "real" bug).

Cheers,
Andre.
