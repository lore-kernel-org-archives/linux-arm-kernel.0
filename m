From: keescook@chromium.org (Kees Cook)
Date: Thu, 21 Jul 2016 11:34:25 -0700
Subject: [PATCH v3 02/11] mm: Hardened usercopy
In-Reply-To: <5790711f.2350420a.b4287.2cc0SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
 <5790711f.2350420a.b4287.2cc0SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <CAGXu5jLCu1Vv0uugKZrsjSEsoABgXJSOJ8GkKmrHbvj9jkC2YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 11:52 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>> new file mode 100644
>> index 000000000000..e4bf4e7ccdf6
>> --- /dev/null
>> +++ b/mm/usercopy.c
>> @@ -0,0 +1,234 @@
> ...
>> +
>> +/*
>> + * Checks if a given pointer and length is contained by the current
>> + * stack frame (if possible).
>> + *
>> + *   0: not at all on the stack
>> + *   1: fully within a valid stack frame
>> + *   2: fully on the stack (when can't do frame-checking)
>> + *   -1: error condition (invalid stack position or bad stack frame)
>> + */
>> +static noinline int check_stack_object(const void *obj, unsigned long len)
>> +{
>> +     const void * const stack = task_stack_page(current);
>> +     const void * const stackend = stack + THREAD_SIZE;
>
> That allows access to the entire stack, including the struct thread_info,
> is that what we want - it seems dangerous? Or did I miss a check
> somewhere else?

That seems like a nice improvement to make, yeah.

> We have end_of_stack() which computes the end of the stack taking
> thread_info into account (end being the opposite of your end above).

Amusingly, the object_is_on_stack() check in sched.h doesn't take
thread_info into account either. :P Regardless, I think using
end_of_stack() may not be best. To tighten the check, I think we could
add this after checking that the object is on the stack:

#ifdef CONFIG_STACK_GROWSUP
        stackend -= sizeof(struct thread_info);
#else
        stack += sizeof(struct thread_info);
#endif

e.g. then if the pointer was in the thread_info, the second test would
fail, triggering the protection.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
