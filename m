From: keescook@chromium.org (Kees Cook)
Date: Thu, 14 Jul 2016 21:25:42 -0700
Subject: [PATCH v2 02/11] mm: Hardened usercopy
In-Reply-To: <20160714232019.GA28254@350D>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-3-git-send-email-keescook@chromium.org>
 <20160714232019.GA28254@350D>
Message-ID: <CAGXu5jKzD_rCMNJQU1bB5KDfKTsb+AaidZwe=FAfGMqt_FkfqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 4:20 PM, Balbir Singh <bsingharora@gmail.com> wrote:
> On Wed, Jul 13, 2016 at 02:55:55PM -0700, Kees Cook wrote:
>> [...]
>> +++ b/mm/usercopy.c
>> @@ -0,0 +1,219 @@
>> [...]
>> +/*
>> + * Checks if a given pointer and length is contained by the current
>> + * stack frame (if possible).
>> + *
>> + *   0: not at all on the stack
>> + *   1: fully within a valid stack frame
>> + *   2: fully on the stack (when can't do frame-checking)
>> + *   -1: error condition (invalid stack position or bad stack frame)
>
> Can we use enums? Makes it easier to read/debug

Sure, I will update this.

>> [...]
>> +static void report_usercopy(const void *ptr, unsigned long len,
>> +                         bool to_user, const char *type)
>> +{
>> +     pr_emerg("kernel memory %s attempt detected %s %p (%s) (%lu bytes)\n",
>> +             to_user ? "exposure" : "overwrite",
>> +             to_user ? "from" : "to", ptr, type ? : "unknown", len);
>> +     dump_stack();
>> +     do_group_exit(SIGKILL);
>
> SIGKILL -- SIGBUS?

I'd like to keep SIGKILL since it indicates a process fiddling with a
kernel bug. The real problem here is that there doesn't seem to be an
arch-independent way to Oops the kernel and kill a process ("die()" is
closest, but it's defined on a per-arch basis with varying arguments).
This could be a BUG, but I'd rather not panic the entire kernel.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
