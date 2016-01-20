From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Jan 2016 11:28:21 +0000
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
References: <fb4506943bbaed8b0657ed367ebd57e4064d57ed.1452884156.git.geoff@infradead.org>
 <20160115201601.GR3262@leverpostej> <569CBDBC.5050500@linaro.org>
 <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
Message-ID: <20160120112819.GA25829@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 10:49:46AM +0800, Dave Young wrote:
> On 01/19/16 at 02:01pm, Mark Rutland wrote:
> > On Tue, Jan 19, 2016 at 09:45:53PM +0800, Dave Young wrote:
> > > On 01/19/16 at 12:51pm, Mark Rutland wrote:
> > > > On Tue, Jan 19, 2016 at 08:28:48PM +0800, Dave Young wrote:
> > > > > On 01/19/16 at 02:35pm, AKASHI Takahiro wrote:
> > > > > > On 01/19/2016 10:43 AM, Dave Young wrote:
> > > > > > >X86 takes another way in latest kexec-tools and kexec_file_load, that is
> > > > > > >recreating E820 table and pass it to kexec/kdump kernel, if the entries
> > > > > > >are over E820 limitation then turn to use setup_data list for remain
> > > > > > >entries.
> > > > > > 
> > > > > > Thanks. I will visit x86 code again.
> > > > > > 
> > > > > > >I think it is X86 specific. Personally I think device tree property is
> > > > > > >better.
> > > > > > 
> > > > > > Do you think so?
> > > > > 
> > > > > I'm not sure it is the best way. For X86 we run into problem with
> > > > > memmap= design, one example is pci domain X (X>1) need the pci memory
> > > > > ranges being passed to kdump kernel. When we passed reserved ranges in /proc/iomem
> > > > > to 2nd kernel we find that cmdline[] array is not big enough.
> > > > 
> > > > I'm not sure how PCI ranges relate to the memory map used for normal
> > > > memory (i.e. RAM), though I'm probably missing some caveat with the way
> > > > ACPI and UEFI describe PCI. Why does memmap= affect PCI memory?
> > > 
> > > Here is the old patch which was rejected in kexec-tools:
> > > http://lists.infradead.org/pipermail/kexec/2013-February/007924.html
> > > 
> > > > 
> > > > If the kernel got the rest of its system topology from DT, the PCI
> > > > regions would be described there.
> > > 
> > > Yes, if kdump kernel use same DT as 1st kernel.
> > 
> > Other than for testing purposes, I don't see why you'd pass the kdump
> > kernel a DTB inconsistent with that the 1st kernel was passsed (other
> > than some proerties under /chosen).
> > 
> > We added /sys/firmware/fdt specifically to allow the kexec tools to get
> > the exact DTB the first kernel used. There's no reason for tools to have
> > to make something up.
> 
> Agreed, but kexec-tools has an option to pass in any dtb files. Who knows
> how one will use it unless dropping the option and use /sys/firmware/fdt
> unconditionally. 

I think this is a tangential discussion. I think it's fine to say that
for kdump we do not expect this -- a user would be shooting themselves
in the foot if they did. Regardless, I was under the impression that
kdump was usually set up by distribution-provided init code.

or kdump, which typically is set up automatically by the OS, 

> If we choose to implement kexec_file_load only in kernel, the interfaces
> provided are kernel, initrd and cmdline. We can always use same dtb.

There are use-cases where being in complete control of the purgatory
code is necessary. For example, the next OS might not be Linux (and
might not accept a DTB, or have different requirements on the initial
register state).

Regardless of the need for something like kexec_file_load for kdump in
Secure Boot environments, there is also a need for kexec_load with the
user having complete control.

> > > > > Do you think for arm64 only usable memory is necessary to let kdump kernel
> > > > > know? I'm curious about how arm64 kernel get all memory layout from boot loader,
> > > > > via UEFI memmap?
> > > > 
> > > > When booted via EFI, we use the EFI memory map. The EFI stub handles
> > > > acquring the relevant information and passing that to the first kernel
> > > > in the DTB (see Documentation/arm/uefi.txt).
> > > 
> > > Ok, thanks for the pointer. So in dt we are just have uefi memmap infomation
> > > instead of memory nodes details.. 
> > 
> > When booted via EFI, yes.
> > 
> > For NUMA topology in !ACPI kernels, we might need to also retain and
> > parse memory nodes, but only for toplogy information. The kernel would
> > still only use memory as described by the EFI memory map.
> > 
> > There's a horrible edge case I've spotted if performing a chain of
> > cross-endian kexecs: LE -> BE -> LE, as the BE kernel would have to
> > respect the EFI memory map so as to avoid corrupting it for the
> > subsequent LE kernel. Other than this I believe everything should just
> > work.
> 
> Firmware do not know kernel endianniess, kernel should respect firmware
> maps and adapt to it, it sounds like a generic issue not specfic to kexec.

I agree that this isn't kexec's fault as such, but in the absence of
kexec, the above issue does not exist, so one can't consider it in
isolation.

> > > > A kexec'd kernel should simply inherit that. So long as the DTB and/or
> > > > UEFI tables in memory are the same, it would be the same as a cold boot.
> > > 
> > > For kexec all memory ranges are same, for kdump we need use original reserved
> > > range with crashkernel= as usable memory and all other orignal usable ranges
> > > are not usable anymore. 
> > 
> > Sure. This is what I believe we should expose with an additional
> > property under /chosen, while keeping everything else pristine.
> > 
> > The crash kernel can then limit itself to that region, while it would
> > have the information of the full memory map (which it could log and/or
> > use to drive other dumping).
> 
> In this way kernel should be aware it is a kdump booting, it is doable though
> I feel it is better for kdump kernel in a black box with infomations it
> can use just like the 1st kernel. Things here is where we choose to cook
> the memory infomation in boot loader or in kernel itself.

Sorry, I can't follow what you are trying to say here. Could you
elaborate?

> > > Is it possible to modify uefi memmap for kdump case?
> > 
> > Technically it would be possible, however I don't think it's necessary,
> > and I think it would be disadvantageous to do so.
> > 
> > Describing the range(s) the crash kernel can use in separate properties
> > under /chosen has a number of advantages.
> 
> Ok, I got the points. We have a is_kdump_kernel() by checking if there is
> elfcorehdr_addr kernel cmdline. This is mainly for some drivers which
> do not work well in kdump kernel some uncertain reasons. But ideally I
> think kernel should handle things just like in 1st kernel and avoid to use
> it. 

I agree that we should not have kexec/kdump knowledge spread throughout
the kernel, and that the boot protocol should be uniform with a cold
boot as far as possible.

However, requiring userspace or the first kernel to modify
firmware-provided information has a number of risks and reduces the
amount of information available to the kdump kernel. To that end I am
opposed to modifying the memory nodes in the DTB, or to modifying the
EFI memory map.

Having a property in the DTB describing the range(s) of memory reserved
for use by the kdump kernel is vastly simpler, and avoids those risks:

* It requires a tiny amount of self-contained code in the kdump kernel
  to parse the property and apply the constraints imposed (i.e. carve up
  memblock).

  This is easy to contain in a single function (or at least within a
  single file), and need not affect drivers or other code.

* It is uniform regardless of whether the EFI memory map, DT memory
  nodes, or some other mechanism is used to discover memory in the
  systems.

  This makes it easy to impose the restrictions consistently, and is
  somewhat future-proof.

* Userspace or the first kernel to not need to parse and modify an
  arbitrary amount of data (which might be in an extended format it
  doesn't fully understand). There is less risk for this to go wrong.

  It is far easier to add a property than it is to correctly modify the
  EFI memory map, memory nodes, or some other data structure. There is
  less risk, and it is somewhat future-proof.
  
* The original memory map information is preserved, even though unused.
  This may be useful for debugging, and it may turn out that the kdump
  kernel needs to know about certain portions of the original memory
  map, even if we are not currently aware of why we would need this.

Thanks,
Mark.
