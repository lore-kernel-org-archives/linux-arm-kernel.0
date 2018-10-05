From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 5 Oct 2018 16:57:57 +0200
Subject: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
In-Reply-To: <20181005141433.GS19272@hirez.programming.kicks-ass.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005141433.GS19272@hirez.programming.kicks-ass.net>
Message-ID: <CAKv+Gu-Gkf2jJ+Nn65pT=HDH6S8wceuXU_RrDpatc=biNx9ROA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2018 at 16:14, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>> new file mode 100644
>> index 000000000000..8fc3b4c9b38f
>> --- /dev/null
>> +++ b/include/linux/ffp.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __LINUX_FFP_H
>> +#define __LINUX_FFP_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/compiler.h>
>> +
>> +#ifdef CONFIG_HAVE_ARCH_FFP
>> +#include <asm/ffp.h>
>> +#else
>> +
>> +struct ffp {
>> +     void    (**fn)(void);
>> +     void    (*default_fn)(void);
>> +};
>> +
>> +#define DECLARE_FFP(_fn, _def)                                               \
>> +     extern typeof(_def) *_fn;                                       \
>> +     extern struct ffp const __ffp_ ## _fn
>> +
>> +#define DEFINE_FFP(_fn, _def)                                                \
>> +     typeof(_def) *_fn = &_def;                                      \
>> +     struct ffp const __ffp_ ## _fn                                  \
>> +             = { (void(**)(void))&_fn, (void(*)(void))&_def };       \
>> +     EXPORT_SYMBOL(__ffp_ ## _fn)
>> +
>> +static inline void ffp_set_target(const struct ffp *m, void *new_fn)
>> +{
>> +     WRITE_ONCE(*m->fn, new_fn);
>> +}
>> +
>> +static inline void ffp_reset_target(const struct ffp *m)
>> +{
>> +     WRITE_ONCE(*m->fn, m->default_fn);
>> +}
>> +
>> +#endif
>> +
>> +#define SET_FFP(_fn, _new)   ffp_set_target(&__ffp_ ## _fn, _new)
>> +#define RESET_FFP(_fn)               ffp_reset_target(&__ffp_ ## _fn)
>> +
>> +#endif
>
> I don't understand this interface. There is no wrapper for the call
> site, so how are we going to patch all call-sites when you update the
> target?

This is the generic implementation, and in this case, it is just a
function pointer which gets dereferenced and called indirectly at each
call site.

In the arch specific implementations (for ones where it matters, see
2/9), it is more like a PLT entry, which gets called from each call
site, and which can be patched to point to another function.

So we replace a single indirect call with a direct call plus a direct jump.
