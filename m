From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 9 Jul 2014 20:59:36 +0200
Subject: [PATCH v9 09/11] seccomp: introduce writer locking
In-Reply-To: <1403911380-27787-10-git-send-email-keescook@chromium.org>
References: <1403911380-27787-1-git-send-email-keescook@chromium.org>
 <1403911380-27787-10-git-send-email-keescook@chromium.org>
Message-ID: <20140709185936.GA6043@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27, Kees Cook wrote:
>
>  void put_seccomp_filter(struct task_struct *tsk)
>  {
> -	struct seccomp_filter *orig = tsk->seccomp.filter;
> +	struct seccomp_filter *orig = smp_load_acquire(&tsk->seccomp.filter);
>  	/* Clean up single-reference branches iteratively. */
>  	while (orig && atomic_dec_and_test(&orig->usage)) {

And this smp_load_acquire() looks unnecessary. atomic_dec_and_test()
is a barrier.

Oleg.
