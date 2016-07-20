From: geoff@infradead.org (Geoff Levand)
Date: Wed, 20 Jul 2016 12:19:21 -0700
Subject: [PATCH v1 3/4] arm64: Add arm64 kexec support
In-Reply-To: <20160720153859.GG24691@leverpostej>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720153859.GG24691@leverpostej>
Message-ID: <1469042361.2977.90.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, 2016-07-20 at 16:39 +0100, Mark Rutland wrote:
> On Tue, Jul 19, 2016 at 11:28:13PM +0000, Geoff Levand wrote:
> > +/**
> > + * struct arm64_image_header - arm64 kernel image header.
> > + *
> > + * @pe_sig: Optional PE format 'MZ' signature.
> > + * @branch_code: Reserved for instructions to branch to stext.
> > + * @text_offset: The image load offset in LSB byte order.
> > + * @image_size: An estimated size of the memory image size in LSB byte order.
> > + * @flags: Bit flags:
> > + *  Bit 7.0: Image byte order, 1=MSB.
> > + * @reserved_1: Reserved.
> > + * @magic: Magic number, "ARM\x64".
> > + * @pe_header: Optional offset to a PE format header.
> > + **/
> > +
> > +struct arm64_image_header {
> > +> > 	> > uint8_t pe_sig[2];
> > +> > 	> > uint16_t branch_code[3];
> > +> > 	> > uint64_t text_offset;
> > +> > 	> > uint64_t image_size;
> > +> > 	> > uint8_t flags[8];
> 
> The flags field is a 64-bit quantity, and it's rather confusing to treat
> it as something else.
> 
> I think it would be better to have it as a uint64_t, and use explicit
> endianness conversion as necessary to swizzle it. I beleive that's less
> confusing than grabbing individual bytes.
> 
> > +static const uint64_t arm64_image_flag_7_be = 0x01U;
> 
> For this we could have:
> 
> #define ARM64_IMAGE_FLAG_BE> 	> 	> (1UL << 0)

Sure, we can do it that way.

> > +static inline int arm64_header_check_magic(const struct arm64_image_header *h)
> > +{
> > +> > 	> > if (!h)
> > +> > 	> > 	> > return 0;
> > +
> > +> > 	> > if (!h->text_offset)
> > +> > 	> > 	> > return 0;
> 
> I believe that with CONFIG_RANDOMIZE_TEXT_OFFSET, it is possible that
> text_offset is 0.
> Regardless, I'm not sure I follow the point of this check; why isn't
> checking the magic sufficient?

I'll remove it.

> > +
> > +> > 	> > return (h->magic[0] == arm64_image_magic[0]
> > +> > 	> > 	> > && h->magic[1] == arm64_image_magic[1]
> > +> > 	> > 	> > && h->magic[2] == arm64_image_magic[2]
> > +> > 	> > 	> > && h->magic[3] == arm64_image_magic[3]);
> > +}
> 
> > +static inline int arm64_header_check_msb(const struct arm64_image_header *h)
> > +{
> > +> > 	> > if (!h)
> > +> > 	> > 	> > return 0;
> > +
> > +> > 	> > return !!(h->flags[7] & arm64_image_flag_7_be);
> > +}
> 
> As above, I think this would be better as the below, perhaps wrapped
> with !! if people don't like implicit bool conversion.
> 
> static inline bool arm64_header_is_be(const struct arm64_image_header *h)
> {
> 	> return le64_to_cpu(h->flags) & ARM64_IMAGE_FLAG_BE;
> }
> 
> > +static int check_cpu_properties(const struct cpu_properties *cp_1,
> > +> > 	> > const struct cpu_properties *cp_2)
> > +{
> > +> > 	> > assert(cp_1->hwid == cp_2->hwid);
> > +
> > +> > 	> > if (cp_1->method != cp_2->method) {
> > +> > 	> > 	> > fprintf(stderr,
> > +> > 	> > 	> > 	> > "%s:%d: hwid-%" PRIx64 ": Error: Different cpu enable methods: %s -> %s\n",
> > +> > 	> > 	> > 	> > __func__, __LINE__, cp_1->hwid,
> > +> > 	> > 	> > 	> > cpu_enable_method_str(cp_1->method),
> > +> > 	> > 	> > 	> > cpu_enable_method_str(cp_2->method));
> > +> > 	> > 	> > return -EINVAL;
> > +> > 	> > }
> > +
> > +> > 	> > if (cp_2->method != cpu_enable_method_psci) {
> > +> > 	> > 	> > fprintf(stderr,
> > +> > 	> > 	> > 	> > "%s:%d: hwid-%" PRIx64 ": Error: Unsupported cpu enable method: %s\n",
> > +> > 	> > 	> > 	> > __func__, __LINE__, cp_1->hwid,
> > +> > 	> > 	> > 	> > cpu_enable_method_str(cp_1->method));
> > +> > 	> > 	> > return -EINVAL;
> > +> > 	> > }
> > +
> > +> > 	> > dbgprintf("%s: hwid-%" PRIx64 ": OK\n", __func__, cp_1->hwid);
> > +
> > +> > 	> > return 0;
> > +}
> 
> Does this really matter to userspace?
>
> I agree that it makes sense to warn the user that kexec might not be
> possible, but producing an error and failing doesn't seem right. Who
> knows what the kernel might support in future?

As of now, we just ignore the return values of the call and
continue on. 
 
> > +static uint64_t read_sink(const char *command_line)
> > +{
> > +> > 	> > uint64_t v;
> > +> > 	> > const char *p;
> > +
> > +> > 	> > if (arm64_opts.port)
> > +> > 	> > 	> > return arm64_opts.port;
> > +
> > +#if defined(ARM64_DEBUG_PORT)
> > +> > 	> > return (uint64_t)(ARM64_DEBUG_PORT);
> > +#endif
> > +> > 	> > if (!command_line)
> > +> > 	> > 	> > return 0;
> > +
> > +> > 	> > if (!(p = strstr(command_line, "earlyprintk=")) &&
> > +> > 	> > 	> > !(p = strstr(command_line, "earlycon=")))
> > +> > 	> > 	> > return 0;
> > +
> > +> > 	> > while (*p != ',')
> > +> > 	> > 	> > p++;
> > +
> > +> > 	> > p++;
> > +
> > +> > 	> > while (isspace(*p))
> > +> > 	> > 	> > p++;
> 
> Why do we skip spaces? As far as I am aware, there should not be any
> spaces in the option.

Sure, I can remove it.

> > +
> > +> > 	> > if (*p == 0)
> > +> > 	> > 	> > return 0;
> > +
> > +> > 	> > errno = 0;
> > +
> > +> > 	> > v = strtoull(p, NULL, 0);
> > +
> > +> > 	> > if (errno)
> > +> > 	> > 	> > return 0;
> > +
> > +> > 	> > return v;
> > +}
> 
> It looks like the purgatory code expects angel SWI as the earlycon,

Maybe you saw the debug_brk macro in entry.S?  I should remove
that and just loop.

> whereas many other earlycons exist (with pl011 being extremely popular).
> Regardless, if we assume a particular UART type, we should explicitly
> verify that here. Otherwise the purgatory code will likely bring down
> the system, and it will be very painful to debug.
> 
> Please explicitly check for the supported earlycon name.

Purgatory just writes bytes to the address given.  Are there
UARTs that don't have TX as the first port?

To be safe, we could do a check when we get the address from
an earlycon parameter.  Here's what I found in the dts'.  The
first three are OK, but I don't know about the others.  

pl011
ns16550
ns16550a

primecell
meson-uart
dw-apb-uart
exynos4210-uart
ls1021a-lpuart
dw-apb-uart
armada-3700-uart
mt6795-uart
mt6577-uart
mt8173-uart


> > +
> > +/**
> > + * arm64_load_other_segments - Prepare the dtb, initrd and purgatory segments.
> > + */
> > +
> > +int arm64_load_other_segments(struct kexec_info *info,
> > +> > 	> > uint64_t kernel_entry)
> > +{
> > +> > 	> > int result;
> > +> > 	> > uint64_t dtb_base;
> > +> > 	> > uint64_t image_base;
> > +> > 	> > unsigned long hole_min;
> > +> > 	> > unsigned long hole_max;
> > +> > 	> > uint64_t purgatory_sink;
> > +> > 	> > char *initrd_buf = NULL;
> > +> > 	> > struct dtb dtb_1 = {.name = "dtb_1"};
> > +> > 	> > struct dtb dtb_2 = {.name = "dtb_2"};
> > +> > 	> > char command_line[COMMAND_LINE_SIZE] = "";
> > +
> > +> > 	> > if (arm64_opts.command_line) {
> > +> > 	> > 	> > strncpy(command_line, arm64_opts.command_line,
> > +> > 	> > 	> > 	> > sizeof(command_line));
> > +> > 	> > 	> > command_line[sizeof(command_line) - 1] = 0;
> > +> > 	> > }
> > +
> > +> > 	> > purgatory_sink = read_sink(command_line);
> > +
> > +> > 	> > dbgprintf("%s:%d: purgatory sink: 0x%" PRIx64 "\n", __func__, __LINE__,
> > +> > 	> > 	> > purgatory_sink);
> > +
> > +> > 	> > if (arm64_opts.dtb) {
> > +> > 	> > 	> > dtb_2.buf = slurp_file(arm64_opts.dtb, &dtb_2.size);
> > +> > 	> > 	> > assert(dtb_2.buf);
> > +> > 	> > }
> > +
> > +> > 	> > result = read_1st_dtb(&dtb_1, command_line);
> > +
> > +> > 	> > if (result && !arm64_opts.dtb) {
> > +> > 	> > 	> > fprintf(stderr, "kexec: Error: No device tree available.\n");
> > +> > 	> > 	> > return result;
> > +> > 	> > }
> > +
> > +> > 	> > if (result && arm64_opts.dtb)
> > +> > 	> > 	> > dtb_1 = dtb_2;
> > +> > 	> > else if (!result && !arm64_opts.dtb)
> > +> > 	> > 	> > dtb_2 = dtb_1;
> > +
> > +> > 	> > result = setup_2nd_dtb(command_line, &dtb_2);
> > +
> > +> > 	> > if (result)
> > +> > 	> > 	> > return result;
> > +> > 	
> > +> > 	> > result =  check_cpu_nodes(&dtb_1, &dtb_2);
> > +
> > +> > 	> > if (result)
> > +> > 	> > 	> > fprintf(stderr, "kexec: Warning: No device tree available.\n");
> 
> There are other reasons we'd return an error (e.g. mismatched enable
> methods), so this is somewhat misleading.
> 
> I believe that in all cases we log the specific reason first anyway, so
> perhaps it's best to jsut remove this warning.

Yes, this could be removed.

> Won't this also be very noisy in the case of ACPI with a stub DTB? In
> that case ther are no cpu nodes, and may be no memory nodes.

Should we just remove check_cpu_nodes and everything associated with
it?  It is a lot of code, and all it does now is issue warnings.
It is still around from the early days of spin_table support.  

As for memory nodes, we currently look at the dt, then fall back
to iomem. We could switch the order, iomem then dt, but then
those just issue dbgprintf's.

> [...]
> 
> > +int arm64_process_image_header(const struct arm64_image_header *h)
> > +{
> > +#if !defined(KERNEL_IMAGE_SIZE)
> > +# define KERNEL_IMAGE_SIZE (768 * 1024)
> > +#endif
> > +
> > +> > 	> > if (!arm64_header_check_magic(h))
> > +> > 	> > 	> > return -EINVAL;
> > +
> > +> > 	> > if (h->image_size) {
> > +> > 	> > 	> > arm64_mem.text_offset = le64_to_cpu(h->text_offset);
> > +> > 	> > 	> > arm64_mem.image_size = le64_to_cpu(h->image_size);
> > +> > 	> > } else {
> > +> > 	> > 	> > /* For 3.16 and older kernels. */
> > +> > 	> > 	> > arm64_mem.text_offset = 0x80000;
> > +> > 	> > 	> > arm64_mem.image_size = KERNEL_IMAGE_SIZE;
> > +> > 	> > }
> > +
> > +> > 	> > return 0;
> > +}
> 
> A v3.16 defconfig Image with the Linaro 14.09 GCC 4.9 toolchain is
> 6.3MB, so the chosen value for KERNEL_IMAGE_SIZE is far too small. I'm
> not sure what to suggest as a better value, however, as I know that some
> configurations are far bigger than that.

OK, I'll make it bigger, say 7.  When I set this up I expected
the distro maintainer to choose KERNEL_IMAGE_SIZE to match their
needs.

> Do we expect to kexec to a v3.16 or earlier kernel, given we need a much
> newer first kernel to have kexec in the first place? We could mandate
> having a header with a non-zero image_size (i.e. the target kernel has
> to be v3.16 or newer).

Kexec could be installed as a bootloader, and users may want the
ability to boot older installations, so I think it worthwile to
have.

Thanks for the review.

-Geoff
