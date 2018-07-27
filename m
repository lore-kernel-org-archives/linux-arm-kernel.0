From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 27 Jul 2018 14:37:55 +0900
Subject: [PATCH v12 10/16] arm64: kexec_file: load initrd and device-tree
In-Reply-To: <99f87d6c-b5e3-4f98-5f3b-7032ff4780b1@arm.com>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-11-takahiro.akashi@linaro.org>
 <99f87d6c-b5e3-4f98-5f3b-7032ff4780b1@arm.com>
Message-ID: <20180727053754.GF11258@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 02:34:55PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 24/07/18 07:57, AKASHI Takahiro wrote:
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
> Since v11 you've renamed struct kimage_arch's dtb_buf as dtb, but not changed
> the struct. This series doesn't build until patch 12 where you fix it. This will
> cause anyone trying to bisect through here a problem.

Right. My last-minute change introduced this screw-up.
I will double-check at v13.

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James
> 
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index e17f0529a882..026f7e408f0c 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> 
> > +struct kimage_arch {
> > +	void *dtb_buf;
> > +	unsigned long dtb_mem;
> > +};
> 
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index c38a8048ed00..b28fbb0659c9 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> 
> > +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > +{
> > +	vfree(image->arch.dtb);
> > +	image->arch.dtb = NULL;
> > +
> > +	return kexec_image_post_load_cleanup_default(image);
> > +}
> 
