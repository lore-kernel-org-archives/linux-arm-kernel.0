From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 9 Jul 2014 20:42:15 +0200
Subject: [PATCH v9 09/11] seccomp: introduce writer locking
In-Reply-To: <1403911380-27787-10-git-send-email-keescook@chromium.org>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org>
 <1403911380-27787-10-git-send-email-keescook@chromium.org>
Message-ID: <20140709184215.GA4866@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27, Kees Cook wrote:
>
>  static u32 seccomp_run_filters(int syscall)
>  {
> -	struct seccomp_filter *f;
> +	struct seccomp_filter *f = ACCESS_ONCE(current->seccomp.filter);

I am not sure...

This is fine if this ->filter is the 1st (and only) one, in this case
we can rely on rmb() in the caller.

But the new filter can be installed at any moment. Say, right after that
rmb() although this doesn't matter. Either we need smp_read_barrier_depends()
after that, or smp_load_acquire() like the previous version did?

Oleg.
