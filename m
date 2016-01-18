From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jan 2016 11:29:33 +0000
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <569CBDBC.5050500@linaro.org>
References: <cover.1452884156.git.geoff@infradead.org>
 <fb4506943bbaed8b0657ed367ebd57e4064d57ed.1452884156.git.geoff@infradead.org>
 <20160115201601.GR3262@leverpostej> <569CBDBC.5050500@linaro.org>
Message-ID: <20160118112933.GH21067@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 07:26:04PM +0900, AKASHI Takahiro wrote:
> On 01/16/2016 05:16 AM, Mark Rutland wrote:
> >On Fri, Jan 15, 2016 at 07:18:38PM +0000, Geoff Levand wrote:
> >>From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>
> >>This patch adds arch specific descriptions about kdump usage on arm64
> >>to kdump.txt.
> >>
> >>Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>---
> >>  Documentation/kdump/kdump.txt | 23 ++++++++++++++++++++++-
> >>  1 file changed, 22 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> >>index bc4bd5a..36cf978 100644
> >>--- a/Documentation/kdump/kdump.txt
> >>+++ b/Documentation/kdump/kdump.txt
> >>@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
> >>  a remote system.
> >>
> >>  Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
> >>-s390x and arm architectures.
> >>+s390x, arm and arm64 architectures.
> >>
> >>  When the system kernel boots, it reserves a small section of memory for
> >>  the dump-capture kernel. This ensures that ongoing Direct Memory Access
> >>@@ -249,6 +249,20 @@ Dump-capture kernel config options (Arch Dependent, arm)
> >>
> >>      AUTO_ZRELADDR=y
> >>
> >>+Dump-capture kernel config options (Arch Dependent, arm64)
> >>+----------------------------------------------------------
> >>+
> >>+1) The maximum memory size on the dump-capture kernel must be limited by
> >>+   specifying:
> >>+
> >>+   mem=X[MG]
> >>+
> >>+   where X should be less than or equal to the size in "crashkernel="
> >>+   boot parameter. Kexec-tools will automatically add this.
> >
> >
> >This is extremely fragile, and will trivially fail when the kernel can
> >be loaded anywhere (see [1]).
> 
> As I said before, this restriction also exists on arm, but I understand
> that recent Ard's patches break it.
> 
> >We must explicitly describe the set of regions the crash kernel may use
> >(i.e. we need base and size). NAK in the absence of that.
> 
> There seem to exist several approaches:
> (a) use a device-tree property, "linux,usable-memory", in addition to "reg"

I'm not opposed to the idea of a DT property, though I think that should
live under /chosen.

I see that "linux,usable-memory" exists already, though I'm confused as
to exactly what it is for as there is no documentation (neither in the
kernel nor in ePAPR). It's also painful to alter multiple memory nodes
to use that, and I can see that going wrong.

>     under "memory" node
> (b) use a kernel's early parameter, "memmap=nn[@#$]ss"

I'm not too keen on this, as I think it's fragile, and logically
somewhat distinct from what mem= is for (a best effort testing tool).

> Power PC takes (a), while this does not work on efi-started kernel
> because dtb has no "memory" nodes under efi.

A property under /chosen would work for EFI too.

> X86 takes (b). If we take this, we will need to overwrite a weak
> early_init_dt_add_memory().
> (I thought that this approach was not smart as we have three different
> ways to specify memory regions, dtb, efi and this kernel parameter.)

I'm not sure that's a big problem. We may be able to make this generic,
also.

We don't necessarily need a weak add memory function if we can guarantee
nothing gets memblock_alloc'd before we carve it out.

Something like the nomap stuff Ard put together might be useful here.

Thanks,
Mark.
