From: thgarnie@google.com (Thomas Garnier)
Date: Thu, 9 Mar 2017 07:48:03 -0800
Subject: [PATCH v2 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <20170309084208.ims3ehcnieo7uqew@pd.tnic>
References: <20170309012456.5631-1-thgarnie@google.com>
 <20170309084208.ims3ehcnieo7uqew@pd.tnic>
Message-ID: <CAJcbSZHwfG3e+nZySpCFronRG08p=Rs4VvY7SC6QLpUCpyy+_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 9, 2017 at 12:42 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Mar 08, 2017 at 05:24:53PM -0800, Thomas Garnier wrote:
>> @@ -191,6 +191,22 @@ extern struct trace_event_functions exit_syscall_print_funcs;
>>       SYSCALL_METADATA(sname, x, __VA_ARGS__)                 \
>>       __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>
>> +asmlinkage void verify_pre_usermode_state(void);
>> +
>> +#ifndef CONFIG_ARCH_NO_SYSCALL_VERIFY_PRE_USERMODE_STATE
>> +static inline bool has_user_ds(void) {
>> +     bool ret = segment_eq(get_fs(), USER_DS);
>> +     // Prevent re-ordering the call
>
> This is not the kernel comments style. Use /* */ instead.
>
>> +     barrier();
>> +     return ret;
>> +}
>> +#else
>> +static inline bool has_user_ds(void) {
>> +     return false;
>> +}
>> +#endif
>
> ... and then you could slim down the ifdeffery a bit:
>
> static inline bool has_user_ds(void) {
>         bool ret = false;
>
> #ifndef CONFIG_ARCH_NO_SYSCALL_VERIFY_PRE_USERMODE_STATE
>         ret = segment_eq(get_fs(), USER_DS);
>         /* Prevent re-ordering the call. */
>         barrier();
> #endif
>
>         return ret;
> }
>

I agree, cleaner. I will look to do this change on next iteration.

> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Thomas
