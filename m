From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 24 Jun 2014 20:35:50 +0200
Subject: [PATCH v7 3/9] seccomp: introduce writer locking
In-Reply-To: <CAGXu5j+G8qAkGD7H=3R2iw2ZTqZSrMPa2f=czoEjwSW5wKqUWQ@mail.gmail.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-4-git-send-email-keescook@chromium.org>
 <20140624165216.GA29272@redhat.com>
 <CAGXu5j+G8qAkGD7H=3R2iw2ZTqZSrMPa2f=czoEjwSW5wKqUWQ@mail.gmail.com>
Message-ID: <20140624183550.GB1258@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24, Kees Cook wrote:
>
> On Tue, Jun 24, 2014 at 9:52 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> > Kees,
> >
> > I am still trying to force myself to read and try to understand what
> > this series does ;) Just a minor nit so far.
>
> The use-case this solves is when a userspace process does not control
> (or know) when a thread is spawned (e.g. via shared library init, or
> LD_PRELOAD) but wants to make sure seccomp filters have been applied
> to it.

Yes, thanks, I understand this. But the details are not clear to me so
far, I'll try to re-read this series later.

> >> @@ -1142,6 +1168,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> >>  {
> >>       int retval;
> >>       struct task_struct *p;
> >> +     unsigned long irqflags;
> >>
> >>       if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
> >>               return ERR_PTR(-EINVAL);
> >> @@ -1196,7 +1223,6 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> >>               goto fork_out;
> >>
> >>       ftrace_graph_init_task(p);
> >> -     get_seccomp_filter(p);
> >>
> >>       rt_mutex_init_task(p);
> >>
> >> @@ -1434,7 +1460,13 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> >>               p->parent_exec_id = current->self_exec_id;
> >>       }
> >>
> >> -     spin_lock(&current->sighand->siglock);
> >> +     spin_lock_irqsave(&current->sighand->siglock, irqflags);
> >> +
> >> +     /*
> >> +      * Copy seccomp details explicitly here, in case they were changed
> >> +      * before holding tasklist_lock.
> >> +      */
> >> +     copy_seccomp(p);
> >>
> >>       /*
> >>        * Process group and session signals need to be delivered to just the
> >> @@ -1446,7 +1478,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> >>       */
> >>       recalc_sigpending();
> >>       if (signal_pending(current)) {
> >> -             spin_unlock(&current->sighand->siglock);
> >> +             spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
> >>               write_unlock_irq(&tasklist_lock);
> >>               retval = -ERESTARTNOINTR;
> >>               goto bad_fork_free_pid;
> >> @@ -1486,7 +1518,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> >>       }
> >>
> >>       total_forks++;
> >> -     spin_unlock(&current->sighand->siglock);
> >> +     spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
> >>       write_unlock_irq(&tasklist_lock);
> >>       proc_fork_connector(p);
> >>       cgroup_post_fork(p);
> >
> > It seems that the only change copy_process() needs is copy_seccomp() under the locks.
> > Everythinh else (irqflags games) looks obviously unneeded?
>
> I got irq lock dep warnings without these changes.

With or without your patches? Could you show the waring?

> If they're
> unneeded, that's totally fine by me, but some change (either this or
> markings to keep lockdep happy) is needed.

Yes, we need to understand what what happens...

Oleg.
