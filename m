From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 24 Aug 2017 18:11:31 +0100
Subject: [PATCH 10/14] arm64: kexec_file: load initrd, device-tree and
 purgatory segments
In-Reply-To: <20170824081811.19299-11-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-11-takahiro.akashi@linaro.org>
Message-ID: <20170824171130.GE29665@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 05:18:07PM +0900, AKASHI Takahiro wrote:
> load_other_segments() sets up and adds all the memory segments necessary
> other than kernel, including initrd, device-tree blob and purgatory.
> Most of the code was borrowed from kexec-tools' counterpart.
> 
> In addition, arch_kexec_image_probe(), arch_kexec_image_load() and
> arch_kexec_kernel_verify_sig() are stubs for supporting multiple types
> of kernel image formats.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/kexec.h         |  18 +++
>  arch/arm64/kernel/machine_kexec_file.c | 255 +++++++++++++++++++++++++++++++++
>  2 files changed, 273 insertions(+)

> +int load_other_segments(struct kimage *image, unsigned long kernel_load_addr,
> +			char *initrd, unsigned long initrd_len,
> +			char *cmdline, unsigned long cmdline_len)
> +{
> +	struct kexec_buf kbuf;
> +	unsigned long initrd_load_addr = 0;
> +	unsigned long purgatory_load_addr, dtb_load_addr;
> +	char *dtb = NULL;
> +	unsigned long dtb_len;
> +	int ret = 0;
> +
> +	kbuf.image = image;
> +
> +	/* Load initrd */
> +	if (initrd) {
> +		kbuf.buffer = initrd;
> +		kbuf.bufsz = initrd_len;
> +		kbuf.memsz = initrd_len;
> +		kbuf.buf_align = PAGE_SIZE;
> +		/* within 1GB-aligned window of up to 32GB in size */
> +		kbuf.buf_min = kernel_load_addr;
> +		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
> +						+ (unsigned long)SZ_1G * 31;
> +		kbuf.top_down = 0;
> +
> +		ret = kexec_add_buffer(&kbuf);
> +		if (ret)
> +			goto out_err;
> +		initrd_load_addr = kbuf.mem;
> +
> +		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +				initrd_load_addr, initrd_len, initrd_len);
> +	}
> +
> +	/* Load dtb blob */
> +	ret = setup_dtb(image, initrd_load_addr, initrd_len,
> +				cmdline, cmdline_len, &dtb, &dtb_len);
> +	if (ret) {
> +		pr_err("Preparing for new dtb failed\n");
> +		goto out_err;
> +	}
> +
> +	kbuf.buffer = dtb;
> +	kbuf.bufsz = dtb_len;
> +	kbuf.memsz = dtb_len;
> +	/* not across 2MB boundary */
> +	kbuf.buf_align = SZ_2M;
> +	/*
> +	 * Note for backporting:
> +	 * On kernel prior to v4.2, fdt must reside within 512MB block
> +	 * where the kernel also resides. So
> +	 *   kbuf.buf_min = round_down(kernel_load_addr, SZ_512M);
> +	 *   kbuf.buf_max = round_up(kernel_load_addr, SZ_512M);
> +	 * would be required.
> +	 */
> +	kbuf.buf_min = kernel_load_addr;
> +	kbuf.buf_max = ULONG_MAX;
> +	kbuf.top_down = 1;

IIUC, this is trying to load the DTB above the kernel. Is that correct?

Assuming so, shouldn't that kernel_load_addr be kernel_load_addr +
image_size from the kernel header?

Otherwise, if the kernel is loaded close to the end of memory, the DTB
could overlap.

Thanks,
Mark.
