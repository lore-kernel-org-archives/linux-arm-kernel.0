From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 18 Jul 2018 14:56:57 +0900
Subject: [PATCH v11 09/15] arm64: kexec_file: load initrd and device-tree
In-Reply-To: <c5199d62-16f3-a0f2-fdf5-7dcbf6a02cd6@arm.com>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-10-takahiro.akashi@linaro.org>
 <c5199d62-16f3-a0f2-fdf5-7dcbf6a02cd6@arm.com>
Message-ID: <20180718055656.GG11258@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On Tue, Jul 17, 2018 at 05:57:06PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 11/07/18 08:41, AKASHI Takahiro wrote:
> > load_other_segments() is expected to allocate and place all the necessary
> > memory segments other than kernel, including initrd and device-tree
> > blob (and elf core header for crash).
> > While most of the code was borrowed from kexec-tools' counterpart,
> > users may not be allowed to specify dtb explicitly, instead, the dtb
> > presented by the original boot loader is reused.
> > 
> > arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
> > specific data allocated in load_other_segments().
> 
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index c38a8048ed00..ca00681c25c6 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> 
> > +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > +{
> > +	vfree(image->arch.dtb_buf);
> > +	image->arch.dtb_buf = NULL;
> > +
> > +	return kexec_image_post_load_cleanup_default(image);
> > +}
> 
> A nit from sparse:
> | warning: symbol 'arch_kimage_file_post_load_cleanup' was not declared
> 
> Can we add a definition for this to a header file somewhere. asm/kexec.h is
> probably the best bet.

Sparse! Ok, I will fix it.

> > +static int setup_dtb(struct kimage *image,
> > +		unsigned long initrd_load_addr, unsigned long initrd_len,
> > +		char *cmdline, unsigned long cmdline_len,
> > +		char **dtb_buf, size_t *dtb_buf_len)
> > +{
> 
> > +	/* add initrd-* */
> > +	if (initrd_load_addr) {
> > +		value = cpu_to_fdt64(initrd_load_addr);
> > +		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-start",
> > +							value);
> 
> fdt_setprop_u64() already does the endian conversion.
> 
> From scripts/dtc/libfdt/libfdt.h, its implemented as:
> | 	fdt64_t tmp = cpu_to_fdt64(val);
> | 	return fdt_setprop(fdt, nodeoffset, name, &tmp, sizeof(tmp));
> 
> (I think you were using setprop directly in an older version)

Indeed.

> This leads to:
> | ------------[ cut here ]------------
> | initrd not fully accessible via the linear mapping -- please check your
> | bootloader ...
> | WARNING: CPU: 0 PID: 0 at ../arch/arm64/mm/init.c:429
> | arm64_memblock_init+0x150/0x3d8
> | Modules linked in:
> | CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc5-00015-g95b5c843d0da #10150
> | Hardware name: AMD Seattle (Rev.B0) Development Board (Overdrive) (DT)
> | pstate: 60000085 (nZCv daIf -PAN -UAO)
> | pc : arm64_memblock_init+0x150/0x3d8
> | lr : arm64_memblock_init+0x150/0x3d8
> 
> | Call trace:
> | arm64_memblock_init+0x150/0x3d8
> | setup_arch+0x1c0/0x510
> | start_kernel+0x80/0x418
> | random: get_random_bytes called from print_oops_end_marker+0x4c/0x68 with
> | crng_init=0
> | ---[ end trace 0000000000000000 ]---
> 
> 
> Which is caused by the values being miles outside ram due to the extra byte
> swapping:

So it is in little endian.

> | morse at frikadeller:~$ sudo dtc -I dtb -O dts /sys/firmware/fdt  | grep initrd
> |                 linux,initrd-end = <0x900b6c05 0x80000000>;
> |                 linux,initrd-start = <0x906a04 0x80000000>;
> 
> 
> With the two extra cpu_to_fdt64() calls removed:
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you for your review.

-Takahiro AKASHI

> 
> Thanks,
> 
> James
