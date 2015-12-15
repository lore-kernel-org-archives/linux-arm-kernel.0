From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Dec 2015 17:15:18 +0000
Subject: [PATCH v12 09/16] arm64/kexec: Add pr_devel output
In-Reply-To: <0e4d27286ec607b0c1f6e17b3034279c96d6b6a6.1448403503.git.geoff@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <0e4d27286ec607b0c1f6e17b3034279c96d6b6a6.1448403503.git.geoff@infradead.org>
Message-ID: <20151215171517.GB353@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 10:25:34PM +0000, Geoff Levand wrote:
> To aid in debugging kexec problems or when adding new functionality to kexec add
> a new routine kexec_image_info() and several inline pr_devel statements.

We don't currently have any pr_devel invocations under arm64. Can you
either remove these or change them to pr_debug?

> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/kernel/machine_kexec.c | 63 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 8b990b8..da28a26 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -25,6 +25,48 @@ extern const unsigned long arm64_relocate_new_kernel_size;
>  
>  static unsigned long kimage_start;
>  
> +/**
> + * kexec_is_dtb - Helper routine to check the device tree header signature.
> + */
> +static bool kexec_is_dtb(const void *dtb)
> +{
> +	__be32 magic;
> +
> +	return get_user(magic, (__be32 *)dtb) ? false :
> +		(be32_to_cpu(magic) == OF_DT_HEADER);

Isn't there an fdt32_to_cpu helper for this already? I also can't help
but thing this would be more readable if you didn't bother with the
ternary if form.

Will
