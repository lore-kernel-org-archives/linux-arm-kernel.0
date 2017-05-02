From: james.morse@arm.com (James Morse)
Date: Tue, 02 May 2017 16:29:00 +0100
Subject: [PATCH v3 1/3] arm64: kvm: support kvmtool to detect RAS extension
 feature
In-Reply-To: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <5908A5BC.1060202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 30/04/17 06:37, Dongjiu Geng wrote:
> Handle kvmtool's detection for RAS extension, because sometimes
> the APP needs to know the CPU's capacity

> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index d9e9697..1004039 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -64,6 +64,14 @@ static bool cpu_has_32bit_el1(void)
>  	return !!(pfr0 & 0x20);
>  }
>  
> +static bool kvm_arm_support_ras_extension(void)
> +{
> +	u64 pfr0;
> +
> +	pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
> +	return !!(pfr0 & 0x10000000);
> +}

Why are we telling user-space that the CPU has RAS extensions? EL0 can't do
anything with this and the guest EL1 can detect it from the id registers.


Are you using this to decide whether or not to generate a HEST for the guest?

If Qemu/kvmtool supports handling memory-failure notifications from signals you
should always generate a HEST. The GHES notification method could be anything
Qemu can deliver to the guest using the KVM APIs. Notifications from Qemu to the
guest don't depend on the RAS extensions. KVM has APIs for IRQ and SEA (you can
use KVM_SET_ONE_REG).


I think we need a new API for injecting SError for SEI from Qemu/kvmtool, but it
shouldn't be related to the RAS extensions. All v8.0 CPUs have HCR_EL2.VSE, so
we need to know KVM supports this API.

Your later patch adds code to set VSESR to make virtual RAS SErrors work, I
think we need to expose that to user-space.


Thanks,

James
