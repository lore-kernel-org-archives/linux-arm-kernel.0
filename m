From: keescook@chromium.org (Kees Cook)
Date: Thu, 17 Jul 2014 08:45:52 -0700
Subject: [PATCH v11 11/11] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
In-Reply-To: <CAHse=S_32tmusk4ceY4U6GbNpX4PkX12iPPDZFVZ7qgv-RAooA@mail.gmail.com>
References: <1405547442-26641-1-git-send-email-keescook@chromium.org>
 <1405547442-26641-12-git-send-email-keescook@chromium.org>
 <CAHse=S_32tmusk4ceY4U6GbNpX4PkX12iPPDZFVZ7qgv-RAooA@mail.gmail.com>
Message-ID: <CAGXu5j+dFZdnnK8f-HRrUs2vLeyhWyHh_AY-OynDcp-Ye+dy7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 8:04 AM, David Drysdale <drysdale@google.com> wrote:
> On Wed, Jul 16, 2014 at 10:50 PM, Kees Cook <keescook@chromium.org> wrote:
>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> index 9065d2c79c56..2125b83ccfd4 100644
>> +/**
>> + * seccomp_can_sync_threads: checks if all threads can be synchronized
>> + *
>> + * Expects sighand and cred_guard_mutex locks to be held.
>> + *
>> + * Returns 0 on success, -ve on error, or the pid of a thread which was
>> + * either not in the correct seccomp mode or it did not have an ancestral
>> + * seccomp filter.
>> + */
>> +static inline pid_t seccomp_can_sync_threads(void)
>> +{
>> +       struct task_struct *thread, *caller;
>> +
>> +       BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
>> +       BUG_ON(!spin_is_locked(&current->sighand->siglock));
>> +
>> +       if (current->seccomp.mode != SECCOMP_MODE_FILTER)
>> +               return -EACCES;
>
> Quick question -- is it possible to apply the first filter and also synchronize
> it across threads in the same operation?  If so, does this arm also need to
> cope with seccomp.mode being SECCOMP_MODE_DISABLED?
>
> [seccomp_set_mode_filter() looks to call this via seccomp_attach_filter()
> before it does seccomp_assign_mode()]

I don't entirely understand what you're asking. The threads gain the
filter and the mode before the current thread may gain the mode (if
it's the first time this has been called). Due to all the locks,
though, this isn't a problem. Is there a situation you see where there
might be a problem?

-Kees

-- 
Kees Cook
Chrome OS Security
