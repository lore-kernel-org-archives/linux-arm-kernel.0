From: keescook@chromium.org (Kees Cook)
Date: Wed, 11 Jul 2018 19:06:25 -0700
Subject: [PATCH] arm64: Add support for STACKLEAK gcc plugin
In-Reply-To: <08f1c1d4-52a8-6d42-fe56-241c255ba934@redhat.com>
References: <20180712000337.GA4022@beast>
 <08f1c1d4-52a8-6d42-fe56-241c255ba934@redhat.com>
Message-ID: <CAGXu5jJtuut1E4DKB=AVs-pq8H9Jvwr3Ve6eskraBL3ekfUzqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 6:45 PM, Laura Abbott <labbott@redhat.com> wrote:
>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +#define MIN_STACK_LEFT 256
>> +
>> +void __used stackleak_check_alloca(unsigned long size)
>> +{
>> +       unsigned long sp, stack_left;
>> +
>> +       sp = current_stack_pointer;
>> +
>> +       stack_left = sp & (THREAD_SIZE - 1);
>> +       BUG_ON(stack_left < MIN_STACK_LEFT ||
>> +               size >= stack_left - MIN_STACK_LEFT);
>> +}
>> +EXPORT_SYMBOL(stackleak_check_alloca);
>> +#endif
>
>
> I think the conclusion was this needs to be re-written to account
> for the different stack sizes in the same way as x86.

Oh, whoops! Sorry, I missed that fork of the thread. :)

-Kees

-- 
Kees Cook
Pixel Security
