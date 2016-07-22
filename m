From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 22 Jul 2016 16:12:08 +0900
Subject: [PATCH v1.2 3/4] arm64: Add arm64 kexec support
In-Reply-To: <1469048065.2977.124.camel@infradead.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <1469048065.2977.124.camel@infradead.org>
Message-ID: <20160722071204.GP20774@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 01:54:25PM -0700, Geoff Levand wrote:
> Add kexec reboot support for ARM64 platforms.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  configure.ac                            |   3 +
>  kexec/Makefile                          |   1 +
>  kexec/arch/arm64/Makefile               |  40 ++
>  kexec/arch/arm64/crashdump-arm64.c      |  21 +
>  kexec/arch/arm64/crashdump-arm64.h      |  12 +
>  kexec/arch/arm64/image-header.h         | 104 ++++
>  kexec/arch/arm64/include/arch/options.h |  43 ++
>  kexec/arch/arm64/kexec-arm64.c          | 979 ++++++++++++++++++++++++++++++++
>  kexec/arch/arm64/kexec-arm64.h          |  70 +++
>  kexec/arch/arm64/kexec-elf-arm64.c      | 130 +++++
>  kexec/arch/arm64/kexec-image-arm64.c    |  44 ++
>  kexec/kexec-syscall.h                   |   8 +-
>  purgatory/Makefile                      |   1 +
>  purgatory/arch/arm64/Makefile           |  18 +
>  purgatory/arch/arm64/entry.S            |  52 ++
>  purgatory/arch/arm64/purgatory-arm64.c  |  35 ++
>  16 files changed, 1559 insertions(+), 2 deletions(-)
>  create mode 100644 kexec/arch/arm64/Makefile
>  create mode 100644 kexec/arch/arm64/crashdump-arm64.c
>  create mode 100644 kexec/arch/arm64/crashdump-arm64.h
>  create mode 100644 kexec/arch/arm64/image-header.h
>  create mode 100644 kexec/arch/arm64/include/arch/options.h
>  create mode 100644 kexec/arch/arm64/kexec-arm64.c
>  create mode 100644 kexec/arch/arm64/kexec-arm64.h
>  create mode 100644 kexec/arch/arm64/kexec-elf-arm64.c
>  create mode 100644 kexec/arch/arm64/kexec-image-arm64.c
>  create mode 100644 purgatory/arch/arm64/Makefile
>  create mode 100644 purgatory/arch/arm64/entry.S
>  create mode 100644 purgatory/arch/arm64/purgatory-arm64.c
> 
> diff --git a/configure.ac b/configure.ac
> index ca3a9d5..8858c94 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -34,6 +34,9 @@ case $target_cpu in
>  		ARCH="ppc64"
>  		SUBARCH="LE"
>  		;;
> +	aarch64* )
> +		ARCH="arm64"
> +		;;
>  	arm* )
>  		ARCH="arm"
>  		;;
> diff --git a/kexec/Makefile b/kexec/Makefile
> index cc3f08b..39f365f 100644
> --- a/kexec/Makefile
> +++ b/kexec/Makefile
> @@ -79,6 +79,7 @@ KEXEC_SRCS			+= $($(ARCH)_DT_OPS)
>  
>  include $(srcdir)/kexec/arch/alpha/Makefile
>  include $(srcdir)/kexec/arch/arm/Makefile
> +include $(srcdir)/kexec/arch/arm64/Makefile
>  include $(srcdir)/kexec/arch/i386/Makefile
>  include $(srcdir)/kexec/arch/ia64/Makefile
>  include $(srcdir)/kexec/arch/m68k/Makefile
> diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
> new file mode 100644
> index 0000000..37414dc
> --- /dev/null
> +++ b/kexec/arch/arm64/Makefile
> @@ -0,0 +1,40 @@
> +
> +arm64_FS2DT += kexec/fs2dt.c
> +arm64_FS2DT_INCLUDE += -include $(srcdir)/kexec/arch/arm64/kexec-arm64.h \
> +	-include $(srcdir)/kexec/arch/arm64/crashdump-arm64.h
> +
> +arm64_DT_OPS += kexec/dt-ops.c
> +
> +arm64_CPPFLAGS += -I $(srcdir)/kexec/
> +
> +arm64_KEXEC_SRCS += \
> +	kexec/arch/arm64/kexec-arm64.c \
> +	kexec/arch/arm64/kexec-image-arm64.c \
> +	kexec/arch/arm64/kexec-elf-arm64.c \
> +	kexec/arch/arm64/crashdump-arm64.c
> +
> +arm64_ARCH_REUSE_INITRD =
> +arm64_ADD_SEGMENT =
> +arm64_VIRT_TO_PHYS =
> +arm64_PHYS_TO_VIRT =
> +
> +dist += $(arm64_KEXEC_SRCS) \
> +	kexec/arch/arm64/Makefile \
> +	kexec/arch/arm64/kexec-arm64.h \
> +	kexec/arch/arm64/crashdump-arm64.h
> +
> +ifdef HAVE_LIBFDT
> +
> +LIBS += -lfdt
> +
> +else
> +
> +include $(srcdir)/kexec/libfdt/Makefile.libfdt
> +
> +libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
> +
> +arm64_CPPFLAGS += -I$(srcdir)/kexec/libfdt
> +
> +arm64_KEXEC_SRCS += $(libfdt_SRCS)
> +
> +endif
> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
> new file mode 100644
> index 0000000..d2272c8
> --- /dev/null
> +++ b/kexec/arch/arm64/crashdump-arm64.c
> @@ -0,0 +1,21 @@
> +/*
> + * ARM64 crashdump.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <linux/elf.h>
> +
> +#include "kexec.h"
> +#include "crashdump.h"
> +#include "crashdump-arm64.h"
> +#include "kexec-arm64.h"
> +#include "kexec-elf.h"
> +
> +struct memory_ranges usablemem_rgns = {};
> +
> +int is_crashkernel_mem_reserved(void)
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
> new file mode 100644
> index 0000000..f33c7a2
> --- /dev/null
> +++ b/kexec/arch/arm64/crashdump-arm64.h
> @@ -0,0 +1,12 @@
> +/*
> + * ARM64 crashdump.
> + */
> +
> +#if !defined(CRASHDUMP_ARM64_H)
> +#define CRASHDUMP_ARM64_H
> +
> +#include "kexec.h"
> +
> +extern struct memory_ranges usablemem_rgns;
> +
> +#endif
> diff --git a/kexec/arch/arm64/image-header.h b/kexec/arch/arm64/image-header.h
> new file mode 100644
> index 0000000..126ca15
> --- /dev/null
> +++ b/kexec/arch/arm64/image-header.h
> @@ -0,0 +1,104 @@
> +/*
> + * ARM64 binary image support.
> + */
> +
> +#if !defined(__ARM64_IMAGE_HEADER_H)
> +#define __ARM64_IMAGE_HEADER_H
> +
> +#if !defined(__KERNEL__)
> +#include <stdint.h>
> +#include <endian.h>
> +#endif
> +
> +#if !defined(__ASSEMBLY__)
> +
> +/**
> + * struct arm64_image_header - arm64 kernel image header.
> + *
> + * @pe_sig: Optional PE format 'MZ' signature.
> + * @branch_code: Reserved for instructions to branch to stext.
> + * @text_offset: The image load offset in LSB byte order.
> + * @image_size: An estimated size of the memory image size in LSB byte order.
> + * @flags: Bit flags in LSB byte order:
> + *  Bit 7.0: Image byte order, 1=MSB.
> + * @reserved_1: Reserved.
> + * @magic: Magic number, "ARM\x64".
> + * @pe_header: Optional offset to a PE format header.
> + **/
> +
> +struct arm64_image_header {
> +	uint8_t pe_sig[2];
> +	uint16_t branch_code[3];
> +	uint64_t text_offset;
> +	uint64_t image_size;
> +	uint64_t flags;
> +	uint64_t reserved_1[3];
> +	uint8_t magic[4];
> +	uint32_t pe_header;
> +};
> +
> +static const uint8_t arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
> +static const uint8_t arm64_image_pe_sig[2] = {'M', 'Z'};
> +static const uint64_t arm64_image_flag_be = (1UL << 0);

Should static variables not be in a header?

> +/**
> + * arm64_header_check_magic - Helper to check the arm64 image header.
> + *
> + * Returns non-zero if header is OK.
> + */
> +
> +static inline int arm64_header_check_magic(const struct arm64_image_header *h)
> +{
> +	if (!h)
> +		return 0;
> +
> +	return (h->magic[0] == arm64_image_magic[0]
> +		&& h->magic[1] == arm64_image_magic[1]
> +		&& h->magic[2] == arm64_image_magic[2]
> +		&& h->magic[3] == arm64_image_magic[3]);
> +}
> +
> +/**
> + * arm64_header_check_pe_sig - Helper to check the arm64 image header.
> + *
> + * Returns non-zero if 'MZ' signature is found.
> + */
> +
> +static inline int arm64_header_check_pe_sig(const struct arm64_image_header *h)
> +{
> +	if (!h)
> +		return 0;
> +
> +	return (h->pe_sig[0] == arm64_image_pe_sig[0]
> +		&& h->pe_sig[1] == arm64_image_pe_sig[1]);
> +}
> +
> +/**
> + * arm64_header_check_msb - Helper to check the arm64 image header.
> + *
> + * Returns non-zero if the image was built as big endian.
> + */
> +
> +static inline int arm64_header_check_msb(const struct arm64_image_header *h)
> +{
> +	if (!h)
> +		return 0;
> +
> +	return le64toh(h->flags) & arm64_image_flag_be;
> +}
> +
> +static inline uint64_t arm64_header_text_offset(
> +	const struct arm64_image_header *h)
> +{
> +	return le64toh(h->text_offset);
> +}
> +
> +static inline uint64_t arm64_header_image_size(
> +	const struct arm64_image_header *h)
> +{
> +	return le64toh(h->image_size);
> +}
> +
> +#endif /* !defined(__ASSEMBLY__) */
> +
> +#endif
> diff --git a/kexec/arch/arm64/include/arch/options.h b/kexec/arch/arm64/include/arch/options.h
> new file mode 100644
> index 0000000..419e867
> --- /dev/null
> +++ b/kexec/arch/arm64/include/arch/options.h
> @@ -0,0 +1,43 @@
> +#if !defined(KEXEC_ARCH_ARM64_OPTIONS_H)
> +#define KEXEC_ARCH_ARM64_OPTIONS_H
> +
> +#define OPT_APPEND		((OPT_MAX)+0)
> +#define OPT_DTB			((OPT_MAX)+1)
> +#define OPT_INITRD		((OPT_MAX)+2)
> +#define OPT_PORT		((OPT_MAX)+3)
> +#define OPT_REUSE_CMDLINE	((OPT_MAX)+4)
> +#define OPT_ARCH_MAX		((OPT_MAX)+5)
> +
> +#define KEXEC_ARCH_OPTIONS \
> +	KEXEC_OPTIONS \
> +	{ "append",        1, NULL, OPT_APPEND }, \
> +	{ "command-line",  1, NULL, OPT_APPEND }, \
> +	{ "dtb",           1, NULL, OPT_DTB }, \
> +	{ "initrd",        1, NULL, OPT_INITRD }, \
> +	{ "port",          1, NULL, OPT_PORT }, \
> +	{ "ramdisk",       1, NULL, OPT_INITRD }, \
> +	{ "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
> +
> +#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR /* Only accept long arch options. */
> +#define KEXEC_ALL_OPTIONS KEXEC_ARCH_OPTIONS
> +#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
> +
> +static const char arm64_opts_usage[] __attribute__ ((unused)) =
> +"     --append=STRING       Set the kernel command line to STRING.\n"
> +"     --command-line=STRING Set the kernel command line to STRING.\n"
> +"     --dtb=FILE            Use FILE as the device tree blob.\n"
> +"     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
> +"     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
> +"     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
> +"     --reuse-cmdline       Use kernel command line from running system.\n";

Ditto

> +struct arm64_opts {
> +	const char *command_line;
> +	const char *dtb;
> +	const char *initrd;
> +	uint64_t port;
> +};
> +
> +extern struct arm64_opts arm64_opts;
> +
> +#endif
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> new file mode 100644
> index 0000000..24031f6
> --- /dev/null
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -0,0 +1,979 @@
> +/*
> + * ARM64 kexec.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <assert.h>
> +#include <errno.h>
> +#include <getopt.h>
> +#include <inttypes.h>
> +#include <libfdt.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <sys/stat.h>
> +#include <linux/elf.h>
> +
> +#include "dt-ops.h"
> +#include "kexec.h"
> +#include "crashdump.h"
> +#include "crashdump-arm64.h"
> +#include "kexec-arm64.h"
> +#include "fs2dt.h"
> +#include "kexec-syscall.h"
> +#include "arch/options.h"

Can those be sorted in an alphabetic order?
> +
> +/* Global varables the core kexec routines expect. */
> +
> +unsigned char reuse_initrd;
> +
> +off_t initrd_base;
> +off_t initrd_size;
> +
> +const struct arch_map_entry arches[] = {
> +	{ "aarch64", KEXEC_ARCH_ARM64 },
> +	{ "aarch64_be", KEXEC_ARCH_ARM64 },
> +	{ NULL, 0 },
> +};
> +
> +/* arm64 global varables. */
> +
> +struct arm64_opts arm64_opts;
> +struct arm64_mem arm64_mem = {
> +	.phys_offset = arm64_mem_ngv,
> +	.page_offset = arm64_mem_ngv,
> +};
> +
> +uint64_t get_phys_offset(void)
> +{
> +	assert(arm64_mem.phys_offset != arm64_mem_ngv);

Assertion here?

> +	return arm64_mem.phys_offset;
> +}
> +
> +uint64_t get_page_offset(void)
> +{
> +	assert(arm64_mem.page_offset != arm64_mem_ngv);
> +	return arm64_mem.page_offset;
> +}
> +
> +void arch_usage(void)
> +{
> +	printf(arm64_opts_usage);
> +}
> +
> +int arch_process_options(int argc, char **argv)
> +{
> +	static const char short_options[] = KEXEC_OPT_STR "";
> +	static const struct option options[] = {
> +		KEXEC_ARCH_OPTIONS
> +		{ 0 }
> +	};
> +	int opt;
> +	char *cmdline = NULL;
> +	const char *append = NULL;
> +
> +	for (opt = 0; opt != -1; ) {
> +		opt = getopt_long(argc, argv, short_options, options, 0);
> +
> +		switch (opt) {
> +		case OPT_APPEND:
> +			append = optarg;
> +			break;
> +		case OPT_REUSE_CMDLINE:
> +			cmdline = get_command_line();
> +			break;
> +		case OPT_DTB:
> +			arm64_opts.dtb = optarg;
> +			break;
> +		case OPT_INITRD:
> +			arm64_opts.initrd = optarg;
> +			break;
> +		case OPT_PORT:
> +			arm64_opts.port = strtoull(optarg, NULL, 0);
> +			break;
> +		default:
> +			break; /* Ignore core and unknown options. */
> +		}
> +	}
> +
> +	arm64_opts.command_line = concat_cmdline(cmdline, append);
> +
> +	dbgprintf("%s:%d: command_line: %s\n", __func__, __LINE__,
> +		arm64_opts.command_line);
> +	dbgprintf("%s:%d: initrd: %s\n", __func__, __LINE__,
> +		arm64_opts.initrd);
> +	dbgprintf("%s:%d: dtb: %s\n", __func__, __LINE__, arm64_opts.dtb);
> +	dbgprintf("%s:%d: port: 0x%" PRIx64 "\n", __func__, __LINE__,
> +		arm64_opts.port);
> +
> +	return 0;
> +}
> +
> +struct dtb {
> +	char *buf;
> +	off_t size;
> +	const char *name;
> +	const char *path;
> +};
> +
> +static void dump_reservemap(const struct dtb *dtb)
> +{
> +	int i;
> +
> +	for (i = 0; ; i++) {
> +		uint64_t address;
> +		uint64_t size;
> +
> +		fdt_get_mem_rsv(dtb->buf, i, &address, &size);
> +
> +		if (!size)
> +			break;
> +
> +		dbgprintf("%s: %s {%" PRIx64 ", %" PRIx64 "}\n", __func__,
> +			dtb->name, address, size);
> +	}
> +}
> +
> +enum cpu_enable_method {
> +	cpu_enable_method_unknown,
> +	cpu_enable_method_psci,
> +	cpu_enable_method_spin_table,
> +};
> +
> +static const char *cpu_enable_method_str(enum cpu_enable_method m)
> +{
> +	if (m == cpu_enable_method_psci)
> +		return "psci";
> +	if (m == cpu_enable_method_spin_table)
> +		return "spin_table";
> +	return "unknown";
> +}
> +
> +/**
> + * struct cpu_properties - Various properties from a device tree cpu node.
> + *
> + * These properties will be valid over a dtb re-size.
> + */
> +
> +struct cpu_properties {
> +	uint64_t hwid;
> +	char node_path[128];
> +	enum cpu_enable_method method;
> +};
> +
> +/**
> + * read_cpu_properties - Helper to read the device tree cpu properties.
> + */
> +
> +static int read_cpu_properties(struct cpu_properties *cp,
> +	const struct dtb *dtb, int node_offset, unsigned int address_cells)
> +{
> +	int result;
> +	const void *data;
> +
> +	result = fdt_get_path(dtb->buf, node_offset, cp->node_path,
> +		sizeof(cp->node_path));
> +
> +	if (result < 0) {
> +		fprintf(stderr, "kexec: %s:%d: %s: fdt_get_path failed: %s\n",
> +			__func__, __LINE__, dtb->name, fdt_strerror(result));
> +		return result;
> +	}
> +
> +	data = fdt_getprop(dtb->buf, node_offset, "device_type", &result);
> +
> +	if (!data) {
> +		dbgprintf("%s: %s (%s) read device_type failed: %s\n",
> +			__func__, dtb->name, cp->node_path,
> +			fdt_strerror(result));
> +		return result == -FDT_ERR_NOTFOUND ? 0 : result;
> +	}
> +
> +	if (strcmp(data, "cpu")) {
> +		dbgprintf("%s: %s (%s): '%s'\n", __func__, dtb->name,
> +			cp->node_path, (const char *)data);
> +		return 0;
> +	}
> +
> +	data = fdt_getprop(dtb->buf, node_offset, "reg", &result);
> +
> +	if (!data) {
> +		fprintf(stderr, "kexec: %s:%d: read hwid failed: %s\n",
> +			__func__, __LINE__, fdt_strerror(result));
> +		return result;
> +	}
> +
> +	cp->hwid = (address_cells == 1) ? fdt32_to_cpu(*(uint32_t *)data) :
> +		fdt64_to_cpu(*(uint64_t *)data);
> +
> +	data = fdt_getprop(dtb->buf, node_offset, "enable-method", &result);
> +
> +	if (!data) {
> +		fprintf(stderr,
> +			"kexec: %s:%d: read enable_method failed: %s\n",
> +			__func__, __LINE__, fdt_strerror(result));
> +		return result;
> +	}
> +
> +	if (!strcmp(data, "psci")) {
> +		cp->method = cpu_enable_method_psci;
> +		return 1;
> +	}
> +
> +	if (!strcmp(data, "spin-table")) {
> +		cp->method = cpu_enable_method_spin_table;
> +		return 1;
> +	}
> +
> +	cp->method = cpu_enable_method_unknown;
> +	return 1;
> +}
> +
> +static int check_cpu_properties(const struct cpu_properties *cp_1,
> +	const struct cpu_properties *cp_2)
> +{
> +	assert(cp_1->hwid == cp_2->hwid);
> +
> +	if (cp_1->method != cp_2->method) {
> +		fprintf(stderr,
> +			"%s:%d: hwid-%" PRIx64 ": Error: Different cpu enable methods: %s -> %s\n",
> +			__func__, __LINE__, cp_1->hwid,
> +			cpu_enable_method_str(cp_1->method),
> +			cpu_enable_method_str(cp_2->method));
> +		return -EINVAL;
> +	}
> +
> +	if (cp_2->method != cpu_enable_method_psci) {
> +		fprintf(stderr,
> +			"%s:%d: hwid-%" PRIx64 ": Error: Unsupported cpu enable method: %s\n",
> +			__func__, __LINE__, cp_1->hwid,
> +			cpu_enable_method_str(cp_1->method));
> +		return -EINVAL;
> +	}
> +
> +	dbgprintf("%s: hwid-%" PRIx64 ": OK\n", __func__, cp_1->hwid);
> +
> +	return 0;
> +}
> +
> +struct cpu_info {
> +	unsigned int cpu_count;
> +	struct cpu_properties *cp;
> +};
> +
> +static int read_cpu_info(struct cpu_info *info, const struct dtb *dtb)
> +{
> +	int i;
> +	int offset;
> +	int result;
> +	int depth;
> +	const void *data;
> +	unsigned int address_cells;
> +
> +	offset = fdt_subnode_offset(dtb->buf, 0, "cpus");
> +
> +	if (offset < 0) {
> +		fprintf(stderr, "kexec: %s:%d: read cpus node failed: %s\n",
> +			__func__, __LINE__, fdt_strerror(offset));
> +		return offset;
> +	}
> +
> +	data = fdt_getprop(dtb->buf, offset, "#address-cells", &result);
> +
> +	if (!data) {
> +		fprintf(stderr,
> +			"kexec: %s:%d: read cpus address-cells failed: %s\n",
> +			__func__, __LINE__, fdt_strerror(result));
> +		return result;
> +	}
> +
> +	address_cells = fdt32_to_cpu(*(uint32_t *)data);
> +
> +	if (address_cells < 1 || address_cells > 2) {
> +		fprintf(stderr,
> +			"kexec: %s:%d: bad cpus address-cells value: %u\n",
> +			__func__, __LINE__, address_cells);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0, depth = 0; ; i++) {
> +		info->cp = realloc(info->cp, (i + 1) * sizeof(*info->cp));
> +
> +		if (!info->cp) {
> +			fprintf(stderr, "kexec: %s:%d: malloc failed: %s\n",
> +				__func__, __LINE__, fdt_strerror(offset));
> +			result = -ENOMEM;
> +			goto on_error;
> +		}
> +
> +next_node:
> +		memset(&info->cp[i], 0, sizeof(*info->cp));
> +
> +		offset = fdt_next_node(dtb->buf, offset, &depth);
> +
> +		if (offset < 0) {
> +			fprintf(stderr,
> +				"kexec: %s:%d: read cpu node failed: %s\n",
> +				__func__, __LINE__, fdt_strerror(offset));
> +			result = offset;
> +			goto on_error;
> +		}
> +
> +		if (depth != 1)
> +			break;
> +
> +		result = read_cpu_properties(&info->cp[i], dtb, offset,
> +			address_cells);
> +
> +		if (result == 0)
> +			goto next_node;
> +
> +		if (result < 0)
> +			goto on_error;
> +
> +		dbgprintf("%s: %s cpu-%d (%s): hwid-%" PRIx64 ", '%s'\n",
> +			__func__, dtb->name, i, info->cp[i].node_path,
> +			info->cp[i].hwid,
> +			cpu_enable_method_str(info->cp[i].method));
> +	}
> +
> +	info->cpu_count = i;
> +	return 0;
> +
> +on_error:
> +	free(info->cp);
> +	info->cp = NULL;
> +	return result;
> +}
> +
> +static int check_cpu_nodes(const struct dtb *dtb_1, const struct dtb *dtb_2)
> +{
> +	int result;
> +	unsigned int cpu_1;
> +	struct cpu_info info_1;
> +	struct cpu_info info_2;
> +	unsigned int to_process;
> +
> +	memset(&info_1, 0, sizeof(info_1));
> +	memset(&info_2, 0, sizeof(info_2));
> +
> +	result = read_cpu_info(&info_1, dtb_1);
> +
> +	if (result)
> +		goto on_exit;
> +
> +	result = read_cpu_info(&info_2, dtb_2);
> +
> +	if (result)
> +		goto on_exit;
> +
> +	to_process = info_1.cpu_count < info_2.cpu_count
> +		? info_1.cpu_count : info_2.cpu_count;
> +
> +	for (cpu_1 = 0; cpu_1 < info_1.cpu_count; cpu_1++) {
> +		struct cpu_properties *cp_1 = &info_1.cp[cpu_1];
> +		unsigned int cpu_2;
> +
> +		for (cpu_2 = 0; cpu_2 < info_2.cpu_count; cpu_2++) {
> +			struct cpu_properties *cp_2 = &info_2.cp[cpu_2];
> +
> +			if (cp_1->hwid != cp_2->hwid)
> +				continue;
> +
> +			to_process--;
> +
> +			result = check_cpu_properties(cp_1, cp_2);
> +
> +			if (result)
> +				goto on_exit;
> +
> +			break;
> +		}
> +	}
> +
> +	if (to_process) {
> +		fprintf(stderr,
> +			"kexec: %s:%d: Warning: Failed to process %u CPUs.\n",
> +			__func__, __LINE__, to_process);
> +		result = -EINVAL;
> +		goto on_exit;
> +	}
> +
> +on_exit:
> +	free(info_1.cp);
> +	free(info_2.cp);
> +	return result;
> +}
> +
> +static int set_bootargs(struct dtb *dtb, const char *command_line)
> +{
> +	int result;
> +
> +	if (!command_line || !command_line[0])
> +		return 0;
> +
> +	result = dtb_set_bootargs(&dtb->buf, &dtb->size, command_line);
> +
> +	if (result)
> +		fprintf(stderr,
> +			"kexec: Set device tree bootargs failed.\n");
> +
> +	return result;
> +}
> +
> +static int read_proc_dtb(struct dtb *dtb, const char *command_line)
> +{
> +	int result;
> +	struct stat s;
> +	static const char path[] = "/proc/device-tree";
> +
> +	result = stat(path, &s);
> +
> +	if (result) {
> +		dbgprintf("%s: %s\n", __func__, strerror(errno));

I think that you always use fprintf() in case of failures.

> +		return -1;
> +	}
> +
> +	dtb->path = path;
> +	create_flatten_tree((char **)&dtb->buf, &dtb->size,
> +		(command_line && command_line[0]) ? command_line : NULL);
> +
> +	return 0;
> +}
> +
> +static int read_sys_dtb(struct dtb *dtb, const char *command_line)
> +{
> +	int result;
> +	struct stat s;
> +	static const char path[] = "/sys/firmware/fdt";
> +
> +	result = stat(path, &s);
> +
> +	if (result) {
> +		dbgprintf("%s: %s\n", __func__, strerror(errno));

Ditto

> +		return -1;
> +	}
> +
> +	dtb->path = path;
> +	dtb->buf = slurp_file("/sys/firmware/fdt", &dtb->size);
> +
> +	return set_bootargs(dtb, command_line);
> +}
> +
> +static int read_1st_dtb(struct dtb *dtb, const char *command_line)
> +{
> +	int result;
> +
> +	result = read_sys_dtb(dtb, command_line);
> +
> +	if (!result)
> +		goto on_success;
> +
> +	result = read_proc_dtb(dtb, command_line);
> +
> +	if (!result)
> +		goto on_success;
> +
> +	dbgprintf("%s: not found\n", __func__);
> +	return -1;

Ditto

> +on_success:
> +	dbgprintf("%s: found %s\n", __func__, dtb->path);
> +	return 0;
> +}
> +
> +static int setup_2nd_dtb(char *command_line, struct dtb *dtb_2)
> +{
> +	int result;
> +
> +	result = fdt_check_header(dtb_2->buf);
> +
> +	if (result) {
> +		fprintf(stderr, "kexec: Invalid 2nd device tree.\n");
> +		return -EINVAL;
> +	}
> +
> +	result = set_bootargs(dtb_2, command_line);
> +
> +	dump_reservemap(dtb_2);
> +
> +	return result;
> +}
> +
> +static uint64_t read_sink(const char *command_line)
> +{
> +	uint64_t v;
> +	const char *p;
> +
> +	if (arm64_opts.port)
> +		return arm64_opts.port;
> +
> +#if defined(ARM64_DEBUG_PORT)
> +	return (uint64_t)(ARM64_DEBUG_PORT);
> +#endif
> +	if (!command_line)
> +		return 0;
> +
> +	if (!(p = strstr(command_line, "earlyprintk=")) &&
> +		!(p = strstr(command_line, "earlycon=")))
> +		return 0;
> +
> +	while (*p != ',')
> +		p++;
> +
> +	p++;
> +
> +	if (*p == 0)
> +		return 0;
> +
> +	errno = 0;
> +
> +	v = strtoull(p, NULL, 0);
> +
> +	if (errno)
> +		return 0;
> +
> +	return v;
> +}
> +
> +/**
> + * arm64_load_other_segments - Prepare the dtb, initrd and purgatory segments.
> + */
> +
> +int arm64_load_other_segments(struct kexec_info *info,
> +	uint64_t kernel_entry)
> +{
> +	int result;
> +	uint64_t dtb_base;
> +	uint64_t image_base;
> +	unsigned long hole_min;
> +	unsigned long hole_max;
> +	uint64_t purgatory_sink;
> +	char *initrd_buf = NULL;
> +	struct dtb dtb_1 = {.name = "dtb_1"};
> +	struct dtb dtb_2 = {.name = "dtb_2"};
> +	char command_line[COMMAND_LINE_SIZE] = "";
> +
> +	if (arm64_opts.command_line) {
> +		strncpy(command_line, arm64_opts.command_line,
> +			sizeof(command_line));
> +		command_line[sizeof(command_line) - 1] = 0;
> +	}
> +
> +	purgatory_sink = read_sink(command_line);
> +
> +	dbgprintf("%s:%d: purgatory sink: 0x%" PRIx64 "\n", __func__, __LINE__,
> +		purgatory_sink);
> +
> +	if (arm64_opts.dtb) {
> +		dtb_2.buf = slurp_file(arm64_opts.dtb, &dtb_2.size);
> +		assert(dtb_2.buf);
> +	}
> +
> +	result = read_1st_dtb(&dtb_1, command_line);
> +
> +	if (result && !arm64_opts.dtb) {
> +		fprintf(stderr, "kexec: Error: No device tree available.\n");
> +		return result;
> +	}
> +
> +	if (result && arm64_opts.dtb)
> +		dtb_1 = dtb_2;

In this case, dtb_1 might also be modified (unintentionally).
So be careful.

> +	else if (!result && !arm64_opts.dtb)
> +		dtb_2 = dtb_1;
> +
> +	result = setup_2nd_dtb(command_line, &dtb_2);
> +
> +	if (result)
> +		return result;
> +	
> +	check_cpu_nodes(&dtb_1, &dtb_2);
> +
> +	/* Put the other segments after the image. */
> +
> +	image_base = arm64_mem.phys_offset + arm64_mem.text_offset;
> +	hole_min = image_base + arm64_mem.image_size;
> +	hole_max = ULONG_MAX;
> +
> +	if (arm64_opts.initrd) {
> +		initrd_buf = slurp_file(arm64_opts.initrd, &initrd_size);
> +
> +		if (!initrd_buf)
> +			fprintf(stderr, "kexec: Empty ramdisk file.\n");

Why not fail?
Empty is not the only reason of failure.

> +		else {
> +			/*
> +			 * Put the initrd after the kernel.  As specified in
> +			 * booting.txt, align to 1 GiB.
> +			 */
> +
> +			initrd_base = add_buffer_phys_virt(info, initrd_buf,
> +				initrd_size, initrd_size, GiB(1),
> +				hole_min, hole_max, 1, 0);
> +
> +			/* initrd_base is valid if we got here. */
> +
> +			dbgprintf("initrd: base %lx, size %lxh (%ld)\n",
> +				initrd_base, initrd_size, initrd_size);
> +
> +			/* Check size limit as specified in booting.txt. */
> +
> +			if (initrd_base - image_base + initrd_size > GiB(32)) {
> +				fprintf(stderr, "kexec: Error: image + initrd too big.\n");
> +				return -EINVAL;

Some dtb_*/fdt_* functions may return -FDT_ERR_*.
Don't mix different type of error codes.

> +			}
> +
> +			result = dtb_set_initrd((char **)&dtb_2.buf,
> +				&dtb_2.size, initrd_base,
> +				initrd_base + initrd_size);
> +
> +			if (result)
> +				return result;
> +		}
> +	}
> +
> +	/* Check size limit as specified in booting.txt. */
> +
> +	if (dtb_2.size > MiB(2)) {
> +		fprintf(stderr, "kexec: Error: dtb too big.\n");
> +		return -EINVAL;
> +	}
> +
> +	dtb_base = add_buffer_phys_virt(info, dtb_2.buf, dtb_2.size, dtb_2.size,
> +		0, hole_min, hole_max, 1, 0);
> +
> +	/* dtb_base is valid if we got here. */
> +
> +	dbgprintf("dtb:    base %lx, size %lxh (%ld)\n", dtb_base, dtb_2.size,
> +		dtb_2.size);
> +
> +	elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
> +		hole_min, hole_max, 1, 0);
> +
> +	info->entry = (void *)elf_rel_get_addr(&info->rhdr, "purgatory_start");
> +
> +	elf_rel_set_symbol(&info->rhdr, "arm64_sink", &purgatory_sink,
> +		sizeof(purgatory_sink));
> +
> +	elf_rel_set_symbol(&info->rhdr, "arm64_kernel_entry", &kernel_entry,
> +		sizeof(kernel_entry));
> +
> +	elf_rel_set_symbol(&info->rhdr, "arm64_dtb_addr", &dtb_base,
> +		sizeof(dtb_base));
> +
> +	return 0;
> +}
> +
> +unsigned long virt_to_phys(unsigned long v)
> +{
> +	unsigned long p;
> +
> +	p = v - get_page_offset() + get_phys_offset();
> +
> +	return p;
> +}
> +
> +unsigned long phys_to_virt(struct crash_elf_info *elf_info,
> +	unsigned long long p)
> +{
> +	unsigned long v;
> +
> +	v = p - get_phys_offset() + elf_info->page_offset;
> +
> +	return v;
> +}
> +
> +void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
> +	unsigned long base, size_t memsz)
> +{
> +	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
> +}
> +
> +int arm64_process_image_header(const struct arm64_image_header *h)
> +{
> +#if !defined(KERNEL_IMAGE_SIZE)
> +# define KERNEL_IMAGE_SIZE MiB(7)
> +#endif

Move this to a header?

> +
> +	if (!arm64_header_check_magic(h))
> +		return -EINVAL;
> +
> +	if (h->image_size) {
> +		arm64_mem.text_offset = arm64_header_text_offset(h);
> +		arm64_mem.image_size = arm64_header_image_size(h);
> +	} else {
> +		/* For 3.16 and older kernels. */
> +		arm64_mem.text_offset = 0x80000;
> +		arm64_mem.image_size = KERNEL_IMAGE_SIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int get_memory_ranges_dt(struct memory_range *array, unsigned int *count)
> +{
> +	struct region {uint64_t base; uint64_t size;};
> +	struct dtb dtb = {.name = "range_dtb"};
> +	int offset;
> +	int result;
> +
> +	*count = 0;
> +
> +	result = read_1st_dtb(&dtb, NULL);
> +
> +	if (result) {
> +		goto on_error;
> +	}
> +
> +	result = fdt_check_header(dtb.buf);
> +
> +	if (result) {
> +		dbgprintf("%s:%d: %s: fdt_check_header failed:%s\n", __func__,
> +			__LINE__, dtb.path, fdt_strerror(result));
> +		goto on_error;
> +	}
> +
> +	for (offset = 0; ; ) {
> +		const struct region *region;
> +		const struct region *end;
> +		int len;
> +
> +		offset = fdt_subnode_offset(dtb.buf, offset, "memory");
> +
> +		if (offset == -FDT_ERR_NOTFOUND)
> +			break;
> +
> +		if (offset <= 0) {
> +			dbgprintf("%s:%d: fdt_subnode_offset failed: %d %s\n",
> +				__func__, __LINE__, offset,
> +				fdt_strerror(offset));
> +			goto on_error;
> +		}
> +
> +		dbgprintf("%s:%d: node_%d %s\n", __func__, __LINE__, offset,
> +			fdt_get_name(dtb.buf, offset, NULL));
> +
> +		region = fdt_getprop(dtb.buf, offset, "reg", &len);
> +
> +		if (region <= 0) {
> +			dbgprintf("%s:%d: fdt_getprop failed: %d %s\n",
> +				__func__, __LINE__, offset,
> +				fdt_strerror(offset));
> +			goto on_error;
> +		}
> +
> +		for (end = region + len / sizeof(*region);
> +			region < end && *count < KEXEC_SEGMENT_MAX;
> +			region++) {
> +			struct memory_range r;
> +
> +			r.type = RANGE_RAM;
> +			r.start = fdt64_to_cpu(region->base);
> +			r.end = r.start + fdt64_to_cpu(region->size) - 1;
> +
> +			if (!region->size) {
> +				dbgprintf("%s:%d: SKIP: %016llx - %016llx\n",
> +					__func__, __LINE__, r.start, r.end);
> +				continue;
> +			}
> +
> +			dbgprintf("%s:%d:  RAM: %016llx - %016llx\n", __func__,
> +				__LINE__, r.start, r.end);
> +
> +			array[(*count)++] = r;
> +
> +			set_phys_offset(r.start);
> +		}
> +	}
> +
> +	if (!*count) {
> +		dbgprintf("%s:%d: %s: No RAM found.\n", __func__, __LINE__,
> +			dtb.path);
> +		goto on_error;
> +	}
> +
> +	dbgprintf("%s:%d: %s: Success\n", __func__, __LINE__, dtb.path);
> +	result = 0;
> +	goto on_exit;
> +
> +on_error:
> +	fprintf(stderr, "%s:%d: %s: Unusable device-tree file\n", __func__,
> +		__LINE__, dtb.path);
> +	result = -1;
> +
> +on_exit:
> +	free(dtb.buf);
> +	return result;
> +}
> +
> +static int get_memory_ranges_iomem(struct memory_range *array,
> +	unsigned int *count)
> +{
> +	const char *iomem;
> +	char line[MAX_LINE];
> +	FILE *fp;
> +
> +	*count = 0;
> +
> +	iomem = proc_iomem();
> +	fp = fopen(iomem, "r");
> +
> +	if (!fp) {
> +		fprintf(stderr, "Cannot open %s: %s\n", iomem, strerror(errno));
> +		return -1;
> +	}
> +
> +	while(fgets(line, sizeof(line), fp) != 0) {

There is an existing interface: kexec_iomem_for_each_line().

> +		struct memory_range r;
> +		char *str;
> +		int consumed;
> +
> +		if (*count >= KEXEC_SEGMENT_MAX)
> +			break;
> +
> +		if (sscanf(line, "%Lx-%Lx : %n", &r.start, &r.end, &consumed)
> +			!= 2)
> +			continue;
> +
> +		str = line + consumed;
> +
> +		if (memcmp(str, "System RAM\n", 11)) {
> +			dbgprintf("%s:%d: SKIP: %016Lx - %016Lx : %s", __func__,
> +				__LINE__, r.start, r.end, str);
> +			continue;
> +		}
> +
> +		r.type = RANGE_RAM;
> +
> +		dbgprintf("%s:%d: RAM:  %016llx - %016llx : %s", __func__,
> +			__LINE__, r.start, r.end, str);
> +
> +		array[(*count)++] = r;
> +
> +		set_phys_offset(r.start);
> +	}
> +
> +	fclose(fp);
> +
> +	if (!*count) {
> +		dbgprintf("%s:%d: failed: No RAM found.\n", __func__, __LINE__);
> +		return -1;
> +	}
> +
> +	dbgprintf("%s:%d: Success\n", __func__, __LINE__);
> +	return 0;
> +}
> +
> +int get_memory_ranges(struct memory_range **range, int *ranges,
> +	unsigned long kexec_flags)
> +{
> +	static struct memory_range array[KEXEC_SEGMENT_MAX];
> +	unsigned int count;
> +	int result;
> +
> +	result = get_memory_ranges_iomem(array, &count);
> +
> +	if (result)
> +		result = get_memory_ranges_dt(array, &count);
> +
> +	*range = result ? NULL : array;
> +	*ranges = result ? 0 : count;
> +
> +	return result;
> +}
> +
> +struct file_type file_type[] = {
> +	{"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
> +	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
> +};
> +
> +int file_types = sizeof(file_type) / sizeof(file_type[0]);
> +
> +int arch_compat_trampoline(struct kexec_info *info)
> +{
> +	return 0;
> +}
> +
> +int machine_verify_elf_rel(struct mem_ehdr *ehdr)
> +{
> +	return (ehdr->e_machine == EM_AARCH64);
> +}
> +
> +void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
> +	unsigned long r_type, void *ptr, unsigned long address,
> +	unsigned long value)
> +{
> +#if !defined(R_AARCH64_ABS64)
> +# define R_AARCH64_ABS64 257
> +#endif
> +
> +#if !defined(R_AARCH64_LD_PREL_LO19)
> +# define R_AARCH64_LD_PREL_LO19 273
> +#endif
> +
> +#if !defined(R_AARCH64_ADR_PREL_LO21)
> +# define R_AARCH64_ADR_PREL_LO21 274
> +#endif
> +
> +#if !defined(R_AARCH64_JUMP26)
> +# define R_AARCH64_JUMP26 282
> +#endif
> +
> +#if !defined(R_AARCH64_CALL26)
> +# define R_AARCH64_CALL26 283
> +#endif

Move those definitions to a header(elf.h)?

> +
> +	uint64_t *loc64;
> +	uint32_t *loc32;
> +	uint64_t *location = (uint64_t *)ptr;
> +	uint64_t data = *location;
> +	const char *type = NULL;
> +
> +	switch(r_type) {
> +	case R_AARCH64_ABS64:
> +		type = "ABS64";
> +		loc64 = ptr;
> +		*loc64 = cpu_to_elf64(ehdr, elf64_to_cpu(ehdr, *loc64) + value);
> +		break;
> +	case R_AARCH64_LD_PREL_LO19:
> +		type = "LD_PREL_LO19";
> +		loc32 = ptr;
> +		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +			+ (((value - address) << 3) & 0xffffe0));
> +		break;
> +	case R_AARCH64_ADR_PREL_LO21:
> +		if (value & 3)
> +			die("%s: ERROR Unaligned value: %lx\n", __func__,
> +				value);
> +		type = "ADR_PREL_LO21";
> +		loc32 = ptr;
> +		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +			+ (((value - address) << 3) & 0xffffe0));
> +		break;
> +	case R_AARCH64_JUMP26:
> +		type = "JUMP26";
> +		loc32 = ptr;
> +		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +			+ (((value - address) >> 2) & 0x3ffffff));
> +		break;
> +	case R_AARCH64_CALL26:
> +		type = "CALL26";
> +		loc32 = ptr;
> +		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +			+ (((value - address) >> 2) & 0x3ffffff));
> +		break;
> +	default:
> +		die("%s: ERROR Unknown type: %lu\n", __func__, r_type);
> +		break;
> +	}
> +
> +	dbgprintf("%s: %s %016lx->%016lx\n", __func__, type, data, *location);
> +}
> +
> +void arch_reuse_initrd(void)
> +{
> +	reuse_initrd = 1;
> +}
> +
> +void arch_update_purgatory(struct kexec_info *UNUSED(info))
> +{
> +}
> diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
> new file mode 100644
> index 0000000..3514b24
> --- /dev/null
> +++ b/kexec/arch/arm64/kexec-arm64.h
> @@ -0,0 +1,70 @@
> +/*
> + * ARM64 kexec.
> + */
> +
> +#if !defined(KEXEC_ARM64_H)
> +#define KEXEC_ARM64_H
> +
> +#include <stdbool.h>
> +#include <sys/types.h>
> +
> +#include "image-header.h"
> +#include "kexec.h"
> +
> +#define KEXEC_SEGMENT_MAX 16
> +
> +#define BOOT_BLOCK_VERSION 17
> +#define BOOT_BLOCK_LAST_COMP_VERSION 16
> +#define COMMAND_LINE_SIZE 512
> +
> +#define KiB(x) ((x) * 1024UL)
> +#define MiB(x) (KiB(x) * 1024UL)
> +#define GiB(x) (MiB(x) * 1024UL)
> +
> +int elf_arm64_probe(const char *kernel_buf, off_t kernel_size);
> +int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
> +	off_t kernel_size, struct kexec_info *info);
> +void elf_arm64_usage(void);
> +
> +int image_arm64_probe(const char *kernel_buf, off_t kernel_size);
> +int image_arm64_load(int argc, char **argv, const char *kernel_buf,
> +	off_t kernel_size, struct kexec_info *info);
> +void image_arm64_usage(void);
> +
> +off_t initrd_base;
> +off_t initrd_size;

Add "extern" for consistent usages.

> +
> +/**
> + * struct arm64_mem - Memory layout info.
> + */
> +
> +struct arm64_mem {
> +	uint64_t phys_offset;
> +	uint64_t text_offset;
> +	uint64_t image_size;
> +	uint64_t page_offset;
> +};
> +
> +#define arm64_mem_ngv UINT64_MAX

What does "ngv" stand for?

> +extern struct arm64_mem arm64_mem;
> +
> +uint64_t get_phys_offset(void);
> +uint64_t get_page_offset(void);
> +
> +static inline void reset_page_offset(void)
> +{
> +	arm64_mem.page_offset = arm64_mem_ngv;
> +}
> +
> +static inline void set_phys_offset(uint64_t v)
> +{
> +	if (arm64_mem.phys_offset == arm64_mem_ngv
> +		|| v < arm64_mem.phys_offset)
> +		arm64_mem.phys_offset = v;
> +}
> +
> +int arm64_process_image_header(const struct arm64_image_header *h);
> +int arm64_load_other_segments(struct kexec_info *info,
> +	uint64_t kernel_entry);
> +
> +#endif
> diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
> new file mode 100644
> index 0000000..27161e8
> --- /dev/null
> +++ b/kexec/arch/arm64/kexec-elf-arm64.c
> @@ -0,0 +1,130 @@
> +/*
> + * ARM64 kexec elf support.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <linux/elf.h>
> +
> +#include "kexec-arm64.h"
> +#include "kexec-elf.h"
> +#include "kexec-syscall.h"
> +
> +int elf_arm64_probe(const char *kernel_buf, off_t kernel_size)
> +{
> +	struct mem_ehdr ehdr;
> +	int result;
> +
> +	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
> +
> +	if (result < 0) {
> +		dbgprintf("%s: Not an ELF executable.\n", __func__);
> +		goto on_exit;
> +	}
> +
> +	if (ehdr.e_machine != EM_AARCH64) {
> +		dbgprintf("%s: Not an AARCH64 ELF executable.\n", __func__);
> +		result = -1;
> +		goto on_exit;
> +	}
> +
> +	result = 0;
> +on_exit:
> +	free_elf_info(&ehdr);
> +	return result;
> +}
> +
> +int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
> +	off_t kernel_size, struct kexec_info *info)
> +{
> +	struct mem_ehdr ehdr;
> +	int result;
> +	int i;
> +
> +	if (info->kexec_flags & KEXEC_ON_CRASH) {
> +		fprintf(stderr, "kexec: kdump not yet supported on arm64\n");
> +		return -EINVAL;
> +	}
> +
> +	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
> +
> +	if (result < 0) {
> +		dbgprintf("%s: build_elf_exec_info failed\n", __func__);
> +		goto exit;
> +	}
> +
> +	/* Find and process the arm64 image header. */
> +
> +	for (i = 0; i < ehdr.e_phnum; i++) {
> +		struct mem_phdr *phdr = &ehdr.e_phdr[i];
> +		const struct arm64_image_header *h;
> +		unsigned long header_offset;
> +
> +		if (phdr->p_type != PT_LOAD)
> +			continue;
> +
> +		/*
> +		 * When CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET=y the image header
> +		 * could be offset in the elf segment.  The linker script sets
> +		 * ehdr.e_entry to the start of text.
> +		 */
> +
> +		header_offset = ehdr.e_entry - phdr->p_vaddr;
> +
> +		h = (const struct arm64_image_header *)(
> +			kernel_buf + phdr->p_offset + header_offset);
> +
> +		if (arm64_process_image_header(h))
> +			continue;
> +
> +		arm64_mem.page_offset = ehdr.e_entry - arm64_mem.text_offset;
> +
> +		dbgprintf("%s: e_entry:       %016llx -> %016lx\n", __func__,
> +			ehdr.e_entry,
> +			virt_to_phys(ehdr.e_entry));
> +		dbgprintf("%s: p_vaddr:       %016llx -> %016lx\n", __func__,
> +			phdr->p_vaddr,
> +			virt_to_phys(phdr->p_vaddr));
> +		dbgprintf("%s: header_offset: %016lx\n", __func__,
> +			header_offset);
> +		dbgprintf("%s: text_offset:   %016lx\n", __func__,
> +			arm64_mem.text_offset);
> +		dbgprintf("%s: image_size:    %016lx\n", __func__,
> +			arm64_mem.image_size);
> +		dbgprintf("%s: phys_offset:   %016lx\n", __func__,
> +			arm64_mem.phys_offset);
> +		dbgprintf("%s: page_offset:   %016lx\n", __func__,
> +			arm64_mem.page_offset);
> +		dbgprintf("%s: PE format:     %s\n", __func__,
> +			(arm64_header_check_pe_sig(h) ? "yes" : "no"));
> +
> +		result = elf_exec_load(&ehdr, info);
> +
> +		if (result) {
> +			fprintf(stderr, "kexec: Elf load failed.\n");
> +			goto exit;
> +		}
> +
> +		result = arm64_load_other_segments(info,
> +			virt_to_phys(ehdr.e_entry));
> +		goto exit;
> +	}
> +
> +	fprintf(stderr, "kexec: Bad arm64 image header.\n");
> +	result = -EINVAL;
> +	goto exit;
> +
> +exit:
> +	reset_page_offset();
> +	free_elf_info(&ehdr);
> +	return result;
> +}
> +
> +void elf_arm64_usage(void)
> +{
> +	printf(
> +"     An ARM64 ELF image, big or little endian.\n"
> +"     Typically vmlinux or a stripped version of vmlinux.\n\n");
> +}
> diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
> new file mode 100644
> index 0000000..caf90c7
> --- /dev/null
> +++ b/kexec/arch/arm64/kexec-image-arm64.c
> @@ -0,0 +1,44 @@
> +/*
> + * ARM64 kexec binary image support.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +
> +#include "kexec-arm64.h"
> +
> +int image_arm64_probe(const char *kernel_buf, off_t kernel_size)
> +{
> +	const struct arm64_image_header *h;
> +
> +	if (kernel_size < sizeof(struct arm64_image_header)) {
> +		dbgprintf("%s: No arm64 image header.\n", __func__);
> +		return -1;
> +	}
> +
> +	h = (const struct arm64_image_header *)(kernel_buf);
> +
> +	if (!arm64_header_check_magic(h)) {
> +		dbgprintf("%s: Bad arm64 image header.\n", __func__);
> +		return -1;
> +	}
> +
> +	fprintf(stderr, "kexec: ARM64 binary image files are currently NOT SUPPORTED.\n");
> +
> +	return -1;
> +}
> +
> +int image_arm64_load(int argc, char **argv, const char *kernel_buf,
> +	off_t kernel_size, struct kexec_info *info)
> +{
> +	return -ENOSYS;
> +}
> +
> +void image_arm64_usage(void)
> +{
> +	printf(
> +"     An ARM64 binary image, compressed or not, big or little endian.\n"
> +"     Typically an Image, Image.gz or Image.lzma file.\n\n");
> +"     This file type is currently NOT SUPPORTED.\n\n");
> +}
> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> index ce2e20b..c0d0bea 100644
> --- a/kexec/kexec-syscall.h
> +++ b/kexec/kexec-syscall.h
> @@ -39,8 +39,8 @@
>  #ifdef __s390__
>  #define __NR_kexec_load		277
>  #endif
> -#ifdef __arm__
> -#define __NR_kexec_load		__NR_SYSCALL_BASE + 347  
> +#if defined(__arm__) || defined(__arm64__)
> +#define __NR_kexec_load		__NR_SYSCALL_BASE + 347
>  #endif
>  #if defined(__mips__)
>  #define __NR_kexec_load                4311
> @@ -108,6 +108,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
>  #define KEXEC_ARCH_PPC64   (21 << 16)
>  #define KEXEC_ARCH_IA_64   (50 << 16)
>  #define KEXEC_ARCH_ARM     (40 << 16)
> +#define KEXEC_ARCH_ARM64   (183 << 16)
>  #define KEXEC_ARCH_S390    (22 << 16)
>  #define KEXEC_ARCH_SH      (42 << 16)
>  #define KEXEC_ARCH_MIPS_LE (10 << 16)
> @@ -153,5 +154,8 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
>  #ifdef __m68k__
>  #define KEXEC_ARCH_NATIVE	KEXEC_ARCH_68K
>  #endif
> +#if defined(__arm64__)
> +#define KEXEC_ARCH_NATIVE	KEXEC_ARCH_ARM64
> +#endif
>  
>  #endif /* KEXEC_SYSCALL_H */
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index 2b5c061..ca0443c 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -19,6 +19,7 @@ dist += purgatory/Makefile $(PURGATORY_SRCS)				\
>  
>  include $(srcdir)/purgatory/arch/alpha/Makefile
>  include $(srcdir)/purgatory/arch/arm/Makefile
> +include $(srcdir)/purgatory/arch/arm64/Makefile
>  include $(srcdir)/purgatory/arch/i386/Makefile
>  include $(srcdir)/purgatory/arch/ia64/Makefile
>  include $(srcdir)/purgatory/arch/mips/Makefile
> diff --git a/purgatory/arch/arm64/Makefile b/purgatory/arch/arm64/Makefile
> new file mode 100644
> index 0000000..636abea
> --- /dev/null
> +++ b/purgatory/arch/arm64/Makefile
> @@ -0,0 +1,18 @@
> +
> +arm64_PURGATORY_EXTRA_CFLAGS = \
> +	-mcmodel=large \
> +	-fno-stack-protector \
> +	-fno-asynchronous-unwind-tables \
> +	-Wundef \
> +	-Werror-implicit-function-declaration \
> +	-Wdeclaration-after-statement \
> +	-Werror=implicit-int \
> +	-Werror=strict-prototypes
> +
> +arm64_PURGATORY_SRCS += \
> +	purgatory/arch/arm64/entry.S \
> +	purgatory/arch/arm64/purgatory-arm64.c
> +
> +dist += \
> +	$(arm64_PURGATORY_SRCS) \
> +	purgatory/arch/arm64/Makefile
> diff --git a/purgatory/arch/arm64/entry.S b/purgatory/arch/arm64/entry.S
> new file mode 100644
> index 0000000..8dfdb47
> --- /dev/null
> +++ b/purgatory/arch/arm64/entry.S
> @@ -0,0 +1,52 @@
> +/*
> + * ARM64 purgatory.
> + */
> +
> +.macro	size, sym:req
> +	.size \sym, . - \sym
> +.endm
> +
> +.text
> +
> +.globl purgatory_start
> +purgatory_start:
> +
> +	adr	x19, .Lstack
> +	mov	sp, x19
> +
> +	bl	purgatory
> +
> +1:
> +	b	1b
> +
> +size purgatory_start
> +
> +.align 4
> +	.rept	256
> +	.quad	0
> +	.endr
> +.Lstack:
> +
> +.data
> +
> +.align 3
> +
> +.globl arm64_sink
> +arm64_sink:
> +	.quad	0
> +size arm64_sink
> +
> +.globl arm64_kernel_entry
> +arm64_kernel_entry:
> +	.quad	0
> +size arm64_kernel_entry
> +
> +.globl arm64_dtb_addr
> +arm64_dtb_addr:
> +	.quad	0
> +size arm64_dtb_addr

Those variables can be defined in purgatory-arm64.c
by adding section attributes.

> +
> +.globl arm64_kexec_lite
> +arm64_kexec_lite:
> +	.quad	0
> +size arm64_kexec_lite

You have removed "lite" option.

> diff --git a/purgatory/arch/arm64/purgatory-arm64.c b/purgatory/arch/arm64/purgatory-arm64.c
> new file mode 100644
> index 0000000..fd76405
> --- /dev/null
> +++ b/purgatory/arch/arm64/purgatory-arm64.c
> @@ -0,0 +1,35 @@
> +/*
> + * ARM64 purgatory.
> + */
> +
> +#include <stdint.h>
> +#include <purgatory.h>
> +
> +/* Symbols set by kexec. */
> +
> +extern uint8_t *arm64_sink;
> +extern void (*arm64_kernel_entry)(uint64_t, uint64_t, uint64_t, uint64_t);
> +extern uint64_t arm64_dtb_addr;
> +
> +void putchar(int ch)
> +{
> +	if (!arm64_sink)
> +		return;
> +
> +	*arm64_sink = ch;
> +
> +	if (ch == '\n')
> +		*arm64_sink = '\r';
> +}
> +
> +void post_verification_setup_arch(void)
> +{
> +	arm64_kernel_entry(arm64_dtb_addr, 0, 0, 0);

I think most archs jump into the next kernel from purgatory_start in entry.S.

Thanks,
-Takahiro AKASHI

> +}
> +
> +void setup_arch(void)
> +{
> +	printf("purgatory: entry=%lx\n", (unsigned long)arm64_kernel_entry);
> +	printf("purgatory: dtb=%lx\n", arm64_dtb_addr);
> +}
> +
> -- 
> 2.5.0
> 
