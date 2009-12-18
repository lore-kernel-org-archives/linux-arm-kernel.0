From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Dec 2009 14:51:41 +0000
Subject: [PATCH] ARM: Fix a race in the vfp_notifier() function on
	SMPsystems
In-Reply-To: <20091218144728.GC32481@n2100.arm.linux.org.uk>
References: <20091218134423.21279.93962.stgit@pc1117.cambridge.arm.com>
	<20091218141100.GA32481@n2100.arm.linux.org.uk>
	<20091218142503.GB32481@n2100.arm.linux.org.uk>
	<20091218144728.GC32481@n2100.arm.linux.org.uk>
Message-ID: <1261147901.13520.73.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-12-18 at 14:47 +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 18, 2009 at 02:25:03PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Dec 18, 2009 at 02:11:00PM +0000, Russell King - ARM Linux wrote:
> > > On Fri, Dec 18, 2009 at 01:45:09PM +0000, Catalin Marinas wrote:
> > > >   (patch updated following Russell's changes to vfpmodule.c)
> > > >
> > > > The vfp_notifier(THREAD_NOTIFY_RELEASE) maybe be called with thread->cpu
> > > > different from the current one, causing a race condition with both the
> > > > THREAD_NOTIFY_SWITCH path and vfp_support_entry().
> > >
> > > How about we provide THREAD_NOTIFY_EXIT and call these hooks from
> > > exit_thread() - we'll be calling the notifier when the thread is
> > > still running, and so thread->cpu will be the local CPU.
> > >
> > > This should be much safer all round, and give much simpler semantics
> > > if we NULL out the current CPU's last_VFP_context pointer.  It also
> > > means that each CPUs last_VFP_context pointer is only ever accessed
> > > from the local CPU, which can only be a good thing.
> >
> > Something like this:
> 
> Actually, I think we should go further and kill off THREAD_NOTIFY_RELEASE
> completely.  Added a few more people because EP93xx and PXA (well,
> Xscale) is now impacted by this change.
> 
> [PATCH] ARM: Convert VFP/Crunch/XscaleCP thread_release() to exit_thread()
> 
> This avoids races in the VFP code where the dead thread may have
> state on another CPU.  By moving this code to exit_thread(), we
> will be running as the thread, and therefore be running on the
> current CPU.
> 
> This means that we can ensure that the only local state is accessed
> in the thread notifiers.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
[...]
>  static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
>  {
> @@ -132,8 +135,8 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
> 
>         if (cmd == THREAD_NOTIFY_FLUSH)
>                 vfp_thread_flush(thread);
> -       else
> -               vfp_thread_release(thread);
> +       else if (cmd == THREAD_NOTIFY_EXIT)
> +               vfp_thread_exit(thread);

Do we still need the second "if" or "else" will do (though it's safer if
anyone adds some extra THREAD_NOTIFY_* in the future.

In any case (for the VFP code):

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
