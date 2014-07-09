From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 9 Jul 2014 20:55:49 +0200
Subject: [PATCH v9 09/11] seccomp: introduce writer locking
In-Reply-To: <20140709184215.GA4866@redhat.com>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org>
 <1403911380-27787-10-git-send-email-keescook@chromium.org>
 <20140709184215.GA4866@redhat.com>
Message-ID: <20140709185549.GB4866@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09, Oleg Nesterov wrote:
>
> On 06/27, Kees Cook wrote:
> >
> >  static u32 seccomp_run_filters(int syscall)
> >  {
> > -	struct seccomp_filter *f;
> > +	struct seccomp_filter *f = ACCESS_ONCE(current->seccomp.filter);
>
> I am not sure...
>
> This is fine if this ->filter is the 1st (and only) one, in this case
> we can rely on rmb() in the caller.
>
> But the new filter can be installed at any moment. Say, right after that
> rmb() although this doesn't matter. Either we need smp_read_barrier_depends()
> after that, or smp_load_acquire() like the previous version did?

Wait... and it seems that seccomp_sync_threads() needs smp_store_release()
when it sets thread->filter = current->filter by the same reason?

OTOH. smp_store_release() in seccomp_attach_filter() can die, "current"
doesn't need a barrier to serialize with itself.

Oleg.
