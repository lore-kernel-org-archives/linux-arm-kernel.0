From: dyoung@redhat.com (Dave Young)
Date: Thu, 18 Aug 2016 16:23:39 +0800
Subject: [PATCH v2 1/2] kexec: add dtb info to struct kimage
In-Reply-To: <1470956638-3589-2-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956638-3589-2-git-send-email-bauerman@linux.vnet.ibm.com>
Message-ID: <20160818082339.GB845@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/16 at 08:03pm, Thiago Jung Bauermann wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> Device tree blob must be passed to a second kernel on DTB-capable
> archs, like powerpc and arm64, but the current kernel interface
> lacks this support.
> 
> This patch adds dtb buffer information to struct kimage.
> When users don't specify dtb explicitly and the one used for the current
> kernel can be re-used, this change will be good enough for implementing
> kexec_file_load feature.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  include/linux/kexec.h | 3 +++
>  kernel/kexec_file.c   | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index d7437777baaa..4f85d284ed0b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -192,6 +192,9 @@ struct kimage {
>  	char *cmdline_buf;
>  	unsigned long cmdline_buf_len;
>  
> +	void *dtb_buf;
> +	unsigned long dtb_buf_len;
> +
>  	/* File operations provided by image loader */
>  	struct kexec_file_ops *fops;
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 503bc2d348e5..113af2f219b9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -92,6 +92,9 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  	vfree(image->initrd_buf);
>  	image->initrd_buf = NULL;
>  
> +	vfree(image->dtb_buf);
> +	image->dtb_buf = NULL;
> +
>  	kfree(image->cmdline_buf);
>  	image->cmdline_buf = NULL;
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
