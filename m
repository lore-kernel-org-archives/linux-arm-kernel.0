From: geoff@infradead.org (Geoff Levand)
Date: Mon, 17 Nov 2014 12:20:53 -0800
Subject: [PATCH 08/10] arm64/kexec: Add core kexec support
In-Reply-To: <20141117163826.GD25416@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <c8e8a3378f028e54e21931bc7f3d62c48725d5c7.1414099246.git.geoff@infradead.org>
 <20141024102838.GB24265@leverpostej> <1415845188.15847.79.camel@smoke>
 <20141117163826.GD25416@leverpostej>
Message-ID: <1416255653.23886.34.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Nov 13, 2014 at 02:19:48AM +0000, Geoff Levand wrote:
> > On Fri, 2014-10-24 at 11:28 +0100, Mark Rutland wrote:
> > > > +/**
> > > > + * machine_kexec_prepare - Prepare for a kexec reboot.
> > > > + *
> > > > + * Called from the core kexec code when a kernel image is loaded.
> > > > + */
> > > > +
> > > > +int machine_kexec_prepare(struct kimage *image)
> > > > +{
> > > > +       const struct kexec_segment *dtb_seg = kexec_find_dtb_seg(image);
> > > > +
> > > > +       if (!dtb_seg)
> > > > +               pr_warn("%s: No device tree segment found.\n", __func__);
> > > > +
> > > > +       arm64_kexec_dtb_addr = dtb_seg ? dtb_seg->mem : 0;
> > > > +       arm64_kexec_kimage_start = image->start;
> > > > +
> > > > +       return 0;
> > > > +}
> > > 
> > > I thought all of the DTB handling was moving to purgatory?
> > 
> > Non-purgatory booting is needed for kexec-lite.  We can do
> > this simple check here which optionally sets x0 to the dtb
> > address to support that.  The other solution is to have a
> > trampoline in kexec-lite that sets x0 (basically an absolute
> > minimal purgatory), but I think to do it here is nicer, and
> > is also the same way that the arm arch code does it.
> > 
> > Maybe removing this pr_warn message and just relying on the
> > kexec_image_info() output would be better.
> 
> I mentioned previously that I don't think the "kexec-lite" approach is a
> good one, especially if we're going to have userspace purgatory code
> anyway. It embeds a policy w.r.t. the segment handling within the
> kernel, on the assumption of a specific use-case for what is a more
> general mechanism.

I don't think this support embeds a policy.  It is completely optional.
If one of the kexec segments is found to have a dtb header at its start
the address of that segment is put into x0 so that it is available to
the code that control is passed to.  That code is free to use the value
or not.  In the case of the current kexec-tools implementation for
example, its purgatory does not use that value in x0 since the address
of the dtb is known to the purgatory code through its arm64_dtb_addr
variable. 

One motivation for kexec-lite was to avoid the complicated user
space of a purgatory when it wasn't really needed.  From what I
understand, kexec-lite is shipping to customers, so there is at least a
desire for it on other architectures which I believe are in the same
market as 64 bit ARM servers.  Also, just to mention it, the arm (32 bit)
arch provides a similar facility in its kexec kernel code, by setting
r2 to the address of the dtb, and there doesn't seem to be any concern
over that.

I can't see any negative effect of setting x0 in this way.  If a user
space loader needs or wants to do something different it is completely
free to ignore the value the 1st stage kernel has put into x0.

If the boot protocol is changed new kernels will still need to be able to
boot from old loaders, and old kernels from new loaders.  Depending on
what the protocol change introduces we can decide if it makes sense to
update this part of kexec.

If you can describe a clear situation where this would cause a problem
we should remove it, but if the choice is to remove support that users
want to provide kernel developers some flexibility that may not be
needed, then I think we should keep it in.

> Unfortunately secureboot with kexec_file_load will require a kernelspace
> purgatory and likely special DT handling, but it's already a far more
> limited interface.

...

> > > > +/*
> > > > + * relocate_new_kernel - Put a 2nd stage kernel image in place and boot it.
> > > > + *
> > > > + * The memory that the old kernel occupies may be overwritten when coping the
> > > > + * new image to its final location.  To assure that the relocate_new_kernel
> > > > + * routine which does that copy is not overwritten all code and data needed
> > > > + * by relocate_new_kernel must be between the symbols relocate_new_kernel and
> > > > + * relocate_new_kernel_end.  The machine_kexec() routine will copy
> > > > + * relocate_new_kernel to the kexec control_code_page, a special page which
> > > > + * has been set up to be preserved during the copy operation.
> > > > + */
> > > > +
> > > > +.globl relocate_new_kernel
> > > > +relocate_new_kernel:
> > 
> > ...
> > 
> > > > +
> > > > +       /* start_new_image */
> > > > +
> > > > +       ldr     x4, arm64_kexec_kimage_start
> > > > +       ldr     x0, arm64_kexec_dtb_addr
> > > > +       mov     x1, xzr
> > > > +       mov     x2, xzr
> > > > +       mov     x3, xzr
> > > > +       br      x4
> > > 
> > > This last part should be in userspace-provided purgatory. If you have
> > > purgatory code which does this then we should be able to rely on that,
> > > and we don't have to try to maintain this DTB handling in kernelspace
> > > (which I suspect may become painful as the boot protocol evolves).
> > 
> > I think the putting the dtb address in x0 is already fixed.  There are
> > users with firmware that does this and any change to the boot protocol
> > will have to work with it.
> 
> Sure, but that is the _Linux_ boot protocol, and the Kconfig description
> of kexec stats "you can start any kernel with it, not just Linux". Why
> should we embed Linux-specific details into a supposedly generic
> mechanism?
> 
> We may also extend the boot protocol, and I would rather not have to
> manage the complexity of each possible extension within the kernel,
> especially given that the only context we can pass in kexec is segments.
> 
> > As I mentioned above, we need a solution for non-purgatory re-boot and I
> > think this is the best way.
> 
> Why do we need a solution for "non-purgatory re-boot"? As far as I can
> see this is a non-problem.

I tried to address these last concerns in my comments above.
  
-Geoff
