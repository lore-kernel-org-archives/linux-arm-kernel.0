From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jan 2016 12:51:15 +0000
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <fb4506943bbaed8b0657ed367ebd57e4064d57ed.1452884156.git.geoff@infradead.org>
 <20160115201601.GR3262@leverpostej> <569CBDBC.5050500@linaro.org>
 <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
Message-ID: <20160119125114.GH25024@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 08:28:48PM +0800, Dave Young wrote:
> On 01/19/16 at 02:35pm, AKASHI Takahiro wrote:
> > On 01/19/2016 10:43 AM, Dave Young wrote:
> > >On 01/18/16 at 07:26pm, AKASHI Takahiro wrote:
> > >>On 01/16/2016 05:16 AM, Mark Rutland wrote:
> > >>>On Fri, Jan 15, 2016 at 07:18:38PM +0000, Geoff Levand wrote:
> > >>>>From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >>>>
> > >>>>This patch adds arch specific descriptions about kdump usage on arm64
> > >>>>to kdump.txt.
> > >>>>
> > >>>>Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >>>>---
> > >>>>  Documentation/kdump/kdump.txt | 23 ++++++++++++++++++++++-
> > >>>>  1 file changed, 22 insertions(+), 1 deletion(-)
> > >>>>
> > >>>>diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> > >>>>index bc4bd5a..36cf978 100644
> > >>>>--- a/Documentation/kdump/kdump.txt
> > >>>>+++ b/Documentation/kdump/kdump.txt
> > >>>>@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
> > >>>>  a remote system.
> > >>>>
> > >>>>  Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
> > >>>>-s390x and arm architectures.
> > >>>>+s390x, arm and arm64 architectures.
> > >>>>
> > >>>>  When the system kernel boots, it reserves a small section of memory for
> > >>>>  the dump-capture kernel. This ensures that ongoing Direct Memory Access
> > >>>>@@ -249,6 +249,20 @@ Dump-capture kernel config options (Arch Dependent, arm)
> > >>>>
> > >>>>      AUTO_ZRELADDR=y
> > >>>>
> > >>>>+Dump-capture kernel config options (Arch Dependent, arm64)
> > >>>>+----------------------------------------------------------
> > >>>>+
> > >>>>+1) The maximum memory size on the dump-capture kernel must be limited by
> > >>>>+   specifying:
> > >>>>+
> > >>>>+   mem=X[MG]
> > >>>>+
> > >>>>+   where X should be less than or equal to the size in "crashkernel="
> > >>>>+   boot parameter. Kexec-tools will automatically add this.
> > >>>
> > >>>
> > >>>This is extremely fragile, and will trivially fail when the kernel can
> > >>>be loaded anywhere (see [1]).
> > >>
> > >>As I said before, this restriction also exists on arm, but I understand
> > >>that recent Ard's patches break it.
> > >>
> > >>>We must explicitly describe the set of regions the crash kernel may use
> > >>>(i.e. we need base and size). NAK in the absence of that.
> > >>
> > >>There seem to exist several approaches:
> > >>(a) use a device-tree property, "linux,usable-memory", in addition to "reg"
> > >>     under "memory" node
> > >>(b) use a kernel's early parameter, "memmap=nn[@#$]ss"
> > >>
> > >>Power PC takes (a), while this does not work on efi-started kernel
> > >>because dtb has no "memory" nodes under efi.
> > >>X86 takes (b). If we take this, we will need to overwrite a weak
> > >>early_init_dt_add_memory().
> > >
> > >X86 takes another way in latest kexec-tools and kexec_file_load, that is
> > >recreating E820 table and pass it to kexec/kdump kernel, if the entries
> > >are over E820 limitation then turn to use setup_data list for remain
> > >entries.
> > 
> > Thanks. I will visit x86 code again.
> > 
> > >I think it is X86 specific. Personally I think device tree property is
> > >better.
> > 
> > Do you think so?
> 
> I'm not sure it is the best way. For X86 we run into problem with
> memmap= design, one example is pci domain X (X>1) need the pci memory
> ranges being passed to kdump kernel. When we passed reserved ranges in /proc/iomem
> to 2nd kernel we find that cmdline[] array is not big enough.

I'm not sure how PCI ranges relate to the memory map used for normal
memory (i.e. RAM), though I'm probably missing some caveat with the way
ACPI and UEFI describe PCI. Why does memmap= affect PCI memory?

If the kernel got the rest of its system topology from DT, the PCI
regions would be described there.

> Do you think for arm64 only usable memory is necessary to let kdump kernel
> know? I'm curious about how arm64 kernel get all memory layout from boot loader,
> via UEFI memmap?

When booted via EFI, we use the EFI memory map. The EFI stub handles
acquring the relevant information and passing that to the first kernel
in the DTB (see Documentation/arm/uefi.txt).

A kexec'd kernel should simply inherit that. So long as the DTB and/or
UEFI tables in memory are the same, it would be the same as a cold boot.

In the !EFI case, we use the memory nodes in the DTB. Only in this case
could usable-memory properties in memory nodes make sense. I'd prefer a
uniform property under /chosen for both cases.

Thanks,
Mark.
