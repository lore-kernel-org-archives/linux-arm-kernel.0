From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 6 Sep 2017 09:17:41 +0100
Subject: [PATCH] arm64: KVM: VHE: save and restore some PSTATE bits
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2015DF717@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2015DF717@DGGEMA503-MBX.china.huawei.com>
Message-ID: <2a5d4299-2523-aef5-7db1-f351ca66b562@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/17 19:58, gengdongjiu wrote:
> when exit from guest, some host PSTATE bits may be lost, such as
> PSTATE.PAN or PSTATE.UAO. It is because host and hypervisor all run
> in the EL2, host PSTATE value cannot be saved and restored via
> SPSR_EL2. So if guest has changed the PSTATE, host continues with
> a wrong value guest has set.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Haibin Zhang <zhanghaibin7@huawei.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  8 +++++++
>  arch/arm64/include/asm/kvm_hyp.h  |  2 ++
>  arch/arm64/include/asm/sysreg.h   | 23 +++++++++++++++++++
>  arch/arm64/kvm/hyp/entry.S        |  2 --
>  arch/arm64/kvm/hyp/switch.c       | 24 ++++++++++++++++++--
>  arch/arm64/kvm/hyp/sysreg-sr.c    | 48 ++++++++++++++++++++++++++++++++++++---
>  6 files changed, 100 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index e923b58..cba7d3e 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -193,6 +193,12 @@ struct kvm_cpu_context {
>  	};
>  };
>  
> +struct kvm_cpu_host_pstate {
> +	u64 daif;
> +	u64 uao;
> +	u64 pan;
> +};

I love it. This is the most expensive way of saving/restoring a single
32bit value.

More seriously, please see the discussion between James and Christoffer
there[1]. I expect James to address the PAN/UAO states together with the
debug state in the next iteration of his patch.

Thanks,

	M.

[1] https://www.spinics.net/lists/arm-kernel/msg599798.html
-- 
Jazz is not dead. It just smells funny...
