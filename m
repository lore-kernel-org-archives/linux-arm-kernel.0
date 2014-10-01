From: vgoyal@redhat.com (Vivek Goyal)
Date: Wed, 1 Oct 2014 13:36:16 -0400
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <20141001161621.GA28440@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001161621.GA28440@leverpostej>
Message-ID: <20141001173616.GC14991@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 05:16:21PM +0100, Mark Rutland wrote:

[..]
> > > So this implementation makes passing dtb mandatory. So it will not work
> > > with ACPI?
> > 
> > I have not yet considered ACPI.  It will most likely need to have
> > something done differently.  Secure boot will also need something
> > different, and I expect it will use your new kexec_file_load().
> 
> A DTB is mandatory for arm64, and is used to pass the command line,
> (optionally) initrd, and other parameters, even if it doesn't contain HW
> description. In the EFI case the EFI stub will create a trivial DTB if
> necessary, and the kernel will detect any ACPI tables via UEFI, so the
> DTB should be sufficient for ACPI.
> 
> I'm still rather unhappy about the mechanism by which the DTB is passed
> by userspace and detected by the kernel, as I'd prefer that the user
> explictly stated which segment they wanted to pass to the (Linux)
> kernel, but that would require reworking the kexec syscall to allow
> per-segment info/flags.

Yep, in this case, it would have been nice if there were per segment
flags to identify type of segment. But unfortunately we don't have. So
in the absence of that, I think putting 4 bytes as dtb magic in the
beginning of segment should work (though no ideal).

> 
> To me it seems that for all the talk of kexec allowing arbitrary kernels
> to be booted it's really just a linux->linux reboot bridge. Does anyone
> use kexec to boot something that isn't Linux?

> 
> > > Where is dtb present? How is it passed to first kernel? Can it still
> > > be around in memory and second kernel can access it?
> > 
> > The user space program (kexec-tools, etc.) passes a dtb.  That dtb
> > could be a copy of the currently one, or a new one specified by
> > the user.
> > 
> > > I mean in ACPI world on x86, all the ACPI info is still present and second
> > > kernel can access it without it being explicitly to second kernel in
> > > memory. Can something similar happen for dtb?
> 
> Any ACPI tables should remain, given they'll be reserved in the UEFI
> memory map. The second kernel can find them as the first kernel did, via
> UEFI tables, which it will fine via the DTB.
> 
> For the DTB, reusing the original DTB is a possibility. From what I
> recall, Grant seemed to prefer re-packing the existing tree as this
> would allow for state destroyed at boot to be corrected for.
> 
> Regardless, being able to pass a DTB from userspace is a useful option
> (especially for the Linux-as-a-bootloader approach that's been mentioned
> a lot). That doesn't work for the secureboot case without a new syscall
> as we can't pass a signed DTB (or any other additional objects other
> than an initrd) to kexec_file_load, but disallowing the user to pass a
> new DTB in that case seems reasonable.

Yes, kexec_file_load() will not allow passing anything except, kernel,
initrd and command line. So syscall implementation will have to resuse
the existing DTB and pass it to second kernel. 

If there are concerns w.r.t state of DTB which can be destroyed during
boot, I guess we will have to store a copy of DTB somewhere early during
boot and kexec can access that original copy during kernel load time.

Thanks
Vivek



> 
> Mark.
