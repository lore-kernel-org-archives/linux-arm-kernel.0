From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 06 Jan 2014 12:37:19 +0000
Subject: [PATCH REPOST 5/5] ARM: kvm MMIO support BE host running LE code
In-Reply-To: <1387558125-3460-6-git-send-email-victor.kamensky@linaro.org>
 (Victor Kamensky's message of "Fri, 20 Dec 2013 16:48:45 +0000")
References: <1387558125-3460-1-git-send-email-victor.kamensky@linaro.org>
 <1387558125-3460-6-git-send-email-victor.kamensky@linaro.org>
Message-ID: <8738l1ffr4.fsf@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20 2013 at 04:48:45 PM, Victor Kamensky <victor.kamensky@linaro.org> wrote:
> In case of status register E bit is not set (LE mode) and host runs in
> BE mode we need byteswap data, so read/write is emulated correctly.

I don't think this is correct.

The only reason we byteswap the value in the BE guest case is because it
has byteswapped the data the first place.

With a LE guest, the value we get in the register is the right one, no
need for further processing. I think your additional byteswap only
hides bugs somewhere else in the stack.

	M.

> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/include/asm/kvm_emulate.h | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> index 0fa90c9..69b7469 100644
> --- a/arch/arm/include/asm/kvm_emulate.h
> +++ b/arch/arm/include/asm/kvm_emulate.h
> @@ -185,9 +185,16 @@ static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
>  		default:
>  			return be32_to_cpu(data);
>  		}
> +	} else {
> +		switch (len) {
> +		case 1:
> +			return data & 0xff;
> +		case 2:
> +			return le16_to_cpu(data & 0xffff);
> +		default:
> +			return le32_to_cpu(data);
> +		}
>  	}
> -
> -	return data;		/* Leave LE untouched */
>  }
>  
>  static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
> @@ -203,9 +210,16 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
>  		default:
>  			return cpu_to_be32(data);
>  		}
> +	} else {
> +		switch (len) {
> +		case 1:
> +			return data & 0xff;
> +		case 2:
> +			return cpu_to_le16(data & 0xffff);
> +		default:
> +			return cpu_to_le32(data);
> +		}
>  	}
> -
> -	return data;		/* Leave LE untouched */
>  }
>  
>  #endif /* __ARM_KVM_EMULATE_H__ */

-- 
Jazz is not dead. It just smells funny.
