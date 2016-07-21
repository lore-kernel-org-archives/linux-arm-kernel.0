From: mpe@ellerman.id.au (Michael Ellerman)
Date: Thu, 21 Jul 2016 16:52:09 +1000
Subject: [PATCH v3 02/11] mm: Hardened usercopy
In-Reply-To: <1468619065-3222-3-git-send-email-keescook@chromium.org>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
Message-ID: <87poq78ova.fsf@@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kees Cook <keescook@chromium.org> writes:

> diff --git a/mm/usercopy.c b/mm/usercopy.c
> new file mode 100644
> index 000000000000..e4bf4e7ccdf6
> --- /dev/null
> +++ b/mm/usercopy.c
> @@ -0,0 +1,234 @@
...
> +
> +/*
> + * Checks if a given pointer and length is contained by the current
> + * stack frame (if possible).
> + *
> + *	0: not at all on the stack
> + *	1: fully within a valid stack frame
> + *	2: fully on the stack (when can't do frame-checking)
> + *	-1: error condition (invalid stack position or bad stack frame)
> + */
> +static noinline int check_stack_object(const void *obj, unsigned long len)
> +{
> +	const void * const stack = task_stack_page(current);
> +	const void * const stackend = stack + THREAD_SIZE;

That allows access to the entire stack, including the struct thread_info,
is that what we want - it seems dangerous? Or did I miss a check
somewhere else?

We have end_of_stack() which computes the end of the stack taking
thread_info into account (end being the opposite of your end above).

cheers
