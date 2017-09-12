From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 12 Sep 2017 13:46:49 +0900
Subject: [PATCH 6/9] arm64: kexec_file: load initrd, device-tree and
 purgatory segments
In-Reply-To: <20170911064754.GA7332@dhcp-128-65.nay.redhat.com>
References: <20170908031616.17916-1-takahiro.akashi@linaro.org>
 <20170908031616.17916-7-takahiro.akashi@linaro.org>
 <20170911064754.GA7332@dhcp-128-65.nay.redhat.com>
Message-ID: <20170912044647.GH17186@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 11, 2017 at 02:47:54PM +0800, Dave Young wrote:
> Hi,
> 
> On 09/08/17 at 12:16pm, AKASHI Takahiro wrote:
> > load_other_segments() sets up and adds all the memory segments necessary
> > other than kernel, including initrd, device-tree blob and purgatory.
> > Most of the code was borrowed from kexec-tools' counterpart.
> > 
> > In addition, arch_kexec_image_probe(), arch_kexec_image_load() and
> > arch_kexec_kernel_verify_sig() are added as stubs for supporting multiple
> > types of kernel image formats.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/kexec.h         |  19 +++
> >  arch/arm64/kernel/machine_kexec_file.c | 264 +++++++++++++++++++++++++++++++++
> >  2 files changed, 283 insertions(+)
> >  create mode 100644 arch/arm64/kernel/machine_kexec_file.c
> > 
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index e17f0529a882..d74dc49670ad 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -93,6 +93,25 @@ static inline void crash_prepare_suspend(void) {}
> >  static inline void crash_post_resume(void) {}
> >  #endif
> >  
> > +#ifdef CONFIG_KEXEC_FILE
> > +#define ARCH_HAS_KIMAGE_ARCH
> > +
> > +struct kimage_arch {
> > +	void *dtb_buf;
> > +};
> > +
> > +struct kimage;
> > +
> > +extern int setup_dtb(struct kimage *image,
> > +		unsigned long initrd_load_addr, unsigned long initrd_len,
> > +		char *cmdline, unsigned long cmdline_len,
> > +		char **dtb_buf, size_t *dtb_buf_len);
> > +extern int load_other_segments(struct kimage *image,
> > +		unsigned long kernel_load_addr,
> > +		char *initrd, unsigned long initrd_len,
> > +		char *cmdline, unsigned long cmdline_len);
> > +#endif
> > +
> >  #endif /* __ASSEMBLY__ */
> >  
> >  #endif
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > new file mode 100644
> > index 000000000000..a6d2c006b4f7
> > --- /dev/null
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > @@ -0,0 +1,264 @@
> > +/*
> > + * kexec_file for arm64
> > + *
> > + * Copyright (C) 2017 Linaro Limited
> > + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + *
> > + * Most code is derived from arm64 port of kexec-tools
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#define pr_fmt(fmt) "kexec_file: " fmt
> > +
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kexec.h>
> > +#include <linux/libfdt.h>
> > +#include <linux/memblock.h>
> > +#include <linux/of_fdt.h>
> > +#include <asm/kexec_file.h>
> > +
> > +static int __dt_root_addr_cells;
> > +static int __dt_root_size_cells;
> > +
> > +static struct kexec_file_ops *kexec_file_loaders[0];
> > +
> > +int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> > +				  unsigned long buf_len)
> > +{
> > +	struct kexec_file_ops *fops;
> > +	int i, ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
> > +		fops = kexec_file_loaders[i];
> > +		if (!fops || !fops->probe)
> > +			continue;
> > +
> > +		ret = fops->probe(buf, buf_len);
> > +		if (!ret) {
> > +			image->fops = fops;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return -ENOEXEC;
> > +}
> > +
> > +void *arch_kexec_kernel_image_load(struct kimage *image)
> > +{
> > +	if (!image->fops || !image->fops->load)
> > +		return ERR_PTR(-ENOEXEC);
> > +
> > +	return image->fops->load(image, image->kernel_buf,
> > +				 image->kernel_buf_len, image->initrd_buf,
> > +				 image->initrd_buf_len, image->cmdline_buf,
> > +				 image->cmdline_buf_len);
> > +}
> > +
> > +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > +{
> > +	vfree(image->arch.dtb_buf);
> > +	image->arch.dtb_buf = NULL;
> > +
> > +	vfree(image->arch.elf_headers);
> > +	image->arch.elf_headers = NULL;
> > +	image->arch.elf_headers_sz = 0;
> > +
> > +	if (!image->fops || !image->fops->cleanup)
> > +		return 0;
> > +
> > +	return image->fops->cleanup(image->image_loader_data);
> > +}
> > +
> > +#ifdef CONFIG_KEXEC_VERIFY_SIG
> > +int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
> > +				 unsigned long kernel_len)
> > +{
> > +	if (!image->fops || !image->fops->verify_sig) {
> > +		pr_debug("kernel loader does not support signature verification.\n");
> > +		return -EKEYREJECTED;
> > +	}
> > +
> > +	return image->fops->verify_sig(kernel, kernel_len);
> > +}
> 
> 
> arch_kexec_kernel_verify_sig now be duplicated so it can be put in the
> general function in kexec_file.c
> 
> Also the probe and load function are also duplicated, they can be moved
> to common code as well.

Okay!

> The x86 load function can be cleaned up with removing the vfree
> callback.

Sure

Thanks,
-Takahiro AKASHI
