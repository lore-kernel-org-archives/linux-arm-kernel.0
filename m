From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Oct 2013 10:34:52 +0000
Subject: [RFC 0/3] Allow CONFIG_DEBUG_SET_MODULE_RONX to be used on ARM
In-Reply-To: <20131024130346.GA31369@n2100.arm.linux.org.uk>
References: <1371057810-3189-1-git-send-email-lauraa@codeaurora.org>
 <20131024130346.GA31369@n2100.arm.linux.org.uk>
Message-ID: <20131027103452.GA16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 02:03:46PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 12, 2013 at 10:23:27AM -0700, Laura Abbott wrote:
> > Hi,
> > 
> > This is an RFC to allow CONFIG_DEBUG_SET_MODULE_RONX to be used on ARM. The
> > current config description from x86 describes it best:
> > 
> > 	This option helps catch unintended modifications to loadable
> > 	kernel module's text and read-only data. It also prevents execution
> > 	of module data. Such protection may interfere with run-time code
> > 	patching and dynamic kernel tracing - and they might also protect
> > 	against certain classes of kernel exploits.
> > 
> > ARM was missing a few functions to modify the page tables so those have been
> > added. I believe modules are always mapped with pages so changing them at map
> > time should be acceptable. Comments/concerns are appreciated.
> 
> I've just tested this and it seems to work:

The only remaining question is whether DEBUG_SET_MODULE_RONX should be
by default enabled.  At the moment, the text says "if unsure, say N"
but is that the right advice?  Shouldn't we be encouraging people to
have this option turned on unless there's a reason not to (eg, kprobes?)

How about adding:

	default y if !(FTRACE || KPROBES || JUMP_LABEL)

as KPROBES and JUMP_LABEL both use the text patching, and FTRACE uses
probe_kernel_write().  We may need to add kgdb to that later too.  Or
maybe a dependency on the above?

One thing which comes to mind while looking at this: should
arch/arm/kernel/patch.c be using the probe_kernel_* functions in
mm/maccess.c?  Also, should we look at improving this code so we can
have RONX modules and still have working ftrace/kprobes etc?
