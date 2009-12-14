From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2009 12:21:38 +0000
Subject: [PATCH 3/6] Fix a race in the vfp_notifier() function on SMP
	systems
In-Reply-To: <20091212135737.GB30537@n2100.arm.linux.org.uk>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
	<20091207141325.30429.13315.stgit@pc1117.cambridge.arm.com>
	<20091212122447.GA30537@n2100.arm.linux.org.uk>
	<20091212135737.GB30537@n2100.arm.linux.org.uk>
Message-ID: <1260793298.17159.70.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-12-12 at 13:57 +0000, Russell King - ARM Linux wrote:
> On Sat, Dec 12, 2009 at 12:24:47PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 07, 2009 at 02:13:34PM +0000, Catalin Marinas wrote:
> > > The vfp_notifier(THREAD_NOTIFY_RELEASE) maybe be called with thread->cpu
> > > different from the current one, causing a race condition with both the
> > > THREAD_NOTIFY_SWITCH path and vfp_support_entry().
> > 
> > The only call where thread->cpu may not be the current CPU is in the
> > THREAD_NOFTIFY_RELEASE case.
> > 
> > When called in the THREAD_NOTIFY_SWITCH case, we are switching to the
> > specified thread, and thread->cpu better be smp_processor_id() or else
> > we're saving our CPUs VFP state into some other CPUs currently running
> > thread.
> > 
> > Not only that, but the thread we're switching away from will still be
> > 'owned' by the CPU we're running on, and can't be scheduled onto another
> > CPU without this function first completing, nor can it be flushed nor
> > released.
> 
> Here's a patch which adds this documentation, and fixes the
> THREAD_NOTIFY_FLUSH case - since that could be preempted.
[...]
> + *  THREAD_NOFTIFY_SWTICH:
> + *   - the previously running thread will not be scheduled onto another CPU.

While this comment is certainly true, I don't think it is relevant since
we aren't always switching the VFP context from the thread being
switched out but it may be a thread that ran much earlier.

Otherwise the patch is fine.

-- 
Catalin
