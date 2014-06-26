From: drysdale@google.com (David Drysdale)
Date: Thu, 26 Jun 2014 13:37:10 +0100
Subject: [PATCH v7 2/9] seccomp: split filter prep from check and apply
In-Reply-To: <1403560693-21809-3-git-send-email-keescook@chromium.org>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-3-git-send-email-keescook@chromium.org>
Message-ID: <20140626123710.GA16204@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 02:58:06PM -0700, Kees Cook wrote:
> In preparation for adding seccomp locking, move filter creation away
> from where it is checked and applied. This will allow for locking where
> no memory allocation is happening. The validation, filter attachment,
> and seccomp mode setting can all happen under the future locks.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/seccomp.c |   97 +++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 67 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index afb916c7e890..edc8c79ed16d 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -515,6 +551,7 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
>  	current->seccomp.mode = seccomp_mode;
>  	set_thread_flag(TIF_SECCOMP);
>  out:
> +	seccomp_filter_free(prepared);
>  	return ret;
>  }

I think this needs to be inside #ifdef CONFIG_SECCOMP_FILTER to match
the definition of seccomp_filter_free:

../kernel/seccomp.c:554:2: error: implicit declaration of function ?seccomp_filter_free? [-Werror=implicit-function-declaration]
