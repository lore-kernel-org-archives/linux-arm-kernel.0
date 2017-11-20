From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Nov 2017 14:41:47 +0000
Subject: [PATCH v2 06/18] arm64: kvm: use -fno-jump-tables with clang
In-Reply-To: <20171115213428.22559-7-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-7-samitolvanen@google.com>
Message-ID: <20171120144147.7iawjcw644zc4xes@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 01:34:16PM -0800, Sami Tolvanen wrote:
> Use -fno-jump-tables to make sure clang doesn't generate branches
> to EL1 virtual addresses.

Are there any other reasons that clang might generate absolute
references/relocations?

It would be nice if there was the option to disable that more generally,
rather than disabling individual optimizations. Is there any PIC/PIE
option that we could use?

We might need something simnilar for GCC, even if we're not seeing
problems today.

Thanks,
Mark.

> Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kvm/hyp/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> index f04400d494b7..19fa1c6b6b69 100644
> --- a/arch/arm64/kvm/hyp/Makefile
> +++ b/arch/arm64/kvm/hyp/Makefile
> @@ -5,6 +5,10 @@
>  
>  ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING
>  
> +ifeq ($(cc-name),clang)
> +ccflags-y += -fno-jump-tables
> +endif
> +
>  KVM=../../../../virt/kvm
>  
>  obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
> -- 
> 2.15.0.448.gf294e3d99a-goog
> 
