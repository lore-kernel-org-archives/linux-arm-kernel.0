From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 24 Jun 2014 21:18:15 +0200
Subject: [PATCH v7 4/9] seccomp: move no_new_privs into seccomp
In-Reply-To: <1403560693-21809-5-git-send-email-keescook@chromium.org>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-5-git-send-email-keescook@chromium.org>
Message-ID: <20140624191815.GA3623@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23, Kees Cook wrote:
>
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -3,6 +3,8 @@
>
>  #include <uapi/linux/seccomp.h>
>
> +#define SECCOMP_FLAG_NO_NEW_PRIVS	0	/* task may not gain privs */
> +
>  #ifdef CONFIG_SECCOMP
>
>  #include <linux/thread_info.h>
> @@ -16,6 +18,7 @@ struct seccomp_filter;
>   *         system calls available to a process.
>   * @filter: must always point to a valid seccomp-filter or NULL as it is
>   *          accessed without locking during system call entry.
> + * @flags: flags under task->sighand->siglock lock
>   *
>   *          @filter must only be accessed from the context of current as there
>   *          is no read locking.
> @@ -23,6 +26,7 @@ struct seccomp_filter;
>  struct seccomp {
>  	int mode;
>  	struct seccomp_filter *filter;
> +	unsigned long flags;
>  };
>
>  extern int __secure_computing(int);
> @@ -51,7 +55,9 @@ static inline int seccomp_mode(struct seccomp *s)
>
>  #include <linux/errno.h>
>
> -struct seccomp { };
> +struct seccomp {
> +	unsigned long flags;
> +};

A bit messy ;)

I am wondering if we can simply do

	static inline bool current_no_new_privs(void)
	{
		if (current->no_new_privs)
			return true;

	#ifdef CONFIG_SECCOMP
		if (test_thread_flag(TIF_SECCOMP))
			return true;
	#endif

		return false;

	     return test_bit(SECCOMP_FLAG_NO_NEW_PRIVS, &p->seccomp.flags);
	}

instead ?

Oleg.
