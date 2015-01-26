From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Jan 2015 19:19:42 +0000
Subject: [PATCH 7/8] arm64/kexec: Add checks for KVM
In-Reply-To: <a3353cf2ac47f49c20bbbb88405301cbaa359805.1421449714.git.geoff@infradead.org>
References: <cover.1421449714.git.geoff@infradead.org>
 <a3353cf2ac47f49c20bbbb88405301cbaa359805.1421449714.git.geoff@infradead.org>
Message-ID: <20150126191942.GQ23313@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> Add runtime checks that fail the arm64 kexec syscall for situations that would
> result in system instability do to problems in the KVM kernel support.
> These checks should be removed when the KVM problems are resolved fixed.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/kernel/machine_kexec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 3d84759..a36459d 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -16,6 +16,9 @@
>  #include <asm/cacheflush.h>
>  #include <asm/system_misc.h>
>  
> +/* TODO: Remove this include when KVM can support a kexec reboot. */
> +#include <asm/virt.h>
> +
>  /* Global variables for the relocate_kernel routine. */
>  extern const unsigned char relocate_new_kernel[];
>  extern const unsigned long relocate_new_kernel_size;
> @@ -100,6 +103,13 @@ int machine_kexec_prepare(struct kimage *image)
>  
>  	kexec_image_info(image);
>  
> +	/* TODO: Remove this message when KVM can support a kexec reboot. */
> +	if (IS_ENABLED(CONFIG_KVM) && is_hyp_mode_available()) {
> +		pr_err("%s: Your kernel is configured with KVM support (CONFIG_KVM=y) which currently does not allow for kexec re-boot.\n",
> +			__func__);
> +		return -ENOSYS;
> +	}

If you really don't want to implement KVM teardown, surely this should
be at the start of the series, so we don't have a point in the middle
where things may explode in this case?

Mark.
