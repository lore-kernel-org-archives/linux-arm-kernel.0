From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 28 Jun 2018 11:02:36 +0200
Subject: [PATCH 2/5] kernel/jump_label: implement generic support for
 relative references
In-Reply-To: <20180628085003.GA2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-3-ard.biesheuvel@linaro.org>
 <20180628085003.GA2494@hirez.programming.kicks-ass.net>
Message-ID: <CAKv+Gu87DmGLG7N8X8+V7LppXm72SJUmCcEpaehCE5Rt0Z4FNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 June 2018 at 10:50, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jun 27, 2018 at 06:06:01PM +0200, Ard Biesheuvel wrote:
>> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
>> index 86ec0652d3b1..aa203dffe72c 100644
>> --- a/include/linux/jump_label.h
>> +++ b/include/linux/jump_label.h
>> @@ -121,6 +121,32 @@ struct static_key {
>>  #include <asm/jump_label.h>
>>
>>  #ifndef __ASSEMBLY__
>> +#ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
>> +
>> +struct jump_entry {
>> +     int code;
>> +     int target;
>> +     int key;
>> +};
>
> I much prefer you use 'u32' there.
>

Actually, they are signed so that would be s32. But yeah, I can change that.

>
>> +static void jump_label_swap(void *a, void *b, int size)
>> +{
>> +     long delta = (unsigned long)a - (unsigned long)b;
>> +     struct jump_entry *jea = a;
>> +     struct jump_entry *jeb = b;
>> +     struct jump_entry tmp = *jea;
>> +
>> +     jea->code       = jeb->code - delta;
>> +     jea->target     = jeb->target - delta;
>> +     jea->key        = jeb->key - delta;
>> +
>> +     jeb->code       = tmp.code + delta;
>> +     jeb->target     = tmp.target + delta;
>> +     jeb->key        = tmp.key + delta;
>> +}
>> +
>>  static void
>>  jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
>>  {
>> @@ -56,7 +72,9 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
>>
>>       size = (((unsigned long)stop - (unsigned long)start)
>>                                       / sizeof(struct jump_entry));
>> -     sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
>> +     sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
>> +          IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE) ? jump_label_swap
>> +                                                           : NULL);
>>  }
>
> That will result in jump_label_swap being an unused symbol for some
> compile options.
>

No, and isn't that the point of IS_ENABLED()? The compiler sees a
reference to jump_label_swap(), so it won't complain about it being
unused.

> Would it not be much nicer to write that like:
>
> static void jump_label_swap(void *a, void *b, int size)
> {
>         struct jump_entry *jea = a, *jeb = b;
>
> #ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
>         long delta = a - b;
>
>         jea->code += delta;
>         jea->target += delta;
>         jea->key += delta;
>
>         jeb->code -= delta;
>         jeb->target -= delta;
>         jeb->key -= delta;
> #else
>
>         swap(*jea, *jeb);
> }
>
> And then unconditionally use jump_label_swap().

Meh. I thought IS_ENABLED() was preferred over #ifdef, no? That way,
the compiler always sees the code, and simply discards it without
complaining if it ends up left unused.
