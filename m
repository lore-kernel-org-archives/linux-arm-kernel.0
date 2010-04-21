From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 21 Apr 2010 22:00:13 +0100
Subject: kernel virtual memory access (from app) does not generatesegfault
In-Reply-To: <20100421194052.GE26616@n2100.arm.linux.org.uk>
References: <20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100420223106.GQ11723@shareable.org>
	<20100420224108.GA1432@n2100.arm.linux.org.uk>
	<000001cae144$4281a9a0$4044010a@Emea.Arm.com>
	<20100421124317.GA9408@desktop>
	<000101cae16c$b2d08cd0$4044010a@Emea.Arm.com>
	<20100421191600.GO27575@shareable.org>
	<20100421194052.GE26616@n2100.arm.linux.org.uk>
Message-ID: <20100421210013.GZ27575@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Apr 21, 2010 at 08:16:00PM +0100, Jamie Lokier wrote:
> > The two-liner proposed earlier should fix all ARMs doing userspace
> > execution > TASK_SIZE - the problem which started this thread.  But
> > not kernel space accidentally executing an NX page > TASK_SIZE due to
> > some bug, which can only occur on ARMv6/v7 due to NX.
> 
> Sorry James, that's wrong.

It's Jamie, btw.  Always has been.

> ARMv6 and ARMv7 use the IFSR, which gives us the error code - and
> that distinguishes between a translation fault and a permission
> fault.  An attempt to execute a NX page generates a permission
> fault, and therefore we end up calling do_page_fault() rather than
> indirecting via do_translation_fault().

That's a fine explanation, but I'd already grokked it, thanks to your
earlier hint.  So what's wrong about what I said above?  Rephrased as:

Kernel executes NX page > TASK_SIZE:

    Without patch, loops calling do_translation_fault() which
    just returns because the pte is already mapped and valid.
    With patch, goes to do_page_fault().

    -> Fixed by the IFSR patch.

User executes NX page > TASK_SIZE

    -> Fixed by the two-liner or IFSR patch, it doesn't matter.
       Either one directs these to do_page_fault().

Kernel executes NX page < TASK_SIZE:

    -> Already caught by PROT_EXEC + FSR_LNF_PX check in
       do_translation_fault -> do_page-fault -> access_error.

User executes NX page < TASK_SIZE:

    -> Already caught by PROT_EXEC + FSR_LNF_PX check in
       do_translation_fault -> do_page-fault -> access_error.

-- Jamie
