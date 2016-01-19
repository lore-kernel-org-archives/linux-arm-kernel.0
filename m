From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jan 2016 12:17:22 +0000
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <fb4506943bbaed8b0657ed367ebd57e4064d57ed.1452884156.git.geoff@infradead.org>
 <20160115201601.GR3262@leverpostej> <569CBDBC.5050500@linaro.org>
 <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
Message-ID: <20160119121721.GG25024@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 09:43:32AM +0800, Dave Young wrote:
> On 01/18/16 at 07:26pm, AKASHI Takahiro wrote:
> > On 01/16/2016 05:16 AM, Mark Rutland wrote:
> > >On Fri, Jan 15, 2016 at 07:18:38PM +0000, Geoff Levand wrote:
> > >>From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >>
> > >>This patch adds arch specific descriptions about kdump usage on arm64
> > >>to kdump.txt.
> > >>
> > >>Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >>---
> > >>  Documentation/kdump/kdump.txt | 23 ++++++++++++++++++++++-
> > >>  1 file changed, 22 insertions(+), 1 deletion(-)
> > >>
> > >>diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> > >>index bc4bd5a..36cf978 100644
> > >>--- a/Documentation/kdump/kdump.txt
> > >>+++ b/Documentation/kdump/kdump.txt
> > >>@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
> > >>  a remote system.
> > >>
> > >>  Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
> > >>-s390x and arm architectures.
> > >>+s390x, arm and arm64 architectures.
> > >>
> > >>  When the system kernel boots, it reserves a small section of memory for
> > >>  the dump-capture kernel. This ensures that ongoing Direct Memory Access
> > >>@@ -249,6 +249,20 @@ Dump-capture kernel config options (Arch Dependent, arm)
> > >>
> > >>      AUTO_ZRELADDR=y
> > >>
> > >>+Dump-capture kernel config options (Arch Dependent, arm64)
> > >>+----------------------------------------------------------
> > >>+
> > >>+1) The maximum memory size on the dump-capture kernel must be limited by
> > >>+   specifying:
> > >>+
> > >>+   mem=X[MG]
> > >>+
> > >>+   where X should be less than or equal to the size in "crashkernel="
> > >>+   boot parameter. Kexec-tools will automatically add this.
> > >
> > >
> > >This is extremely fragile, and will trivially fail when the kernel can
> > >be loaded anywhere (see [1]).
> > 
> > As I said before, this restriction also exists on arm, but I understand
> > that recent Ard's patches break it.
> > 
> > >We must explicitly describe the set of regions the crash kernel may use
> > >(i.e. we need base and size). NAK in the absence of that.
> > 
> > There seem to exist several approaches:
> > (a) use a device-tree property, "linux,usable-memory", in addition to "reg"
> >     under "memory" node
> > (b) use a kernel's early parameter, "memmap=nn[@#$]ss"
> > 
> > Power PC takes (a), while this does not work on efi-started kernel
> > because dtb has no "memory" nodes under efi.
> > X86 takes (b). If we take this, we will need to overwrite a weak
> > early_init_dt_add_memory().
> 
> X86 takes another way in latest kexec-tools and kexec_file_load, that is
> recreating E820 table and pass it to kexec/kdump kernel, if the entries
> are over E820 limitation then turn to use setup_data list for remain
> entries.

This would imply modifying the EFI memory map or the memory nodes, which
I'm not keen on.

I would prefer that they are left _pristine_, and we describe the
restriction on the kdump kernel with additional properties under
/chosen.

That leaves us with more useful information about the environment of the
first kernel, is simpler for userspace (it's resilient to updates to the
UEFI memory map spec, for example), and is simple for the crash kernel.

> I think it is X86 specific. Personally I think device tree property is
> better.

As above, agreed.

Thanks,
Mark.
