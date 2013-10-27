From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Oct 2013 11:57:07 +0000
Subject: [RFC 0/3] Allow CONFIG_DEBUG_SET_MODULE_RONX to be used on ARM
In-Reply-To: <20131027103452.GA16735@n2100.arm.linux.org.uk>
References: <1371057810-3189-1-git-send-email-lauraa@codeaurora.org>
 <20131024130346.GA31369@n2100.arm.linux.org.uk>
 <20131027103452.GA16735@n2100.arm.linux.org.uk>
Message-ID: <20131027115706.GB16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 27, 2013 at 10:34:52AM +0000, Russell King - ARM Linux wrote:
> On Thu, Oct 24, 2013 at 02:03:46PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Jun 12, 2013 at 10:23:27AM -0700, Laura Abbott wrote:
> > > Hi,
> > > 
> > > This is an RFC to allow CONFIG_DEBUG_SET_MODULE_RONX to be used on ARM. The
> > > current config description from x86 describes it best:
> > > 
> > > 	This option helps catch unintended modifications to loadable
> > > 	kernel module's text and read-only data. It also prevents execution
> > > 	of module data. Such protection may interfere with run-time code
> > > 	patching and dynamic kernel tracing - and they might also protect
> > > 	against certain classes of kernel exploits.
> > > 
> > > ARM was missing a few functions to modify the page tables so those have been
> > > added. I believe modules are always mapped with pages so changing them at map
> > > time should be acceptable. Comments/concerns are appreciated.
> > 
> > I've just tested this and it seems to work:
> 
> The only remaining question is whether DEBUG_SET_MODULE_RONX should be
> by default enabled.  At the moment, the text says "if unsure, say N"
> but is that the right advice?  Shouldn't we be encouraging people to
> have this option turned on unless there's a reason not to (eg, kprobes?)
> 
> How about adding:
> 
> 	default y if !(FTRACE || KPROBES || JUMP_LABEL)
> 
> as KPROBES and JUMP_LABEL both use the text patching, and FTRACE uses
> probe_kernel_write().  We may need to add kgdb to that later too.  Or
> maybe a dependency on the above?
> 
> One thing which comes to mind while looking at this: should
> arch/arm/kernel/patch.c be using the probe_kernel_* functions in
> mm/maccess.c?  Also, should we look at improving this code so we can
> have RONX modules and still have working ftrace/kprobes etc?

Further to this...

probe_kernel_write() will return failure if it can't write without
oopsing the kernel, so arguably this is "okay" in that it won't cause
a kernel oops.  x86 appears to do no different here, though see below.

The real problem case is ARMs patch_text() function which directly
dereferences a virtual address, and so will oops against a kernel RO
page.

x86 takes a different approach: they remap the page using a fixmap
mapping so that they can bypass the RO permissions on text pages.  I
don't see any reason we can't do the same, though of course it makes
it slightly more heavy-weight to do code patching.  I think this is
something we should do before introducing RO text of any kind on ARM,
otherwise people will turn these options off when first presented with
them and probably won't enable them later once such issues are fixed.

That argument can be applied to ftrace using probe_kernel_write() as
well - I think we should avoid having to turn off RO(NX) support if
we have a kernel feature which needs to write to text as much as
possible.

A further idea is to have a separate config option which enables the
presence of the code which bypasses the RO attribute: we don't want to
build that into the kernel unless we have a reason for it to be there.

As far as merging this stuff, I know it's late in the cycle, but I think
that the NX lowmem patches can go in during the next merge window as all
they're doing is fixing the NX attribute setting on various mappings
which should never have had them, and marking lowmem sections which do
not need to be executable as such.  I see this as very low risk as we
should have nothing poking code directly to lowmem pages and trying to
directly execute: the bpf stuff uses module_alloc() rather than grabbing
a lowmem allocation, and we're not (yet) marking any lowmem as read-only.
Also the kernel page table dumping code can go in too.

Expect to see those in linux-next very soon (unless someone objects?)
