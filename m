From: james.morse@arm.com (James Morse)
Date: Fri, 11 Mar 2016 11:39:51 +0000
Subject: [PATCH v14 14/20] arm64/kexec: Add pr_debug output
In-Reply-To: <b11ec7d6be4debe94cd91c20d218f4015980d057.1457135058.git.geoff@infradead.org>
References: <cover.1457135058.git.geoff@infradead.org>
 <b11ec7d6be4debe94cd91c20d218f4015980d057.1457135058.git.geoff@infradead.org>
Message-ID: <56E2AE87.4060209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 04/03/16 23:51, Geoff Levand wrote:
> To aid in debugging kexec problems or when adding new functionality to kexec add
> a new routine kexec_image_info() and several inline pr_debug statements.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

[ ... snip ...]

> +/**
> + * kexec_image_info - For debugging output.
> + */
> +#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
> +static void _kexec_image_info(const char *func, int line,
> +	const struct kimage *kimage)
> +{
> +	unsigned long i;
> +

> +#ifndef DEBUG
> +	return;
> +#endif

>From include/linux/printk.h on pr_foo():
> * All of these will print unconditionally, although note that pr_debug()
> * and other debug macros are compiled out unless either DEBUG is defined

So you can remove the #ifdef ... return, as all the pr_debug() calls will be
removed by the compiler in this case. (which also explains why it doesn't
complain about unreachable code!)


> +	pr_debug("%s:%d:\n", func, line);
> +	pr_debug("  kexec kimage info:\n");
> +	pr_debug("    type:        %d\n", kimage->type);
> +	pr_debug("    start:       %lx\n", kimage->start);
> +	pr_debug("    head:        %lx\n", kimage->head);
> +	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
> +
> +	for (i = 0; i < kimage->nr_segments; i++) {
> +		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages%s\n",
> +			i,
> +			kimage->segment[i].mem,
> +			kimage->segment[i].mem + kimage->segment[i].memsz,
> +			kimage->segment[i].memsz,
> +			kimage->segment[i].memsz /  PAGE_SIZE,
> +			(kexec_is_dtb(kimage->segment[i].buf) ?
> +				", dtb segment" : ""));
> +	}
> +}
> +
>  void machine_kexec_cleanup(struct kimage *kimage)
>  {
>  	/* Empty routine needed to avoid build errors. */


Thanks,

James
