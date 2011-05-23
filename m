From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Mon, 23 May 2011 16:57:24 +0100 (BST)
Subject: [RFC PATCH v2] ARM hibernation / suspend-to-disk support code
In-Reply-To: <20110523143216.GA14131@n2100.arm.linux.org.uk>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
	<201105210027.17159.rjw@sisk.pl> <20110523095232.GB2370@arm.com>
	<alpine.DEB.2.00.1105231239270.8018@localhost6.localdomain6>
	<20110523143216.GA14131@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1105231603070.8018@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 May 2011, Russell King - ARM Linux wrote:

> On Mon, May 23, 2011 at 02:37:19PM +0100, Frank Hofmann wrote:
>> What I've found necessary to save/restore via swsusp_arch_suspend/resume
>> are the SYSTEM_MODE and SVC_MODE registers.
>> Yesterday, I had thought that cpu_init() resets SVC_MODE sufficiently but
>> that doesn't seem to be the case, if I leave that out, resume-from-disk
>> doesn't work anymore.
>
> You will be running in SVC mode, so the SVC mode registers are your
> current register set.  At some point you need to do an effective
> "context switch" between the kernel doing the resume and the kernel
> which was running.  That involves restoring the saved register state.
>
> System mode on the other hand is unused by the kernel.
>

Ah, and I had it the other way round ... that's why. Thanks !

I've tried that, saving/restoring just CPSR/SPSR and the reg set - and 
that seems sufficient, works fine !


All this means that the basic code has again become smaller.
Attached is a new version, integrating all the feedback so far:

* save/restore only those parts of the register set that the kernel cannot
   reinitialize from scratch

* take care of FIQ disable/enable bracketing

* use traditional stmfd/ldmfd instead of push/pop

* don't rely on thread state, current->active_mm, but use global &init_mm

* dump arch_prepare_suspend (skipping ahead of Rafael's suggested fix)

* ditch the vmlinux.lds changes as they're not needed


What other outstanding things are there to address for this ?

All the best,
FrankH.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hibernation-core-23May2011.patch
Type: text/x-diff
Size: 5761 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110523/a8962381/attachment.bin>
