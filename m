From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 25 Aug 2017 10:49:46 +0900
Subject: [PATCH 13/14] arm64: kexec_file: add Image format support
In-Reply-To: <20170824172337.GF29665@leverpostej>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-14-takahiro.akashi@linaro.org>
 <20170824172337.GF29665@leverpostej>
Message-ID: <20170825014942.GB7282@akashi-kouhiroshi-no-MacBook-Air.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 06:23:37PM +0100, Mark Rutland wrote:
> On Thu, Aug 24, 2017 at 05:18:10PM +0900, AKASHI Takahiro wrote:
> > The "Image" binary will be loaded at the offset of TEXT_OFFSET from
> > the start of system memory. TEXT_OFFSET is basically determined from
> > the header of the image.
> 
> What's the policy for the binary types kexec_file_load() will load, and
> how are these identified? AFAICT, there are no flags, so it looks like
> we're just checking the magic and hoping.

Yes, please see image_probe().

> > Regarding kernel verification, it will be done through
> > verify_pefile_signature() as arm64's "Image" binary can be seen as
> > in PE format. This approach is consistent with x86 implementation.
> 
> This will not work for kernels built without CONFIG_EFI, where we don't
> have a PE header.

Right.

> What happens in that case?

In this case, we cannot find a signature in the binary when loading,
so kexec just fails.
Signature is a must if the kernel is configured with KEXEC_FILE_VERIFY.

Thanks,
-Takahiro AKASHI

> [...]
> 
> > +/**
> > + * arm64_header_check_msb - Helper to check the arm64 image header.
> > + *
> > + * Returns non-zero if the image was built as big endian.
> > + */
> > +
> > +static inline int arm64_header_check_msb(const struct arm64_image_header *h)
> > +{
> > +	if (!h)
> > +		return 0;
> > +
> > +	return !!(h->flags[7] & arm64_image_flag_7_be);
> > +}
> 
> What are we going to use this for?

Nowhere. I forgot to remove it.

> In kernel, we use the term "BE" rather than "MSB", and it's unfortunate
> to have code with varying naming conventions.
> 
> [...]
> 
> > +static void *image_load(struct kimage *image, char *kernel,
> > +			    unsigned long kernel_len, char *initrd,
> > +			    unsigned long initrd_len, char *cmdline,
> > +			    unsigned long cmdline_len)
> > +{
> > +	struct kexec_buf kbuf;
> > +	struct arm64_image_header *h = (struct arm64_image_header *)kernel;
> > +	unsigned long text_offset, kernel_load_addr;
> > +	int ret;
> > +
> > +	/* Create elf core header segment */
> > +	ret = load_crashdump_segments(image);
> > +	if (ret)
> > +		goto out;
> > +
> > +	/* Load the kernel */
> > +	kbuf.image = image;
> > +	if (image->type == KEXEC_TYPE_CRASH) {
> > +		kbuf.buf_min = crashk_res.start;
> > +		kbuf.buf_max = crashk_res.end + 1;
> > +	} else {
> > +		kbuf.buf_min = 0;
> > +		kbuf.buf_max = ULONG_MAX;
> > +	}
> > +	kbuf.top_down = 0;
> > +
> > +	kbuf.buffer = kernel;
> > +	kbuf.bufsz = kernel_len;
> > +	if (h->image_size) {
> > +		kbuf.memsz = le64_to_cpu(h->image_size);
> > +		text_offset = le64_to_cpu(h->text_offset);
> > +	} else {
> > +		/* v3.16 or older */
> > +		kbuf.memsz = kbuf.bufsz; /* NOTE: not including BSS */
> 
> Why bother supporting < 3.16 kernels?

Because kexec-tools does :)

> They predate regulate kexec, we know we don't have enough information to
> boot such kernels reliably, and arguably attempting to load one would
> indicate some kind of rollback attack.

Around the time when Geoff were originally working on kexec,
there might be some possibility that people might want to boot a bit older
kernel, I guess.

Thanks,
-Takahiro AKASHI

> Thanks,
> Mark.
