From: geoff@infradead.org (Geoff Levand)
Date: Wed, 20 Jul 2016 13:33:48 -0700
Subject: [PATCH v1 3/4] arm64: Add arm64 kexec support
In-Reply-To: <20160720175305.GB4797@localhost.localdomain>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720175305.GB4797@localhost.localdomain>
Message-ID: <1469046828.2977.122.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On Wed, 2016-07-20 at 23:23 +0530, Pratyush Anand wrote:
> On 19/07/2016:11:28:13 PM, Geoff Levand wrote:

> > +++ b/kexec/arch/arm64/include/arch/options.h
> > @@ -0,0 +1,43 @@
> > +#if !defined(KEXEC_ARCH_ARM64_OPTIONS_H)
> > +#define KEXEC_ARCH_ARM64_OPTIONS_H
> > +
> > +#define OPT_APPEND> > 	> > 	> > ((OPT_MAX)+0)
> > +#define OPT_DTB> > 	> > 	> > 	> > ((OPT_MAX)+1)
> > +#define OPT_INITRD> > 	> > 	> > ((OPT_MAX)+2)
> > +#define OPT_PORT> > 	> > 	> > ((OPT_MAX)+3)
> > +#define OPT_REUSE_CMDLINE> > 	> > ((OPT_MAX)+4)
> > +#define OPT_ARCH_MAX> > 	> > 	> > ((OPT_MAX)+5)
> > +
> > +#define KEXEC_ARCH_OPTIONS \
> > +> > 	> > KEXEC_OPTIONS \
> > +> > 	> > { "append",        1, NULL, OPT_APPEND }, \
> > +> > 	> > { "command-line",  1, NULL, OPT_APPEND }, \
> > +> > 	> > { "dtb",           1, NULL, OPT_DTB }, \
> > +> > 	> > { "initrd",        1, NULL, OPT_INITRD }, \
> > +> > 	> > { "port",          1, NULL, OPT_PORT }, \
> 
> I still think that we should have a way to check TX buffer overflow..Anyway, I
> will send top up patch for that when these patch set are merged.

I was very tempted to just not support the purgatory printing,
as other arches do, because of all the trouble with different
UARTs.  Is it really so important to see the 'I'm in purgatory'
message?

> > +> > 	> > { "ramdisk",       1, NULL, OPT_INITRD }, \
> > +> > 	> > { "reuse-cmdline", 0, NULL, OPT_REUSE_CMDLINE }, \
> > +
> > +#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR /* Only accept long arch options. */
> > +#define KEXEC_ALL_OPTIONS KEXEC_ARCH_OPTIONS
> > +#define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
> > +
> > +static const char arm64_opts_usage[] __attribute__ ((unused)) =
> > +"     --append=STRING       Set the kernel command line to STRING.\n"
> 
> "Update the kernel command line with STRING.\n" may be a better description.

That is the text the other arches use, so I'll keep it for consistency.

> 
> > +"     --command-line=STRING Set the kernel command line to STRING.\n"
> > +"     --dtb=FILE            Use FILE as the device tree blob.\n"
> > +"     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
> > +"     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
> > +"     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
> > +"     --reuse-cmdline       Use kernel command line from running system.\n";
> > +
> > +
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
> 
> What if cp_1->method = cp_2->method = cpu_enable_method_spin_table?
> 
> I think, second if loop should be within 1st loop's scope.

There is no way to get a cpu back into a spin, so spin_table is not supported.

> +> 	> for (cpu_1 = 0; cpu_1 < info_1.cpu_count; cpu_1++) {
> > +> > 	> > 	> > struct cpu_properties *cp_1 = &info_1.cp[cpu_1];
> > +> > 	> > 	> > unsigned int cpu_2;
> > +
> > +> > 	> > 	> > for (cpu_2 = 0; cpu_2 < info_2.cpu_count; cpu_2++) {
> > +> > 	> > 	> > 	> > struct cpu_properties *cp_2 = &info_2.cp[cpu_2];
> > +
> > +> > 	> > 	> > 	> > if (cp_1->hwid != cp_2->hwid)
> > +> > 	> > 	> > 	> > 	> > continue;
> > +
> > +> > 	> > 	> > 	> > to_process--;
> > +
> > +> > 	> > 	> > 	> > result = check_cpu_properties(cp_1, cp_2);
> > +
> > +> > 	> > 	> > 	> > if (result)
> > +> > 	> > 	> > 	> > 	> > goto on_exit;
> 
> I think, you can break the loop when cp_1->hwid and cp_2->hwid matches.

OK.

> +int arm64_load_other_segments(struct kexec_info *info,
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
> 
> Probably, we can skip check_cpu_nodes() when dtb_2 = dtb_1.               

OK.

> > +unsigned long virt_to_phys(unsigned long v)
> > +{
> > +> > 	> > unsigned long p;
> > +
> > +> > 	> > p = v - get_page_offset() + get_phys_offset();
> 
> 
> Do we need to take care of kaslr while converting from virtual to physical?

>From what I understand of kaslr, the kernel relocates parts of
itself after startup.

This virt_to_phys conversion here is to just convert the (virtual
address) values in the vmlinux elf file to physical addresses we
can use to load the elf segments.  I don't think kaslr should
affect how the elf file is loaded.

> > +
> > +int get_memory_ranges(struct memory_range **range, int *ranges,
> > +> > 	> > unsigned long kexec_flags)
> > +{
> > +> > 	> > static struct memory_range array[KEXEC_SEGMENT_MAX];
> > +> > 	> > unsigned int count;
> > +> > 	> > int result;
> > +
> > +> > 	> > result = get_memory_ranges_dt(array, &count);
> > +
> > +> > 	> > if (result)
> > +> > 	> > 	> > result = get_memory_ranges_iomem(array, &count);
> 
> IMO, reading from iomem should be preferred over reading from dt, because
> /proc/iomem would have updated information whether it is DT or ACPI. 
> 
> Actually, there are some platform's DT file (such as mustang) which expects that
> firmware will update memory node information. Now, if firmware is not doing that
> (ofcourse its a firmware issue) then, kexec will fail with above code. However,
> it will work fine even with those systems if memory ranges are read from
> /proc/iomem.

That's a good point.  I will switch the order.

Thanks for the review.

-Geoff
