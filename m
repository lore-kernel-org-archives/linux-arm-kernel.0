From: geoff@infradead.org (Geoff Levand)
Date: Mon, 25 Jul 2016 17:37:01 -0700
Subject: [PATCH v1.2 3/4] arm64: Add arm64 kexec support
In-Reply-To: <20160722071204.GP20774@linaro.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <1469048065.2977.124.camel@infradead.org>
 <20160722071204.GP20774@linaro.org>
Message-ID: <1469493421.2889.50.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-07-22 at 16:12 +0900, AKASHI Takahiro wrote:
> On Wed, Jul 20, 2016 at 01:54:25PM -0700, Geoff Levand wrote:
> > new file mode 100644
> > index 0000000..126ca15
> > --- /dev/null
> > +++ b/kexec/arch/arm64/image-header.h

> > +static const uint8_t arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
> > +static const uint8_t arm64_image_pe_sig[2] = {'M', 'Z'};
> > +static const uint64_t arm64_image_flag_be = (1UL << 0);
> 
> Should static variables not be in a header?

We need static linkage so each translation unit gets its own set.  The optimizer should remove unused ones.

> > --- /dev/null
> > +++ b/kexec/arch/arm64/include/arch/options.h
> > +
> > +static const char arm64_opts_usage[] __attribute__ ((unused)) =
> > +"     --append=STRING       Set the kernel command line to STRING.\n"
> > +"     --command-line=STRING Set the kernel command line to STRING.\n"
> > +"     --dtb=FILE            Use FILE as the device tree blob.\n"
> > +"     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
> > +"     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
> > +"     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
> > +"     --reuse-cmdline       Use kernel command line from running system.\n";
> 
> Ditto
> 
> > +struct arm64_opts {
> > +> > 	> > const char *command_line;
> > +> > 	> > const char *dtb;
> > +> > 	> > const char *initrd;
> > +> > 	> > uint64_t port;
> > +};
> > +
> > +extern struct arm64_opts arm64_opts;
> > +
> > +#endif
> > diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> > new file mode 100644
> > index 0000000..24031f6
> > --- /dev/null
> > +++ b/kexec/arch/arm64/kexec-arm64.c
> > @@ -0,0 +1,979 @@
> > +/*
> > + * ARM64 kexec.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include 
> > +#include 
> > +#include 
> > +#include 
> > +#include 
> > +#include 
> > +#include 
> > +#include 
> > +#include 
> > +
> > +#include "dt-ops.h"
> > +#include "kexec.h"
> > +#include "crashdump.h"
> > +#include "crashdump-arm64.h"
> > +#include "kexec-arm64.h"
> > +#include "fs2dt.h"
> > +#include "kexec-syscall.h"
> > +#include "arch/options.h"
> 
> Can those be sorted in an alphabetic order?

kexec.h needs to go before crashdump.h, and kexec-arm64.h needs to go before fs2dt.h.

Will this satisfy you?

#include "kexec.h"
#include "kexec-arm64.h"
#include "crashdump.h"
#include "crashdump-arm64.h"
#include "dt-ops.h"
#include "fs2dt.h"
#include "kexec-syscall.h"
#include "arch/options.h"

> > +
> > +/* Global varables the core kexec routines expect. */
> > +
> > +unsigned char reuse_initrd;
> > +
> > +off_t initrd_base;
> > +off_t initrd_size;
> > +
> > +const struct arch_map_entry arches[] = {
> > +> > 	> > { "aarch64", KEXEC_ARCH_ARM64 },
> > +> > 	> > { "aarch64_be", KEXEC_ARCH_ARM64 },
> > +> > 	> > { NULL, 0 },
> > +};
> > +
> > +/* arm64 global varables. */
> > +
> > +struct arm64_opts arm64_opts;
> > +struct arm64_mem arm64_mem = {
> > +> > 	> > .phys_offset = arm64_mem_ngv,
> > +> > 	> > .page_offset = arm64_mem_ngv,
> > +};
> > +
> > +uint64_t get_phys_offset(void)
> > +{
> > +> > 	> > assert(arm64_mem.phys_offset != arm64_mem_ngv);
> 
> Assertion here?

If get_phys_offset is used incorrectly this will assert.

> 
> > +> > 	> > return arm64_mem.phys_offset;
> > +}
> > +
> > +uint64_t get_page_offset(void)
> > +{
> > +> > 	> > assert(arm64_mem.page_offset != arm64_mem_ngv);
> > +> > 	> > return arm64_mem.page_offset;
> > +}
> > +
> > +void arch_usage(void)
> > +{
> > +> > 	> > printf(arm64_opts_usage);
> > +}
> > +
> > +static int read_proc_dtb(struct dtb *dtb, const char *command_line)
> > +{
> > +> > 	> > int result;
> > +> > 	> > struct stat s;
> > +> > 	> > static const char path[] = "/proc/device-tree";
> > +
> > +> > 	> > result = stat(path, &s);
> > +
> > +> > 	> > if (result) {
> > +> > 	> > 	> > dbgprintf("%s: %s\n", __func__, strerror(errno));
> 
> I think that you always use fprintf() in case of failures.

But this in not a failure, just 'not found'.  If read_1st_dtb()
returns failure we print an error message in
arm64_load_other_segments().

> > +> > 	> > 	> > return -1;
> > +> > 	> > }
> > +
> > +> > 	> > dtb->path = path;
> > +> > 	> > create_flatten_tree((char **)&dtb->buf, &dtb->size,
> > +> > 	> > 	> > (command_line && command_line[0]) ? command_line : NULL);
> > +
> > +> > 	> > return 0;
> > +}
> > +
> > +static int read_sys_dtb(struct dtb *dtb, const char *command_line)
> > +{
> > +> > 	> > int result;
> > +> > 	> > struct stat s;
> > +> > 	> > static const char path[] = "/sys/firmware/fdt";
> > +
> > +> > 	> > result = stat(path, &s);
> > +
> > +> > 	> > if (result) {
> > +> > 	> > 	> > dbgprintf("%s: %s\n", __func__, strerror(errno));
> 
> Ditto
> 
> > +> > 	> > 	> > return -1;
> > +> > 	> > }
> > +
> > +> > 	> > dtb->path = path;
> > +> > 	> > dtb->buf = slurp_file("/sys/firmware/fdt", &dtb->size);
> > +
> > +> > 	> > return set_bootargs(dtb, command_line);
> > +}
> > +
> > +static int read_1st_dtb(struct dtb *dtb, const char *command_line)
> > +{
> > +> > 	> > int result;
> > +
> > +> > 	> > result = read_sys_dtb(dtb, command_line);
> > +
> > +> > 	> > if (!result)
> > +> > 	> > 	> > goto on_success;
> > +
> > +> > 	> > result = read_proc_dtb(dtb, command_line);
> > +
> > +> > 	> > if (!result)
> > +> > 	> > 	> > goto on_success;
> > +
> > +> > 	> > dbgprintf("%s: not found\n", __func__);
> > +> > 	> > return -1;
> 
> Ditto
> 
> > +on_success:
> > +> > 	> > dbgprintf("%s: found %s\n", __func__, dtb->path);
> > +> > 	> > return 0;
> > +}
> > +
> > +static int setup_2nd_dtb(char *command_line, struct dtb *dtb_2)
> > +{
> > +> > 	> > int result;
> > +
> > +> > 	> > result = fdt_check_header(dtb_2->buf);
> > +
> > +> > 	> > if (result) {
> > +> > 	> > 	> > fprintf(stderr, "kexec: Invalid 2nd device tree.\n");
> > +> > 	> > 	> > return -EINVAL;
> > +> > 	> > }
> > +
> > +> > 	> > result = set_bootargs(dtb_2, command_line);
> > +
> > +> > 	> > dump_reservemap(dtb_2);
> > +
> > +> > 	> > return result;
> > +}
> > +
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
> 
> In this case, dtb_1 might also be modified (unintentionally).
> So be careful.

The new version of this patch no longer does the cpu check, so we will
only use dtb_1 when there is no command line dtb_2.

> +> > 	> > /* Put the other segments after the image. */
> > +
> > +> > 	> > image_base = arm64_mem.phys_offset + arm64_mem.text_offset;
> > +> > 	> > hole_min = image_base + arm64_mem.image_size;
> > +> > 	> > hole_max = ULONG_MAX;
> > +
> > +> > 	> > if (arm64_opts.initrd) {
> > +> > 	> > 	> > initrd_buf = slurp_file(arm64_opts.initrd, &initrd_size);
> > +
> > +> > 	> > 	> > if (!initrd_buf)
> > +> > 	> > 	> > 	> > fprintf(stderr, "kexec: Empty ramdisk file.\n");
> 
> Why not fail?

> > Empty is not the only reason of failure.

The decision of what to put in the initrd is out of exec's control.  It
may not be a failure that the file is empty.  
 
> > +		else {
> > +> > 	> > 	> > 	> > /*
> > +> > 	> > 	> > 	> >  * Put the initrd after the kernel.  As specified in
> > +> > 	> > 	> > 	> >  * booting.txt, align to 1 GiB.
> > +> > 	> > 	> > 	> >  */
> > +
> > +> > 	> > 	> > 	> > initrd_base = add_buffer_phys_virt(info, initrd_buf,
> > +> > 	> > 	> > 	> > 	> > initrd_size, initrd_size, GiB(1),
> > +> > 	> > 	> > 	> > 	> > hole_min, hole_max, 1, 0);
> > +
> > +> > 	> > 	> > 	> > /* initrd_base is valid if we got here. */
> > +
> > +> > 	> > 	> > 	> > dbgprintf("initrd: base %lx, size %lxh (%ld)\n",
> > +> > 	> > 	> > 	> > 	> > initrd_base, initrd_size, initrd_size);
> > +
> > +> > 	> > 	> > 	> > /* Check size limit as specified in booting.txt. */
> > +
> > +> > 	> > 	> > 	> > if (initrd_base - image_base + initrd_size > GiB(32)) {
> > +> > 	> > 	> > 	> > 	> > fprintf(stderr, "kexec: Error: image + initrd too big.\n");
> > +> > 	> > 	> > 	> > 	> > return -EINVAL;
> 
> Some dtb_*/fdt_* functions may return -FDT_ERR_*.
> Don't mix different type of error codes.

The kexec core just checks for a negative result with the exception of
ENOCRASHKERNEL.  I'll change to return EFAILED.

> > +void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
> > +> > 	> > unsigned long base, size_t memsz)
> > +{
> > +> > 	> > add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
> > +}
> > +
> > +int arm64_process_image_header(const struct arm64_image_header *h)
> > +{
> > +#if !defined(KERNEL_IMAGE_SIZE)
> > +# define KERNEL_IMAGE_SIZE MiB(7)
> > +#endif
> 
> Move this to a header?

This is just a local value.

> > +
> > +> > 	> > if (!arm64_header_check_magic(h))
> > +> > 	> > 	> > return -EINVAL;
> > +
> > +> > 	> > if (h->image_size) {
> > +> > 	> > 	> > arm64_mem.text_offset = arm64_header_text_offset(h);
> > +> > 	> > 	> > arm64_mem.image_size = arm64_header_image_size(h);
> > +> > 	> > } else {
> > +> > 	> > 	> > /* For 3.16 and older kernels. */
> > +> > 	> > 	> > arm64_mem.text_offset = 0x80000;
> > +> > 	> > 	> > arm64_mem.image_size = KERNEL_IMAGE_SIZE;
> > +> > 	> > }
> > +
> > +> > 	> > return 0;
> > +}
> > +
> > +static int get_memory_ranges_dt(struct memory_range *array, unsigned int *count)
> > +{
> > +> > 	> > struct region {uint64_t base; uint64_t size;};
> > +> > 	> > struct dtb dtb = {.name = "range_dtb"};
> > +> > 	> > int offset;
> > +> > 	> > int result;
> > +
> > +> > 	> > *count = 0;
> > +
> > +> > 	> > result = read_1st_dtb(&dtb, NULL);
> > +
> > +> > 	> > if (result) {
> > +> > 	> > 	> > goto on_error;
> > +> > 	> > }
> > +
> > +> > 	> > result = fdt_check_header(dtb.buf);
> > +
> > +> > 	> > if (result) {
> > +> > 	> > 	> > dbgprintf("%s:%d: %s: fdt_check_header failed:%s\n", __func__,
> > +> > 	> > 	> > 	> > __LINE__, dtb.path, fdt_strerror(result));
> > +> > 	> > 	> > goto on_error;
> > +> > 	> > }
> > +
> > +> > 	> > for (offset = 0; ; ) {
> > +> > 	> > 	> > const struct region *region;
> > +> > 	> > 	> > const struct region *end;
> > +> > 	> > 	> > int len;
> > +
> > +> > 	> > 	> > offset = fdt_subnode_offset(dtb.buf, offset, "memory");
> > +
> > +> > 	> > 	> > if (offset == -FDT_ERR_NOTFOUND)
> > +> > 	> > 	> > 	> > break;
> > +
> > +> > 	> > 	> > if (offset <= 0) {
> > +> > 	> > 	> > 	> > dbgprintf("%s:%d: fdt_subnode_offset failed: %d %s\n",
> > +> > 	> > 	> > 	> > 	> > __func__, __LINE__, offset,
> > +> > 	> > 	> > 	> > 	> > fdt_strerror(offset));
> > +> > 	> > 	> > 	> > goto on_error;
> > +> > 	> > 	> > }
> > +
> > +> > 	> > 	> > dbgprintf("%s:%d: node_%d %s\n", __func__, __LINE__, offset,
> > +> > 	> > 	> > 	> > fdt_get_name(dtb.buf, offset, NULL));
> > +
> > +> > 	> > 	> > region = fdt_getprop(dtb.buf, offset, "reg", &len);
> > +
> > +> > 	> > 	> > if (region <= 0) {
> > +> > 	> > 	> > 	> > dbgprintf("%s:%d: fdt_getprop failed: %d %s\n",
> > +> > 	> > 	> > 	> > 	> > __func__, __LINE__, offset,
> > +> > 	> > 	> > 	> > 	> > fdt_strerror(offset));
> > +> > 	> > 	> > 	> > goto on_error;
> > +> > 	> > 	> > }
> > +
> > +> > 	> > 	> > for (end = region + len / sizeof(*region);
> > +> > 	> > 	> > 	> > region < end && *count < KEXEC_SEGMENT_MAX;
> > +> > 	> > 	> > 	> > region++) {
> > +> > 	> > 	> > 	> > struct memory_range r;
> > +
> > +> > 	> > 	> > 	> > r.type = RANGE_RAM;
> > +> > 	> > 	> > 	> > r.start = fdt64_to_cpu(region->base);
> > +> > 	> > 	> > 	> > r.end = r.start + fdt64_to_cpu(region->size) - 1;
> > +
> > +> > 	> > 	> > 	> > if (!region->size) {
> > +> > 	> > 	> > 	> > 	> > dbgprintf("%s:%d: SKIP: %016llx - %016llx\n",
> > +> > 	> > 	> > 	> > 	> > 	> > __func__, __LINE__, r.start, r.end);
> > +> > 	> > 	> > 	> > 	> > continue;
> > +> > 	> > 	> > 	> > }
> > +
> > +> > 	> > 	> > 	> > dbgprintf("%s:%d:  RAM: %016llx - %016llx\n", __func__,
> > +> > 	> > 	> > 	> > 	> > __LINE__, r.start, r.end);
> > +
> > +> > 	> > 	> > 	> > array[(*count)++] = r;
> > +
> > +> > 	> > 	> > 	> > set_phys_offset(r.start);
> > +> > 	> > 	> > }
> > +> > 	> > }
> > +
> > +> > 	> > if (!*count) {
> > +> > 	> > 	> > dbgprintf("%s:%d: %s: No RAM found.\n", __func__, __LINE__,
> > +> > 	> > 	> > 	> > dtb.path);
> > +> > 	> > 	> > goto on_error;
> > +> > 	> > }
> > +
> > +> > 	> > dbgprintf("%s:%d: %s: Success\n", __func__, __LINE__, dtb.path);
> > +> > 	> > result = 0;
> > +> > 	> > goto on_exit;
> > +
> > +on_error:
> > +> > 	> > fprintf(stderr, "%s:%d: %s: Unusable device-tree file\n", __func__,
> > +> > 	> > 	> > __LINE__, dtb.path);
> > +> > 	> > result = -1;
> > +
> > +on_exit:
> > +> > 	> > free(dtb.buf);
> > +> > 	> > return result;
> > +}
> > +
> > +static int get_memory_ranges_iomem(struct memory_range *array,
> > +> > 	> > unsigned int *count)
> > +{
> > +> > 	> > const char *iomem;
> > +> > 	> > char line[MAX_LINE];
> > +> > 	> > FILE *fp;
> > +
> > +> > 	> > *count = 0;
> > +
> > +> > 	> > iomem = proc_iomem();
> > +> > 	> > fp = fopen(iomem, "r");
> > +
> > +> > 	> > if (!fp) {
> > +> > 	> > 	> > fprintf(stderr, "Cannot open %s: %s\n", iomem, strerror(errno));
> > +> > 	> > 	> > return -1;
> > +> > 	> > }
> > +
> > +> > 	> > while(fgets(line, sizeof(line), fp) != 0) {
> 
> There is an existing interface: kexec_iomem_for_each_line().
> 
> > +> > 	> > 	> > struct memory_range r;
> > +> > 	> > 	> > char *str;
> > +> > 	> > 	> > int consumed;
> > +
> > +> > 	> > 	> > if (*count >= KEXEC_SEGMENT_MAX)
> > +> > 	> > 	> > 	> > break;
> > +
> > +> > 	> > 	> > if (sscanf(line, "%Lx-%Lx : %n", &r.start, &r.end, &consumed)
> > +> > 	> > 	> > 	> > != 2)
> > +> > 	> > 	> > 	> > continue;
> > +
> > +> > 	> > 	> > str = line + consumed;
> > +
> > +> > 	> > 	> > if (memcmp(str, "System RAM\n", 11)) {
> > +> > 	> > 	> > 	> > dbgprintf("%s:%d: SKIP: %016Lx - %016Lx : %s", __func__,
> > +> > 	> > 	> > 	> > 	> > __LINE__, r.start, r.end, str);
> > +> > 	> > 	> > 	> > continue;
> > +> > 	> > 	> > }
> > +
> > +> > 	> > 	> > r.type = RANGE_RAM;
> > +
> > +> > 	> > 	> > dbgprintf("%s:%d: RAM:  %016llx - %016llx : %s", __func__,
> > +> > 	> > 	> > 	> > __LINE__, r.start, r.end, str);
> > +
> > +> > 	> > 	> > array[(*count)++] = r;
> > +
> > +> > 	> > 	> > set_phys_offset(r.start);
> > +> > 	> > }
> > +
> > +> > 	> > fclose(fp);
> > +
> > +> > 	> > if (!*count) {
> > +> > 	> > 	> > dbgprintf("%s:%d: failed: No RAM found.\n", __func__, __LINE__);
> > +> > 	> > 	> > return -1;
> > +> > 	> > }
> > +
> > +> > 	> > dbgprintf("%s:%d: Success\n", __func__, __LINE__);
> > +> > 	> > return 0;
> > +}
> > +
> > +int get_memory_ranges(struct memory_range **range, int *ranges,
> > +> > 	> > unsigned long kexec_flags)
> > +{
> > +> > 	> > static struct memory_range array[KEXEC_SEGMENT_MAX];
> > +> > 	> > unsigned int count;
> > +> > 	> > int result;
> > +
> > +> > 	> > result = get_memory_ranges_iomem(array, &count);
> > +
> > +> > 	> > if (result)
> > +> > 	> > 	> > result = get_memory_ranges_dt(array, &count);
> > +
> > +> > 	> > *range = result ? NULL : array;
> > +> > 	> > *ranges = result ? 0 : count;
> > +
> > +> > 	> > return result;
> > +}
> > +
> > +struct file_type file_type[] = {
> > +> > 	> > {"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
> > +> > 	> > {"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
> > +};
> > +
> > +int file_types = sizeof(file_type) / sizeof(file_type[0]);
> > +
> > +int arch_compat_trampoline(struct kexec_info *info)
> > +{
> > +> > 	> > return 0;
> > +}
> > +
> > +int machine_verify_elf_rel(struct mem_ehdr *ehdr)
> > +{
> > +> > 	> > return (ehdr->e_machine == EM_AARCH64);
> > +}
> > +
> > +void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
> > +> > 	> > unsigned long r_type, void *ptr, unsigned long address,
> > +> > 	> > unsigned long value)
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
> 
> Move those definitions to a header(elf.h)?

These are just local values for now.  They sould
be comming from a system header.

> > +
> > +> > 	> > uint64_t *loc64;
> > +> > 	> > uint32_t *loc32;
> > +> > 	> > uint64_t *location = (uint64_t *)ptr;
> > +> > 	> > uint64_t data = *location;
> > +> > 	> > const char *type = NULL;
> > +
> > +> > 	> > switch(r_type) {
> > +> > 	> > case R_AARCH64_ABS64:
> > +> > 	> > 	> > type = "ABS64";
> > +> > 	> > 	> > loc64 = ptr;
> > +> > 	> > 	> > *loc64 = cpu_to_elf64(ehdr, elf64_to_cpu(ehdr, *loc64) + value);
> > +> > 	> > 	> > break;
> > +> > 	> > case R_AARCH64_LD_PREL_LO19:
> > +> > 	> > 	> > type = "LD_PREL_LO19";
> > +> > 	> > 	> > loc32 = ptr;
> > +> > 	> > 	> > *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> > +> > 	> > 	> > 	> > + (((value - address) << 3) & 0xffffe0));
> > +> > 	> > 	> > break;
> > +> > 	> > case R_AARCH64_ADR_PREL_LO21:
> > +> > 	> > 	> > if (value & 3)
> > +> > 	> > 	> > 	> > die("%s: ERROR Unaligned value: %lx\n", __func__,
> > +> > 	> > 	> > 	> > 	> > value);
> > +> > 	> > 	> > type = "ADR_PREL_LO21";
> > +> > 	> > 	> > loc32 = ptr;
> > +> > 	> > 	> > *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> > +> > 	> > 	> > 	> > + (((value - address) << 3) & 0xffffe0));
> > +> > 	> > 	> > break;
> > +> > 	> > case R_AARCH64_JUMP26:
> > +> > 	> > 	> > type = "JUMP26";
> > +> > 	> > 	> > loc32 = ptr;
> > +> > 	> > 	> > *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> > +> > 	> > 	> > 	> > + (((value - address) >> 2) & 0x3ffffff));
> > +> > 	> > 	> > break;
> > +> > 	> > case R_AARCH64_CALL26:
> > +> > 	> > 	> > type = "CALL26";
> > +> > 	> > 	> > loc32 = ptr;
> > +> > 	> > 	> > *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> > +> > 	> > 	> > 	> > + (((value - address) >> 2) & 0x3ffffff));
> > +> > 	> > 	> > break;
> > +> > 	> > default:
> > +> > 	> > 	> > die("%s: ERROR Unknown type: %lu\n", __func__, r_type);
> > +> > 	> > 	> > break;
> > +> > 	> > }
> > +
> > +> > 	> > dbgprintf("%s: %s %016lx->%016lx\n", __func__, type, data, *location);
> > +}
> > +
> > +void arch_reuse_initrd(void)
> > +{
> > +> > 	> > reuse_initrd = 1;
> > +}
> > +
> > +void arch_update_purgatory(struct kexec_info *UNUSED(info))
> > +{
> > +}
> > diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
> > new file mode 100644
> > index 0000000..3514b24
> > --- /dev/null
> > +++ b/kexec/arch/arm64/kexec-arm64.h
> > @@ -0,0 +1,70 @@
> > +/*
> > + * ARM64 kexec.
> > + */
> > +
> > +#if !defined(KEXEC_ARM64_H)
> > +#define KEXEC_ARM64_H
> > +
> > +#include 
> > +#include 
> > +
> > +#include "image-header.h"
> > +#include "kexec.h"
> > +
> > +#define KEXEC_SEGMENT_MAX 16
> > +
> > +#define BOOT_BLOCK_VERSION 17
> > +#define BOOT_BLOCK_LAST_COMP_VERSION 16
> > +#define COMMAND_LINE_SIZE 512
> > +
> > +#define KiB(x) ((x) * 1024UL)
> > +#define MiB(x) (KiB(x) * 1024UL)
> > +#define GiB(x) (MiB(x) * 1024UL)
> > +
> > +int elf_arm64_probe(const char *kernel_buf, off_t kernel_size);
> > +int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
> > +> > 	> > off_t kernel_size, struct kexec_info *info);
> > +void elf_arm64_usage(void);
> > +
> > +int image_arm64_probe(const char *kernel_buf, off_t kernel_size);
> > +int image_arm64_load(int argc, char **argv, const char *kernel_buf,
> > +> > 	> > off_t kernel_size, struct kexec_info *info);
> > +void image_arm64_usage(void);
> > +
> > +off_t initrd_base;
> > +off_t initrd_size;
> 
> Add "extern" for consistent usages.
> 
> > +
> > +/**
> > + * struct arm64_mem - Memory layout info.
> > + */
> > +
> > +struct arm64_mem {
> > +> > 	> > uint64_t phys_offset;
> > +> > 	> > uint64_t text_offset;
> > +> > 	> > uint64_t image_size;
> > +> > 	> > uint64_t page_offset;
> > +};
> > +
> > +#define arm64_mem_ngv UINT64_MAX
> 
> What does "ngv" stand for?

NG value, ?????.

> > new file mode 100644
> > index 0000000..27161e8
> > --- /dev/null
> > +++ b/kexec/arch/arm64/kexec-elf-arm64.c
> > @@ -0,0 +1,130 @@
> > +/*
> > + * ARM64 kexec elf support.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include 
> > +#include 
> > +#include 
> > +
> > +#include "kexec-arm64.h"
> > +#include "kexec-elf.h"
> > +#include "kexec-syscall.h"
> > +
> > +int elf_arm64_probe(const char *kernel_buf, off_t kernel_size)
> > +{
> > +> > 	> > struct mem_ehdr ehdr;
> > +> > 	> > int result;
> > +
> > +> > 	> > result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
> > +
> > +> > 	> > if (result < 0) {
> > +> > 	> > 	> > dbgprintf("%s: Not an ELF executable.\n", __func__);
> > +> > 	> > 	> > goto on_exit;
> > +> > 	> > }
> > +
> > +> > 	> > if (ehdr.e_machine != EM_AARCH64) {
> > +> > 	> > 	> > dbgprintf("%s: Not an AARCH64 ELF executable.\n", __func__);
> > +> > 	> > 	> > result = -1;
> > +> > 	> > 	> > goto on_exit;
> > +> > 	> > }
> > +
> > +> > 	> > result = 0;
> > +on_exit:
> > +> > 	> > free_elf_info(&ehdr);
> > +> > 	> > return result;
> > +}
> > +
> > +int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
> > +> > 	> > off_t kernel_size, struct kexec_info *info)
> > +{
> > +> > 	> > struct mem_ehdr ehdr;
> > +> > 	> > int result;
> > +> > 	> > int i;
> > +
> > +> > 	> > if (info->kexec_flags & KEXEC_ON_CRASH) {
> > +> > 	> > 	> > fprintf(stderr, "kexec: kdump not yet supported on arm64\n");
> > +> > 	> > 	> > return -EINVAL;
> > +> > 	> > }
> > +
> > +> > 	> > result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
> > +
> > +> > 	> > if (result < 0) {
> > +> > 	> > 	> > dbgprintf("%s: build_elf_exec_info failed\n", __func__);
> > +> > 	> > 	> > goto exit;
> > +> > 	> > }
> > +
> > +> > 	> > /* Find and process the arm64 image header. */
> > +
> > +> > 	> > for (i = 0; i < ehdr.e_phnum; i++) {
> > +> > 	> > 	> > struct mem_phdr *phdr = &ehdr.e_phdr[i];
> > +> > 	> > 	> > const struct arm64_image_header *h;
> > +> > 	> > 	> > unsigned long header_offset;
> > +
> > +> > 	> > 	> > if (phdr->p_type != PT_LOAD)
> > +> > 	> > 	> > 	> > continue;
> > +
> > +> > 	> > 	> > /*
> > +> > 	> > 	> >  * When CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET=y the image header
> > +> > 	> > 	> >  * could be offset in the elf segment.  The linker script sets
> > +> > 	> > 	> >  * ehdr.e_entry to the start of text.
> > +> > 	> > 	> >  */
> > +
> > +> > 	> > 	> > header_offset = ehdr.e_entry - phdr->p_vaddr;
> > +
> > +> > 	> > 	> > h = (const struct arm64_image_header *)(
> > +> > 	> > 	> > 	> > kernel_buf + phdr->p_offset + header_offset);
> > +
> > +> > 	> > 	> > if (arm64_process_image_header(h))
> > +> > 	> > 	> > 	> > continue;
> > +
> > +> > 	> > 	> > arm64_mem.page_offset = ehdr.e_entry - arm64_mem.text_offset;
> > +
> > +> > 	> > 	> > dbgprintf("%s: e_entry:       %016llx -> %016lx\n", __func__,
> > +> > 	> > 	> > 	> > ehdr.e_entry,
> > +> > 	> > 	> > 	> > virt_to_phys(ehdr.e_entry));
> > +> > 	> > 	> > dbgprintf("%s: p_vaddr:       %016llx -> %016lx\n", __func__,
> > +> > 	> > 	> > 	> > phdr->p_vaddr,
> > +> > 	> > 	> > 	> > virt_to_phys(phdr->p_vaddr));
> > +> > 	> > 	> > dbgprintf("%s: header_offset: %016lx\n", __func__,
> > +> > 	> > 	> > 	> > header_offset);
> > +> > 	> > 	> > dbgprintf("%s: text_offset:   %016lx\n", __func__,
> > +> > 	> > 	> > 	> > arm64_mem.text_offset);
> > +> > 	> > 	> > dbgprintf("%s: image_size:    %016lx\n", __func__,
> > +> > 	> > 	> > 	> > arm64_mem.image_size);
> > +> > 	> > 	> > dbgprintf("%s: phys_offset:   %016lx\n", __func__,
> > +> > 	> > 	> > 	> > arm64_mem.phys_offset);
> > +> > 	> > 	> > dbgprintf("%s: page_offset:   %016lx\n", __func__,
> > +> > 	> > 	> > 	> > arm64_mem.page_offset);
> > +> > 	> > 	> > dbgprintf("%s: PE format:     %s\n", __func__,
> > +> > 	> > 	> > 	> > (arm64_header_check_pe_sig(h) ? "yes" : "no"));
> > +
> > +> > 	> > 	> > result = elf_exec_load(&ehdr, info);
> > +
> > +> > 	> > 	> > if (result) {
> > +> > 	> > 	> > 	> > fprintf(stderr, "kexec: Elf load failed.\n");
> > +> > 	> > 	> > 	> > goto exit;
> > +> > 	> > 	> > }
> > +
> > +> > 	> > 	> > result = arm64_load_other_segments(info,
> > +> > 	> > 	> > 	> > virt_to_phys(ehdr.e_entry));
> > +> > 	> > 	> > goto exit;
> > +> > 	> > }
> > +
> > +> > 	> > fprintf(stderr, "kexec: Bad arm64 image header.\n");
> > +> > 	> > result = -EINVAL;
> > +> > 	> > goto exit;
> > +
> > +exit:
> > +> > 	> > reset_page_offset();
> > +> > 	> > free_elf_info(&ehdr);
> > +> > 	> > return result;
> > +}
> > +
> > +void elf_arm64_usage(void)
> > +{
> > +> > 	> > printf(
> > +"     An ARM64 ELF image, big or little endian.\n"
> > +"     Typically vmlinux or a stripped version of vmlinux.\n\n");
> > +}
> > diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
> > new file mode 100644
> > index 0000000..caf90c7
> > --- /dev/null
> > +++ b/kexec/arch/arm64/kexec-image-arm64.c
> > @@ -0,0 +1,44 @@
> > +/*
> > + * ARM64 kexec binary image support.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include 
> > +
> > +#include "kexec-arm64.h"
> > +
> > +int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
> > +{
> > +> > 	> > const struct arm64_image_header *h;
> > +
> > +> > 	> > if (kernel_size < sizeof(struct arm64_image_header)) {
> > +> > 	> > 	> > dbgprintf("%s: No arm64 image header.\n", __func__);
> > +> > 	> > 	> > return -1;
> > +> > 	> > }
> > +
> > +> > 	> > h = (const struct arm64_image_header *)(kernel_buf);
> > +
> > +> > 	> > if (!arm64_header_check_magic(h)) {
> > +> > 	> > 	> > dbgprintf("%s: Bad arm64 image header.\n", __func__);
> > +> > 	> > 	> > return -1;
> > +> > 	> > }
> > +
> > +> > 	> > fprintf(stderr, "kexec: ARM64 binary image files are currently NOT SUPPORTED.\n");
> > +
> > +> > 	> > return -1;
> > +}
> > +
> > +int image_arm64_load(int argc, char **argv, const char *kernel_buf,
> > +> > 	> > off_t kernel_size, struct kexec_info *info)
> > +{
> > +> > 	> > return -ENOSYS;
> > +}
> > +
> > +void image_arm64_usage(void)
> > +{
> > +> > 	> > printf(
> > +"     An ARM64 binary image, compressed or not, big or little endian.\n"
> > +"     Typically an Image, Image.gz or Image.lzma file.\n\n");
> > +"     This file type is currently NOT SUPPORTED.\n\n");
> > +}
> > diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> > index ce2e20b..c0d0bea 100644
> > --- a/kexec/kexec-syscall.h
> > +++ b/kexec/kexec-syscall.h
> > @@ -39,8 +39,8 @@
> >  #ifdef __s390__
> >  #define __NR_kexec_load> > 	> > 	> > 277
> >  #endif
> > -#ifdef __arm__
> > -#define __NR_kexec_load> > 	> > 	> > __NR_SYSCALL_BASE + 347  
> > +#if defined(__arm__) || defined(__arm64__)
> > +#define __NR_kexec_load> > 	> > 	> > __NR_SYSCALL_BASE + 347
> >  #endif
> >  #if defined(__mips__)
> >  #define __NR_kexec_load                4311
> > @@ -108,6 +108,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
> >  #define KEXEC_ARCH_PPC64   (21 << 16)
> >  #define KEXEC_ARCH_IA_64   (50 << 16)
> >  #define KEXEC_ARCH_ARM     (40 << 16)
> > +#define KEXEC_ARCH_ARM64   (183 << 16)
> >  #define KEXEC_ARCH_S390    (22 << 16)
> >  #define KEXEC_ARCH_SH      (42 << 16)
> >  #define KEXEC_ARCH_MIPS_LE (10 << 16)
> > @@ -153,5 +154,8 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
> >  #ifdef __m68k__
> >  #define KEXEC_ARCH_NATIVE> > 	> > KEXEC_ARCH_68K
> >  #endif
> > +#if defined(__arm64__)
> > +#define KEXEC_ARCH_NATIVE> > 	> > KEXEC_ARCH_ARM64
> > +#endif
> >  
> >  #endif /* KEXEC_SYSCALL_H */
> > diff --git a/purgatory/Makefile b/purgatory/Makefile
> > index 2b5c061..ca0443c 100644
> > --- a/purgatory/Makefile
> > +++ b/purgatory/Makefile
> > @@ -19,6 +19,7 @@ dist += purgatory/Makefile $(PURGATORY_SRCS)> > 	> > 	> > 	> > 	> > \
> >  
> >  include $(srcdir)/purgatory/arch/alpha/Makefile
> >  include $(srcdir)/purgatory/arch/arm/Makefile
> > +include $(srcdir)/purgatory/arch/arm64/Makefile
> >  include $(srcdir)/purgatory/arch/i386/Makefile
> >  include $(srcdir)/purgatory/arch/ia64/Makefile
> >  include $(srcdir)/purgatory/arch/mips/Makefile
> > diff --git a/purgatory/arch/arm64/Makefile b/purgatory/arch/arm64/Makefile
> > new file mode 100644
> > index 0000000..636abea
> > --- /dev/null
> > +++ b/purgatory/arch/arm64/Makefile
> > @@ -0,0 +1,18 @@
> > +
> > +arm64_PURGATORY_EXTRA_CFLAGS = \
> > +> > 	> > -mcmodel=large \
> > +> > 	> > -fno-stack-protector \
> > +> > 	> > -fno-asynchronous-unwind-tables \
> > +> > 	> > -Wundef \
> > +> > 	> > -Werror-implicit-function-declaration \
> > +> > 	> > -Wdeclaration-after-statement \
> > +> > 	> > -Werror=implicit-int \
> > +> > 	> > -Werror=strict-prototypes
> > +
> > +arm64_PURGATORY_SRCS += \
> > +> > 	> > purgatory/arch/arm64/entry.S \
> > +> > 	> > purgatory/arch/arm64/purgatory-arm64.c
> > +
> > +dist += \
> > +> > 	> > $(arm64_PURGATORY_SRCS) \
> > +> > 	> > purgatory/arch/arm64/Makefile
> > diff --git a/purgatory/arch/arm64/entry.S b/purgatory/arch/arm64/entry.S
> > new file mode 100644
> > index 0000000..8dfdb47
> > --- /dev/null
> > +++ b/purgatory/arch/arm64/entry.S
> > @@ -0,0 +1,52 @@
> > +/*
> > + * ARM64 purgatory.
> > + */
> > +
> > +.macro> > 	> > size, sym:req
> > +> > 	> > .size \sym, . - \sym
> > +.endm
> > +
> > +.text
> > +
> > +.globl purgatory_start
> > +purgatory_start:
> > +
> > +> > 	> > adr> > 	> > x19, .Lstack
> > +> > 	> > mov> > 	> > sp, x19
> > +
> > +> > 	> > bl> > 	> > purgatory
> > +
> > +1:
> > +> > 	> > b> > 	> > 1b
> > +
> > +size purgatory_start
> > +
> > +.align 4
> > +> > 	> > .rept> > 	> > 256
> > +> > 	> > .quad> > 	> > 0
> > +> > 	> > .endr
> > +.Lstack:
> > +
> > +.data
> > +
> > +.align 3
> > +
> > +.globl arm64_sink
> > +arm64_sink:
> > +> > 	> > .quad> > 	> > 0
> > +size arm64_sink
> > +
> > +.globl arm64_kernel_entry
> > +arm64_kernel_entry:
> > +> > 	> > .quad> > 	> > 0
> > +size arm64_kernel_entry
> > +
> > +.globl arm64_dtb_addr
> > +arm64_dtb_addr:
> > +> > 	> > .quad> > 	> > 0
> > +size arm64_dtb_addr
> 
> Those variables can be defined in purgatory-arm64.c
> by adding section attributes.

If we remove any reference to these in purgatory-arm64.c (below) it
makes sence to keep these.

> > +
> > +.globl arm64_kexec_lite
> > +arm64_kexec_lite:
> > +> > 	> > .quad> > 	> > 0
> > +size arm64_kexec_lite
> 
> You have removed "lite" option.

OK.

> 
> > diff --git a/purgatory/arch/arm64/purgatory-arm64.c b/purgatory/arch/arm64/purgatory-arm64.c
> > new file mode 100644
> > index 0000000..fd76405
> > --- /dev/null
> > +++ b/purgatory/arch/arm64/purgatory-arm64.c
> > @@ -0,0 +1,35 @@
> > +/*
> > + * ARM64 purgatory.
> > + */
> > +
> > +#include 
> > +#include 
> > +
> > +/* Symbols set by kexec. */
> > +
> > +extern uint8_t *arm64_sink;
> > +extern void (*arm64_kernel_entry)(uint64_t, uint64_t, uint64_t, uint64_t);
> > +extern uint64_t arm64_dtb_addr;
> > +
> > +void putchar(int ch)
> > +{
> > +> > 	> > if (!arm64_sink)
> > +> > 	> > 	> > return;
> > +
> > +> > 	> > *arm64_sink = ch;
> > +
> > +> > 	> > if (ch == '\n')
> > +> > 	> > 	> > *arm64_sink = '\r';
> > +}
> > +
> > +void post_verification_setup_arch(void)
> > +{
> > +> > 	> > arm64_kernel_entry(arm64_dtb_addr, 0, 0, 0);
> 
> I think most archs jump into the next kernel from purgatory_start in entry.S.

OK.
