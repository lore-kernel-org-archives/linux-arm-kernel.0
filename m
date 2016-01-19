From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jan 2016 12:10:14 +0000
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <569DCA19.4080704@linaro.org>
References: <cover.1452884156.git.geoff@infradead.org>
 <fb4506943bbaed8b0657ed367ebd57e4064d57ed.1452884156.git.geoff@infradead.org>
 <20160115201601.GR3262@leverpostej> <569CBDBC.5050500@linaro.org>
 <20160118112933.GH21067@leverpostej> <569DCA19.4080704@linaro.org>
Message-ID: <20160119121014.GF25024@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 02:31:05PM +0900, AKASHI Takahiro wrote:
> On 01/18/2016 08:29 PM, Mark Rutland wrote:
> >On Mon, Jan 18, 2016 at 07:26:04PM +0900, AKASHI Takahiro wrote:
> >>On 01/16/2016 05:16 AM, Mark Rutland wrote:
> >>>On Fri, Jan 15, 2016 at 07:18:38PM +0000, Geoff Levand wrote:
> >>>>From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>
> >>>>This patch adds arch specific descriptions about kdump usage on arm64
> >>>>to kdump.txt.
> >>>>
> >>>>Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>---
> >>>>  Documentation/kdump/kdump.txt | 23 ++++++++++++++++++++++-
> >>>>  1 file changed, 22 insertions(+), 1 deletion(-)
> >>>>
> >>>>diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> >>>>index bc4bd5a..36cf978 100644
> >>>>--- a/Documentation/kdump/kdump.txt
> >>>>+++ b/Documentation/kdump/kdump.txt
> >>>>@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
> >>>>  a remote system.
> >>>>
> >>>>  Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
> >>>>-s390x and arm architectures.
> >>>>+s390x, arm and arm64 architectures.
> >>>>
> >>>>  When the system kernel boots, it reserves a small section of memory for
> >>>>  the dump-capture kernel. This ensures that ongoing Direct Memory Access
> >>>>@@ -249,6 +249,20 @@ Dump-capture kernel config options (Arch Dependent, arm)
> >>>>
> >>>>      AUTO_ZRELADDR=y
> >>>>
> >>>>+Dump-capture kernel config options (Arch Dependent, arm64)
> >>>>+----------------------------------------------------------
> >>>>+
> >>>>+1) The maximum memory size on the dump-capture kernel must be limited by
> >>>>+   specifying:
> >>>>+
> >>>>+   mem=X[MG]
> >>>>+
> >>>>+   where X should be less than or equal to the size in "crashkernel="
> >>>>+   boot parameter. Kexec-tools will automatically add this.
> >>>
> >>>
> >>>This is extremely fragile, and will trivially fail when the kernel can
> >>>be loaded anywhere (see [1]).
> >>
> >>As I said before, this restriction also exists on arm, but I understand
> >>that recent Ard's patches break it.
> >>
> >>>We must explicitly describe the set of regions the crash kernel may use
> >>>(i.e. we need base and size). NAK in the absence of that.
> >>
> >>There seem to exist several approaches:
> >>(a) use a device-tree property, "linux,usable-memory", in addition to "reg"
> >
> >I'm not opposed to the idea of a DT property, though I think that should
> >live under /chosen.
> 
> In fact, powerpc uses another property, "linux,crashkernel-base(& size)",
> under /chosen in order for the *1st kernel* to export info about a memory
> region for the 2nd(crash dump) kernel to user apps (kexec-tools).

Do you mean that said property is provided _to_ the 1st kernel, or
provided _by_ the first kernel?

> >I see that "linux,usable-memory" exists already, though I'm confused as
> >to exactly what it is for as there is no documentation (neither in the
> >kernel nor in ePAPR).
> 
> For example,
>   memory at 0x80000000 {
>     reg = <0x0 0x80000000 0x0 0x80000000>;
>     linux,usable-memory = <0x0 0x8c000000 0x0 0x4000000>;
>   }
> There exists 2GB memory available on the system, but the last 64MB can be
> used as a system ram. See early_init_dt_scan_memory() in fdt.c.

Sure, except that's the implementation rather than the intended
semantics (which are not defined).

> >It's also painful to alter multiple memory nodes
> >to use that, and I can see that going wrong.
> 
> Yeah, I implemented this feature in my old versions experimentally,
> but didn't like it as we had to touch all the memory nodes.
> 
> >>     under "memory" node
> >>(b) use a kernel's early parameter, "memmap=nn[@#$]ss"
> >
> >I'm not too keen on this, as I think it's fragile, and logically
> >somewhat distinct from what mem= is for (a best effort testing tool).
> 
> I'm not sure whether it is fragile, and contrary to x86, as Dave
> described, I think we will only need a single memmap= on arm64 as
> efi's mem map table is accessible even on the crash kernel.

I just realised I misread this as "mem=", apologies.

It looks like memmap= to force a specific region of memory to be used
may work.

I'd still err on the side of preferring an explicit property in the DT.

> >>Power PC takes (a), while this does not work on efi-started kernel
> >>because dtb has no "memory" nodes under efi.
> >
> >A property under /chosen would work for EFI too.
> >
> >>X86 takes (b). If we take this, we will need to overwrite a weak
> >>early_init_dt_add_memory().
> >>(I thought that this approach was not smart as we have three different
> >>ways to specify memory regions, dtb, efi and this kernel parameter.)
> >
> >I'm not sure that's a big problem. We may be able to make this generic,
> >also.
> >
> >We don't necessarily need a weak add memory function if we can guarantee
> >nothing gets memblock_alloc'd before we carve it out.
> >
> >Something like the nomap stuff Ard put together might be useful here.
> 
> I'm afraid it doesn't work.
> It doesn't matter whether it is linearly mapped or not. We should prevent
> any part of memory regions used by the 1st kernel from being reclaimed
> by memblock_alloc() and others.

Are you certain that nomap memory can be allocated? That sounds like a
major bug.

Nomap memory should act like reserved memory with the additional
property that the kernel must not map it implicitly.

> Or do you mean we can introduce another memblock flag?

That wasn't what I meant, but that would be a potential solution.

Thanks,
Mark.
