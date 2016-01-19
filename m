From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jan 2016 14:01:40 +0000
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <fb4506943bbaed8b0657ed367ebd57e4064d57ed.1452884156.git.geoff@infradead.org>
 <20160115201601.GR3262@leverpostej> <569CBDBC.5050500@linaro.org>
 <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
Message-ID: <20160119140139.GC26545@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 09:45:53PM +0800, Dave Young wrote:
> On 01/19/16 at 12:51pm, Mark Rutland wrote:
> > On Tue, Jan 19, 2016 at 08:28:48PM +0800, Dave Young wrote:
> > > On 01/19/16 at 02:35pm, AKASHI Takahiro wrote:
> > > > On 01/19/2016 10:43 AM, Dave Young wrote:
> > > > >X86 takes another way in latest kexec-tools and kexec_file_load, that is
> > > > >recreating E820 table and pass it to kexec/kdump kernel, if the entries
> > > > >are over E820 limitation then turn to use setup_data list for remain
> > > > >entries.
> > > > 
> > > > Thanks. I will visit x86 code again.
> > > > 
> > > > >I think it is X86 specific. Personally I think device tree property is
> > > > >better.
> > > > 
> > > > Do you think so?
> > > 
> > > I'm not sure it is the best way. For X86 we run into problem with
> > > memmap= design, one example is pci domain X (X>1) need the pci memory
> > > ranges being passed to kdump kernel. When we passed reserved ranges in /proc/iomem
> > > to 2nd kernel we find that cmdline[] array is not big enough.
> > 
> > I'm not sure how PCI ranges relate to the memory map used for normal
> > memory (i.e. RAM), though I'm probably missing some caveat with the way
> > ACPI and UEFI describe PCI. Why does memmap= affect PCI memory?
> 
> Here is the old patch which was rejected in kexec-tools:
> http://lists.infradead.org/pipermail/kexec/2013-February/007924.html
> 
> > 
> > If the kernel got the rest of its system topology from DT, the PCI
> > regions would be described there.
> 
> Yes, if kdump kernel use same DT as 1st kernel.

Other than for testing purposes, I don't see why you'd pass the kdump
kernel a DTB inconsistent with that the 1st kernel was passsed (other
than some proerties under /chosen).

We added /sys/firmware/fdt specifically to allow the kexec tools to get
the exact DTB the first kernel used. There's no reason for tools to have
to make something up.

> > > Do you think for arm64 only usable memory is necessary to let kdump kernel
> > > know? I'm curious about how arm64 kernel get all memory layout from boot loader,
> > > via UEFI memmap?
> > 
> > When booted via EFI, we use the EFI memory map. The EFI stub handles
> > acquring the relevant information and passing that to the first kernel
> > in the DTB (see Documentation/arm/uefi.txt).
> 
> Ok, thanks for the pointer. So in dt we are just have uefi memmap infomation
> instead of memory nodes details.. 

When booted via EFI, yes.

For NUMA topology in !ACPI kernels, we might need to also retain and
parse memory nodes, but only for toplogy information. The kernel would
still only use memory as described by the EFI memory map.

There's a horrible edge case I've spotted if performing a chain of
cross-endian kexecs: LE -> BE -> LE, as the BE kernel would have to
respect the EFI memory map so as to avoid corrupting it for the
subsequent LE kernel. Other than this I believe everything should just
work.

> > A kexec'd kernel should simply inherit that. So long as the DTB and/or
> > UEFI tables in memory are the same, it would be the same as a cold boot.
> 
> For kexec all memory ranges are same, for kdump we need use original reserved
> range with crashkernel= as usable memory and all other orignal usable ranges
> are not usable anymore. 

Sure. This is what I believe we should expose with an additional
property under /chosen, while keeping everything else pristine.

The crash kernel can then limit itself to that region, while it would
have the information of the full memory map (which it could log and/or
use to drive other dumping).

> Is it possible to modify uefi memmap for kdump case?

Technically it would be possible, however I don't think it's necessary,
and I think it would be disadvantageous to do so.

Describing the range(s) the crash kernel can use in separate properties
under /chosen has a number of advantages.

> > In the !EFI case, we use the memory nodes in the DTB. Only in this case
> > could usable-memory properties in memory nodes make sense. I'd prefer a
> > uniform property under /chosen for both cases.
> 
> We stil use same DTB, need to modify the DT and update the usable and unusable
> nodes for kdump?

We'd have a (slightly) modified DTB that contained additional properties
describing the range(s) reserved for use by the crash kernel.

Other than those properties under /chosen (e.g. the command line, initrd
pointers if any), it would be the original DTB.

Thanks,
Mark.
