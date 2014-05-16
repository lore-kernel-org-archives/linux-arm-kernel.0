From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 May 2014 11:26:11 +0100
Subject: [PATCH 7/8] arm64/kexec: Add core kexec support
In-Reply-To: <1400020050.11178.73.camel@smoke>
References: <cover.1399594544.git.geoff@infradead.org>
 <64ef27888fa70b3e27ddcf4ca594fa71ab7f7777.1399594544.git.geoff@infradead.org>
 <20140509153656.GB16418@e106331-lin.cambridge.arm.com>
 <1400020050.11178.73.camel@smoke>
Message-ID: <20140516102611.GB12965@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 11:27:30PM +0100, Geoff Levand wrote:
> Hi Mark,
> 
> On Fri, 2014-05-09 at 16:36 +0100, Mark Rutland wrote:
> > On Fri, May 09, 2014 at 01:48:17AM +0100, Geoff Levand wrote:
> > > Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S, to the
> > > arm64 architecture that add support for the kexec re-boot mechanism on arm64
> > > (CONFIG_KEXEC).
> > >
> > > This implementation supports re-boots of kernels with either PSCI or spin-table
> > > enable methods, but with some limitations on the match of 1st and 2nd stage
> > > kernels.  The known limitations are checked in the kexec_compat_check() routine,
> > > which is called during a kexec_load syscall.  If any limitations are reached an
> > > error is returned by the kexec_load syscall.  Many of the limitations can be
> > > removed with some enhancment to the CPU shutdown management code in
> > > machine_kexec.c.
> >
> > I think if we cannot offline a CPU through the generic hotplug
> > infrastructure then we should fail to kexec. If we need a way of doing
> > hotplug without PSCI then we should sort that out [1] rather than
> > working around brokenness with more brokenness
> 
> OK, as I mentioned in the cover message I agree with this.

Ok.

> > I also don't think that kexec should care about the precise hotplug
> > mechanism so long as it works. If the DTB passed to the new kernel
> > describes a different mechanism than is currently in use, that's the
> > caller's choice and I don't see any point second-guessing that -- we're
> > already allowing them to boot an arbitrary kernel and so long as we
> > leave the system in a sane state I don't see a good reason to deny the
> > user from immediately destroying that.
> 
> One use case for kexec is to use linux as a bootloader.  The 1st stage
> bootloader kernel should be able to boot any other kernel.  For this to work
> the 1st stage kernel should do whatever it can to get the secondary cpus into a
> state compatible with the 2nd stage kernel.  If any of the secondary cpus
> have a 1st stage enable method different from the 2nd stage enable method,
> then the 1st stage kernel should move the cpus to their 2nd stage enable
> method at shutdown.  Also, any cpus stuck in the kernel secondary_holding_pen
> should to be moved to their 2nd stage enable method.  I have not tried to
> implement this, but it seems to me that it can be done.

While using Linux as a chained bootloader could make sense, I don't
think it makes sense for that bootloader kernel to bring the secondaries
up at all if we're not going to be able to hotplug them off.

I'm not sure I follow the reasoning w.r.t. making the first kernel
behave as a shim to use a different enable-method for the second kernel.
Why would you not teach the secondary kernel to handle the real enable
method?

> Do you see any reason why this would not work?

This may work, but I think there is a much better solution (i.e.
ensuring we have real hotplug mechanisms where we need them). 

I am concerned that if and when we get more enable methods, the
complexity of performing the shim work is going to expand dramatically.
It certainly isn't going to be possible to shim all combinations (e.g.
spint-table -> PSCI).

> > [1] For hotplug without PSCI I think we can get away with adding an
> > optional property to spin-table describing a (physical) address to
> > branch to which returns CPUs to their original spin code. So long as the
> > kernel zeroes the release address first we should be able to boot a CPU
> > exactly as we managed to the first time.
> 
> I think just this would be just the address of the cpu's spin code, with the
> restriction that the code is entered at this address also.  If there is no code
> there, in the case of a PSCI to spin-table re-boot, then the 1st stage kernel
> needs to install some spin code.  Also, shouldn't this be a required property
> to avoid the spin code memory leakage problem?

The initial spin code must have been protected with a memeserve, so it
should still be there. Why would we need to install some new code there?

As the original code is still present, retaining the original memreserve
will be sufficient. We won't leak memory through additional memreserves,
and we won't clobber the spin-table code as it was reserved.

If it's not present we simply don't have hotplug, cannot hotplug the
CPU, and cannot kexec in SMP.

> > For spin-table we'll also need to jump back up to EL2 when EL2 is
> > present. It should be possible to do that within the spin-table code if
> > we update the initial EL2 vector and get KVM to tear itself down before
> > cpu_die happens.
> 
> OK, I have not yet considered EL2.
> 
> > > +/**
> > > + * struct kexec_cpu_info_spin - Info needed for the "spin table" enable method.
> > > + */
> > > +
> > > +struct kexec_cpu_info_spin {
> > > +       phys_addr_t phy_release_addr; /* cpu order */
> >
> > I assume you mean this is in the endianness of the current kernel? I was
> > initially confused by the comment, and I think it might be better to
> > drop it -- unless told that a variable is in a specific endianness I
> > would assume that it's the current native endianness anyway.
> 
> The value is read as LE from the device tree, and this comment is to clarify
> that the conversion from LE to cpu has been done.  Maybe 'cpu byte order' is
> less confusing?  Normally, I think the term 'machine order' would be used, but
> I chose 'cpu' from the name of the le64_to_cpu routine.

To me, the code is more confusing due to the presence of the comment. My
default assumption would be that all variables are {native,cpu}-endian
unless commented otherwise.

I'm not sure what you mean w.r.t. the LE conversion. The address in the
DT will be big-endian, and the accessors will covert them to native
endianness as required. The value _at_ the address will be LE, but there
is no conversion necessary on the address itself.

> > > +struct kexec_ctx {
> > > +       struct kexec_dt_info dt_1st;
> > > +       struct kexec_dt_info dt_2nd;
> > > +};
> > > +
> > > +static struct kexec_ctx *ctx;
> >
> > Is there any reason this should be dynamically allocated?
> >
> > Do we even need the current DTB if we rely on hotplug?
> 
> I think so, for this implementation we need to at least check if the enable
> methods and cpu counts of the two DTs match and fail the kexec-load syscall
> if they do not.

With the approach I described, we would not need to perform this check.
We should simply trust that the user knows what they are doing (we're
letting them boot an arbitrary kernel anyway...).

> 
> > > +/**
> > > + * kexec_is_dtb_user - Helper routine to check the device tree header signature.
> > > + */
> > > +
> > > +static int kexec_is_dtb_user(const void *dtb)
> > > +{
> > > +       __be32 magic;
> > > +
> > > +       get_user(magic, (__be32 *)dtb);
> >
> > Return value check? Unless we know this can't fail?
> >
> > If it can fail, surely we should return an appropriate error and forward
> > it to userspace. EFAULT?
> >
> > > +
> > > +       return kexec_is_dtb(magic);
> >
> > And EINVAL if we can read this but it's not a DTB?
> 
> These kexec_is_dtb are just used to search for the DTB segment, so are expected
> to return false for non-DTB segments.  I'll change the return type to bool to
> make the usage more clear.

While that's fine for the latter, I think the former should fail all the
way to userspace which has handed us a pointer to memory which it does
not own.

> 
> > > +/**
> > > + * kexec_read_memreserve - Initialize memreserve info from a dtb.
> > > + */
> > > +
> > > +static int kexec_read_memreserve(const void *dtb, struct kexec_dt_info *info)
> > > +{
> > > +       const struct boot_param_header *h = dtb;
> > > +       struct pair {
> > > +               __be64 phy_addr;
> > > +               __be64 size;
> > > +       } const *pair;
> > > +
> > > +       pair = dtb + be32_to_cpu(h->off_mem_rsvmap);
> > > +
> > > +       if ((pair + 1)->size)
> > > +               pr_warn("kexec: Multiple memreserve regions found.");
> >
> > Huh? Multiple arbitrary memreserves are entirely valid. Why should we
> > warn in that case?
> 
> If a user reports a problem I thought this comment may be useful in debugging
> since the current implementation does not consider them.

Given that multiple memreserves are entirely valid this is going to
result in false positives. I think we can get rid of this if we rely on
userspace passing the right information along.

> 
> > > +
> > > +       info->phy_memreserve_addr = be64_to_cpu(pair->phy_addr);
> > > +       info->memreserve_size = be64_to_cpu(pair->size);
> >
> > So we're assuming that the memory described in an arbitrary memreserve
> > entry (which is intended to describe memory which shouldn't be touched
> > unless we know what we're doing) is for our arbitrary use!?
> >
> > NAK.
> >
> > We shouldn't need to special-case reserved memory handling if we rely on
> > cpu hotplug. If we don't then the only functional option is to add a
> > memreserve, but that will end up leaking a small amount of memory upon
> > every kexec. I believe that the former is the only sane option.
> 
> I think the solution is to have the cpu spin code address property.

Ok.

> 
> > > +static int kexec_setup_cpu_spin(const struct device_node *dn,
> > > +       struct kexec_cpu_info_spin *info)
> > > +{
> > > +       int result;
> > > +       u64 t1;
> > > +
> > > +       memset(info, 0, sizeof(*info));
> > > +
> > > +       result = of_property_read_u64(dn, "cpu-release-addr", &t1);
> > > +
> > > +       if (result) {
> > > +               pr_warn("kexec: Read cpu-release-addr failed.\n");
> > > +               return result;
> > > +       }
> > > +
> > > +       info->phy_release_addr = le64_to_cpu(t1);
> >
> > Why are we calling le64_to_cpu here?
> >
> > of_property_read_u64 reads a be64 value from dt into cpu endianness, so
> > at the very least the annotation is the wrong way around.
> 
> I'll check it again.  I read this and thought the conversion was needed:
> 
>   The value will be written as a single 64-bit little-endian
>   value, so CPUs must convert the read value to their native endianness
>   before jumping to it.

Endianness conversion may be necessary on the value written/read to/from
the address but you're converting the endianness of the address of the
mailbox, not the value written to the mailbox...

> 
> > Have you tested this with a BE kernel? We should ensure that LE->LE,
> > LE->BE, BE->BE, BE->LE all work.
> 
> Not yet.  I'm in the process of setting up a BE test environment.

Ok. I'd very much like to know that this will work across BE<->LE
boundaries.

> 
> > > +int kexec_cpu_info_init(const struct device_node *dn,
> > > +       struct kexec_dt_info *info)
> > > +{
> > > +       int result;
> > > +       unsigned int cpu;
> > > +       const struct device_node *i;
> > > +
> > > +       info->cpu_info = kmalloc(
> > > +               (1 + info->cpu_count) * sizeof(struct kexec_cpu_info),
> > > +               GFP_KERNEL);
> >
> > Why one more than the cpu count? I thought cpu_count covered all the
> > CPUs in the dtb?
> 
> Yes, a left over from when the array was zero terminated.  Thanks for such
> a detailed check!
> 
> > [...]
> >
> > > +int kexec_dt_info_init(void *dtb, struct kexec_dt_info *info)
> > > +{
> > > +       int result;
> > > +       struct device_node *i;
> > > +       struct device_node *dn;
> > > +
> > > +       if (!dtb) {
> > > +               /* 1st stage. */
> > > +               dn = NULL;
> > > +       } else {
> > > +               /* 2nd stage. */
> > > +
> > > +               of_fdt_unflatten_tree(dtb, &dn);
> >
> > This may fail. We should check that dn is not NULL before we try to use
> > it later -- many of_* functions will traverse the current kernel's boot
> > DT if provided with a NULL root.
> 
> OK, I'll fix it.
> 
> > > +
> > > +               result = kexec_read_memreserve(dtb, info);
> > > +
> > > +               if (result)
> > > +                       return result;
> > > +       }
> > > +
> > > +       /*
> > > +        * We may need to work with offline cpus to get them into the correct
> > > +        * state for a given enable method to work, and so need an info_array
> > > +        * that has info about all the platform cpus.
> > > +        */
> >
> > What exactly do we need to do to offline CPUs?
> 
> As mentioned above, to get them into a state expected by the 2nd stage
> kernel if we choose to do so, but to do the compatibility checks for
> this implementation.  Maybe I'll change the wording of this comment.

I still don't understand why we would need to bring them online to later
fake putting them offline, rather than getting the next kernel to handle
the real enable method.

Cheers,
Mark.
