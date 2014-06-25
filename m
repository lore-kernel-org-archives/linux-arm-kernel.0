From: keescook@chromium.org (Kees Cook)
Date: Wed, 25 Jun 2014 07:51:25 -0700
Subject: [PATCH v8 5/9] seccomp: split mode set routines
In-Reply-To: <20140625135121.GB7892@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-6-git-send-email-keescook@chromium.org>
 <20140625135121.GB7892@redhat.com>
Message-ID: <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 6:51 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/24, Kees Cook wrote:
>>
>> +static inline void seccomp_assign_mode(struct task_struct *task,
>> +                                    unsigned long seccomp_mode)
>> +{
>> +     BUG_ON(!spin_is_locked(&task->sighand->siglock));
>> +
>> +     task->seccomp.mode = seccomp_mode;
>> +     set_tsk_thread_flag(task, TIF_SECCOMP);
>> +}
>
> OK, but unless task == current this can race with secure_computing().
> I think this needs smp_mb__before_atomic() and secure_computing() needs
> rmb() after test_bit(TIF_SECCOMP).
>
> Otherwise, can't __secure_computing() hit BUG() if it sees the old
> mode == SECCOMP_MODE_DISABLED ?
>
> Or seccomp_run_filters() can see ->filters == NULL and WARN(),
> smp_load_acquire() only serializes that LOAD with the subsequent memory
> operations.

Hm, actually, now I'm worried about smp_load_acquire() being too slow
in run_filters().

The ordering must be:
- task->seccomp.filter must be valid before
- task->seccomp.mode is set, which must be valid before
- TIF_SECCOMP is set

But I don't want to impact secure_computing(). What's the best way to
make sure this ordering is respected?

-Kees

-- 
Kees Cook
Chrome OS Security
