From: prudo@linux.ibm.com (Philipp Rudo)
Date: Tue, 24 Jul 2018 11:23:06 +0200
Subject: [PATCH v12 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
In-Reply-To: <20180724065759.19186-4-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-4-takahiro.akashi@linaro.org>
Message-ID: <20180724112306.299540b5@ThinkPad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi AKASHI,

the patch looks good to me.

Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>

Thanks
Philipp


On Tue, 24 Jul 2018 15:57:46 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> Since s390 already knows where to locate buffers, calling
> arch_kexec_mem_walk() has no sense. So we can just drop it as kbuf->mem
> indicates this while all other architectures sets it to 0 initially.
> 
> This change is a preparatory work for the next patch, where all the
> variant memory walks, either on system resource or memblock, will be
> put in one common place so that it will satisfy all the architectures'
> need.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> ---
>  arch/s390/kernel/machine_kexec_file.c | 10 ----------
>  kernel/kexec_file.c                   |  4 ++++
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index f413f57f8d20..32023b4f9dc0 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -134,16 +134,6 @@ int kexec_file_add_initrd(struct kimage *image, struct s390_load_data *data,
>  	return ret;
>  }
>  
> -/*
> - * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
> - * and provide kbuf->mem by hand.
> - */
> -int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> -			int (*func)(struct resource *, void *))
> -{
> -	return 1;
> -}
> -
>  int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  				     Elf_Shdr *section,
>  				     const Elf_Shdr *relsec,
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 63c7ce1c0c3e..bf39df5e5bb9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -534,6 +534,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  {
>  	int ret;
>  
> +	/* Arch knows where to place */
> +	if (kbuf->mem)
> +		return 0;
> +
>  	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
>  
>  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
