From: luto@amacapital.net (Andy Lutomirski)
Date: Thu, 9 Jun 2016 15:46:10 -0700
Subject: [PATCH 05/14] seccomp: recheck the syscall after RET_TRACE
In-Reply-To: <1465506124-21866-6-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
 <1465506124-21866-6-git-send-email-keescook@chromium.org>
Message-ID: <CALCETrUsqr3YbD=5mA9mRmgYqiHeEoLpWi-teyexUo_jR1BaFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 9, 2016 at 2:01 PM, Kees Cook <keescook@chromium.org> wrote:
> When RET_TRACE triggers, a tracer may change a syscall into something that
> should be filtered by seccomp. This re-runs seccomp after a trace event
> to make sure things continue to pass.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> ---
>  kernel/seccomp.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 14a37d71b612..54d15eb2b701 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -556,7 +556,8 @@ void secure_computing_strict(int this_syscall)
>  #else
>
>  #ifdef CONFIG_SECCOMP_FILTER
> -static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
> +static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
> +                           const bool recheck_after_trace)

This patch looks good with one minor nit: I read this as "pass true if
you want to recheck after trace", which is exactly the opposite of how
it works.

--Andy
