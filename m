From: geoff@infradead.org (Geoff Levand)
Date: Wed, 07 Sep 2016 16:57:32 -0700
Subject: [PATCH v5 2/3] arm64: Add arm64 kexec support
In-Reply-To: <20160906054359.GC16712@linaro.org>
References: <cover.1472766405.git.geoff@infradead.org>
 <3a90727656b958ccf3ca303002785920615c495b.1472766405.git.geoff@infradead.org>
 <20160906054359.GC16712@linaro.org>
Message-ID: <1473292652.8862.14.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-09-06 at 14:44 +0900, AKASHI Takahiro wrote:
> On Thu, Sep 01, 2016 at 09:51:10PM +0000, Geoff Levand wrote:

> > +int arm64_load_other_segments(struct kexec_info *info,
> > +	unsigned long image_base)
> > +{
> > +	int result;
> > +	unsigned long dtb_base;
> > +	unsigned long hole_min;
> > +	unsigned long hole_max;
> > +	char *initrd_buf = NULL;
> > +	struct dtb dtb;
> > +	char command_line[COMMAND_LINE_SIZE] = "";
> > +
> > +	if (arm64_opts.command_line) {
> > +		strncpy(command_line, arm64_opts.command_line,
> > +			sizeof(command_line));
> > +		command_line[sizeof(command_line) - 1] = 0;
> > +	}
> > +
> > +	if (arm64_opts.dtb) {
> > +		dtb.name = "dtb_2";
> "dtb_1" and "dtb_2" are not very meaningful.

dtb_1 means from 1st stage, dtb_2 means a new 2nd stage.

> Instead, I'm going to use:
> ????dtb_2 => "dtb_user" (if a command line option is specified)
> ????dtb_1 => "dtb_sys" (if from /sys/firmware/fdt), or
> ?????????????"dtb_unflatten" (if created from /proc/device-tree)
> to distinguish the origins in my kdump patches.

Sure, that's OK.  If you make a fixup patch I'll merge it in.

> 
> > +static int get_memory_ranges_iomem_cb(void *data, int nr, char *str,
> > +	unsigned long long base, unsigned long long length)
> > +{
> > +	struct memory_range *r;
> > +
> > +	if (nr >= KEXEC_SEGMENT_MAX)
> > +		return -1;
> > +
> > +	r = (struct memory_range *)data + nr;
> > +	r->type = RANGE_RAM;
> > +	r->start = base;
> > +	r->end = base + length - 1;
> > +
> > +	set_phys_offset(r->start);
> This will no longer work correctly for identifying PHYS_OFFSET
> once the following patch is applied:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/450433.html
> and it is now queued in arm64/for-next.
> 
> I will include a fixup in my kdump patches as the current code of kexec
> doesn't rely on a result of virt_to_phys() seriously.

OK.

> +int get_memory_ranges(struct memory_range **range, int *ranges,
> > +	unsigned long kexec_flags)
> > +{
> > +	static struct memory_range array[KEXEC_SEGMENT_MAX];
> > +	unsigned int count;
> > +	int result;
> > +
> > +	result = get_memory_ranges_iomem(array, &count);
> > +
> > +	if (result)
> > +		result = get_memory_ranges_dt(array, &count);
> Do we really need to scan a DT blob here?
> I think that all the (usable) memory regions are added to
> /proc/iomem anyway.

I guess it is now expected that /proc/iomem has memory
in it.

> > +void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
> > +	unsigned long r_type, void *ptr, unsigned long address,
> > +	unsigned long value)
> > +{
> > +#if !defined(R_AARCH64_ABS64)
> > +# define R_AARCH64_ABS64 257
> > +#endif
> > +
> > +#if !defined(R_AARCH64_LD_PREL_LO19)
> > +# define R_AARCH64_LD_PREL_LO19 273
> > +#endif
> > +
> > +#if !defined(R_AARCH64_ADR_PREL_LO21)
> > +# define R_AARCH64_ADR_PREL_LO21 274
> > +#endif
> > +
> > +#if !defined(R_AARCH64_JUMP26)
> > +# define R_AARCH64_JUMP26 282
> > +#endif
> > +
> > +#if !defined(R_AARCH64_CALL26)
> > +# define R_AARCH64_CALL26 283
> > +#endif
> Did you see my comment?
> http://lists.infradead.org/pipermail/kexec/2016-August/016947.html

I'm still expecting?elf.h to have these.

-Geoff
