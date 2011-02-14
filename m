From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Feb 2011 16:13:21 +0000
Subject: [PATCH 1/2] ARM: Introduce THREAD_NOTIFY_COPY for
	copy_thread() hooks
In-Reply-To: <000201cbcc40$6571c840$305558c0$@deacon@arm.com>
References: <20110214103528.5796.99616.stgit@e102109-lin.cambridge.arm.com>
	<20110214103738.5796.44268.stgit@e102109-lin.cambridge.arm.com>
	<000201cbcc40$6571c840$305558c0$@deacon@arm.com>
Message-ID: <20110214161321.GB31103@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 12:12:05PM -0000, Will Deacon wrote:
> Hi Catalin,
> 
> > Subject: [PATCH 1/2] ARM: Introduce THREAD_NOTIFY_COPY for copy_thread() hooks
> > 
> > This patch adds THREAD_NOTIFY_COPY for colling registered handlers
> > during the copy_thread() function call. It also changes the VFP handler
> > to use a switch statement rather than if..else and ignore this event.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm/include/asm/thread_notify.h |    1 +
> >  arch/arm/kernel/process.c            |    2 ++
> >  arch/arm/vfp/vfpmodule.c             |   22 +++++++++++++++-------
> >  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> This would be useful for the hw-breakpoint code, where we need to clear
> (memset 0) the breakpoint structures in the child so that they don't get
> unregistered later on.
> 
> However, we also need to flush (unregister) breakpoints in flush_thread
> so that they don't persist across an exec. Ideally, we'd have a single
> notifier block and act on THREAD_NOTIFY_{FLUSH,COPY} accordingly, but
> the problem is that THREAD_NOTIFY_FLUSH is only notified *after* zeroing
> most of the thread structure, so the call is currently inlined into
> flush_thread and we don't use a notifier.

It's better to avoid the thread notifier if you don't need all the
facilities it offers as it gets called for every thread switch.  Every
additional registration will add additional cycles to the thread switch.
