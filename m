From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 25 Jun 2014 20:29:07 +0200
Subject: [PATCH v8 3/9] seccomp: introduce writer locking
In-Reply-To: <20140625180705.GB18185@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-4-git-send-email-keescook@chromium.org>
 <20140625180705.GB18185@redhat.com>
Message-ID: <20140625182907.GA20226@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25, Oleg Nesterov wrote:
>
> On 06/24, Kees Cook wrote:
> >
> > +static void copy_seccomp(struct task_struct *p)
> > +{
> > +#ifdef CONFIG_SECCOMP
> > +	/*
> > +	 * Must be called with sighand->lock held, which is common to
> > +	 * all threads in the group. Regardless, nothing special is
> > +	 * needed for the child since it is not yet in the tasklist.
> > +	 */
> > +	BUG_ON(!spin_is_locked(&current->sighand->siglock));
> > +
> > +	get_seccomp_filter(current);
> > +	p->seccomp = current->seccomp;
> > +
> > +	if (p->seccomp.mode != SECCOMP_MODE_DISABLED)
> > +		set_tsk_thread_flag(p, TIF_SECCOMP);
> > +#endif
> > +}
>
> Wait. But what about no_new_privs? We should copy it as well...
>
> Perhaps this helper should be updated a bit and moved into seccomp.c so
> that seccomp_sync_threads() could use it too.

This way we can also unexport get_seccomp_filter().

Oleg.
