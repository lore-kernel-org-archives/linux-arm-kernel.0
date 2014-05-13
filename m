From: geoff@infradead.org (Geoff Levand)
Date: Tue, 13 May 2014 15:27:30 -0700
Subject: [PATCH 7/8] arm64/kexec: Add core kexec support
In-Reply-To: <20140509153656.GB16418@e106331-lin.cambridge.arm.com>
References: <cover.1399594544.git.geoff@infradead.org>
 <64ef27888fa70b3e27ddcf4ca594fa71ab7f7777.1399594544.git.geoff@infradead.org>
 <20140509153656.GB16418@e106331-lin.cambridge.arm.com>
Message-ID: <1400020050.11178.73.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, 2014-05-09 at 16:36 +0100, Mark Rutland wrote:
> On Fri, May 09, 2014 at 01:48:17AM +0100, Geoff Levand wrote:
> > Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S, to the
> > arm64 architecture that add support for the kexec re-boot mechanism on arm64
> > (CONFIG_KEXEC).
> >
> > This implementation supports re-boots of kernels with either PSCI or spin-table
> > enable methods, but with some limitations on the match of 1st and 2nd stage
> > kernels.  The known limitations are checked in the kexec_compat_check() routine,
> > which is called during a kexec_load syscall.  If any limitations are reached an
> > error is returned by the kexec_load syscall.  Many of the limitations can be
> > removed with some enhancment to the CPU shutdown management code in
> > machine_kexec.c.
> 
> I think if we cannot offline a CPU through the generic hotplug
> infrastructure then we should fail to kexec. If we need a way of doing
> hotplug without PSCI then we should sort that out [1] rather than
> working around brokenness with more brokenness

OK, as I mentioned in the cover message I agree with this.

> I also don't think that kexec should care about the precise hotplug
> mechanism so long as it works. If the DTB passed to the new kernel
> describes a different mechanism than is currently in use, that's the
> caller's choice and I don't see any point second-guessing that -- we're
> already allowing them to boot an arbitrary kernel and so long as we
> leave the system in a sane state I don't see a good reason to deny the
> user from immediately destroying that.

One use case for kexec is to use linux as a bootloader.  The 1st stage
bootloader kernel should be able to boot any other kernel.  For this to work
the 1st stage kernel should do whatever it can to get the secondary cpus into a
state compatible with the 2nd stage kernel.  If any of the secondary cpus
have a 1st stage enable method different from the 2nd stage enable method,
then the 1st stage kernel should move the cpus to their 2nd stage enable
method at shutdown.  Also, any cpus stuck in the kernel secondary_holding_pen
should to be moved to their 2nd stage enable method.  I have not tried to
implement this, but it seems to me that it can be done.

Do you see any reason why this would not work?

> [1] For hotplug without PSCI I think we can get away with adding an
> optional property to spin-table describing a (physical) address to
> branch to which returns CPUs to their original spin code. So long as the
> kernel zeroes the release address first we should be able to boot a CPU
> exactly as we managed to the first time.

I think just this would be just the address of the cpu's spin code, with the
restriction that the code is entered at this address also.  If there is no code
there, in the case of a PSCI to spin-table re-boot, then the 1st stage kernel
needs to install some spin code.  Also, shouldn't this be a required property
to avoid the spin code memory leakage problem?

> For spin-table we'll also need to jump back up to EL2 when EL2 is
> present. It should be possible to do that within the spin-table code if
> we update the initial EL2 vector and get KVM to tear itself down before
> cpu_die happens.

OK, I have not yet considered EL2.

> > +/**
> > + * struct kexec_cpu_info_spin - Info needed for the "spin table" enable method.
> > + */
> > +
> > +struct kexec_cpu_info_spin {
> > +       phys_addr_t phy_release_addr; /* cpu order */
> 
> I assume you mean this is in the endianness of the current kernel? I was
> initially confused by the comment, and I think it might be better to
> drop it -- unless told that a variable is in a specific endianness I
> would assume that it's the current native endianness anyway.

The value is read as LE from the device tree, and this comment is to clarify
that the conversion from LE to cpu has been done.  Maybe 'cpu byte order' is
less confusing?  Normally, I think the term 'machine order' would be used, but
I chose 'cpu' from the name of the le64_to_cpu routine.

> As a general point, could you please use "phys" rather than "phy" in
> variable names? It'll make this more consistent with the rest of the
> arm64 code, easier to search for, and reads better IMO.

Sure.

> > +struct kexec_ctx {
> > +       struct kexec_dt_info dt_1st;
> > +       struct kexec_dt_info dt_2nd;
> > +};
> > +
> > +static struct kexec_ctx *ctx;
> 
> Is there any reason this should be dynamically allocated?
> 
> Do we even need the current DTB if we rely on hotplug?

I think so, for this implementation we need to at least check if the enable
methods and cpu counts of the two DTs match and fail the kexec-load syscall
if they do not.

> > +/**
> > + * kexec_is_dtb_user - Helper routine to check the device tree header signature.
> > + */
> > +
> > +static int kexec_is_dtb_user(const void *dtb)
> > +{
> > +       __be32 magic;
> > +
> > +       get_user(magic, (__be32 *)dtb);
> 
> Return value check? Unless we know this can't fail?
> 
> If it can fail, surely we should return an appropriate error and forward
> it to userspace. EFAULT?
> 
> > +
> > +       return kexec_is_dtb(magic);
> 
> And EINVAL if we can read this but it's not a DTB?

These kexec_is_dtb are just used to search for the DTB segment, so are expected
to return false for non-DTB segments.  I'll change the return type to bool to
make the usage more clear.

> > +/**
> > + * kexec_read_memreserve - Initialize memreserve info from a dtb.
> > + */
> > +
> > +static int kexec_read_memreserve(const void *dtb, struct kexec_dt_info *info)
> > +{
> > +       const struct boot_param_header *h = dtb;
> > +       struct pair {
> > +               __be64 phy_addr;
> > +               __be64 size;
> > +       } const *pair;
> > +
> > +       pair = dtb + be32_to_cpu(h->off_mem_rsvmap);
> > +
> > +       if ((pair + 1)->size)
> > +               pr_warn("kexec: Multiple memreserve regions found.");
> 
> Huh? Multiple arbitrary memreserves are entirely valid. Why should we
> warn in that case?

If a user reports a problem I thought this comment may be useful in debugging
since the current implementation does not consider them.

> > +
> > +       info->phy_memreserve_addr = be64_to_cpu(pair->phy_addr);
> > +       info->memreserve_size = be64_to_cpu(pair->size);
> 
> So we're assuming that the memory described in an arbitrary memreserve
> entry (which is intended to describe memory which shouldn't be touched
> unless we know what we're doing) is for our arbitrary use!?
> 
> NAK.
> 
> We shouldn't need to special-case reserved memory handling if we rely on
> cpu hotplug. If we don't then the only functional option is to add a
> memreserve, but that will end up leaking a small amount of memory upon
> every kexec. I believe that the former is the only sane option.

I think the solution is to have the cpu spin code address property.

> > +static int kexec_setup_cpu_spin(const struct device_node *dn,
> > +       struct kexec_cpu_info_spin *info)
> > +{
> > +       int result;
> > +       u64 t1;
> > +
> > +       memset(info, 0, sizeof(*info));
> > +
> > +       result = of_property_read_u64(dn, "cpu-release-addr", &t1);
> > +
> > +       if (result) {
> > +               pr_warn("kexec: Read cpu-release-addr failed.\n");
> > +               return result;
> > +       }
> > +
> > +       info->phy_release_addr = le64_to_cpu(t1);
> 
> Why are we calling le64_to_cpu here?
> 
> of_property_read_u64 reads a be64 value from dt into cpu endianness, so
> at the very least the annotation is the wrong way around.

I'll check it again.  I read this and thought the conversion was needed:

  The value will be written as a single 64-bit little-endian
  value, so CPUs must convert the read value to their native endianness
  before jumping to it.

> Have you tested this with a BE kernel? We should ensure that LE->LE,
> LE->BE, BE->BE, BE->LE all work.

Not yet.  I'm in the process of setting up a BE test environment.

> > +int kexec_cpu_info_init(const struct device_node *dn,
> > +       struct kexec_dt_info *info)
> > +{
> > +       int result;
> > +       unsigned int cpu;
> > +       const struct device_node *i;
> > +
> > +       info->cpu_info = kmalloc(
> > +               (1 + info->cpu_count) * sizeof(struct kexec_cpu_info),
> > +               GFP_KERNEL);
> 
> Why one more than the cpu count? I thought cpu_count covered all the
> CPUs in the dtb?

Yes, a left over from when the array was zero terminated.  Thanks for such
a detailed check!

> [...]
> 
> > +int kexec_dt_info_init(void *dtb, struct kexec_dt_info *info)
> > +{
> > +       int result;
> > +       struct device_node *i;
> > +       struct device_node *dn;
> > +
> > +       if (!dtb) {
> > +               /* 1st stage. */
> > +               dn = NULL;
> > +       } else {
> > +               /* 2nd stage. */
> > +
> > +               of_fdt_unflatten_tree(dtb, &dn);
> 
> This may fail. We should check that dn is not NULL before we try to use
> it later -- many of_* functions will traverse the current kernel's boot
> DT if provided with a NULL root.

OK, I'll fix it.

> > +
> > +               result = kexec_read_memreserve(dtb, info);
> > +
> > +               if (result)
> > +                       return result;
> > +       }
> > +
> > +       /*
> > +        * We may need to work with offline cpus to get them into the correct
> > +        * state for a given enable method to work, and so need an info_array
> > +        * that has info about all the platform cpus.
> > +        */
> 
> What exactly do we need to do to offline CPUs?

As mentioned above, to get them into a state expected by the 2nd stage
kernel if we choose to do so, but to do the compatibility checks for
this implementation.  Maybe I'll change the wording of this comment.

> > +void kexec_spin_2(unsigned int cpu, phys_addr_t signal_1,
> > +       phys_addr_t phy_release_addr, phys_addr_t signal_2)
> > +{
> > +       typedef void (*fn_t)(phys_addr_t, phys_addr_t);
> > +
> > +       fn_t spin_3;
> > +
> > +       atomic_dec((atomic_t *)signal_1);
> > +
> > +       /* Wait for next signal. */
> > +
> > +       while (!atomic_read((atomic_t *)signal_2))
> > +               (void)0;
> 
> Why not cpu_relax()?

Sure.

> 
> [...]
> 
> > +       /* Check for cpus still spinning in secondary_holding_pen. */
> > +
> > +       if (NR_CPUS < dt1->spinner_count) {
> > +               pr_err("kexec: Error: NR_CPUS too small for spin enable %u < %u.\n",
> > +                       NR_CPUS, dt1->spinner_count + 1);
> > +               result++;
> > +       }
> 
> In some cases people might describe fewer CPUs in the DTB than are
> actually present, which we should give up for also. I think we can alter
> secondary_holding_pen to be a bit more intelligent for that case and get
> any unexpected secondaries to write a flag to indicate their presence.

OK, I'll look into that change.

> > +void machine_crash_shutdown(struct pt_regs *regs)
> > +{
> > +}
> 
> Missing implementation? If it's fine for this to be empty it would be
> nice to have a comment to that effect.

Sure, the core kexec code calls this, but it is a todo for kdump.

> > +int machine_kexec_prepare(struct kimage *image)
> > +{
> > +       int result;
> > +       const struct kexec_segment *seg;
> > +       void *dtb;
> > +
> > +       machine_kexec_cleanup(NULL);
> > +
> > +       ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> > +
> > +       if (!ctx) {
> > +               pr_debug("%s: out of memory", __func__);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       seg = kexec_find_dtb_seg(image);
> > +       BUG_ON(!seg);
> > +
> > +       dtb = kexec_copy_dtb(seg);
> > +       BUG_ON(!dtb);
> > +       BUG_ON(!kexec_is_dtb(*(const __be32 *)dtb));
> 
> Why BUG_ON rather than report the failure and return an error?

Sure, the user space kexec helper should have set these up correctly, so these
were intended as sanity checks, but to report an error would be better.

> > +
> > +       result = kexec_dt_info_init(NULL, &ctx->dt_1st);
> > +
> > +       if (result)
> > +               goto on_error;
> > +
> > +       result = kexec_dt_info_init(dtb, &ctx->dt_2nd);
> > +
> > +       if (result)
> > +               goto on_error;
> > +
> > +       if (ctx->dt_2nd.spinner_count) {
> > +               BUG_ON(!ctx->dt_2nd.phy_memreserve_addr);
> > +               BUG_ON(kexec_cpu_spin_size >= ctx->dt_2nd.memreserve_size
> > +                       - kexec_spin_code_offset);
> > +       }
> > +
> > +       result = kexec_compat_check(&ctx->dt_1st, &ctx->dt_2nd);
> > +
> > +       if (result)
> > +               goto on_error;
> > +
> > +       kexec_dtb_addr = seg->mem;
> > +       kexec_kimage_start = image->start;
> > +       kexec_spinner_count = ctx->dt_1st.spinner_count - 1;
> > +
> > +       smp_spin_table_set_die(kexec_spin_1);
> 
> I very much dislike hooking into the spin-table code like this.
> 
> [...]
> 
> > +       if (ctx->dt_2nd.spinner_count) {
> > +               void *va;
> > +
> > +               /*
> > +               * Copy the spin code to the 2nd stage memreserve area as
> > +               * dictated by the arm64 boot specification.
> > +               */
> 
> The boot documentation says any spin code must be protected with a
> memreserve. This does not mean that the first memreserve is a special
> location that the spin table must be placed at. This comment seems to
> have the implication backwards.

I'll think about how we can reword the boot documentation to make it more clear.

> > + * kexec_cpu_spin - Spin the CPU as described in the arm64/booting.txt document.
> > + *
> > + * Prototype: void kexec_cpu_spin(phys_addr_t release_addr, phys_addr_t signal);
> > + *
> > + * The caller must initialize release_addr to zero or a valid address
> > + * prior to calling kexec_cpu_spin.  Note that if the MMU will be turned on
> > + * or off while the CPU is spinning here this code must be in an identity
> > + * mapped page.  The value written to release_addr must be in little endian
> > + * order.
> 
> The MMU _must_ be off upon entry to the kernel, as is explicitly stated
> in Documentation/arm64/booting.txt, and I don't see why the spinning
> code should have the MMU on. It seems like an endless source of subtle
> bugs.

Sorry, this is an old comment.  The part about the MMU is no longer valid.

> > +/*
> > + * relocate_new_kernel - Put the 2nd stage kernel image in place and boot it.
> > + *
> > + * The memory that the old kernel occupies may be overwritten when coping the
> > + * new kernel to its final location.  To assure that the relocate_new_kernel
> > + * routine which does that copy is not overwritten, all code and data needed
> > + * by relocate_new_kernel must be between the symbols relocate_new_kernel and
> > + * relocate_new_kernel_end.  The machine_kexec() routine will copy
> > + * relocate_new_kernel to the kexec control_code_page, a special page which
> > + * has been set up to be preserved during the kernel copy operation.
> > + */
> > +
> > +/* These definitions correspond to the kimage_entry flags in linux/kexec.h */
> > +
> > +#define IND_DESTINATION_BIT 0
> > +#define IND_INDIRECTION_BIT 1
> > +#define IND_DONE_BIT        2
> > +#define IND_SOURCE_BIT      3
> 
> These should live in linux/kexec.h -- the existing macros can be
> generated from these and we should be able to protect everything with
> #ifndef __ASSEMBLY__

I'll make that change.

-Geoff
