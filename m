From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Dec 2009 14:22:01 +0000
Subject: [PATCH] ARM: Fix a race in the vfp_notifier() function on
	SMPsystems
In-Reply-To: <20091218141100.GA32481@n2100.arm.linux.org.uk>
References: <20091218134423.21279.93962.stgit@pc1117.cambridge.arm.com>
	<20091218141100.GA32481@n2100.arm.linux.org.uk>
Message-ID: <1261146121.13520.66.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-12-18 at 14:11 +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 18, 2009 at 01:45:09PM +0000, Catalin Marinas wrote:
> >       (patch updated following Russell's changes to vfpmodule.c)
> >
> > The vfp_notifier(THREAD_NOTIFY_RELEASE) maybe be called with thread->cpu
> > different from the current one, causing a race condition with both the
> > THREAD_NOTIFY_SWITCH path and vfp_support_entry().
> 
> How about we provide THREAD_NOTIFY_EXIT and call these hooks from
> exit_thread() - we'll be calling the notifier when the thread is
> still running, and so thread->cpu will be the local CPU.
> 
> This should be much safer all round, and give much simpler semantics
> if we NULL out the current CPU's last_VFP_context pointer.  It also
> means that each CPUs last_VFP_context pointer is only ever accessed
> from the local CPU, which can only be a good thing.

It sounds like a clean workaround. I'm fine with this approach.

-- 
Catalin
