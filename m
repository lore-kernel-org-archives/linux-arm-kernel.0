From: james.morse@arm.com (James Morse)
Date: Tue, 3 Jul 2018 17:32:09 +0100
Subject: [PATCH v10 08/14] arm64: kexec_file: load initrd and device-tree
In-Reply-To: <20180623022058.10935-9-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-9-takahiro.akashi@linaro.org>
Message-ID: <1e401f4e-6176-990d-476c-31ae3f28f26c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 23/06/18 03:20, AKASHI Takahiro wrote:
> load_other_segments() is expected to allocate and place all the necessary
> memory segments other than kernel, including initrd and device-tree
> blob (and elf core header for crash).
> While most of the code was borrowed from kexec-tools' counterpart,
> users may not be allowed to specify dtb explicitly, instead, the dtb
> presented by the original boot loader is reused.
> 
> arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
> specific data allocated in load_other_segments().


> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index c38a8048ed00..7115c4f915dc 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c

> +static int setup_dtb(struct kimage *image,
> +		unsigned long initrd_load_addr, unsigned long initrd_len,
> +		char *cmdline, unsigned long cmdline_len,
> +		char **dtb_buf, size_t *dtb_buf_len)
> +{
> +	char *buf = NULL;
> +	size_t buf_size;
> +	int nodeoffset;
> +	u64 value;
> +	int ret;
> +
> +	/* duplicate dt blob */
> +	buf_size = fdt_totalsize(initial_boot_params);
> +
> +	if (initrd_load_addr) {
> +		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64));
> +		buf_size += fdt_prop_len("linux,initrd-end", sizeof(u64));
> +	}
> +
> +	if (cmdline)
> +		buf_size += fdt_prop_len("bootargs", cmdline_len + 1);

(a comment here about the possibility of an embedded NULL may avoid surprises later)


> +	buf = vmalloc(buf_size);
> +	if (!buf) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	ret = fdt_open_into(initial_boot_params, buf, buf_size);
> +	if (ret)
> +		goto out_err;
> +
> +	nodeoffset = fdt_path_offset(buf, "/chosen");
> +	if (nodeoffset < 0)
> +		goto out_err;

This doesn't update 'ret', so we return the 0/success from above...


> +
> +	/* add bootargs */
> +	if (cmdline) {
> +		ret = fdt_setprop(buf, nodeoffset, "bootargs",
> +						cmdline, cmdline_len + 1);
> +		if (ret)
> +			goto out_err;
> +	}

So (cmdline_len == 0) from user-space means keep the old cmdline. Sounds
sensible. Is this documented anywhere?

powerpc does the opposite, it deletes the bootargs in this case. Are we happy
making his a per-arch thing?


> +	/* add initrd-* */
> +	if (initrd_load_addr) {
> +		value = cpu_to_fdt64(initrd_load_addr);
> +		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-start",
> +							value);
> +		if (ret)
> +			goto out_err;
> +
> +		value = cpu_to_fdt64(initrd_load_addr + initrd_len);
> +		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-end",
> +							value);
> +		if (ret)
> +			goto out_err;
> +	}

Won't this do the same with the initrd? Re-use the old values if no new one was
provided? I can't find anything that deletes the property by the time we come to
kexec, and the old physical addresses may have been re-used by who-knows-what.

(powerpc has some code to: /* If there's no new initrd, delete the old initrd's
info. */)



Thanks,

James
