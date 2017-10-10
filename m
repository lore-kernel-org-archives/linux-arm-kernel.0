From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 10 Oct 2017 12:06:23 +0100
Subject: [PATCH v5 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
In-Reply-To: <20171010063619.6303-4-takahiro.akashi@linaro.org>
References: <20171010063619.6303-1-takahiro.akashi@linaro.org>
 <20171010063619.6303-4-takahiro.akashi@linaro.org>
Message-ID: <e2ec250b-f5c1-aae8-6291-f1bddb3d59ab@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takahiro,

Sorry about the previous message, confidential disclaimer shouldn't have 
been there.

Resending comments without disclaimer to avoid confusion.

On 10/10/17 07:36, AKASHI Takahiro wrote:
> arch_kexec_kernel_*() and arch_kimage_file_post_load_cleanup can now be
> duplicated among some architectures, so let's factor them out.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/kexec.h            |  2 +-
>   arch/powerpc/kernel/kexec_elf_64.c          |  2 +-
>   arch/powerpc/kernel/machine_kexec_file_64.c | 36 ++----------------
>   arch/x86/include/asm/kexec-bzimage64.h      |  2 +-
>   arch/x86/kernel/kexec-bzimage64.c           |  2 +-
>   arch/x86/kernel/machine_kexec_64.c          | 45 +----------------------
>   include/linux/kexec.h                       | 15 ++++----
>   kernel/kexec_file.c                         | 57 +++++++++++++++++++++++++++--
>   8 files changed, 70 insertions(+), 91 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 25668bc8cb2a..23588952d8bd 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -92,7 +92,7 @@ static inline bool kdump_in_progress(void)
>   }
>   
>   #ifdef CONFIG_KEXEC_FILE
> -extern struct kexec_file_ops kexec_elf64_ops;
> +extern const struct kexec_file_ops kexec_elf64_ops;
>   
>   #ifdef CONFIG_IMA_KEXEC
>   #define ARCH_HAS_KIMAGE_ARCH
> diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
> index 9a42309b091a..6c78c11c7faf 100644
> --- a/arch/powerpc/kernel/kexec_elf_64.c
> +++ b/arch/powerpc/kernel/kexec_elf_64.c
> @@ -657,7 +657,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>   	return ret ? ERR_PTR(ret) : fdt;
>   }
>   
> -struct kexec_file_ops kexec_elf64_ops = {
> +const struct kexec_file_ops kexec_elf64_ops = {
>   	.probe = elf64_probe,
>   	.load = elf64_load,
>   };
> diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
> index 992c0d258e5d..e7ce78857f0b 100644
> --- a/arch/powerpc/kernel/machine_kexec_file_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_file_64.c
> @@ -31,8 +31,9 @@
>   
>   #define SLAVE_CODE_SIZE		256
>   
> -static struct kexec_file_ops *kexec_file_loaders[] = {
> +const struct kexec_file_ops * const kexec_file_loaders[] = {
>   	&kexec_elf64_ops,
> +	NULL
>   };
>   
>   int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> @@ -45,38 +46,7 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>   	if (image->type == KEXEC_TYPE_CRASH)
>   		return -ENOTSUPP;
>   
> -	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
> -		fops = kexec_file_loaders[i];
> -		if (!fops || !fops->probe)
> -			continue;
> -
> -		ret = fops->probe(buf, buf_len);
> -		if (!ret) {
> -			image->fops = fops;
> -			return ret;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -void *arch_kexec_kernel_image_load(struct kimage *image)
> -{
> -	if (!image->fops || !image->fops->load)
> -		return ERR_PTR(-ENOEXEC);
> -
> -	return image->fops->load(image, image->kernel_buf,
> -				 image->kernel_buf_len, image->initrd_buf,
> -				 image->initrd_buf_len, image->cmdline_buf,
> -				 image->cmdline_buf_len);
> -}
> -
> -int arch_kimage_file_post_load_cleanup(struct kimage *image)
> -{
> -	if (!image->fops || !image->fops->cleanup)
> -		return 0;
> -
> -	return image->fops->cleanup(image->image_loader_data);
> +	return _kexec_kernel_image_probe(image, buf, buf_len);
>   }
>   
>   /**
> diff --git a/arch/x86/include/asm/kexec-bzimage64.h b/arch/x86/include/asm/kexec-bzimage64.h
> index d1b5d194e31d..284fd23d133b 100644
> --- a/arch/x86/include/asm/kexec-bzimage64.h
> +++ b/arch/x86/include/asm/kexec-bzimage64.h
> @@ -1,6 +1,6 @@
>   #ifndef _ASM_KEXEC_BZIMAGE64_H
>   #define _ASM_KEXEC_BZIMAGE64_H
>   
> -extern struct kexec_file_ops kexec_bzImage64_ops;
> +extern const struct kexec_file_ops kexec_bzImage64_ops;
>   
>   #endif  /* _ASM_KEXE_BZIMAGE64_H */
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index fb095ba0c02f..705654776c0c 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -538,7 +538,7 @@ static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>   }
>   #endif
>   
> -struct kexec_file_ops kexec_bzImage64_ops = {
> +const struct kexec_file_ops kexec_bzImage64_ops = {
>   	.probe = bzImage64_probe,
>   	.load = bzImage64_load,
>   	.cleanup = bzImage64_cleanup,
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 1f790cf9d38f..2cdd29d64181 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -30,8 +30,9 @@
>   #include <asm/set_memory.h>
>   
>   #ifdef CONFIG_KEXEC_FILE
> -static struct kexec_file_ops *kexec_file_loaders[] = {
> +const struct kexec_file_ops * const kexec_file_loaders[] = {
>   		&kexec_bzImage64_ops,
> +		NULL
>   };
>   #endif
>   
> @@ -363,27 +364,6 @@ void arch_crash_save_vmcoreinfo(void)
>   /* arch-dependent functionality related to kexec file-based syscall */
>   
>   #ifdef CONFIG_KEXEC_FILE
> -int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> -				  unsigned long buf_len)
> -{
> -	int i, ret = -ENOEXEC;
> -	struct kexec_file_ops *fops;
> -
> -	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
> -		fops = kexec_file_loaders[i];
> -		if (!fops || !fops->probe)
> -			continue;
> -
> -		ret = fops->probe(buf, buf_len);
> -		if (!ret) {
> -			image->fops = fops;
> -			return ret;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
>   void *arch_kexec_kernel_image_load(struct kimage *image)
>   {
>   	vfree(image->arch.elf_headers);
> @@ -398,27 +378,6 @@ void *arch_kexec_kernel_image_load(struct kimage *image)
>   				 image->cmdline_buf_len);
>   }
>   
> -int arch_kimage_file_post_load_cleanup(struct kimage *image)
> -{
> -	if (!image->fops || !image->fops->cleanup)
> -		return 0;
> -
> -	return image->fops->cleanup(image->image_loader_data);
> -}
> -
> -#ifdef CONFIG_KEXEC_VERIFY_SIG
> -int arch_kexec_kernel_verify_sig(struct kimage *image, void *kernel,
> -				 unsigned long kernel_len)
> -{
> -	if (!image->fops || !image->fops->verify_sig) {
> -		pr_debug("kernel loader does not support signature verification.");
> -		return -EKEYREJECTED;
> -	}
> -
> -	return image->fops->verify_sig(kernel, kernel_len);
> -}
> -#endif
> -
>   /*
>    * Apply purgatory relocations.
>    *
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 2b7590f5483a..bfb37665a77f 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -208,7 +208,7 @@ struct kimage {
>   	unsigned long cmdline_buf_len;
>   
>   	/* File operations provided by image loader */
> -	struct kexec_file_ops *fops;
> +	const struct kexec_file_ops *fops;
>   
>   	/* Image loader handling the kernel can store a pointer here */
>   	void *image_loader_data;
> @@ -276,12 +276,13 @@ int crash_shrink_memory(unsigned long new_size);
>   size_t crash_get_memory_size(void);
>   void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
>   
> -int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> -					 unsigned long buf_len);
> -void * __weak arch_kexec_kernel_image_load(struct kimage *image);
> -int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
> -int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> -					unsigned long buf_len);
> +int _kexec_kernel_image_probe(struct kimage *image, void *buf,
> +			      unsigned long buf_len);
> +void *_kexec_kernel_image_load(struct kimage *image);
> +int _kimage_file_post_load_cleanup(struct kimage *image);
> +int _kexec_kernel_verify_sig(struct kimage *image, void *buf,
> +			     unsigned long buf_len);
> +
>   int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
>   					Elf_Shdr *sechdrs, unsigned int relsec);
>   int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 9f48f4412297..bbb0177e20ab 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -26,30 +26,79 @@
>   #include <linux/vmalloc.h>
>   #include "kexec_internal.h"
>   
> +const __weak struct kexec_file_ops * const kexec_file_loaders[] = {NULL};
> +
>   static int kexec_calculate_store_digests(struct kimage *image);
>   
> +int _kexec_kernel_image_probe(struct kimage *image, void *buf,
> +			     unsigned long buf_len)
> +{
> +	const struct kexec_file_ops *fops;
> +	int ret = -ENOEXEC;
> +
> +	for (fops = kexec_file_loaders[0]; fops && fops->probe; ++fops) {

Hmm, that's not gonna work (and I see that what I said in the previous 
patch was not 100% correct either).

'fops' should be of type 'const struct kexec_file_ops **', and the loop 
should be:

for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops)

With some additional dereferences in the body of the loop.

Unless you prefer the previous state of the loop (with i and the break 
inside), but I still think this looks better.

Cheers,

-- 
Julien Thierry
