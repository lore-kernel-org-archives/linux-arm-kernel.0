From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 30 Jan 2015 12:29:30 -0500 (EST)
Subject: Continuing kallsyms failures - large kernels, XIP kernels,
 and large XIP kernels
In-Reply-To: <20150130153414.GM26493@n2100.arm.linux.org.uk>
References: <20150130145642.GK26493@n2100.arm.linux.org.uk>
 <20150130153414.GM26493@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1501301224180.1322@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Jan 2015, Russell King - ARM Linux wrote:

> Here's a potential patch for issue 2b - to cause the link to fail if
> the resulting kernel would be broken by trying to run it.
> 
>  arch/arm/kernel/vmlinux.lds.S | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index b31aa73e8076..9351f7fbdfb1 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -351,3 +351,13 @@ ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
>   * The above comment applies as well.
>   */
>  ASSERT(((__hyp_idmap_text_end - __hyp_idmap_text_start) <= PAGE_SIZE), "HYP init code too big")
> +
> +#ifdef CONFIG_XIP_KERNEL
> +/*
> + * __data_loc is not only the LMA of the data section, but also the VMA of
> + * the end of the .rodata section.  This must not overlap the VMA of the
> + * data section.  Since the .text section starts in module space, and that
> + * is always below the .data section, this should be sufficient.
> + */
> +ASSERT((_data >= __data_loc), "Text section oversize")
> +#endif

I agree with this patch.

Acked-by: Nicolas Pitre <nico@linaro.org>

This might not prevent a config leading to this from happening, but at 
least it makes the issue much clearer.  XIP kernel was created for 
systems where the total amount of RAM is often smaller than the imposed
size limit here.


Nicolas
