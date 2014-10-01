From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Oct 2014 17:16:21 +0100
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <1412106877.6630.45.camel@smoke>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
Message-ID: <20141001161621.GA28440@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > > +/**
> > > + * kexec_is_dtb - Helper routine to check the device tree header signature.
> > > + */
> > > +
> > > +static bool kexec_is_dtb(const void *dtb)
> > > +{
> > > +	__be32 magic;
> > > +
> > > +	return get_user(magic, (__be32 *)dtb) ? false :
> > > +		(be32_to_cpu(magic) == OF_DT_HEADER);
> > > +}
> > > +
> > > +/**
> > > + * kexec_find_dtb_seg - Helper routine to find the dtb segment.
> > > + */
> > > +
> > > +static const struct kexec_segment *kexec_find_dtb_seg(
> > > +	const struct kimage *image)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < image->nr_segments; i++) {
> > > +		if (kexec_is_dtb(image->segment[i].buf))
> > > +			return &image->segment[i];
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> > 
> > So this implementation makes passing dtb mandatory. So it will not work
> > with ACPI?
> 
> I have not yet considered ACPI.  It will most likely need to have
> something done differently.  Secure boot will also need something
> different, and I expect it will use your new kexec_file_load().

A DTB is mandatory for arm64, and is used to pass the command line,
(optionally) initrd, and other parameters, even if it doesn't contain HW
description. In the EFI case the EFI stub will create a trivial DTB if
necessary, and the kernel will detect any ACPI tables via UEFI, so the
DTB should be sufficient for ACPI.

I'm still rather unhappy about the mechanism by which the DTB is passed
by userspace and detected by the kernel, as I'd prefer that the user
explictly stated which segment they wanted to pass to the (Linux)
kernel, but that would require reworking the kexec syscall to allow
per-segment info/flags.

To me it seems that for all the talk of kexec allowing arbitrary kernels
to be booted it's really just a linux->linux reboot bridge. Does anyone
use kexec to boot something that isn't Linux?

> > Where is dtb present? How is it passed to first kernel? Can it still
> > be around in memory and second kernel can access it?
> 
> The user space program (kexec-tools, etc.) passes a dtb.  That dtb
> could be a copy of the currently one, or a new one specified by
> the user.
> 
> > I mean in ACPI world on x86, all the ACPI info is still present and second
> > kernel can access it without it being explicitly to second kernel in
> > memory. Can something similar happen for dtb?

Any ACPI tables should remain, given they'll be reserved in the UEFI
memory map. The second kernel can find them as the first kernel did, via
UEFI tables, which it will fine via the DTB.

For the DTB, reusing the original DTB is a possibility. From what I
recall, Grant seemed to prefer re-packing the existing tree as this
would allow for state destroyed at boot to be corrected for.

Regardless, being able to pass a DTB from userspace is a useful option
(especially for the Linux-as-a-bootloader approach that's been mentioned
a lot). That doesn't work for the secureboot case without a new syscall
as we can't pass a signed DTB (or any other additional objects other
than an initrd) to kexec_file_load, but disallowing the user to pass a
new DTB in that case seems reasonable.

Mark.
